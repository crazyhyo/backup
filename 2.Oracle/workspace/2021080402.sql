2021-0804-02)저장 프로시져(Stored Procedure)
  - 특정 목적으로 서버에 컴파일해 저장한 모듈
  - 처리속도의 향상 : 프로시져 내의 모든 구문을 하나의 Batch로 인식하여 한번에 분석 및 최적화 시키고 실행시킴
  - 네트워크의 Traffic 감소 : Client에서 Server로 전송할 SQL구문을 서버가 미리 저장하고 있어 Client에서 다량의
    SQL구문 대신 프로시져 이름과 매개변수만 전송
  - 반환값이 없음


 (사용형식)
  CREATE [OR REPLACE] PROCEDURE 프로시져명[(
    매개변수 [MODE] 타입 [:=값][,
              :
    매개변수 [MODE] 타입 [:=값]])]
  IS|AS
    선언영역
  BEGIN
    실행영역
  END;
   - 'OR REPLACE' : 같은 이름의 프로시져가 존재하면 OVERWRITE, 없으면 새롭게 생성
   - 'MODE' : 매개변수의 성격을 나타내며 IN (입력용), OUT(출력용), INOUT(입출력 공용) --INOUT은 쓰지 말자(부담이 큼), :=값은 디폴트값
   - '타입' : 매개변수의 데이터타입으로 크기를 지정하지 않음
   
일반 SQL 처리 과정 : 분석 - 최적화 - 컴파일 - 실행, 각 SQL 구문을 실행시킬 때마다 이 과정이 반복된다
프로시져는 이것을 컴파일까지 해두는 작업, 처리속도와 처리능률이 증가한다.

매개변수 전달 방법
CALL BY VALUE 값을 전달
CALL BY REFERENCE 주소를 전달

프로젝트 주제는 기업이 좋아하는 것을 하거나 진로의 타겟을 정해서 하자.
무난한 것은 공공SI, 특정 진로는 솔로션을 가지고 있는 회사, 게임개발회사

개발자 2년~4년(3-4000)이면 제 몫을 하는데 몸값은 싼 시기, 회사가 좋아함
중급개발자 5년이상(5000이상)

최종 프로젝트에서 많은 데이터에서 쿼리를 수행하면 속도가 느린 경우가 많음. 프로시져로 실행하는 것을 생각해야 함.

 (사용형식-실행)
  EXEC|EXECUTE 프로시저명[(매개변수LIST)];
  
  OR
  
  프로시저명[(매개변수LIST)]; --익명블록이나 다른 PL/SQL객체 내에서 실행
  
사용예)년도와 월과 제품코드를 입력 받아 해당제품의 입고수량을 집계하여 재고수불테이블에서 해당 제품의 재고를 갱신하는 프로시져 작성

CREATE OR REPLACE PROCEDURE PROC_BUY_REMAIN(
    P_YEAR  IN  CHAR,
    P_MONTH IN  VARCHAR2,
    P_PID   IN  VARCHAR2)
IS
    V_IAMT  NUMBER(5)   := 0;       --매입수량
    V_FLAG  NUMBER      := 0;   --매입자료 유무
    V_DATE  DATE        := TO_DATE(P_YEAR||P_MONTH||'01');  --날짜
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

(실행)
    EXEC PROC_BUY_REMAIN('2005','03','P201000017');

ROLLBACK;

사용예)사원번호를 입력받아 해당사원이 소속된 부서의 부서명, 인원수, 평균급여를 반환하는 프로시져를 작성하시오.

CREATE OR REPLACE PROCEDURE PROC_EMP_INFO(
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

CREATE OR REPLACE PROCEDURE PROC_EMP_INFO(
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








































