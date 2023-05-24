package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/dariociaudano/coffee_arena_server/method"
	"github.com/gin-gonic/gin"
)

var (
	help    = flag.Bool("help", false, "Show help")
	address string
	port    int
	DB_USER string
	DB_PWD  string
	DB_HOST string
	DB_PORT int
	DB_NAME string
)

func handleRequests() {
	// Create new router
	router := gin.Default()

	// CORS middleware
	router.Use(corsMiddleware())

	log.Println("Creating routes")

	dbState := method.DBState{Username: DB_USER, Password: DB_PWD, Host: DB_HOST, Port: DB_PORT, DatabaseName: DB_NAME}

	// Specify endpoints
	router.GET("/", method.HomePage)
	router.GET("/userinfo", func(c *gin.Context) {
		method.UserInfo(c, dbState)
	})
	router.POST("/registeruser", func(c *gin.Context) {
		method.RegisterUser(c, dbState)
	})
	router.GET("/nextsession", method.RetrieveNextSession)
	router.GET("/qaList", func(c *gin.Context) {
		method.GetQuestionsAnswers(c, dbState)
	})
	router.GET("/joinlobby", func(c *gin.Context) {
		method.JoinLobby(c, dbState)
	})
	router.GET("/leadboard", func(c *gin.Context) {
		method.RetrieveLeadboard(c, dbState)
	})

	router.GET("/submitResponse", func(c *gin.Context) {
		method.ParseResponse(c, dbState)
	})

	log.Printf("Listen&Serve on %s:%d", address, port)

	runAddress := fmt.Sprintf("%s:%d", address, port)
	router.Run(runAddress)
}

func corsMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		// Set CORS headers
		c.Header("Access-Control-Allow-Origin", "*")
		c.Header("Access-Control-Allow-Methods", "GET, OPTIONS")
		c.Header("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")

		// Handle OPTIONS request
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(200)
			return
		}

		c.Next()
	}
}

func init() {
	// Bind flags
	flag.StringVar(&address, "address", "localhost", "REST service base address")
	flag.IntVar(&port, "port", 8080, "REST service port")

	flag.StringVar(&DB_USER, "DB_USER", "coffee_arena_admin", "DB service username")
	flag.StringVar(&DB_PWD, "DB_PWD", "secret", "DB service password")
	flag.StringVar(&DB_HOST, "DB_HOST", "localhost", "DB service host")
	flag.IntVar(&DB_PORT, "DB_PORT", 3306, "DB service port")
	flag.StringVar(&DB_NAME, "DB_NAME", "coffee_arena_db", "DB service name")

	// Parse flags
	flag.Parse()

	// Usage demo
	if *help {
		flag.Usage()
		os.Exit(0)
	}

}

func main() {
	handleRequests()
}
