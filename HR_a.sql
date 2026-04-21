Create database HR

DROP TABLE IF EXISTS employee_survey;

CREATE TABLE employee_survey (
    department       VARCHAR(100),
    sum_response_id  BIGINT,
    sum_director     INT,
    sum_supervisor   INT,
    sum_staff        INT,
    sum_manager      INT,
    count_question   INT,
    count_response   INT,
    count_status     INT
);
INSERT INTO employee_survey VALUES
('Assessor-Treasurer''s Office',   3365640,   0,   36,  72,   12,  516,  513,  516),
('Assigned Council',               1300936,   0,   12,  12,   24,  216,  216,  216),
('Clerk of Superior Court',        2815215,   0,   24,  60,   36,  432,  432,  432),
('Communications Office',          1544614,   0,    0,   0,   36,  241,  239,  241),
('Council''s Office',              2127149,   0,   48,  24,   48,  324,  323,  324),
('District Court',                 3254654,   0,   24,  36,    0,  504,  502,  504),
('Economic Development',            551106,   0,    0,  12,   12,   84,   84,   84),
('Emergency Management',           1456079,   0,    0,   0,   48,  228,  226,  228),
('Exec Office & Directors',        2135142, 204,    0,  12,   24,  324,  323,  324),
('Facilities Management',          3743119,   0,   36,  60,   48,  577,  571,  577),
('Family Justice Center',           299210,   0,    0,   0,    0,   48,   46,   48),
('Finance and Performance Mgmt',   8343949,   0,  181, 264,  133, 1313, 1312, 1313),
('Human Resources',                2000408,   0,    0,   0,   97,  325,  323,  325),
('Human Services',                 7351955,   0,  120,  96,   48, 1165, 1161, 1165),
('Juvenile Court',                 5880761,   0,  144,  48,   48,  900,  900,  900),
('Medical Examiner',                888334,   0,    0,   0,    0,  132,  132,  132),
('Parks and Recreation',           4272366,   0,  192,  36,   96,  673,  666,  673),
('Planning and Public Works',     35267420,   0,  745, 672,  372, 5644, 5625, 5644),
('Prosecuting Attorney''s Office', 9102176,   0,  132,  72,   60, 1418, 1414, 1418),
('Sheriff''s Department',         14280360,   0,  240,  24,  120, 2185, 2178, 2185),
('Superior Court',                 2724187,   0,   60,   0,   24,  420,  420,  420);

select * from 
 employee_survey;
 
 --1. Overall Response Rate per Department:
 SELECT 
    department,
    count_question,
    count_response,
    count_status,
    ROUND((CAST(count_response AS FLOAT) / count_status) * 100, 2) AS response_rate_pct
FROM employee_survey
ORDER BY response_rate_pct ASC;

--2. Departments with Lowest Engagement (Problem Areas):
SELECT 
    department,
    count_question,
    count_response,
    count_status,
    ROUND((CAST(count_response AS FLOAT) / count_status) * 100, 2) AS response_rate_pct
FROM employee_survey
WHERE ROUND((CAST(count_response AS FLOAT) / count_status) * 100, 2) < 98
ORDER BY response_rate_pct ASC;

--  3. Management Layer Participation Analysis:
SELECT
    department,
    sum_director,
    sum_supervisor,
    sum_staff,
    sum_manager,
    (sum_director + sum_supervisor + sum_staff + sum_manager) AS total_mgmt_responses
FROM employee_survey
ORDER BY total_mgmt_responses DESC;

--4. Departments with Zero Management Participation:
SELECT department
FROM employee_survey
WHERE sum_director = 0 
  AND sum_supervisor = 0 
  AND sum_manager = 0
ORDER BY department;

--5. Top 5 Most Active Departments:
SELECT TOP 5
    department,
    count_question,
    count_response,
    ROUND((CAST(count_response AS FLOAT) / count_status) * 100, 2) AS response_rate_pct
FROM employee_survey
ORDER BY count_response DESC;

--6. Bottom 5 Least Active Departments:
SELECT TOP 5
    department,
    count_question,
    count_response,
    ROUND((CAST(count_response AS FLOAT) / count_status) * 100, 2) AS response_rate_pct
FROM employee_survey
ORDER BY count_response ASC;