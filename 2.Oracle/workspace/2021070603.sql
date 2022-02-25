학생 데이터베이스 만들기

1. 엔티티 구분
-엔티티는 학생(학번, 이름, 나이, 성별, 전공이름, 전공코드, 성적, 수강과목), 전공(전공코드, 전공이름), 과목(과목코드, 과목이름, 수강생, 교수, 성적)

CREATE TABLE department(
    department_id            NUMBER(8)               NOT NULL,
    department_name          VARCHAR2(50)            NOT NULL,
    CONSTRAINT  pk_department    PRIMARY KEY(department_id)
);

INSERT INTO department(department_id,department_name) VALUES(1,'수학과');
INSERT INTO department(department_id,department_name) VALUES(2,'물리학과');
INSERT INTO department(department_id,department_name) VALUES(3,'화학과');
INSERT INTO department(department_id,department_name) VALUES(4,'화학공학과');
INSERT INTO department(department_id,department_name) VALUES(5,'생명공학과');
INSERT INTO department(department_id,department_name) VALUES(6,'기계공학과');
INSERT INTO department(department_id,department_name) VALUES(7,'컴퓨터공학과');
INSERT INTO department(department_id,department_name) VALUES(8,'전자전기공학과');

CREATE TABLE professor(
    professor_id        NUMBER(8)               NOT NULL,
    professor_name      VARCHAR2(50)            NOT NULL,
    department_id  NUMBER(8),
    CONSTRAINT  pk_professor    PRIMARY KEY(professor_id),
    CONSTRAINT  fk_professor_department   FOREIGN KEY(department_id) REFERENCES department(department_id)
);

INSERT INTO professor(professor_id,professor_name,department_id) VALUES(01,'가', 1);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(02,'나', 1);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(03,'다', 2);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(04,'라', 3);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(05,'마', 3);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(06,'바', 3);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(07,'사', 4);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(08,'아', 5);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(09,'자', 7);
INSERT INTO professor(professor_id,professor_name,department_id) VALUES(10,'차', 8);

CREATE TABLE student(
    student_id          NUMBER(8)           NOT NULL,
    student_name        VARCHAR2(50)        NOT NULL,
    department_id    NUMBER(8)           NOT NULL,
    student_age         NUMBER(4)           NOT NULL,
    student_address     VARCHAR2(50),
    CONSTRAINT  pk_student    PRIMARY KEY(student_id),
    CONSTRAINT  fk_student_department   FOREIGN KEY(department_id) REFERENCES department(department_id)
);

INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(001,'a', 1, 20, '대전');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(002,'b', 1, 20, '서울');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(003,'c', 1, 20, '인천');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(004,'d', 1, 21, '인천');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(005,'e', 1, 24, '대구');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(006,'f', 1, 26, '울산');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(007,'g', 1, 28, '부산');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(008,'h', 1, 22, '부산');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(009,'i', 1, 21, '서울');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(010,'j', 1, 21, '인천');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(011,'k', 1, 20, '광주');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(012,'l', 1, 20, '세종');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(013,'m', 1, 24, '양구');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(014,'n', 1, 23, '인천');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(015,'o', 1, 23, '서울');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(016,'p', 1, 20, '대전');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(017,'q', 1, 25, '부산');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(018,'r', 1, 25, '울산');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(019,'s', 1, 26, '부산');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(020,'t', 1, 23, '광주');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(021,'u', 1, 22, '목포');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(022,'w', 1, 21, '제주');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(023,'v', 1, 21, '수원');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(024,'x', 1, 20, '진안');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(025,'y', 1, 20, '천안');
INSERT INTO student(student_id,student_name,department_id,student_age,student_address) VALUES(026,'z', 1, 23, '광주');

UPDATE student SET department_id = 1 WHERE student_id = 001;
UPDATE student SET department_id = 2 WHERE student_id = 002;
UPDATE student SET department_id = 4 WHERE student_id = 003;
UPDATE student SET department_id = 4 WHERE student_id = 004;
UPDATE student SET department_id = 8 WHERE student_id = 005;
UPDATE student SET department_id = 7 WHERE student_id = 006;
UPDATE student SET department_id = 7 WHERE student_id = 007;
UPDATE student SET department_id = 2 WHERE student_id = 008;
UPDATE student SET department_id = 2 WHERE student_id = 009;
UPDATE student SET department_id = 3 WHERE student_id = 010;
UPDATE student SET department_id = 3 WHERE student_id = 011;
UPDATE student SET department_id = 6 WHERE student_id = 012;
UPDATE student SET department_id = 6 WHERE student_id = 013;
UPDATE student SET department_id = 8 WHERE student_id = 014;
UPDATE student SET department_id = 1 WHERE student_id = 015;
UPDATE student SET department_id = 3 WHERE student_id = 016;
UPDATE student SET department_id = 2 WHERE student_id = 017;
UPDATE student SET department_id = 5 WHERE student_id = 018;
UPDATE student SET department_id = 4 WHERE student_id = 019;
UPDATE student SET department_id = 4 WHERE student_id = 020;
UPDATE student SET department_id = 4 WHERE student_id = 021;
UPDATE student SET department_id = 6 WHERE student_id = 022;
UPDATE student SET department_id = 4 WHERE student_id = 023;
UPDATE student SET department_id = 2 WHERE student_id = 024;
UPDATE student SET department_id = 8 WHERE student_id = 025;
UPDATE student SET department_id = 7 WHERE student_id = 026;

CREATE TABLE course(
    course_id           NUMBER(8)           NOT NULL,
    course_name         VARCHAR2(20)            NOT NULL,
    professor_id NUMBER(8)           NOT NULL,
    CONSTRAINT  pk_course    PRIMARY KEY(course_id),
    CONSTRAINT  fk_course_professor   FOREIGN KEY(professor_id) REFERENCES professor(professor_id)
);

INSERT INTO course(course_id,course_name,professor_id) VALUES(0001,'확률과 통계', 01);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0002,'해석학', 02);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0003,'열역학', 03);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0004,'유기화학', 04);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0005,'무기화학', 05);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0006,'무기화학실험', 06);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0007,'유기화학실험', 06);
INSERT INTO course(course_id,course_name,professor_id) VALUES(0008,'합성공학', 07);

CREATE TABLE enrolment(
    student_id    NUMBER(8)       NOT NULL,
    course_id     NUMBER(8)       NOT NULL,
    enrolment_grade         VARCHAR2(4),
    CONSTRAINT pk_enrolment PRIMARY KEY (student_id,course_id),
    CONSTRAINT fk_enrolment_student FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_enrolment_course  FOREIGN KEY (course_id)  REFERENCES course(course_id)
);

INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(001,0001, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(001,0002, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(001,0003, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(002,0001, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(002,0002, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(002,0005, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(003,0001, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(003,0003, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(003,0006, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(003,0008, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(004,0001, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0001, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0002, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0003, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0004, 'A0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0005, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0006, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0007, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(005,0008, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(006,0001, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(006,0003, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(006,0007, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(007,0008, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(008,0001, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(008,0002, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(009,0001, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(009,0004, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(010,0003, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(010,0004, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(010,0005, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(011,0006, 'B0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(011,0007, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(011,0008, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(012,0001, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(012,0002, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(012,0005, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(012,0007, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(013,0001, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(013,0002, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(013,0005, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(013,0007, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(014,0001, 'C0');
INSERT INTO enrolment(student_id,course_id,enrolment_grade) VALUES(015,0001, 'C0');

select student_id from enrolment
where enrolment.enrolment_grade = 'A0' AND course_id = 0001;

select student_name from student A, enrolment B
where A.student_id = B.student_id and
B.enrolment_grade = 'A0' AND course_id = 0001;

select department_name from department A, student B, enrolment C
where A.department_id = B.department_id and
B.student_id = C.student_id and
C.enrolment_grade = 'A0' AND course_id = 0001;

DROP TABLE enrolment;
DROP TABLE student;
DROP TABLE course;
DROP TABLE professor;
DROP TABLE department;