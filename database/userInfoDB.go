package database

import (
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type UserDB struct {
	Id                int    `json:"id"`
	Username          string `json:"username"`
	Nick              string `json:"nick"`
	PasswordEncrypted string `json:"password_encrypted"`
	Image             string `json:"image"`
	QRcode            string `json:"qr_code"`
}

type JWTClaimsDB struct {
	Id        int    `json:"id"`
	UserId    int    `json:"user_id"`
	Timestamp int64  `json:"timestamp"`
	Token     string `json:"token"`
}

func (conn *MySQLDB) QueryUserDB(username string) (*UserDB, error) {
	query := "SELECT id, username, nick, password_enc, image, qr_code FROM user WHERE username = ?"

	stmt, err := conn.db.Prepare(query)
	if err != nil {
		return nil, err
	}
	defer stmt.Close()

	row := stmt.QueryRow(username)

	user := &UserDB{}
	err = row.Scan(&user.Id, &user.Username, &user.Nick, &user.PasswordEncrypted, &user.Image, &user.QRcode)
	if err != nil {
		return nil, err
	}

	return user, nil
}

func (conn *MySQLDB) InsertUserDB(username string, password string, nickname string) error {
	// Encrypt the password
	encryptedPassword, err := Encrypt(password)
	if err != nil {
		return err
	}

	// Prepare the SQL statement
	stmt, err := conn.db.Prepare("INSERT INTO user (username, nick, password_enc, image, qr_code) VALUES (?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Execute the statement with the desired values
	_, err = stmt.Exec(username, nickname, encryptedPassword, "https://picsum.photos/200", uuid.NewString())
	if err != nil {
		return err
	}

	return nil
}

// Encrypt encrypts a string using bcrypt
func Encrypt(password string) (string, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}
	return string(hashedPassword), nil
}

func (conn *MySQLDB) AddToLobby(userId int, lobbyType int) error {
	query := "INSERT INTO lobby (user_id, value) VALUES (?, ?)"

	stmt, err := conn.db.Prepare(query)
	if err != nil {
		return err
	}
	defer stmt.Close()

	_, err = stmt.Exec(userId, lobbyType)
	if err != nil {
		return err
	}

	return nil
}
