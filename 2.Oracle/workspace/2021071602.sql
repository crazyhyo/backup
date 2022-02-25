2021-0716-02)집계함수
  - 주어진 자료를 특정 컬럼을 기준으로 그룹으로 나누고 그룹별로 자료에 대한 집계를 반환하는 함수
  - SUM, AVG, COUNT, MIN, MAX
  (사용형식)
    SELECT  [컬럼list],
            SUM|AVG|COUNT(column|*)|MIN|MAX(expr),
            
    FROM    테이블명
    [WHERE 조건]
    [GROUP BY 컬럼명[, 컬럼명,...]]
    [HAVING 조건]
    [ORDER BY 컬럼명|컬럼인덱스[ASC|DESC]][,컬럼명|컬럼인덱스[ASC|DESC],...];

GROUP BY : 특정 컬럼을 조회하며 그 컬럼의 값이 같은 행끼리 묶는다.
GROUP BY 뒤에 있는 컬럼의 순서 중요
가장 왼쪽 부터 그룹으로 묶는 것이 순차적으로 실행됨
왼쪽에 컬럼을 기술하면 할 수록 그 그룹 안에서 다음 컬럼을 기준으로 묶는 방식을 반복한다.
GROUP BY만 사용해서는 전체의 합계를 구할 수 없어서   ROLLUP(컬럼명list) 는 컬럼명 + 1 개의 합계를 반환
                                                CUBE(컬럼명list) 는 2 ^ (컬럼명) 개의 합계를 반환
부서코드별 인원수, 평균임금을 구하시오
HAVING 조건은 집계함수의 결과에 대한 조건
    이유 : SELECT문의 실행 순서 [FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY]
    집계함수의 결과값은 GROUP BY가 실행 된 이후에 알 수 있다.
    WHERE에 집계함수의 결과값을 참조하려고 하는 경우 테이블을 찾고 바로 집계함수의 결과값을 조회해야 하는데
    이 시점에서 GROUP BY절이 실행되지 않았기 때문에 집계함수의 결과값을 찾을 수 없다는 에러를 발생시킨다.
    따라서 집계함수의 결과에 대한 조건은 GROUP BY가 실행 된 이후에 컴파일러가 찾는 HAVING절 에서 주어야 한다.

GROUP BY절이 필요 없는 경우 : 전체 데이터를 하나의 그룹으로 간주할 때(전체 데이터의 수를 구할 때)
    
  1. SUM(expr)
   - 'expr'로 표현되는 수식 또는 컬럼의 값에 대한 합계를 반환

사용예)사원테이블에서 모든 사원의 급여 총액을 구하시오
    SELECT      EMP_NAME,
                SUM(SALARY)
    FROM        HR.EMPLOYEES
    GROUP BY    EMP_NAME;
    
    SELECT      --EMP_NAME,
                SUM(SALARY)
    FROM        HR.EMPLOYEES;
    --GROUP BY    EMP_NAME;
    
    SELECT      EMP_NAME
    FROM        HR.EMPLOYEES;
    GROUP BY    SALARY;
   
사용예)사원테이블에서 부서별 급여 합계를 구하시오.
    SELECT      DEPARTMENT_ID       AS  "부서코드",
                COUNT(*)            AS  "부서인원",
                SUM(SALARY)         AS  "급여합계"
    FROM        HR.EMPLOYEES
    GROUP BY    DEPARTMENT_ID
    ORDER BY    1;

사용예)사원테이블에서 부서별 급여 합계를 구하되, 합계가 10000이상인 부서만 조회하시오.
    SELECT      DEPARTMENT_ID   AS  "부서코드",
                SUM(SALARY)     AS  "급여합계"
    FROM        HR.EMPLOYEES
--    WHERE       SUM(SALARY) >= 10000
--                DEPARTMENT_ID != NULL         원하지 않는 결과
--                DEPARTMENT_ID IS NOT NULL     NULL값을 다루므로 따로 NULL처리 함수 호출
    GROUP BY    DEPARTMENT_ID
    HAVING      SUM(SALARY) >= 10000
    ORDER BY    1;
    
사용예)2005년 5월 회원별 구매현황(회원번호, 구매수량합계, 구매금액합계)을 조회하시오
    SELECT      A.MEM_ID                             AS   "회원번호",
                SUM(B.CART_QTY)                      AS   "구매수량합계",
                TO_CHAR(SUM(B.CART_QTY * C.PROD_PRICE), '999,999,999,999L')        AS   "구매금액합계"
--                SUM(B.CART_QTY * C.PROD_PRICE)        AS   "구매금액합계"
    FROM        MEMBER A, CART B, PROD C
    WHERE       B.CART_MEMBER = A.MEM_ID
                AND B.CART_PROD = C.PROD_ID
                AND SUBSTR(B.CART_NO, 1, 6) = '200505'
    GROUP BY    A.MEM_ID;
    
    SELECT      A.CART_MEMBER                   AS      "회원번호",
                SUM(A.CART_QTY)                 AS      "구매수량합계",
                SUM(A.CART_QTY * B.PROD_PRICE)  AS      "구매금액합계"
    FROM        CART A, PROD B
    WHERE       A.CART_PROD = B.PROD_ID
                AND SUBSTR(A.CART_NO, 1, 6) = '200505'
    GROUP BY    A.CART_MEMBER;
    
사용예)2005년 월별 회원별 구매현황(월, 회원번호, 구매수량합계, 구매금액합계)을 조회하시오.
    SELECT      SUBSTR(A.CART_NO, 5, 2)                                 AS      "월",
                A.CART_MEMBER                                           AS      "회원번호",
                SUM(A.CART_QTY)                                         AS      "구매수량합계",
                SUM(A.CART_QTY * B.PROD_PRICE)                          AS      "구매금액합계"
    FROM        CART A, PROD B
    WHERE       A.CART_PROD = B.PROD_ID
                AND SUBSTR(A.CART_NO, 1, 4) = '2005'
    GROUP BY    SUBSTR(A.CART_NO, 5, 2), A.CART_MEMBER
    ORDER BY    1;
    
주의) WHERE절에서 ',' 안 쓴다고 생각해라. AND, OR, IN, ANY 만 쓴다. 특히 AND, OR이 ,를 대체한다

사용예)회원테이블에서 직업별 마일리지 합계를 구하시오.

    SELECT      MEM_JOB                                         AS  "직업",
--                COUNT(*)                                        AS  "인원수",
--                TO_CHAR(AVG(MEM_MILEAGE),'9,999.00')            AS  "평균 마일리지",
                SUM(MEM_MILEAGE)                                AS  "마일리지 합계"
    FROM        MEMBER
    GROUP BY    MEM_JOB
    ORDER BY    1;

    
    SELECT      COUNT(*)
    FROM        MEMBER
    WHERE       SUBSTR(MEM_REGNO2, 1, 1) = '2'
                OR  SUBSTR(MEM_REGNO2, 1, 1) = '4';
    
문제] 사원테이블에서 근무국가별 급여합계를 구하시오.

    SELECT      D.COUNTRY_NAME                                          AS      "근무국가",
                SUM(A.SALARY)                                           AS      "급여합계"
    FROM        HR.EMPLOYEES A, HR. DEPARTMENTS B, HR.LOCATIONS C,
                HR.COUNTRIES D
    WHERE       A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND     B.LOCATION_ID = C.LOCATION_ID
                AND     C.COUNTRY_ID = D.COUNTRY_ID
    GROUP BY    D.COUNTRY_NAME;
    
    SELECT      E.REGION_NAME                                           AS      "근무대륙",
                SUM(A.SALARY)                                           AS      "급여합계"
    FROM        HR.EMPLOYEES A, HR.DEPARTMENTS B,
                HR.LOCATIONS C, HR.COUNTRIES D,
                HR.REGIONS E
    WHERE       A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND     B.LOCATION_ID = C.LOCATION_ID
                AND     C.COUNTRY_ID = D.COUNTRY_ID
                AND     D.REGION_ID = E.REGION_ID
    GROUP BY    E.REGION_NAME;
    
    
    
    SELECT D.COUNTRY_ID                     AS  "근무국가코드",
           D.COUNTRY_NAME                   AS  "국가명",
           COUNT(*)                         AS  "사원수",
           TO_CHAR(SUM(A.SALARY),'999,999') AS  "급여합계"
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.COUNTRY_ID = D.COUNTRY_ID
     GROUP BY D.COUNTRY_ID, D.COUNTRY_NAME
     ORDER BY 3 DESC;
     
사용예)사원테이블에서 각 부서별 보너스 합계를 구하시오
      출력은 부서코드, 부서명, 보너스 합계이고, 보너스는 영업실적(COMMISION_PCT)과
      급여를 곱한 결과의 30%를 지급한다.
      
UPDATE HR.EMPLOYEES
   SET COMMISSION_PCT = 0.2
 WHERE EMPLOYEE_ID = 107;
 
 COMMIT;
      
    SELECT A.DEPARTMENT_ID                                  AS  "부서코드",
           B.DEPARTMENT_NAME                                AS  "부서명",
           SUM(A.SALARY * NVL(A.COMMISSION_PCT, 1) * 0.3)    AS  "보너스 합계"
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;

