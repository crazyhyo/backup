사원테이블에서 사원번호 125번(Julia Mayer) 사원의 직무가 'ST-CLERK'에서 'ST-MAN'으로 승진되었다.
             이 정보를 사원테이블에 반영하고 난 후 직무변동테이블을 갱신하시오.(트리거 작성)

    ** 사원테이블에 퇴직일자컬럼을 추가하시오
       컬럼명          타입       NULL여부
       RETIRE_DATE    DATE      
       
사용예)사원관리에 필요한 함수 등을 관리
      - 패키지명 : PKG_EMP
      - FN_GET_NAME : 사원번호를 입력받아 이름을 반환하는 함수
      - PROC_NEW_EMP : 신규사원정보 입력 프로시져(사원번호, LAST_NAME, 이메일, 입사일, JOB_ID)
      - PROC_RETIRE_EMP : 퇴직자처리 프로시져(사원번호 입력)
      
CREATE OR REPLACE TRIGGER TG_EMPLOYEE_JOB_HISTORY
    AFTER UPDATE OF JOB_ID, DEPARTMENT_ID ON EMPLOYEE
    FOR EACH ROW
DECLARE
    V_CNT   NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM JOB_HISTORY
     WHERE EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
     
    IF V_CNT = 0 THEN
        V_DATE = :OLD.HIRE_DATE;
    ELSE
        SELECT MAX(END_DATE) + 1 INTO V_DATE
          FROM JOB_HISTORY
         WHERE EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
    END IF;
    
    INSERT INTO JOB_HISTORY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
    VALUES(:OLD.EMPLOYEE_ID, V_DATE, SYSDATE -1, :OLD.JOB_ID, :OLD.DEPARTMENT_ID);
END;

ALTER TABLE EMPLOYEES ADD RETIRE_DATE DATE;

--CREATE OR REPLACE PACKAGE PKG_EMP IS
--    FUNCTION FN_GET_NAME(
--        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE)
--        RETURN  IN  EMPLOYEES.EMP_NAME      %TYPE
--    END FN_GET_NAME;
--    PROCEDURE PROC_NEW_EMP(
--        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE,
--        P_LNAME IN  EMPLOYEES.LAST_NAME     %TYPE,
--        P_EMAIL IN  EMPLOYEES.EMAIL         %TYPE,
--        P_JOBID IN  EMPLOYEES.JOB_ID        %TYPE)
--    END PROC_NEW_EMP;
--    PROCEDURE PROC_RETIRE_EMP(
--        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE)
--    END PROC_RETIRE_EMP;
--END PKG_EMP;

CREATE OR REPLACE PACKAGE PKG_EMP IS
    FUNCTION FN_GET_NAME(
        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE)
        RETURN  EMPLOYEES.EMP_NAME          %TYPE;
    PROCEDURE PROC_NEW_EMP(
        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE,
        P_LNAME IN  EMPLOYEES.LAST_NAME     %TYPE,
        P_EMAIL IN  EMPLOYEES.EMAIL         %TYPE,
        P_JOBID IN  EMPLOYEES.JOB_ID        %TYPE);
    PROCEDURE PROC_RETIRE_EMP(
        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE);
END PKG_EMP;

DROP PACKAGE PKG_EMP;

CREATE OR REPLACE PACKAGE BODY PKG_EMP IS
--    FUNCTION FN_GET_NAME(
--        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE)
--        RETURN      EMPLOYEES.EMP_NAME      %TYPE
--    IS
--        V_ENAME EMPLOYEES.EMP_NAME          %TYPE;
--    BEGIN
--        SELECT EMP_NAME INTO V_ENAME
--          FROM EMPLOYEE_ID
--         WHERE EMPLOYEE_ID = P_EID;
--        
--        RETURN V_ENAME;
--    END FN_GET_NAME;
    
--    PROCEDURE PROC_NEW_EMP(
--        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE,
--        P_LNAME IN  EMPLOYEES.LAST_NAME     %TYPE,
--        P_EMAIL IN  EMPLOYEES.EMAIL         %TYPE,
--        P_JOBID IN  JOBS.JOB_ID        %TYPE)
--    IS
--    BEGIN
--        INSERT INTO EMPLOYEES(EMPLOYEE_ID, LAST_NAME, EMAIL, JOB_ID, HIRE_DATE)
--        VALUES(P_EID, P_LNAME, P_EMAIL, P_JOBID, SYSDATE);
--    END PROC_NEW_EMP;
    PROCEDURE PROC_RETIRE_EMP(
        P_EID   IN  EMPLOYEES.EMPLOYEE_ID   %TYPE)
    IS
    BEGIN
        UPDATE EMPLOYEES
           SET RETIRE_DATE = SYSDATE
         WHERE EMPLOYEE_ID = P_EID;
    END PROC_RETIRE_EMP;
END PKG_EMP;
