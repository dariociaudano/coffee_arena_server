package method

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/dariociaudano/coffee_arena_server/database"
	_ "github.com/go-sql-driver/mysql"

	"github.com/gin-gonic/gin"
)

type NextSession struct {
	Time time.Time `json:"time"`
}

type Answer struct {
	AnswerID   int    `json:"answer-id"`
	AnswerText string `json:"answer-text"`
}

type Question struct {
	QuestionID    int      `json:"question-id"`
	QuestionText  string   `json:"question-text"`
	CorrectAnswer int      `json:"correct-answer-id"`
	Points        int      `json:"point"`
	Answers       []Answer `json:"answers"`
}

func RetrieveNextSession(c *gin.Context) {
	fmt.Println("Endpoint hit: nextSession")
	c.JSON(200, gin.H{"next-session": time.Now().Unix() + 300})
}

func GetQuestionsAnswers(c *gin.Context, dbState DBState) {
	questions, err := GetQuestions(c, dbState)
	if err != nil {
		c.JSON(500, gin.H{"error": err})
		return
	}

	c.JSON(200, gin.H{"questions": questions})
}

func GetQuestions(c *gin.Context, dbState DBState) ([]Question, error) {
	// Generate a random number of questions to retrieve
	numQuestions := rand.Intn(10) + 1 // Random number between 1 and 10

	// Check user inside DB
	conn, err := database.NewMySQLDB(dbState.Username, dbState.Password, dbState.Host, dbState.Port, dbState.DatabaseName)
	if err != nil {
		return nil, err
	}

	// Query the database to retrieve random questions
	qdb, err := conn.QueryQuestionsDB(numQuestions)
	if err != nil {
		return nil, err
	}
	conn.Close()

	// Return the questions as JSON
	return ConvertQuestionDBToQuestion(qdb), nil
}

func ConvertQuestionDBToQuestion(qdb []database.QuestionDB) []Question {
	questions := make([]Question, len(qdb))

	for i, q := range qdb {
		question := Question{
			QuestionID:    q.QuestionID,
			QuestionText:  q.QuestionText,
			CorrectAnswer: q.CorrectAnswer,
			Points:        q.Points,
			Answers:       make([]Answer, len(q.Answers)),
		}

		for j, a := range q.Answers {
			answer := Answer{
				AnswerID:   a.AnswerID,
				AnswerText: a.AnswerText,
			}
			question.Answers[j] = answer
		}

		questions[i] = question
	}

	return questions
}
