CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_EID   IN  HR.EMPLOYEES.EMPLOYEE_ID        %TYPE,
    P_DNAME OUT HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE,
    P_CNT   OUT                                 NUMBER,
    P_SAL   OUT                                 NUMBER)
IS
BEGIN
    SELECT B.DEPARTMENT_NAME, COUNT(A.EMPLOYEE_ID), ROUND(AVG(A.SALARY))
      INTO P_DNAME, P_CNT, P_SAL
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.EMPLOYEE_ID = P_EID
     GROUP BY B.DEPARTMENT_NAME;
END;


CREATE OR REPLACE PROCEDURE PROC_EMP01(
    P_EID   IN  HR.EMPLOYEES.EMPLOYEE_ID        %TYPE,
    P_DNAME OUT HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE,
    P_CNT   OUT                                 NUMBER,
    P_SAL   OUT                                 NUMBER)
IS
BEGIN
    SELECT B.DEPARTMENT_NAME, COUNT(A.EMPLOYEE_ID), ROUND(AVG(A.SALARY))
      INTO P_DNAME, P_CNT, P_SAL
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
           (SELECT A.DEPARTMENT_ID AS CID
              FROM HR.EMPLOYEES A
             WHERE A.EMPLOYEE_ID = P_EID) C
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND B.DEPARTMENT_ID = C.CID
     GROUP BY B.DEPARTMENT_NAME;
END;

(실행)
    DECLARE
        V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE;
        V_CNT                                    NUMBER := 0;
        V_SAL                                    NUMBER := 0;
    BEGIN
        PROC_EMP01(123, V_DNAME, V_CNT, V_SAL);
        DBMS_OUTPUT.PUT_LINE(V_DNAME);
        DBMS_OUTPUT.PUT_LINE(V_CNT);
        DBMS_OUTPUT.PUT_LINE(V_SAL);
    END;


--익명블록 안에서 변수에 값을 할당하는 방법 3가지(직접할당 제외)
1. SELECT INTO 할당
2. (CURSOR 이용) FETCH INTO 할당 (FOR문을 사용하면서 이제부터는 보기 힘들 것임)
3. 외부에서 컴파일한 PROCEDURE의 OUT 매개변수를 이용한 할당