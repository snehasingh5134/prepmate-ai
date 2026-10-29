Endpoint	Method	Kaam	Owner
/api/auth/register	POST	Naya user banao	M1
/api/auth/login	POST	Login, JWT token do	M1
/api/profile	GET / PUT	Student profile dekho / badlo	M1
/api/resume/upload	POST	PDF upload, text extract, parse	M1 + M2
/api/jd	POST	JD paste / role select karke save	M1
/api/analysis/skill-gap	POST	Resume + JD se gap report banao (Gemini)	M2
/api/analysis/:id	GET	Gap report dekho	M2
/api/interviews	POST	Personalized interview generate karo	M2
/api/interviews/:id	GET	Interview aur questions lo	M1
/api/interviews/:id/answer	POST	Answer submit, AI evaluation wapas	M2
/api/interviews/:id/complete	POST	Interview khatam, overall score	M2
/api/progress	GET	Student ki history aur scores	M1
/api/roadmap	POST / GET	30-day roadmap banao / dekho	M2
/api/admin/users	GET / DELETE	Users manage karo	M4
/api/admin/stats	GET	Batch stats, top skills, gap analytics	M4
/api/admin/skills	GET / POST / DELETE	Skills taxonomy	M4
/api/admin/announcements	GET / POST	Announcements	M4