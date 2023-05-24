package database

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

// Define a struct to hold the MySQL database connection.
type MySQLDB struct {
	db *sql.DB
}

// Create a function to establish a connection to the MySQL database.
func NewMySQLDB(username string, password string, host string, port int, database string) (*MySQLDB, error) {
	connectionString := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s", username, password, host, port, database)

	db, err := sql.Open("mysql", connectionString)
	if err != nil {
		return nil, err
	}

	err = db.Ping()
	if err != nil {
		return nil, err
	}

	return &MySQLDB{db: db}, nil
}

// Create a function to close the database connection.
func (db *MySQLDB) Close() error {
	err := db.db.Close()
	if err != nil {
		return err
	}

	return nil
}

// Example: Fetch all records from a table.
func (db *MySQLDB) GetAllRecords(tableName string, where map[string]string) ([]map[string]interface{}, error) {
	query := fmt.Sprintf("SELECT * FROM %s", tableName)

	rows, err := db.db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	columns, err := rows.Columns()
	if err != nil {
		return nil, err
	}

	result := make([]map[string]interface{}, 0)
	values := make([]interface{}, len(columns))
	valuePointers := make([]interface{}, len(columns))
	for i := range columns {
		valuePointers[i] = &values[i]
	}

	for rows.Next() {
		err := rows.Scan(valuePointers...)
		if err != nil {
			return nil, err
		}

		entry := make(map[string]interface{})
		for i, col := range columns {
			entry[col] = values[i]
		}
		result = append(result, entry)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return result, nil
}
