2021-0720-02)NULL처리 함수
  - 오라클에서 각 컬럼의 기본 초기값은 모두 NULL임
  - NULL 자료에 대한 사칙연산 겨로가는 모두 NULL임
  - NULL 자료에 대한 연산자 및 함수로 IS NULL, IS NOT NULL, NVL, NVL2, NULLIF 등이 사용됨
  
  1. IS NULL, IS NOT NULL
   - 특정 컬럼이나 계산된 값이 NULL인지 판별하기 위해 사용
   - '='연산자로 NULL값 여부를 판별하지 못함
   
사용예) 사원테이블에서 영업실적코드(COMMISSION_PCT)가 NULL이 아닌 사원의
       사원번호, 사원명, 입사일, 부서코드, 급여를 조회하시오
       
    SELECT EMPLOYEE_ID          AS  "사원번호",
           EMP_NAME             AS  "사원명",
           HIRE_DATE            AS  "입사일",
           DEPARTMENT_ID        AS  "부사코드",
           SALARY               AS  "급여"
      FROM HR.EMPLOYEES
     WHERE COMMISSION_PCT IS NOT NULL
     ORDER BY 1;
     
   -- '=' '<>' '!='연산자로 NULL값 여부를 판별하지 못함     
   
   2. NVL(c, val)
    - 'c'의 값을 판단하여 그 값이 NULL이면 'val' 값을 반환하고, NULL이 아니면 'c'의 값을 반환
    - 'c'와 'val'의 자료형이 동일해야 함.
    
오라클에서는 숫자가 가장 강력함.
c와 val에서 한 쪽이 숫자고 한 쪽이 문자인 경우 서로 자동형변환이 불가능한 경우 오류가 발생한다.

사용예)상품테이블에서 PROD_SIZE 값이 NULL이면 '상품크기정보 없음' 문자열을 출력하시오
      Alias는 상품코드, 상품명, 크기, 매입단가
      
    SELECT PROD_ID                              AS  "상품코드",
           PROD_NAME                            AS  "상품명",
           NVL(PROD_SIZE,'상품크기정보 없음')     AS  "크기",
           PROD_COST                            AS  "매입단가"
      FROM PROD;
      
사용예)사원테이블에서 사원번호, 사원명, 부서코드, 직무코드를 출력하시오      
      단, 부서코드가 NULL이면 'CEO'를 출력하시오
      
    SELECT EMPLOYEE_ID                              AS  "사원번호",
           EMP_NAME                                 AS  "사원명",
           NVL(TO_CHAR(DEPARTMENT_ID),'CEO')        AS  "부서코드",
           JOB_ID                                   AS  "직무코드"
      FROM HR.EMPLOYEES;
      
**상품테이블에서 분류코드가 P301인 상품의 판매가를 매입가의 90%로 UPDATE하시오
UPDATE  PROD
SET     PROD_PRICE = PROD_COST
WHERE   LOWER(PROD_LGU) = LOWER('P301');

SELECT * FROM PROD
WHERE PROD_LGU = 'P301';

ROLLBACK;
COMMIT;

UPDATE -> SELECT -> COMMIT은 한 단위이다.

사용예)2005년 7월 모든 상품에 대한 판매정보를 조회하시오.
      Alias는 상품코드, 판매수량합계, 판매금액합계
      
    SELECT B.PROD_ID                        AS  "상품코드",
           SUM(A.CART_QTY)                  AS  "판매수량합계",
           SUM(A.CART_QTY * B.PROD_PRICE)   AS  "판매금액합계"
      FROM CART A, PROD B
     WHERE A.CART_PROD(+)= B.PROD_ID
           AND SUBSTR(A.CART_NO,1,6) = '200507'
     GROUP BY B.PROD_ID
     ORDER BY 2,3;
     
     
외부조인에서 일반조인조건이 실행되면 외부조인을 실행시키지 않고 일반조인(INNER JOIN)이 실행된다.
위의 예에서 오라클 조인조건 + 일반조인 조건이 적용되어 외부조인이 아니라 내부 조인이 실행되면서 원하는 형태로 출력되지 않았다

    SELECT B.PROD_ID                        AS  "상품코드",
           NVL(SUM(A.CART_QTY),0)                  AS  "판매수량합계",
           NVL(SUM(A.CART_QTY * B.PROD_PRICE),0)   AS  "판매금액합계"
      FROM CART A
     RIGHT OUTER JOIN PROD B ON(A.CART_PROD= B.PROD_ID
           AND SUBSTR(A.CART_NO,1,6) = '200507')
     GROUP BY B.PROD_ID
     ORDER BY 2,3 ASC;

좋은 출력습관은 NVL(,0)이다. NULL은 0으로 출력하는 것이다.

   3. NVL2(c, val1, val2)
   - 'c'값을 판단하여 그 값이 NULL이면 'val2'를 반환하고 NULL이 아니면 'val1'을 반환 함
   - 'val1'과 'val2'의 데이터 타입이 같아야 함
   - 이때 'c'의 데이터 타입은 무관

사용예)사원테이블에서 사원번호, 사원명, 부서코드, 직무코드를 출력하시오.
      단, 부서코드가 NULL이면 'CEO'를 출력하시오.
      
    SELECT EMPLOYEE_ID              AS  "사원번호",
           EMP_NAME              AS  "사원명",
           NVL2(DEPARTMENT_ID,TO_CHAR(DEPARTMENT_ID),'CEO')              AS  "부서코드",
           JOB_ID              AS  "직무코드" 
      FROM HR.EMPLOYEES;
      
사용예)상품테이블에서 상품의 색상정보(PROD_COLOR)의 값이 NULL이면 '색상정보 없는 상품'을, NULL이 아니면 '색상정보 보유 상품'을 출력하시오

SELECT PROD_ID AS  "상품코드",
       PROD_NAME AS  "상품명",
       NVL2(PROD_COLOR,'색상정보 보유 상품','색상정보 없는 상품') AS  "색상정보"
  FROM PROD;
  
   4. NULLIF(c1, c2)
    - 'c1'과 'c2'를 비교하여 같으면 NULL을 반환하고, 같지 않으면 c1을 반환 함
    
사용예)상품테이블에서 판매가와 매입가를 비교하여 같지 않으면 '정상상품', 같으면 '단종상품'을 비고란에 출력하시오
      Alias는 상품코드, 상품명, 매입가, 판매가, 비고
      
    SELECT PROD_ID AS "상품코드",
           PROD_NAME AS "상품명",
           PROD_COST AS "매입가",
           PROD_PRICE AS "판매가",
           NVL2(NULLIF(PROD_PRICE,PROD_COST), '정상상품', '단종상품') AS "비고"
      FROM PROD;

사용예)상품테이블에서 판매가와 매입가를 비교하여 같지 않으면 판매가를, 같으면 '단종상품'을 판매가란에 출력하시오
      Alias는 상품코드, 상품명, 매입가, 판매가
      
    SELECT PROD_ID AS "상품코드",
           PROD_NAME AS "상품명",
           PROD_COST AS "매입가",
           LPAD(NVL(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST)),'단종상품'),8) AS "판매가"
      FROM PROD;
      
    SELECT PROD_ID AS "상품코드",
           PROD_NAME AS "상품명",
           PROD_COST AS "매입가",
           NVL(LPAD(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST)),10),LPAD(TRIM('단종상품'),11)) AS "판매가"
      FROM PROD;
      
      
퀵베이직, 비주얼베이직이 한글이 포함한 글씨를 정렬하는데는 가장 좋은 언어이다.
