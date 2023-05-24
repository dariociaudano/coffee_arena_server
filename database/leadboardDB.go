package database

type Leadboard struct {
	Nick      string `json:"nick"`
	UserImage string `json:"user-image"`
	Order     int    `json:"order"`
	Points    int    `json:"points"`
}

func (conn *MySQLDB) RetrieveLeaderboard() ([]Leadboard, error) {
	query := `
		SELECT u.nick, u.image, l.order_pos, l.point
		FROM leadboard l
		INNER JOIN user u ON l.user_id = u.id
		ORDER BY l.order_pos ASC
	`

	rows, err := conn.db.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	leaderboard := make([]Leadboard, 0)

	for rows.Next() {
		var lb Leadboard
		if err := rows.Scan(&lb.Nick, &lb.UserImage, &lb.Order, &lb.Points); err != nil {
			return nil, err
		}

		leaderboard = append(leaderboard, lb)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return leaderboard, nil
}

func (conn *MySQLDB) ParseResponseDB(user_id int) (int, error) {
	query := ` SELECT points FROM leaderboard WHERE user_id = ?
	`
	var points int
	err := conn.db.QueryRow(query, user_id).Scan(&points)
	if err != nil {
		return points, err
	}

	return points, nil
}
