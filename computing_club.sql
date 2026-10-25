CREATE DATABASE IF NOT EXISTS computing_club;
USE computing_club;
show databases;

DROP TABLE IF EXISTS member_activity;
DROP TABLE IF EXISTS Resource;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Community;

-- =====================================
-- 1. Member
-- =====================================
CREATE TABLE Member (
Academic_ID INT PRIMARY KEY,
Fname VARCHAR(50) NOT NULL,
Lname VARCHAR(50) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
Phone VARCHAR(15) CHECK (Phone LIKE '05%'),
Role VARCHAR(50) NOT NULL CHECK (Role IN ('Leader', 'Member', 'Organizer', 'Volunteer')),
College VARCHAR(100) NOT NULL,
Major VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

describe Member;

INSERT INTO Member VALUES
(4461001, 'Sara', 'Ali', 'sara1@uqu.edu.sa', '0501111111', 'Leader', 'Computer Science', 'Database'),
(4461002, 'Jana', 'Ahmed', 'jana2@uqu.edu.sa', '0502222222', 'Member', 'Computer Science', 'Artificial Intelligence'),
(4461003, 'Jawana', 'Saad', 'jawana3@uqu.edu.sa', '0503333333', 'Organizer', 'Computer Science', 'Cybersecurity'),
(4461004, 'Ghala', 'Hussein', 'ghala4@uqu.edu.sa', '0504444444', 'Member', 'Computer Science', 'Software Engineering'),
(4461005, 'Layan', 'Omar', 'layan5@uqu.edu.sa', '0505555555', 'Volunteer', 'Computer Science', 'Information Systems');
select * from Member;
-- =====================================
-- 2. Community
-- =====================================
CREATE TABLE Community (
Community_Name VARCHAR(100) PRIMARY KEY,
Description VARCHAR(255) NOT NULL,
Contact_Email VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

describe Community;



INSERT INTO Community VALUES
('Programming Club', 'Focuses on coding and software development', 'programming@uqu.edu.sa'),
('Design Club', 'Interested in UI/UX and graphic design', 'design@uqu.edu.sa'),
('Robotics Club', 'Works on robotics and AI projects', 'robotics@uqu.edu.sa'),
('Media Club', 'Handles media, photography and editing', 'media@uqu.edu.sa'),
('Volunteer Club', 'Organizes charity and volunteer events', 'volunteer@uqu.edu.sa');
select * from Community;







-- =====================================
-- 3. Activity
-- =====================================
CREATE TABLE Activity (
Activity_ID INT PRIMARY KEY,
Activity_Name VARCHAR(100) NOT NULL,
Description VARCHAR(255),
Date DATE NOT NULL,
Time TIME NOT NULL,
Location VARCHAR(100) NOT NULL,
Type VARCHAR(50) CHECK (Type IN ('Workshop', 'Training', 'Event')),
Community_Name VARCHAR(100) NOT NULL,
FOREIGN KEY (Community_Name) REFERENCES Community(Community_Name)
ON DELETE CASCADE
ON UPDATE CASCADE
) ENGINE=InnoDB;
describe Activity;

INSERT INTO Activity VALUES
(1, 'Coding Workshop', 'Learn coding basics', '2026-04-20', '10:00:00', 'Lab 1', 'Workshop', 'Programming Club'),
(2, 'UI Design', 'Design basics', '2026-04-21', '12:00:00', 'Lab 2', 'Workshop', 'Design Club'),
(3, 'Robot Build', 'Build robots', '2026-04-22', '02:00:00', 'Lab 3', 'Training', 'Robotics Club'),
(4, 'Video Editing', 'Edit videos', '2026-04-23', '11:00:00', 'Lab 4', 'Workshop', 'Media Club'),
(5, 'Charity Event', 'Help community', '2026-04-24', '01:00:00', 'Hall A', 'Event', 'Volunteer Club');
select * from Activity;
-- =====================================






-- 4. Resource
-- =====================================
CREATE TABLE Resource (
Resource_ID INT PRIMARY KEY,
Resource_Name VARCHAR(100) NOT NULL,
Resource_Type VARCHAR(50) NOT NULL,
Supplier_Name VARCHAR(100),
Activity_ID INT NOT NULL,
FOREIGN KEY (Activity_ID) REFERENCES Activity(Activity_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
) ENGINE=InnoDB;

describe Resource;




INSERT INTO Resource VALUES
(1, 'Laptop', 'Hardware', 'Dell', 1),
(2, 'Design Software', 'Software', 'Adobe', 2),
(3, 'Robot Kit', 'Hardware', 'Arduino', 3),
(4, 'Camera', 'Hardware', 'Canon', 4),
(5, 'Flyers', 'Material', 'PrintShop', 5);
select * from Resource;
-- =====================================






-- 5. member_activity (M:N)
-- =====================================
CREATE TABLE member_activity (
Academic_ID INT,
Activity_ID INT,
PRIMARY KEY (Academic_ID, Activity_ID),





FOREIGN KEY (Academic_ID) REFERENCES Member(Academic_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY (Activity_ID) REFERENCES Activity(Activity_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
) ENGINE=InnoDB;

describe member_activity;
INSERT INTO member_activity VALUES
(4461001, 1),
(4461001, 2),
(4461002, 2),
(4461003, 3),
(4461004, 4);
select * from member_activity;
show tables;




-- 3
-- =====================================
USE computing_club;

SELECT Fname, Email
FROM Member;



SELECT College, COUNT(*) AS Number_of_Members
FROM Member
GROUP BY College;


SELECT Activity_Name, Location, Date
FROM Activity
WHERE Type = 'Workshop';


SELECT count(Activity_Id) AS TotalActivities
FROM Activity;


SELECT *
FROM Activity
JOIN Community
ON Activity.Community_Name = Community.Community_Name;



SELECT Activity_Name
FROM Activity
WHERE Community_Name = (
    SELECT Community_Name
    FROM Community
    WHERE Community_Name = 'Design Club'
);


CREATE VIEW Activity_Report AS
SELECT Activity.Activity_Name,
       Activity.Location,
       Activity.Date,
       Community.Community_Name
FROM Activity
JOIN Community
ON Activity.Community_Name = Community.Community_Name;

SELECT * FROM Activity_Report;