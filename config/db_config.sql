-- clear the db before --

DROP TABLE IF EXISTS answer;
DROP TABLE IF EXISTS question;


-- Create the question table
CREATE TABLE question (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  text VARCHAR(255) NOT NULL,
  correct_answer_id INT NOT NULL,
  difficulty_point INT NOT NULL DEFAULT 0
);

-- Create the answer table
CREATE TABLE answer (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  text VARCHAR(255) NOT NULL,
  question_id INT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES question(id)
);

CREATE TABLE lobby (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  value INT
);


CREATE TABLE leaderboard (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL,
	points INT NOT NULL DEFAULT 0,
	order INT NOT NULL
);

-- Insert questions
INSERT INTO question (text, correct_answer_id, difficulty_point) VALUES
('What is the primary goal of consulting firms?', 1, 1),
('Which famous consulting firm was founded in 1963?', 2, 1),
('What are some key skills required for a successful consultant?', 4, 2),
('How does digital transformation impact the consulting industry?', 5, 2),
('What are some common challenges faced by consultants?', 7, 1),
('What is the role of data analytics in consulting?', 9, 2),
('How does consulting contribute to business growth and strategy?', 11, 2),
('What are the different types of consulting services offered by firms?', 13, 1),
('How has the COVID-19 pandemic affected the consulting industry?', 15, 2),
('What are some ethical considerations in the consulting profession?', 17, 1);

-- Insert answers
INSERT INTO answer (text, question_id) VALUES
('Providing expert advice and solutions to businesses.', 1),
('McKinsey & Company.', 2),
('Strong analytical skills, problem-solving abilities, and effective communication.', 3),
('It enables companies to leverage technology for improved efficiency and decision-making.', 4),
('Balancing client demands, managing tight deadlines, and adapting to diverse industries.', 5),
('Data analytics helps in identifying trends, making informed decisions, and improving performance.', 6),
('Consultants help businesses identify opportunities, optimize operations, and develop strategies.', 7),
('Management consulting, IT consulting, financial consulting, and human resources consulting.', 8),
('It has accelerated digital transformation and increased the demand for remote consulting.', 9),
('Maintaining confidentiality, avoiding conflicts of interest, and adhering to professional standards.', 10);

-- Insert additional incorrect answers for each question
-- Question 1
INSERT INTO answer (text, question_id) VALUES
('Providing administrative support to businesses.', 1),
('Designing marketing campaigns for businesses.', 1),
('Developing new products and services for businesses.', 1),
('Assessing the environmental impact of businesses.', 1);

-- Question 2
INSERT INTO answer (text, question_id) VALUES
('Boston Consulting Group.', 2),
('Bain & Company.', 2),
('Deloitte.', 2),
('Accenture.', 2);

-- Insert additional incorrect answers for Question 3
INSERT INTO answer (text, question_id) VALUES
('Public speaking skills and event planning abilities.', 3),
('Foreign language proficiency and translation skills.', 3),
('Physical fitness and sports-related knowledge.', 3),
('Graphic design skills and creative problem-solving.', 3),
('Leadership and team management skills.', 3);

-- Insert additional incorrect answers for Question 4
INSERT INTO answer (text, question_id) VALUES
('It reduces the need for human interaction in business processes.', 4),
('It has no impact on the consulting industry.', 4),
('It increases the complexity of consulting engagements.', 4),
('It leads to job losses in the consulting field.', 4),
('It enables companies to automate decision-making processes.', 4),
('It improves the accuracy of financial forecasting.', 4);

-- Insert additional incorrect answers for Question 5
INSERT INTO answer (text, question_id) VALUES
('Keeping up with the latest fashion trends.', 5),
('Negotiating contracts with suppliers.', 5),
('Managing social media accounts for clients.', 5),
('Handling customer support requests.', 5),
('Adapting to different organizational cultures.', 5),
('Creating marketing strategies for clients.', 5),
('Developing innovative solutions for clients.', 5);

-- Insert additional incorrect answers for Question 6
INSERT INTO answer (text, question_id) VALUES
('Data analytics is not relevant to consulting.', 6),
('Data analytics only applies to large corporations.', 6),
('Data analytics is used primarily for financial analysis.', 6),
('Data analytics is a manual and time-consuming process.', 6),
('Data analytics is only useful for historical data analysis.', 6),
('Data analytics can help identify customer behavior patterns.', 6);

-- Insert additional incorrect answers for Question 7
INSERT INTO answer (text, question_id) VALUES
('Consulting has no impact on business growth and strategy.', 7),
('Consulting focuses only on short-term goals and objectives.', 7),
('Consulting is limited to operational improvements.', 7),
('Consulting cannot provide actionable insights to businesses.', 7),
('Consulting is not aligned with organizational goals and objectives.', 7),
('Consulting lacks industry expertise and market knowledge.', 7);

-- Insert additional incorrect answers for Question 8
INSERT INTO answer (text, question_id) VALUES
('Business transformation consulting and logistics consulting.', 8),
('Environmental consulting and event planning consulting.', 8),
('Supply chain consulting and talent management consulting.', 8),
('Real estate consulting and hospitality consulting.', 8),
('Healthcare consulting and education consulting.', 8),
('Technology consulting and marketing consulting.', 8),
('Legal consulting and cybersecurity consulting.', 8);

-- Insert additional incorrect answers for Question 9
INSERT INTO answer (text, question_id) VALUES
('The consulting industry has remained unaffected by the pandemic.', 9),
('The pandemic has increased the demand for traditional consulting services.', 9),
('The pandemic has led to a decline in remote consulting engagements.', 9),
('The pandemic has resulted in a shortage of consulting talent.', 9),
('The pandemic has limited the scope of consulting projects.', 9),
('The pandemic has shifted consulting services towards digital platforms.', 9);

-- Insert additional incorrect answers for Question 10
INSERT INTO answer (text, question_id) VALUES
('Consultants are not bound by any ethical considerations.', 10),
('Consultants prioritize their personal interests over client interests.', 10),
('Consultants often engage in unethical competitive practices.', 10),
('Consultants are not accountable for their advice and recommendations.', 10),
('Consultants lack transparency in their billing and pricing models.', 10),
('Consultants face no legal consequences for unethical behavior.', 10);

