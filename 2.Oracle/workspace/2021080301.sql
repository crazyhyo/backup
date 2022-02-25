2021-0803-01)
   (2) CASE문
     - 표준 SQL의 SELECT 절에 사용되는 CASE표현식과 동일
     - 다중 분기 기능 제공
     (사용형식 - 1)
      CASE 변수|수식 WHEN 값1 THEN 명령1;
                    WHEN 값2 THEN 명령2;
                             :
                    ELSE          명령n;
      END CASE;
      
     (사용형식 - 2)
      CASE WHEN 조건1 THEN 명령1;
           WHEN 조건2 THEN 명령2;
                  :
           ELSE            명령n;
      END CASE;

IF보다 효율성이 우수함, SWITCH와 유사하나 BREAK필요 없음, PL/SQL의 CASE문은 END CASE로 끝남

사용예)10-110사이의 난수를 발생시켜 난수에 해당하는 부서에 속한 사원 중 첫번째 사원의 급여를 조회하여
      5000이하이면 '저임금 사원', 10000이하이면 '평균임금 사원', 그 이상이면 '고임금 사원'을 
      사원번호, 사원명, 부서명과 함께 출력하시오.
      
DECLARE
    V_EID   HR.EMPLOYEES.EMPOLYEE_ID    %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME       %TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
    V_SAL   HR.EMPLOYEES.SALARY         %TYPE;
    V_MESSAGE                           VARCHAR2(20);
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    V_DID := TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
    
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY,
           CASE WHEN SALARY <= 5000     THEN '저임금 사원'
                WHEN SALARY <= 10000    THEN '평균임금 사원'
                ELSE                         '고임금 사원'
           END
      INTO V_EID, V_ENAME, V_DNAME, V_SAL, V_MESSAGE
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.DEPARTMENT_ID = V_DID;
    DBMS_OUTPUT.PUT_LINE(V_EID || ' ' || V_ENAME || ' ' || V_DNAME || ' ' || V_SAL || ' ' V_MESSAGE);
END;

DECLARE
    V_EID   HR.EMPLOYEES.EMPLOYEE_ID        %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME           %TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE;
    V_SAL   HR.EMPLOYEES.SALARY             %TYPE;
    V_MESSAGE                               VARCHAR2(20);
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID    %TYPE;
BEGIN
    V_DID := TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
    
    DBMS_OUTPUT.PUT_LINE(V_DID);
    
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY
      INTO V_EID, V_ENAME, V_DNAME, V_SAL
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.DEPARTMENT_ID = V_DID
           AND ROWNUM = 1;
           
    CASE WHEN V_SAL <= 5000     THEN V_MESSAGE := '저임금 사원';
         WHEN V_SAL <= 10000    THEN V_MESSAGE := '평균임금 사원';
         ELSE                        V_MESSAGE := '고임금 사원';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || V_DNAME);
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || V_EID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('비고 : ' || V_MESSAGE);
END;

  2) 반복문
   - 오라클의 반복문은 LOOP, WHILE, FOR문이 제공
   (1) LOOP 문
    - 반복문의 기본 구조
     (사용형식)
     LOOP
        반복처리명령문[N];
        [EXIT WHEN 조건;]
     END LOOP;
      - 기본적으로 무한루프
      - 'EXIT WHEN 조건' : 조건이 참(TRUE)이면 반복을 벗어남(END LOOP 다음으로 제어 이동)

오라클은 데이터베이스
자료를 정확하게 저장하고 제공하는 것 // 사용자의 판단을 위한 자료 제공이 궁극적인 목표
프로그래밍을 위한 기능들이 아님, 반복문은 CURSOR와 같이 쓰인다

사용예) 구구단의 7단을 출력하는 블록을 작성하시오

DECLARE
    V_CNT NUMBER := 1;
    V_RES NUMBER := 0;
BEGIN
    LOOP
        V_RES := V_CNT * 7;
        EXIT WHEN V_CNT > 9;
        DBMS_OUTPUT.PUT_LINE(7 || ' * ' || V_CNT || ' = ' || V_RES);
        V_CNT := V_CNT + 1;
    END LOOP;
END;

PL/SQL을 실행했는데 실행시간이 오래 걸리면 숫자변수를 초기화하지 않고 사용했는지 확인하라

   (2) WHILE 문
    - 개발언어의 WHILE문과 동일 기능 및 구조
    (사용형식)
     WHILE 조건 LOOP
        반복처리명령문[n];
     END LOOP; 
      - '조건'이 참이면 반복 수행

사용예)구구단의 7단을 출력하시오.

DECLARE
    V_CNT NUMBER := 1;
    V_RES NUMBER := 0;
BEGIN
    WHILE V_CNT <= 9 LOOP
        V_RES := V_CNT * 7;
        DBMS_OUTPUT.PUT_LINE(7 || ' * ' || V_CNT || ' = ' || V_RES);
        V_CNT := V_CNT + 1;
    END LOOP;
END;

