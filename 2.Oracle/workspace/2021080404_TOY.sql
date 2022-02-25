��뿹)�������� 7���� ����Ͻÿ�.

DECLARE
    V_CNT   NUMBER := 0;
BEGIN
    LOOP
        V_CNT := V_CNT + 1;
        EXIT WHEN V_CNT > 9;
        DBMS_OUTPUT.PUT_LINE('7 * ' || V_CNT || ' = ' || V_CNT * 7);
    END LOOP;
END;

DECLARE
    V_CNT   NUMBER := 0;
BEGIN
    WHILE V_CNT < 9 LOOP
        V_CNT := V_CNT + 1;
        DBMS_OUTPUT.PUT_LINE('7 * ' || V_CNT || ' = ' || V_CNT * 7);
    END LOOP;
END;

DECLARE
BEGIN
    FOR I IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE('7 * ' || I || ' = ' || I * 7);
    END LOOP;
END;
��뿹)ù���� 100���� �����ϰ�, �� ������ ���� ������ 2�辿 ������ �� ���ʷ� 200������ �Ѵ� ���� ����ݾ��� ���Ͻÿ�

DECLARE
    V_CNT   NUMBER := 1;
    V_SUM   NUMBER := 0;
    V_MONEY NUMBER := 100;
BEGIN
    LOOP
        V_SUM := V_SUM + V_MONEY;
        EXIT WHEN V_SUM >= 2000000;
        V_MONEY := V_MONEY * 2;
        V_CNT := V_CNT + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE( V_SUM || ' ' || V_CNT);
END;

DECLARE
    V_CNT   NUMBER := 1;
    V_SUM   NUMBER := 0;
    V_MONEY NUMBER := 100;
BEGIN
    V_SUM := V_SUM + V_MONEY;
    WHILE V_SUM <= 2000000 LOOP
        V_MONEY := V_MONEY * 2;
        V_CNT := V_CNT + 1;
        V_SUM := V_SUM + V_MONEY;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE( V_SUM || ' ' || V_CNT);
END;

DECLARE
    V_SUM   NUMBER := 0;
    V_MONEY NUMBER := 100;
BEGIN
    
    FOR I IN 1..100 LOOP
        V_SUM := V_SUM + V_MONEY;
        
        IF V_SUM >= 2000000 THEN
            DBMS_OUTPUT.PUT_LINE( V_SUM || ' ' || I);
            EXIT;
        END IF;
        V_MONEY := V_MONEY * 2;
    END LOOP;
END;

��뿹)�⵵�� ���� ��ǰ�ڵ带 �Է� �޾� �ش���ǰ�� �԰������ �����Ͽ� ���������̺��� �ش� ��ǰ�� ��� �����ϴ� ���ν��� �ۼ�

CREATE OR REPLACE PROCEDURE PROC_BUY(
    P_YEAR  IN  VARCHAR2,
    P_MONTH IN  VARCHAR2,
    P_PID   IN  VARCHAR2)
IS
    V_AMT       NUMBER := 0;
    V_DATE      DATE;
    V_PNAME     PROD.PROD_NAME  %TYPE;
BEGIN
    V_DATE := TO_DATE(P_YEAR || P_MONTH || '01');
    SELECT B.PROD_NAME, COUNT(*) INTO V_PNAME, V_AMT
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD = B.PROD_ID
           AND A.BUY_PROD = P_PID
           AND A.BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE);
    
    
    UPDATE REMAIN
       SET REMAIN_I     = REMAIN_I + V_AMT,
           REMAIN_J_99  = REMAIN_J_99 + V_AMT,
           REMAIN_DATE  = LAST_DAY(V_DATE)
     WHERE PROD_ID = P_PID;
END;

EXEC PROC_BUY('2005', '05', 'P')

CREATE OR REPLACE PROCEDURE PROC_BUY_REMAIN(
    P_YEAR  IN  CHAR,
    P_MONTH IN  VARCHAR2,
    P_PID   IN  VARCHAR2)
IS
    V_IAMT  NUMBER(5)   := 0;       --���Լ���
    V_FLAG  NUMBER      := 0;   --�����ڷ� ����
    V_DATE  DATE        := TO_DATE(P_YEAR||P_MONTH||'01');  --��¥
BEGIN
    SELECT COUNT(*), SUM(BUY_QTY) INTO V_FLAG, V_IAMT
      FROM BUYPROD
     WHERE BUY_PROD = P_PID
           AND BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE);
    
    IF V_FLAG != 0 THEN
        UPDATE REMAIN
           SET REMAIN_I = REMAIN_I + V_IAMT,
               REMAIN_J_99 = REMAIN_J_99 + V_IAMT,
               REMAIN_DATE = LAST_DAY(V_DATE)
         WHERE REMAIN_YEAR = P_YEAR
               AND PROD_ID = P_PID;
    END IF;
    
END;

��뿹)�����ȣ�� �Է¹޾� �ش����� �Ҽӵ� �μ��� �μ���, �ο���, ��ձ޿��� ��ȯ�ϴ� ���ν����� �ۼ��Ͻÿ�.

CREATE OR REPLACE PROCEDURE PROC_EMP_DEPT(
    P_EID   IN  EMPLOYEES.EMPLOYEE_ID       %TYPE,
    P_DNAME OUT DEPARTMENTS.DEPARTMENT_NAME %TYPE,
    P_CNT   OUT                              NUMBER,
    P_SAL   OUT                              NUMBER)
IS
BEGIN
    SELECT B.DEPARTMENT_NAME, COUNT(A.EMPLOYEE_ID), ROUND(AVG(A.SALARY))
      INTO P_DNAME, P_CNT, P_SAL
      FROM EMPLOYEES A, DEPARTMENTS B,
           (SELECT DEPARTMENT_ID AS DID
              FROM EMPLOYEES
             WHERE EMPLOYEE_ID = P_EID) C
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND B.DEPARTMENT_ID = C.DID
     GROUP BY B.DEPARTMENT_NAME;
END;

DECLARE
    V_NAME  DEPARTMENTS.DEPARTMENT_NAME %TYPE;
    V_CNT                                NUMBER;
    V_SAL                                NUMBER;
BEGIN
    PROC_EMP_DEPT(113, V_NAME, V_CNT, V_SAL);
    
    DBMS_OUTPUT.PUT_LINE(V_NAME);
    DBMS_OUTPUT.PUT_LINE(V_CNT);
    DBMS_OUTPUT.PUT_LINE(V_SAL);
END;


��뿹)10-110������ ������ �߻����� ������ �ش��ϴ� �μ��� ���� ��� �� ù��° ����� �޿��� ��ȸ�Ͽ�
      5000�����̸� '���ӱ� ���', 10000�����̸� '����ӱ� ���', �� �̻��̸� '���ӱ� ���'�� 
      �����ȣ, �����, �μ���� �Բ� ����Ͻÿ�.
V_DID := TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
DECLARE
    V_EID   HR.EMPLOYEES.EMPLOYEE_ID        %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME           %TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE;
    V_DID                                   NUMBER :=  TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
    V_MSG   VARCHAR2(20);
    
    CURSOR CUR_EMP_DEPT IS
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME,
           CASE WHEN A.SALARY <= 5000   THEN    '���ӱ� ���'
                WHEN A.SALARY <= 10000  THEN    '����ӱ� ���'
                ELSE                            '���ӱ� ���'
           END AS CRIT
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND B.DEPARTMENT_ID = V_DID;
BEGIN
    
    OPEN CUR_EMP_DEPT;
    LOOP
        FETCH CUR_EMP_DEPT INTO V_EID, V_ENAME, V_DNAME, V_MSG;
        EXIT WHEN CUR_EMP_DEPT  %NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(V_EID);
        DBMS_OUTPUT.PUT_LINE(V_ENAME);
        DBMS_OUTPUT.PUT_LINE(V_DNAME);
        DBMS_OUTPUT.PUT_LINE(V_MSG);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
            
    END LOOP;
    CLOSE CUR_EMP_DEPT;
END;

DECLARE
    V_EID   HR.EMPLOYEES.EMPLOYEE_ID        %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME           %TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE;
    V_DID                                   NUMBER :=  TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
    V_MSG   VARCHAR2(20);
    
    CURSOR CUR_EMP_DEPT IS
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME,
           CASE WHEN A.SALARY <= 5000   THEN    '���ӱ� ���'
                WHEN A.SALARY <= 10000  THEN    '����ӱ� ���'
                ELSE                            '���ӱ� ���'
           END AS CRIT
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND B.DEPARTMENT_ID = V_DID;
BEGIN
    
    OPEN CUR_EMP_DEPT;
    FETCH CUR_EMP_DEPT INTO V_EID, V_ENAME, V_DNAME, V_MSG;
    WHILE CUR_EMP_DEPT  %FOUND LOOP
        
        
        DBMS_OUTPUT.PUT_LINE(V_EID);
        DBMS_OUTPUT.PUT_LINE(V_ENAME);
        DBMS_OUTPUT.PUT_LINE(V_DNAME);
        DBMS_OUTPUT.PUT_LINE(V_MSG);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
        FETCH CUR_EMP_DEPT INTO V_EID, V_ENAME, V_DNAME, V_MSG;        
    END LOOP;
    CLOSE CUR_EMP_DEPT;
END;

DECLARE
    V_DID   NUMBER :=  TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
BEGIN
    FOR ROW1    IN  (SELECT A.EMPLOYEE_ID AS EID, A.EMP_NAME AS ENAME, B.DEPARTMENT_NAME AS DNAME,
                            CASE WHEN A.SALARY <= 5000   THEN    '���ӱ� ���'
                                 WHEN A.SALARY <= 10000  THEN    '����ӱ� ���'
                                 ELSE                            '���ӱ� ���'
                            END AS CRIT
                       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
                      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                            AND B.DEPARTMENT_ID = V_DID)
    LOOP
    
        DBMS_OUTPUT.PUT_LINE(ROW1.EID);
        DBMS_OUTPUT.PUT_LINE(ROW1.ENAME);
        DBMS_OUTPUT.PUT_LINE(ROW1.DNAME);
        DBMS_OUTPUT.PUT_LINE(ROW1.CRIT);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
    END LOOP;
   
END;


SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME,
       CASE WHEN A.SALARY <= 5000   THEN    '���ӱ� ���'
            WHEN A.SALARY <= 10000  THEN    '����ӱ� ���'
            ELSE                            '���ӱ� ���'
       END AS CRIT
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_ID = 80;

��뿹1)2005�� 5�� �԰��ǰ�� �����Ȳ�� ��ȸ�ϴ� Ŀ���� �ۼ��Ͻÿ�.
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ����
      
DECLARE

BEGIN
    FOR TMPROW IN  (SELECT B.PROD_ID AS PID, B.PROD_NAME AS PNAME, NVL(SUM(C.CART_QTY),0) AS AMT
                      FROM BUYPROD A
                     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
                           AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
                      LEFT OUTER JOIN CART C ON(B.PROD_ID = C.CART_PROD
                           AND SUBSTR(C.CART_NO,1,6) = '200505')
                     GROUP BY B.PROD_ID, B.PROD_NAME
                     ORDER BY 1)
    LOOP
        DBMS_OUTPUT.PUT_LINE(TMPROW.PID);
        DBMS_OUTPUT.PUT_LINE(TMPROW.PNAME);
        DBMS_OUTPUT.PUT_LINE(TMPROW.AMT);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
    END LOOP;
END;

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                    NUMBER := 0;
    
    CURSOR CUR_BUT01 IS
    SELECT B.PROD_ID AS PID, B.PROD_NAME AS PNAME, NVL(SUM(C.CART_QTY),0) AS AMT
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
      LEFT OUTER JOIN CART C ON(B.PROD_ID = C.CART_PROD
           AND SUBSTR(C.CART_NO,1,6) = '200505')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
BEGIN
    
    OPEN CUR_BUT01;
    LOOP
        FETCH CUR_BUT01 INTO V_PID, V_PNAME, V_AMT;
        EXIT WHEN CUR_BUT01 %NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(V_PID);
        DBMS_OUTPUT.PUT_LINE(V_PNAME);
        DBMS_OUTPUT.PUT_LINE(V_AMT);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
    END LOOP;
    
    CLOSE CUR_BUT01;
END;

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                    NUMBER := 0;
    
    CURSOR CUR_BUT01 IS
    SELECT B.PROD_ID AS PID, B.PROD_NAME AS PNAME, NVL(SUM(C.CART_QTY),0) AS AMT
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
      LEFT OUTER JOIN CART C ON(B.PROD_ID = C.CART_PROD
           AND SUBSTR(C.CART_NO,1,6) = '200505')
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
BEGIN
    
    OPEN CUR_BUT01;
    FETCH CUR_BUT01 INTO V_PID, V_PNAME, V_AMT;
    WHILE  CUR_BUT01 %FOUND  LOOP
        DBMS_OUTPUT.PUT_LINE(V_PID);
        DBMS_OUTPUT.PUT_LINE(V_PNAME);
        DBMS_OUTPUT.PUT_LINE(V_AMT);
        DBMS_OUTPUT.PUT_LINE('--------------------------------');
        FETCH CUR_BUT01 INTO V_PID, V_PNAME, V_AMT;
    END LOOP;
    
    CLOSE CUR_BUT01;
END;

SELECT B.PROD_ID, B.PROD_NAME, NVL(SUM(C.CART_QTY),0)
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
  LEFT OUTER JOIN CART C ON(B.PROD_ID = C.CART_PROD
       AND SUBSTR(C.CART_NO,1,6) = '200505')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
      
��뿹2)2005�� ��ǰ�� �԰�����հ踦 ����ϴ� ����� Ŀ���� �̿��Ͽ� �ۼ��Ͻÿ�
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, �԰����      

DECLARE
BEGIN
    FOR TMPROW  IN
    (SELECT B.PROD_ID AS PID, B.PROD_NAME AS PNAME, SUM(BUY_QTY) AS AMT
       FROM BUYPROD A, PROD B
      WHERE A.BUY_PROD = B.PROD_ID
            AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
      GROUP BY B.PROD_ID, B.PROD_NAME
      ORDER BY 1)
    LOOP

    DBMS_OUTPUT.PUT_LINE(TMPROW.PID);
    DBMS_OUTPUT.PUT_LINE(TMPROW.PNAME);
    DBMS_OUTPUT.PUT_LINE(TMPROW.AMT);
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    
    END LOOP;
END;

DECLARE
    V_PID       PROD.PROD_ID    %TYPE;
    V_PNAME     PROD.PROD_NAME  %TYPE;
    V_AMT                       NUMBER := 0;
    
    CURSOR CUR_TMP IS
    SELECT B.PROD_ID AS PID, B.PROD_NAME AS PNAME, SUM(BUY_QTY) AS AMT
       FROM BUYPROD A, PROD B
      WHERE A.BUY_PROD = B.PROD_ID
            AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
      GROUP BY B.PROD_ID, B.PROD_NAME
      ORDER BY 1;
BEGIN
    OPEN CUR_TMP;
    LOOP
        FETCH CUR_TMP INTO V_PID, V_PNAME, V_AMT;
        EXIT WHEN CUR_TMP %NOTFOUND;
        
    DBMS_OUTPUT.PUT_LINE(V_PID);
    DBMS_OUTPUT.PUT_LINE(V_PNAME);
    DBMS_OUTPUT.PUT_LINE(V_AMT);
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    
    END LOOP;
    
    CLOSE CUR_TMP;
END;

DECLARE
    V_PID       PROD.PROD_ID    %TYPE;
    V_PNAME     PROD.PROD_NAME  %TYPE;
    V_AMT                       NUMBER := 0;
    
    CURSOR CUR_TMP IS
    SELECT B.PROD_ID AS PID, B.PROD_NAME AS PNAME, SUM(BUY_QTY) AS AMT
       FROM BUYPROD A, PROD B
      WHERE A.BUY_PROD = B.PROD_ID
            AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
      GROUP BY B.PROD_ID, B.PROD_NAME
      ORDER BY 1;
BEGIN
    OPEN CUR_TMP;
    FETCH CUR_TMP INTO V_PID, V_PNAME, V_AMT;
    WHILE CUR_TMP %FOUND LOOP

    DBMS_OUTPUT.PUT_LINE(V_PID);
    DBMS_OUTPUT.PUT_LINE(V_PNAME);
    DBMS_OUTPUT.PUT_LINE(V_AMT);
    DBMS_OUTPUT.PUT_LINE('--------------------------------');
    FETCH CUR_TMP INTO V_PID, V_PNAME, V_AMT;    
    END LOOP;
    
    CLOSE CUR_TMP;
END;

SELECT B.PROD_ID, B.PROD_NAME, SUM(BUY_QTY)
  FROM BUYPROD A, PROD B
 WHERE A.BUY_PROD = B.PROD_ID
       AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
  