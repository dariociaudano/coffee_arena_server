package method

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/dariociaudano/coffee_arena_server/ai"
	"github.com/dariociaudano/coffee_arena_server/database"
	"github.com/dariociaudano/coffee_arena_server/security"
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

var secretKey = "thisis32bitlongpassphraseimusing"

type UserLogin struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type LobbyRequest struct {
	JWT       string `json:"token"`
	LobbyType int    `json:"lobby"`
}

type ResultResponse struct {
	Nick      string `json:"nick"`
	UserImage string `json:"user-image"`
	Points    int    `json:"points"`
	Trend     bool   `json:"trendGood"`
}

type ResultRequest struct {
	JWT string `json:"token"`
}

type JWTClaims struct {
	Id     int    `json:"id"`
	Nick   string `json:"nick"`
	Image  string `json:"image"`
	QRcode string `json:"qr_code"`
	jwt.StandardClaims
}

func HomePage(c *gin.Context) {
	fmt.Fprintf(c.Writer, "Welcome to the HomePage!")
	fmt.Println("Endpoint hit: homePage")
}

func UserInfo(c *gin.Context, dbState DBState) {
	var user UserLogin

	// Bind the request body to the user struct
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(400, gin.H{"error": "Invalid request payload"})
		return
	}

	// Check user inside DB
	conn, err := database.NewMySQLDB(dbState.Username, dbState.Password, dbState.Host, dbState.Port, dbState.DatabaseName)
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to create MySQL DB:"})
		return
	}

	userDB, err := conn.QueryUserDB(user.Username)
	if err != nil || userDB == nil {
		c.JSON(401, gin.H{"error": "Invalid credentials"})
		return
	}

	conn.Close()

	if userDB.Username != user.Username {
		c.JSON(401, gin.H{"error": "Invalid credentials"})
		return
	}

	// Generate JWT token
	claims := JWTClaims{
		Id:     userDB.Id,
		Nick:   userDB.Nick,
		Image:  userDB.Image,
		QRcode: userDB.QRcode,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Add(time.Minute * 60).Unix(),
		},
	}

	signedToken, err := jwt.NewWithClaims(jwt.SigningMethodHS256, claims).SignedString([]byte(secretKey))
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to generate the signed token"})
		return
	}
	c.JSON(200, gin.H{
		"token":   signedToken,
		"id":      userDB.Id,
		"nick":    userDB.Nick,
		"image":   userDB.Image,
		"qr_code": userDB.QRcode,
	})
}

func RegisterUser(c *gin.Context, dbState DBState) {
	var user UserLogin

	// Bind the request body to the user struct
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(400, gin.H{"error": "Invalid request payload"})
		return
	}

	// Check user inside DB
	conn, err := database.NewMySQLDB(dbState.Username, dbState.Password, dbState.Host, dbState.Port, dbState.DatabaseName)
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to create MySQL DB."})
		return
	}

	// Encrypt the password
	encryptedPassword, err := security.EncryptString([]byte(secretKey), user.Password)
	if err != nil {
		c.JSON(500, gin.H{"error": fmt.Sprint("Encryption error:", err)})
		return
	}

	err = conn.InsertUserDB(user.Username, encryptedPassword, ai.GenerateNickname())
	if err != nil {
		c.JSON(500, gin.H{"error": err})
		return
	}

	conn.Close()

	c.JSON(200, gin.H{"registration_status": "completed"})
}

func JoinLobby(c *gin.Context, dbState DBState) {
	var lobby LobbyRequest

	// Bind the request body to the user struct
	if err := c.ShouldBindJSON(&lobby); err != nil {
		c.JSON(400, gin.H{"error": "Invalid request payload"})
		return
	}

	// Check user inside DB
	conn, err := database.NewMySQLDB(dbState.Username, dbState.Password, dbState.Host, dbState.Port, dbState.DatabaseName)
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to create MySQL DB."})
		return
	}

	tokenDecoded, err := ParseJWTToken(lobby.JWT)
	if err != nil {
		c.JSON(500, gin.H{"error": "Invalid Token"})
		return
	}

	err = conn.AddToLobby(tokenDecoded.Id, lobby.LobbyType)
	if err != nil {
		c.JSON(500, gin.H{"error": err})
		return
	}

	conn.Close()

	questions, err := GetQuestions(c, dbState)
	if err != nil {
		c.JSON(500, gin.H{"error": err})
		return
	}

	c.JSON(200, gin.H{"questions": questions})
}

func ParseResponse(c *gin.Context, dbState DBState) {
	var request ResultRequest

	// Bind the request body to the user struct
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(400, gin.H{"error": "Invalid request payload"})
		return
	}

	tokenDecoded, err := ParseJWTToken(request.JWT)
	if err != nil {
		c.JSON(500, gin.H{"error": "Invalid Token"})
		return
	}

	// Check user inside DB
	conn, err := database.NewMySQLDB(dbState.Username, dbState.Password, dbState.Host, dbState.Port, dbState.DatabaseName)
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to create MySQL DB."})
		return
	}

	points, err := conn.ParseResponseDB(tokenDecoded.Id)
	conn.Close()

	if err != nil {
		c.JSON(404, gin.H{"error": "Uable to retrieve points"})
		return
	}

	rand.New(rand.NewSource(time.Now().UnixNano()))
	trend := rand.Intn(2) == 1

	c.JSON(200, gin.H{"results": ResultResponse{
		Nick:      tokenDecoded.Nick,
		UserImage: tokenDecoded.Image,
		Points:    points,
		Trend:     trend,
	}})
}

func ParseJWTToken(tokenString string) (*JWTClaims, error) {
	token, err := jwt.ParseWithClaims(tokenString, &JWTClaims{}, func(token *jwt.Token) (interface{}, error) {
		// Provide the secret key used for signing the token
		return []byte(secretKey), nil
	})
	if err != nil {
		return nil, err
	}

	if claims, ok := token.Claims.(*JWTClaims); ok && token.Valid {
		return claims, nil
	} else {
		return nil, fmt.Errorf("invalid token")
	}
}
