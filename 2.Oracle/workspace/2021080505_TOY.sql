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

select kor from toystudent;

select avg(kor), avg(eng), avg(math), avg(society), avg(science), avg(java), avg(oracle) from toystudent;

update TOYSTUDENT a
   set (stud_id, rank) = (select stud_id, rnk
                              from (select stud_id,
                                           kor + eng + math + society + science + java + oracle,
                                           rank() over(order by (kor + eng + math + society + science + java + oracle) desc) as rnk
                                      from toystudent) b
                            where a.stud_id = b.stud_id);
rollback;                            
                                  
select * from toystudent;

select stud_id, stud_name, kor, eng, math, society, science, java, oracle,
       kor + eng + math + society + science + java + oracle as tsum,
       round((kor + eng + math + society + science + java + oracle) / 7, 2) as tavg, rank
  from TOYSTUDENT;
                                                  