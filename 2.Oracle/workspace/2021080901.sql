2021-0809-01)������̺��� �����ȣ 125��(Julia Mayer) ����� ������ 'ST-CLERK'���� 'ST-MAN'���� �����Ǿ���.
             �� ������ ������̺� �ݿ��ϰ� �� �� �����������̺��� �����Ͻÿ�.(Ʈ���� �ۼ�)

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
            
            DBMS_OUTPUT.PUT_LINE('���ο� ���� �����̷��� �Է��Ͽ����ϴ�');
        ELSIF V_CNT > 0 THEN
            INSERT INTO JOB_HISTORY(EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID)
            VALUES(:NEW.EMPLOYEE_ID, V_DATE + 1, SYSDATE - 1, :OLD.JOB_ID, :OLD.DEPARTMENT_ID);
            
            DBMS_OUTPUT.PUT_LINE('���� �����̷��� �����Ͽ����ϴ�');
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
    DBMS_OUTPUT.PUT_LINE('���� �����̷��� �����Ͽ����ϴ�');
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

�ι��� ������ ���� : HR���� ��ü���� ����� �� �̷°��� TRIGGER�� �ֱ� ����
+ AFTER/BEFORE [UPDATE/INSERT/DELETE] OF �÷��� ON ���̺��
���̺��� Ư�� �÷��� DML ����� ����Ǿ��� ��. �ٵ� INSERT�� DELETE�� �⺻������ �� ������ �÷������ �����ϴ� �������� UPDATE�� ����ɵ�
���ο� ����