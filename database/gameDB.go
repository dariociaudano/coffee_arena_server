package database

type AnswerDB struct {
	AnswerID   int    `json:"answer-id"`
	AnswerText string `json:"answer-text"`
}

type QuestionDB struct {
	QuestionID    int        `json:"question-id"`
	QuestionText  string     `json:"question-text"`
	CorrectAnswer int        `json:"correct-answer-id"`
	Points        int        `json:"point"`
	Answers       []AnswerDB `json:"answers"`
}

func (conn *MySQLDB) QueryQuestionsDB(limit int) ([]QuestionDB, error) {
	rows, err := conn.db.Query("SELECT q.id, q.text, q.difficulty_point, q.correct_answer_id, a.id, a.text FROM question q LEFT JOIN answer a ON q.id = a.question_id ORDER BY q.id, a.id")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	// Create a slice to store the questions
	questions := make([]QuestionDB, 0)
	var currentQuestionID int

	// Iterate over the result set
	for rows.Next() {
		var questionID, difficultyPoint, correctAnswerID, answerID int
		var questionText, answerText string
		if err := rows.Scan(&questionID, &questionText, &difficultyPoint, &correctAnswerID, &answerID, &answerText); err != nil {
			return nil, err
		}

		// Check if the question has changed
		if questionID != currentQuestionID {
			// Create a new question object
			question := QuestionDB{
				QuestionID:    questionID,
				QuestionText:  questionText,
				Points:        difficultyPoint,
				CorrectAnswer: correctAnswerID,
				Answers:       make([]AnswerDB, 0),
			}
			questions = append(questions, question)
			currentQuestionID = questionID
		}

		// Append the answer to the current question's answers
		if len(questions) > 0 {
			lastQuestion := &questions[len(questions)-1]
			lastQuestion.Answers = append(lastQuestion.Answers, AnswerDB{
				AnswerID:   answerID,
				AnswerText: answerText,
			})
		}
	}

	// Check for any errors encountered during iteration
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return questions, nil
}
