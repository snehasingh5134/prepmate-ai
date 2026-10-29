CREATE TABLE colleges (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role VARCHAR(10) NOT NULL CHECK (role IN ('student','admin')),
  college_id INT REFERENCES colleges(id),
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE student_profiles (
  user_id INT PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  branch VARCHAR(80),
  batch_year INT,
  cgpa NUMERIC(4,2),
  phone VARCHAR(15),
  target_role VARCHAR(100)
);

CREATE TABLE skills (
  id SERIAL PRIMARY KEY,
  name VARCHAR(80) UNIQUE NOT NULL,
  category VARCHAR(50)
);

CREATE TABLE resumes (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  file_path TEXT NOT NULL,
  extracted_text TEXT,
  parsed_data JSONB,
  uploaded_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE student_skills (
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  skill_id INT REFERENCES skills(id),
  proficiency INT CHECK (proficiency BETWEEN 0 AND 100),
  source VARCHAR(10) DEFAULT 'resume',
  PRIMARY KEY (user_id, skill_id)
);

CREATE TABLE job_descriptions (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(120) NOT NULL,
  company VARCHAR(120),
  jd_text TEXT,
  required_skills JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE skill_gap_reports (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  resume_id INT REFERENCES resumes(id),
  jd_id INT REFERENCES job_descriptions(id),
  match_percent NUMERIC(5,2),
  skill_scores JSONB,
  top_gaps JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE interviews (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  jd_id INT REFERENCES job_descriptions(id),
  interview_type VARCHAR(20),
  difficulty VARCHAR(10),
  status VARCHAR(15) DEFAULT 'in_progress',
  overall_score NUMERIC(4,2),
  started_at TIMESTAMP DEFAULT NOW(),
  completed_at TIMESTAMP
);

CREATE TABLE interview_questions (
  id SERIAL PRIMARY KEY,
  interview_id INT REFERENCES interviews(id) ON DELETE CASCADE,
  order_no INT,
  question_text TEXT NOT NULL,
  topic VARCHAR(80)
);

CREATE TABLE interview_answers (
  id SERIAL PRIMARY KEY,
  question_id INT REFERENCES interview_questions(id) ON DELETE CASCADE,
  answer_text TEXT,
  technical_score INT,
  clarity_score INT,
  completeness_score INT,
  confidence_score INT,
  overall_score NUMERIC(4,2),
  feedback JSONB,
  answered_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE roadmaps (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id) ON DELETE CASCADE,
  gap_report_id INT REFERENCES skill_gap_reports(id),
  plan JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE announcements (
  id SERIAL PRIMARY KEY,
  admin_id INT REFERENCES users(id),
  title VARCHAR(150),
  body TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);