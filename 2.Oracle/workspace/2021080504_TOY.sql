CREATE TABLE TOYSTUDENT(
    STUD_ID     NUMBER(4)       NOT NULL,
    STUD_NAME   VARCHAR2(20)    NOT NULL,
    KOR         NUMBER          DEFAULT 0,
    ENG         NUMBER          DEFAULT 0,
    MATH        NUMBER          DEFAULT 0,
    SOCIETY     NUMBER          DEFAULT 0,
    SCIENCE     NUMBER          DEFAULT 0,
    JAVA        NUMBER          DEFAULT 0,
    ORACLE      NUMBER          DEFAULT 0,
    RANK        NUMBER          DEFAULT 1,
    
    constraint PK_TOYSTUD primary key (STUD_ID)
);

DROP TABLE TOYSTUDENT;