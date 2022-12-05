create table users (
    id integer primary key AUTOINCREMENT,
    name text,
    pass text
);
INSERT INTO users (id, name, pass)
VALUES (1, 'user1', '123456');

create table announcements (
    id INTEGER primary key,
    content text
);
INSERT INTO announcements (id, content)
VALUES 
(1, 'Announcement of the HANU Foreign Language Proficiency Test, the output standard for students in the English language major, university level, distance learning form, courses 29 and 30.'),
(2, 'Exam schedule, list and instructions for computer-based NLNN exam for general English teachers at all levels, exam on December 3, 2022'),
(3, 'Admission results; Guide to university admission in the form of studying while working, 2nd batch in 2022');

create table courses(
    id integer primary key,
    name text,
    img_url text,
    discription text
);
INSERT INTO courses 
VALUES
(1, 'Data structures and Algorithms', './assets/image/ctdlvgt.jpg', 'This course will help you understand algorithms as well as understand the nature of data structures - a condition to become a good programmer.'),
(2, 'Java Basic', './assets/image/javabasic.jpg', 'Basic Java programming course for beginners, this course will be the foundation for an advanced Java course to progress to Java Web or Android programming, ...'),
(3, 'Python Basic', './assets/image/pythonbasic.jpg', 'Basic Python programming course with easy-to-understand exercises and theory, you can confidently move on to more advanced Python topics.'),
(4, 'JavaOOP', './assets/image/javaoop.jpg', 'Object-Oriented-Programming is an object-based programming method to find the essence of the problem. Java OOP course helps programmers learn programming techniques that all logic, ...');


create table myCourses(
    id integer primary key,
    user_id integer,
    course_id integer,
    status text,
    foreign key (user_id) references user(id),
    foreign key (course_id) references courses(course_id)
);
INSERT into myCourses
VALUES
(1, 1, 1, 'Done'),
(2, 1, 2, 'Learning');

create table quizes(
    id integer primary key,
    course_id integer,
    name text,
    foreign key (course_id) references courses(course_id)
);
INSERT INTO quizes(id, course_id, name)
VALUES
(1, 1, 'Mid-term'),
(2, 1, 'Final-test'),
(3, 2, 'Mid-term'),
(4, 2, 'Final-test'),
(5, 3, 'Mid-term'),
(6, 3, 'Final-test'),
(7, 4, 'Mid-term'),
(8, 4, 'Final-test');

create table answers(
    id integer primary key,
    content text
);
INSERT INTO answers 
VALUES
(1, ''),(2, ''),(3, ''),(4, ''),(5, ''),(6, ''),(7, ''),(8, ''),(9, ''),(10, ''),
(11, ''),(12, ''),(13, ''),(14, ''),(15, ''),(16, ''),(17, ''),(18, ''),(19, ''),(20, ''),
(21, ''),(22, ''),(23, ''),(24, ''),(25, ''),(26, ''),(27, ''),(28, ''),(29, ''),(30, ''),
(31, ''),(32, ''),(33, ''),(34, ''),(35, ''),(36, ''),(37, ''),(38, ''),(39, ''),(40, ''),
(41, ''),(42, ''),(43, ''),(44, ''),(45, ''),(46, ''),(47, ''),(48, ''),(49, ''),(50, ''),
(51, ''),(52, ''),(53, ''),(54, ''),(55, ''),(56, ''),(57, ''),(58, ''),(59, ''),(60, ''),
(61, ''),(62, ''),(63, ''),(64, ''),(65, ''),(66, ''),(67, ''),(68, ''),(69, ''),(70, ''),
(71, ''),(72, ''),(73, ''),(74, ''),(75, ''),(76, ''),(77, ''),(78, ''),(79, ''),(80, ''),
(81, ''),(82, ''),(83, ''),(84, ''),(85, ''),(86, ''),(87, ''),(88, ''),(89, ''),(90, ''),
(91, ''),(92, ''),(93, ''),(94, ''),(95, ''),(96, ''),(97, ''),(98, ''),(99, ''),(100, ''),
(101, ''),(102, ''),(103, ''),(104, ''),(105, ''),(106, ''),(107, ''),(108, ''),(109, ''),(110, ''),
(111, ''),(112, ''),(113, ''),(114, ''),(115, ''),(116, ''),(117, ''),(118, ''),(119, ''),(120, ''),
(121, ''),(122, ''),(123, ''),(124, ''),(125, ''),(126, ''),(127, ''),(128, ''),(129, ''),(130, ''),
(131, ''),(132, ''),(133, ''),(134, ''),(135, ''),(136, ''),(137, ''),(138, ''),(139, ''),(140, ''),
(141, ''),(142, ''),(143, ''),(144, ''),(145, ''),(146, ''),(147, ''),(148, ''),(149, ''),(150, ''),
(151, ''),(152, ''),(153, ''),(154, ''),(155, ''),(156, ''),(157, ''),(158, ''),(159, ''),(160, '');

create table questions(
    id integer primary key,
    content text,
    answer_id integer,
    quiz_id integer,
    foreign key (answer_id) references answers(answer_id),
    foreign key (quiz_id) references quizes(quiz_id)
);
INSERT INTO questions 
VALUES
(1, '', 1, 1), (2, '', 5, 1), (3, '', 1, 1), (4, '', 1, 1),
(5, '', 1, 2), (6, '', 1, 2), (7, '', 1, 2), (8, '', 1, 2),
(9, '', 1, 3), (10, '', 1, 3), (11, '', 1, 3), (12, '', 1, 3),
(13, '', 1, 4), (14, '', 1, 4), (15, '', 1, 4), (16, '', 1, 4),
(17, '', 1, 5), (18, '', 1, 5), (19, '', 1, 5), (20, '', 1, 5),
(21, '', 1, 6), (22, '', 1, 6), (23, '', 1, 6), (24, '', 1, 6),
(25, '', 1, 7), (26, '', 1, 7), (27, '', 1, 7), (28, '', 1, 7),
(29, '', 1, 8), (30, '', 1, 8), (31, '', 1, 8), (32, '', 1, 8),
(33, '', 1, 1), (34, '', 1, 2), (35, '', 1, 3), (36, '', 1, 4),
(37, '', 1, 5), (38, '', 1, 6), (39, '', 1, 7), (40, '', 1, 8);