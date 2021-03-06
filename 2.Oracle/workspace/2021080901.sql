2021-0809-01)사원테이블에서 사원번호 125번(Julia Mayer) 사원의 직무가 'ST-CLERK'에서 'ST-MAN'으로 승진되었다.
             이 정보를 사원테이블에 반영하고 난 후 직무변동테이블을 갱신하시오.(트리거 작성)

UPDATE HR.EMPLOYEES
   SET (JOB_ID,SALARY) = (SELECT JOB_ID, MIN_SALARY
                            FROM JOBS
                           WHERE JOB_ID = 'ST-MAN')
 WHERE EMPLOYEE_ID = 125;

CREATE OR REPLACE TRIGGER TG_EMPLOYEES_JOB_HISTRORY_UPDATE
    AFTER UPDATE OF JOB_ID, DEPARTMENT_ID ON EMPLOYEES
    FOR EACH ROW
DECLARE
    V_CNT   NUMBER := 0;
    V_DATE  DATE;
BEGIN
    
        SELECT CNT, RNK INTO V_CNT, V_DATE
          FROM (SELECT EMPLOYEE_ID,
--                       COUNT(*) AS CNT,
                       COUNT(*) AS CNT
--                       RANK() OVER(ORDER BY END_DATE DESC) AS RNK
                  FROM JOB_HISTORY
                 WHERE :NEW.EMPLOYEE_ID = EMPLOYEE_ID
                 GROUP BY EMPLOYEE_ID) A
         WHERE ROWNUM = 1;
        
        IF V_CNT = 0 THEN
            INSERT INTO JOB_HISTORY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
            VALUES(:NEW.EMPLOYEE_ID, :OLD.HIRE_DATE, SYSDATE, :OLD.JOB_ID, :OLD.DEPARTMENT_ID);
            
            DBMS_OUTPUT.PUT_LINE('새로운 직무 변동이력을 입력하였습니다');
        ELSIF V_CNT > 0 THEN
            INSERT INTO JOB_HISTORY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
            VALUES(:NEW.EMPLOYEE_ID, V_DATE + 1, SYSDATE - 1, :OLD.JOB_ID, :OLD.DEPARTMENT_ID);
            
            DBMS_OUTPUT.PUT_LINE('직무 변동이력을 갱신하였습니다');
        END IF;
    
END;

SELECT EMPLOYEE_ID,
       COUNT(*) AS CNT,
       RANK() OVER(ORDER BY END_DATE DESC) AS RNK
  FROM JOB_HISTORY
 WHERE EMPLOYEE_ID = 122
 GROUP BY EMPLOYEE_ID, RANK() OVER(ORDER BY END_DATE DESC);
 
CREATE OR REPLACE TRIGGER TG_JOB_CHANGE
    AFTER UPDATE OF JOB_ID, DEPARTMENT_ID ON EMPLOYEES
    FOR EACH ROW
DECLARE
    V_EID   EMPLOYEES.EMPLOYEE_ID   %TYPE;
    V_CNT   NUMBER := 0;
    V_SDATE DATE;
    V_EDATE DATE;
BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM JOB_HISTORY
     WHERE EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
     
     V_EID := :NEW.EMPLOYEE_ID;
      
    IF V_CNT = 0 THEN
        V_SDATE :=:OLD.HIRE_DATE;
        V_EDATE := SYSDATE - 1;
    ELSE
        SELECT A.END_DATE INTO V_SDATE
          FROM (SELECT END_DATE
                  FROM JOB_HISTORY
                 WHERE EMPLOYEE_ID = 125
                 ORDER BY 1 DESC) A
         WHERE ROWNUM = 1;
        V_SDATE := V_SDATE + 1;
        V_EDATE := SYSDATE - 1;
    END IF;
    INSERT INTO JOB_HISTORY
    VALUES(V_EID, V_SDATE, V_EDATE, :OLD.JOB_ID, :OLD.DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('직무 변동이력을 갱신하였습니다');
END;

DECLARE
    V_SAL   EMPLOYEES.SALARY    %TYPE;
BEGIN
    SELECT MIN_SALARY INTO V_SAL
      FROM JOBS
     WHERE JOB_ID = 'ST_MAN';
     
    UPDATE EMPLOYEES
       SET SALARY = V_SAL,
           JOB_ID = 'ST_MAN'
     WHERE EMPLOYEE_ID = 125;
END;

DECLARE
BEGIN
    UPDATE EMPLOYEES
       SET (SALARY, JOB_ID) = (SELECT MIN_SALARY, JOB_ID
                                 FROM JOBS
                                WHERE JOB_ID = 'ST_MAN')
     WHERE EMPLOYEE_ID = 125;
END;
COMMIT;

DROP TRIGGER UPDATE_JOB_HISTORY;

두번씩 나오는 이유 : HR계정 자체에서 만들어 둔 이력관리 TRIGGER가 있기 때문
+ AFTER/BEFORE [UPDATE/INSERT/DELETE] OF 컬럼명 ON 테이블명
테이블의 특정 컬럼에 DML 명령이 수행되었을 때. 근데 INSERT랑 DELETE는 기본적으로 행 단위라 컬럼명까지 관여하는 디테일은 UPDATE만 적용될듯
새로운 문법