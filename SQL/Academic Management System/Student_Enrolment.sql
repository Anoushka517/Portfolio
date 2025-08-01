create database Student_enrollment; 
use Student_enrollment;

-- Create table for storing student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    is_current ENUM('YES', 'NO') DEFAULT 'YES'
);

-- Create table for storing courses information
CREATE TABLE Unit (
    unit_code VARCHAR(15) PRIMARY KEY,
    unit_name VARCHAR(100),
    is_advanced ENUM('YES', 'NO') DEFAULT 'NO',
    enrollment INT DEFAULT 0,
    registration_date DATE
);

-- Create table for storing registrations (student-unit relationship)   
-- Update on 03/10/2024: added new column no_penlty_deadline. See ilearn announcement on 03/10/2024
-- Update on 07/10/2024: added new columns droped_out_date and status. 
CREATE TABLE Registration (
    student_id INT,
    unit_code VARCHAR(15),
    semester varchar(15),
    registration_date DATE,
    no_penalty_deadline DATE, 
    dropped_out_date DATE,
    status ENUM('active', 'dropped_with_penalty', 'dropped_without_penalty') DEFAULT 'active',  -- Newly added column
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);


-- Create table for storing student grades
-- Update on 07/10/2024: added new column status.
CREATE TABLE UnitGrade (
    student_id INT,
    unit_code VARCHAR(15),
    semester VARCHAR(15),
    marks DECIMAL(5, 2),
    status ENUM('active', 'dropped') DEFAULT 'active', 
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);

-- Create table for storing fee information
CREATE TABLE Fee (
    student_id INT,
    semester varchar(15),
    fee_amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    description VARCHAR(255),
    PRIMARY KEY (student_id, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


-- Insert data into Student table
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10001, 'Alice Smith', 'YES'),
(10002, 'Bob Johnson', 'YES'),
(10003, 'Charlie Brown', 'NO'),
(10004, 'David Wilson', 'YES'),
(10005, 'Emily Davis', 'NO'),
(10006, 'Frank Miller', 'YES'),
(10007, 'Grace Hall', 'YES'),
(10008, 'Hannah Lewis', 'YES'),
(10009, 'Ian Walker', 'NO'),
(10010, 'Julia Young', 'YES'),
(10011, 'Kevin Harris', 'YES'),
(10012, 'Lily Martin', 'YES'),
(10013, 'Mason White', 'NO'),
(10014, 'Nina Clark', 'YES'),
(10015, 'Oliver King', 'YES'),
(10016, 'Paul Scott', 'YES'),
(10017, 'Quinn Green', 'NO'),
(10018, 'Rachel Adams', 'YES'),
(10019, 'Samuel Turner', 'YES'),
(10020, 'Tina Baker', 'YES'),
(10021, 'John Doe', 'YES');


-- Insert data into Unit table
INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT101', 'Introduction to Programming', 'NO', 40, '2023-02-20'),
('IT102', 'Data Structures', 'NO', 35, '2023-02-20'),
('IT103', 'Database Systems', 'NO', 30, '2023-02-20'),
('IT401', 'Advanced Algorithms', 'YES', 20, '2023-02-20'),
('IT402', 'Machine Learning', 'YES', 25, '2023-02-20'),
('IT403', 'AI in Business', 'YES', 15, '2023-02-20'),
('IT404', 'Cybersecurity', 'YES', 18, '2023-02-20'),
('IT105', 'Operating Systems', 'NO', 30, '2023-02-20'),
('IT106', 'Web Development', 'NO', 28, '2023-02-20'),
('IT405', 'Cloud Computing', 'YES', 12, '2023-02-20');

-- Insert data into Registration table. 
-- Update on 07/10/2024: added data for new columns, droped_out_date and status. Also, updated no_penalty_deadline data
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10001, 'IT102', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10002, 'IT103', '2023S1', '2023-01-16', '2023-02-13', NULL, 'active'), 
(10002, 'IT105', '2023S1', '2023-01-16', '2023-02-13', '2023-02-10', 'dropped_without_penalty'), 
(10003, 'IT101', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'), 
(10003, 'IT401', '2023S1', '2023-01-17', '2023-02-14', NULL, 'active'), 
(10004, 'IT402', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10004, 'IT403', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10005, 'IT404', '2023S1', '2023-01-19', '2023-02-16', NULL, 'active'), 
(10005, 'IT102', '2023S1', '2023-01-19', '2023-02-12', '2023-02-20', 'dropped_with_penalty'), 
(10006, 'IT401', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10006, 'IT105', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10007, 'IT402', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10007, 'IT101', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10008, 'IT403', '2023S2', '2023-06-12', '2023-07-10', NULL, 'active'), 
(10008, 'IT102', '2023S2', '2023-06-12', '2023-07-10', '2023-07-15', 'dropped_with_penalty'), 
(10009, 'IT404', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10009, 'IT103', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10010, 'IT401', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10010, 'IT405', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10011, 'IT101', '2024S1', '2024-01-10', '2024-02-10', NULL, 'active'), 
(10011, 'IT402', '2024S1', '2024-01-10', '2024-02-07', NULL, 'active'), 
(10012, 'IT403', '2024S1', '2024-01-11', '2024-02-11', '2024-02-10', 'dropped_with_penalty'), 
(10012, 'IT102', '2024S1', '2024-01-11', '2024-02-11', NULL, 'active'), 
(10013, 'IT105', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10013, 'IT404', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10014, 'IT101', '2024S1', '2024-01-13', '2024-02-10', '2024-02-12', 'dropped_with_penalty'), 
(10014, 'IT405', '2024S1', '2024-01-13', '2024-02-10', NULL, 'active'), 
(10015, 'IT102', '2024S1', '2024-01-14', '2024-02-11', '2024-02-01', 'dropped_without_penalty'), 
(10015, 'IT403', '2024S1', '2024-01-14', '2024-02-11', NULL, 'active'), 
(10016, 'IT401', '2024S1', '2024-01-15', '2024-02-07', NULL, 'active'), 
(10016, 'IT103', '2024S1', '2024-01-15', '2024-02-12', '2024-02-10', 'dropped_without_penalty'), 
(10017, 'IT102', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10017, 'IT404', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10018, 'IT101', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10018, 'IT401', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10019, 'IT105', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10019, 'IT402', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10020, 'IT403', '2024S2', '2024-06-04', '2024-07-02', NULL, 'active'), 
(10020, 'IT101', '2024S2', '2024-06-04', '2024-06-30', NULL, 'active');


-- Insert data into UnitGrade table with semester, marks, and status (active or dropped)
-- Update on 07/10/2024: added data for new column status and updated marks for dropped units
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10001, 'IT101', '2023S1', 75.00, 'active'),
(10001, 'IT102', '2023S1', 65.00, 'active'),
(10002, 'IT103', '2023S1', 85.50, 'active'),
(10002, 'IT105', '2023S1', NULL, 'dropped'),
(10003, 'IT101', '2023S1', NULL, 'dropped'),
(10003, 'IT401', '2023S1', NULL, 'dropped'),
(10004, 'IT402', '2023S1', 55.00, 'active'),
(10004, 'IT403', '2023S1', 92.00, 'active'),
(10005, 'IT404', '2023S1', 50.00, 'active'), 
(10005, 'IT102', '2023S1', NULL, 'dropped'),
(10006, 'IT401', '2023S2', 47.00, 'active'),  
(10006, 'IT105', '2023S2', 60.00, 'active'),
(10007, 'IT402', '2023S2', 88.00, 'active'),
(10007, 'IT101', '2023S2', 30.00, 'active'), 
(10008, 'IT403', '2023S2', 90.00, 'active'),
(10008, 'IT102', '2023S2', NULL, 'dropped'), 
(10009, 'IT404', '2023S2', 40.00, 'active'),
(10009, 'IT103', '2023S2', 55.00, 'active'),
(10010, 'IT401', '2023S2', 85.00, 'active'),
(10010, 'IT405', '2023S2', 32.00, 'active'), 
(10011, 'IT101', '2024S1', 75.00, 'active'),
(10011, 'IT402', '2024S1', 65.00, 'active'),
(10012, 'IT403', '2024S1', NULL, 'dropped'), 
(10012, 'IT102', '2024S1', 70.00, 'active'),
(10013, 'IT105', '2024S1', 85.00, 'active'),
(10013, 'IT404', '2024S1', 48.00, 'active'),
(10014, 'IT101', '2024S1', NULL, 'dropped'), 
(10014, 'IT405', '2024S1', 88.00, 'active'),
(10015, 'IT102', '2024S1', NULL, 'dropped'), 
(10015, 'IT403', '2024S1', 90.00, 'active'),
(10016, 'IT401', '2024S1', 75.00, 'active'),
(10016, 'IT103', '2024S1', NULL, 'dropped'),  
(10017, 'IT102', '2024S2', 70.00, 'active'),
(10017, 'IT404', '2024S2', 68.00, 'active'),
(10018, 'IT101', '2024S2', 60.00, 'active'),
(10018, 'IT401', '2024S2', 80.00, 'active'),
(10019, 'IT105', '2024S2', 82.00, 'active'),
(10019, 'IT402', '2024S2', 90.00, 'active'),
(10020, 'IT403', '2024S2', 94.00, 'active'),
(10020, 'IT101', '2024S2', 78.00, 'active');


-- Insert data into Fee table
-- Update on 07/10/2024: updated data for fee_amount column 
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10001, '2023S1', 6500.00, 'PAID', 'Tuition Fee'),
(10001, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10002, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10002, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10003, '2023S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10003, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10004, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10004, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10005, '2023S1', 6500.00, 'UNPAID', 'Tuition Fee'),
(10005, '2023S2', 6500.00, 'PAID', 'Late Unit Enrollment Fee'),
(10006, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10006, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10007, '2023S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10007, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2024S1', 8500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10009, '2023S2', 6500.00, 'UNPAID', 'Tuition Fee'),
(10009, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10010, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10010, '2024S1', 8500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10012, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10012, '2024S2', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S2', 7500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10014, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S2', 8500.00, 'PAID', 'Dropped Unit Penalty'),
(10015, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10015, '2024S2', 6500.00, 'UNPAID', 'Tution Fee'),
(10016, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10016, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10017, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10017, '2023S2', 6500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10018, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10018, '2023S2', 6500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10019, '2024S2', 8500.00, 'PAID', 'Tuition Fee'),
(10019, '2023S2', 7500.00, 'PAID', 'Tution Fee'),
(10020, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10020, '2023S2', 8500.00, 'PAID', 'Tuition Fee');

DELIMITER //

CREATE FUNCTION CalculateTotalOutstandingBalance(
    p_student_id INT
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_outstanding_balance DECIMAL(10, 2);
    DECLARE v_penalty DECIMAL(10, 2);

    -- Initialize
    SET v_outstanding_balance = 0;
    SET v_penalty = 0;

    -- Step 1: Unpaid Fees
    SELECT IFNULL(SUM(fee_amount), 0)
    INTO v_outstanding_balance
    FROM Fee
    WHERE student_id = p_student_id
      AND status = 'UNPAID';

    -- Step 2: Penalty for dropped units AFTER the no-penalty deadline
    SELECT IFNULL(SUM(
        CASE 
            WHEN Unit.is_advanced = 'YES' THEN 600
            ELSE 400
        END), 0)
    INTO v_penalty
    FROM Registration
    JOIN Unit ON Registration.unit_code = Unit.unit_code
    WHERE Registration.student_id = p_student_id
      AND Registration.status = 'dropped_with_penalty'
      AND Registration.dropped_out_date > Registration.no_penalty_deadline;

    -- Step 3: Total
    SET v_outstanding_balance = v_outstanding_balance + v_penalty;

    RETURN v_outstanding_balance;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE RegisterStudentInUnit(
    IN p_student_id INT,
    IN p_unit_code VARCHAR(15),
    IN p_semester VARCHAR(15)
)
BEGIN
    DECLARE v_failed_units INT;
    DECLARE v_unpaid_fees DECIMAL(10,2);
    DECLARE v_is_advanced ENUM('YES', 'NO');
    DECLARE v_error_message VARCHAR(255);

    -- Step 1: Check for unpaid fees (BR2)
    SET v_unpaid_fees = CalculateTotalOutstandingBalance(p_student_id);

    IF v_unpaid_fees > 0 THEN
        SET v_error_message = 'Student has unpaid fees or penalties and cannot enroll.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Step 2: Check how many units student has failed (marks < 50)
    SELECT COUNT(*) INTO v_failed_units
    FROM UnitGrade
    WHERE student_id = p_student_id
      AND status = 'active'
      AND marks < 50;

    -- Step 3: Check if unit is advanced
    SELECT is_advanced INTO v_is_advanced
    FROM Unit
    WHERE unit_code = p_unit_code;

    -- Step 4: If unit is advanced and student failed >2 units → block (BR6)
    IF v_is_advanced = 'YES' AND v_failed_units > 2 THEN
        SET v_error_message = 'Student has failed more than 2 units and cannot enroll in advanced units.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Step 5: Prevent duplicate registration (BR1 – implicit)
    IF EXISTS (
        SELECT 1 FROM Registration
        WHERE student_id = p_student_id
          AND unit_code = p_unit_code
          AND semester = p_semester
    ) THEN
        SET v_error_message = 'Student is already registered in this unit for this semester.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_error_message;
    END IF;

    -- Step 6: Insert into Registration table
    INSERT INTO Registration (
        student_id, unit_code, semester, registration_date, no_penalty_deadline, status
    ) VALUES (
        p_student_id, p_unit_code, p_semester, CURDATE(), CURDATE() + INTERVAL 1 MONTH, 'active'
    );

END //

DELIMITER ;



-- Task 1 Test case 1
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (20001, 'John Doe', 'YES');

-- Insert registration (active, no dropped units)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (20001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'),
       (20001, 'IT401', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active');

-- Insert grades (student completed units)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (20001, 'IT101', '2023S1', 85.00, 'active'),
       (20001, 'IT401', '2023S1', 75.00, 'active');

-- Insert fee (all fees paid)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (20001, '2023S1', 7000.00, 'PAID', 'Tuition Fee');

-- Test scenario where student has no outstanding balance
SELECT CalculateTotalOutstandingBalance(20001) AS Outstanding_Balance;

-- Task 1 Test Case 2
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (20002, 'Jane Smith', 'YES');


-- Insert registration (active)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (20002, 'IT103', '2023S1', '2023-01-16', '2023-02-12', NULL, 'active'),
       (20002, 'IT404', '2023S1', '2023-01-16', '2023-02-12', NULL, 'active');

-- Insert grades (student completed units)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (20002, 'IT103', '2023S1', 90.00, 'active'),
       (20002, 'IT404', '2023S1', 80.00, 'active');

-- Insert fee (unpaid fees)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (20002, '2023S1', 9000.00, 'UNPAID', 'Tuition Fee');

-- Test scenario where student has unpaid fees
SELECT CalculateTotalOutstandingBalance(20002) AS Outstanding_Balance;

-- Task 1 Test Case 3
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (20003, 'Alice Cooper', 'YES');

-- Insert registration (dropped unit with penalty)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (20003, 'IT105', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'),
       (20003, 'IT401', '2023S2', '2023-01-17', '2023-02-12', NULL, 'active');

-- Insert grades (student completed the remaining unit)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (20003, 'IT401', '2023S2', 78.00, 'active');

-- Insert fee (student still owes fees for dropped unit penalty)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (20003, '2023S1', 3600.00, 'UNPAID', 'Dropped Unit Penalty'),
	   (20003, '2023S2', 4000, 'PAID', 'Tuition');

-- Test scenario where student has a penalty for dropped unit
SELECT CalculateTotalOutstandingBalance(20003) AS Outstanding_Balance;

-- Task 1 Test Case 4
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (20004, 'Bob Marley', 'YES');


-- Insert registration (one dropped unit and one active)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (20004, 'IT101', '2023S1', '2023-01-18', '2023-02-10', '2023-02-20', 'dropped_with_penalty'),
       (20004, 'IT404', '2023S2', '2023-01-18', '2023-02-10', NULL, 'active');

-- Insert grades (student completed one unit)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (20004, 'IT404', '2023S2', 85.00, 'active');

-- Insert fee (unpaid tuition and penalty)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (20004, '2023S1', 3400.00, 'UNPAID', 'Dropped Unit Penalty'),
       (20004, '2023S2', 8000.00, 'UNPAID', 'Tuition Fee');

-- Test scenario where student has both unpaid tuition and penalty
SELECT CalculateTotalOutstandingBalance(20004) AS Outstanding_Balance;

-- Task 2 Test Case 1
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (30001, 'David Beckham', 'YES');

-- Insert registration (for the previous semester, unpaid fees)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (30001, 'IT101', '2023S1', '2023-01-20', '2023-02-12', NULL, 'active');

-- Insert grades (student completed the unit)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (30001, 'IT101', '2023S1', 80.00, 'active');

-- Insert fee (unpaid fee from previous semester)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (30001, '2023S1', 6000.00, 'UNPAID', 'Tuition Fee');
-- Attempt to enroll in the next semester's advanced unit
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (30001, 'IT401', '2023S2', '2023-07-01', '2023-08-01', NULL, 'active');
-- Call the procedure to attempt enrollment
CALL RegisterStudentInUnit(30001, 'IT401', '2023S2');

-- Task 2 Test 2
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (30003, 'Roger Federer', 'YES');

-- Insert registration for previous semesters (3 failed units)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (30003, 'IT101', '2023S1', '2023-01-20', NULL, NULL, 'active'),
       (30003, 'IT102', '2023S1', '2023-01-20', NULL, NULL, 'active'),
       (30003, 'IT103', '2023S1', '2023-01-20', NULL, NULL, 'active');

-- Insert grades (student failed 3 units)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (30003, 'IT101', '2023S1', 45.00, 'active'),
       (30003, 'IT102', '2023S1', 35.00, 'active'),
       (30003, 'IT103', '2023S1', 40.00, 'active');

-- Insert fee (all fees paid)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (30003, '2023S1', 9000.00, 'PAID', 'Tuition Fee');

-- Attempt to enroll in an advanced unit in the next semester
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (30003, 'IT401', '2023S2', '2023-07-01', '2023-08-01', NULL, 'active');

-- Call the procedure to attempt enrollment in the advanced unit IT401
CALL RegisterStudentInUnit(30003, 'IT401', '2023S2');

-- Task 2 Test 3
-- Insert student
INSERT INTO Student (student_id, student_name, is_current)
VALUES (30004, 'Michael Jordan', 'YES');

-- Insert registration (previous semesters, only one failed unit)
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status)
VALUES (30004, 'IT101', '2023S1', '2023-01-20', NULL, NULL, 'active');

-- Insert grades (student passed one unit and failed one unit)
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status)
VALUES (30004, 'IT101', '2023S1', 70.00, 'active'); -- Passed unit

-- Insert fee (no unpaid fees for the previous semester)
INSERT INTO Fee (student_id, semester, fee_amount, status, description)
VALUES (30004, '2023S1', 6000.00, 'PAID', 'Tuition Fee');

-- Attempt to enroll student in the advanced unit 'IT402' for semester '2023S2'
CALL RegisterStudentInUnit(30004, 'IT402', '2023S2');

