package method

import (
	"github.com/dariociaudano/coffee_arena_server/database"
	"github.com/gin-gonic/gin"
)

func RetrieveLeadboard(c *gin.Context, dbState DBState) {
	// Check leadboard inside DB
	conn, err := database.NewMySQLDB(dbState.Username, dbState.Password, dbState.Host, dbState.Port, dbState.DatabaseName)
	if err != nil {
		c.JSON(500, gin.H{"error": "Failed to create MySQL DB:"})
		return
	}

	leadboard, err := conn.RetrieveLeaderboard()
	if err != nil || leadboard == nil {
		c.JSON(500, gin.H{"error": "Unable to retrieve leadboard"})
		return
	}

	conn.Close()

	c.JSON(200, gin.H{"leadboard": leadboard})
}
