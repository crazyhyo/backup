사용예) 모든 부서별 사원수를 조회하시오(NULL부서코드는 무시)
SELECT B.DEPARTMENT_ID AS "부서번호",
       B.DEPARTMENT_NAME AS "부서명",
       COUNT(A.EMP_NAME) AS "사원수"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1;

--SELECT B.DEPARTMENT_ID AS "부서번호",
--       B.DEPARTMENT_NAME AS "부서명",
--       COUNT(*) AS "사원수"
--  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
-- WHERE A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID
-- GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
-- ORDER BY 1;
 
 SELECT B.DEPARTMENT_ID AS "부서번호",
       B.DEPARTMENT_NAME AS "부서명",
       COUNT(A.EMP_NAME) AS "사원수"
  FROM HR.EMPLOYEES A
 RIGHT OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID)
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1;
 
--  SELECT B.DEPARTMENT_ID AS "부서번호",
--       B.DEPARTMENT_NAME AS "부서명",
--       COUNT(*) AS "사원수"
--  FROM HR.EMPLOYEES A
-- RIGHT OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID)
-- GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
-- ORDER BY 1;

사용예)2005년 월별 매입액 중 최대매입액, 최소매입액
      Alias는 월, 최대매입액, 최소매입액
SELECT B.MONTH AS "월",
       A.MAXV AS "최대매입액",
       A.MINV AS "최소매입액"
FROM   (SELECT MAX(A.TOTCOST) AS MAXV,
               MIN(A.TOTCOST) AS MINV
        FROM    (SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS MONTH,
                       SUM(B.PROD_COST * A.BUY_QTY) AS TOTCOST
                  FROM BUYPROD A, PROD B
                 WHERE A.BUY_PROD = B.PROD_ID
                       AND EXTRACT(YEAR FROM A.BUY_DATE) = '2005'
                 GROUP BY EXTRACT(MONTH FROM A.BUY_DATE)) A)A,
         (SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS MONTH,
               SUM(B.PROD_COST * A.BUY_QTY) AS TOTCOST
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND EXTRACT(YEAR FROM A.BUY_DATE) = '2005'
         GROUP BY EXTRACT(MONTH FROM A.BUY_DATE)) B
WHERE A.MAXV = B.TOTCOST
      OR A.MINV = B.TOTCOST;
GROUP BY A.MONTH;

SELECT EXTRACT(MONTH FROM BUY_DATE) AS MONTH,
               MAX(BUY_COST * BUY_QTY) AS ASDF,
               MIN(BUY_COST * BUY_QTY) AS QWER
          FROM BUYPROD
         WHERE EXTRACT(YEAR FROM BUY_DATE) = '2005'
         GROUP BY EXTRACT(MONTH FROM BUY_DATE)
         ORDER BY 1;

SELECT A.MONTH,
       A.TOTCOST
FROM    (SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS MONTH,
                       SUM(B.PROD_COST * A.BUY_QTY) AS TOTCOST
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND EXTRACT(YEAR FROM A.BUY_DATE) = '2005'
         GROUP BY EXTRACT(MONTH FROM A.BUY_DATE)
         ORDER BY 2 DESC) A
WHERE ROWNUM = 1;


사용예)2005년 5월 최대구매 고객정보를 조회하시오.
      Alias는 회원번호, 회원명, 구매금액      

SELECT A.MID, A.MNM, A.MON      
FROM    (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNM,
               SUM(A.CART_QTY * C.PROD_PRICE) AS MON
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
WHERE ROWNUM = 1;

SELECT A.MID, A.MNM, A.MON      
FROM    (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNM,
               SUM(A.CART_QTY * C.PROD_PRICE) AS MON
          FROM CART A
         INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505')
         INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
WHERE ROWNUM = 1;


사용예) 사원테이블에서 영업실적코드(COMMISSION_PCT)가 NULL이 아닌 사원의
       사원번호, 사원명, 입사일, 부서코드, 급여를 조회하시오
       
SELECT EMPLOYEE_ID AS "사원번호",
       EMP_NAME AS "사원명",
       HIRE_DATE AS "입사일",
       DEPARTMENT_ID AS "부서코드",
       SALARY AS "급여"
  FROM HR.EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;
       
사용예)상품테이블에서 PROD_SIZE 값이 NULL이면 '상품크기정보 없음' 문자열을 출력하시오
      Alias는 상품코드, 상품명, 크기, 매입단가

SELECT PROD_ID AS "상품코드",
       PROD_NAME AS "상품명",
       NVL(PROD_SIZE,'상품크기정보 없음') AS "크기",
       PROD_COST AS "매입단가"
  FROM PROD;
사용예)사원테이블에서 사원번호, 사원명, 부서코드, 직무코드를 출력하시오      
      단, 부서코드가 NULL이면 'CEO'를 출력하시오
SELECT EMPLOYEE_ID AS "사원번호",
       EMP_NAME AS "사원명",
       NVL(TO_CHAR(DEPARTMENT_ID), 'CEO') AS "부서코드",
       JOB_ID AS "직무코드"
  FROM HR.EMPLOYEES;
**상품테이블에서 분류코드가 P301인 상품의 판매가를 매입가의 90%로 UPDATE하시오
UPDATE PROD
   SET PROD_PRICE = PROD_COST
 WHERE PROD_LGU = 'P301';
사용예)2005년 7월 모든 상품에 대한 판매정보를 조회하시오.
      Alias는 상품코드, 판매수량합계, 판매금액합계
SELECT B.PROD_ID AS "상품코드",
       SUM(A.CART_QTY) AS "판매수량합계",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "판매금액합계"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200507'
 GROUP BY B.PROD_ID
 ORDER BY 1;
      
사용예)사원테이블에서 사원번호, 사원명, 부서코드, 직무코드를 출력하시오.
      단, 부서코드가 NULL이면 'CEO'를 출력하시오.      
SELECT EMPLOYEE_ID AS "사원번호",
       EMP_NAME AS "사원명",
       NVL(TO_CHAR(DEPARTMENT_ID),'CEO') AS "부서코드",
       JOB_ID AS "직무코드"
  FROM HR.EMPLOYEES;

사용예)상품테이블에서 상품의 색상정보(PROD_COLOR)의 값이 NULL이면 '색상정보 없는 상품'을, NULL이 아니면 '색상정보 보유 상품'을 출력하시오 
SELECT PROD_ID AS "상품코드",
       PROD_NAME AS "상품명",
       NVL2(PROD_COLOR,'색상정보 보유 상품','색상정보 없는 상품') AS "색상정보"
  FROM PROD;
사용예)상품테이블에서 판매가와 매입가를 비교하여 같지 않으면 '정상상품', 같으면 '단종상품'을 비고란에 출력하시오
      Alias는 상품코드, 상품명, 매입가, 판매가, 비고
SELECT PROD_ID AS "상품코드",
       PROD_NAME AS "상품명",
       PROD_COST AS "매입가",
       PROD_PRICE AS "판매가",
       NVL2(NULLIF(PROD_COST,PROD_PRICE),'정상상품','단종상품') AS "비고"
  FROM PROD;
사용예)상품테이블에서 판매가와 매입가를 비교하여 같지 않으면 판매가를, 같으면 '단종상품'을 판매가란에 출력하시오
      Alias는 상품코드, 상품명, 매입가, 판매가
SELECT PROD_ID AS "상품코드",
       PROD_NAME AS "상품명",
       PROD_COST AS "매입가",
       NVL(TO_CHAR(NULLIF(PROD_COST,PROD_PRICE)),'단종상품') AS "판매가"
  FROM PROD;
사용예)매입테이블에서 2005년 1월 상품별 매입현황을 조회하시오
      Alias는 상품코드, 상품명, 매입수량합계, 매입금액 합계
SELECT A.PROD_ID AS "상품코드",
       A.PROD_NAME AS "상품명",
       SUM(B.BUY_QTY) AS "매입수량합계",
       SUM(B.BUY_QTY * B.BUY_COST) AS "매입금액 합계"
  FROM PROD A, BUYPROD B
 WHERE B.BUY_PROD = A.PROD_ID
       AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
 GROUP BY A.PROD_ID, A.PROD_NAME;

      
사용예)사원테이블에서 관리자 사원번호가 121번인 부서에 속한 사원 정보를 조회하시오
Alias는 사원번호, 사원명, 부서명, 직무명이다.      
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       C.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = C.JOB_ID
       AND B.MANAGER_ID = 121;

SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       C.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.MANAGER_ID = 121)
 INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID);




사용예)2005년 거래처별 매출현황을 조회하시오
거래처코드 / 거래처명
      Alias는 거래처코드, 거래처명, 매출금액합계      
      
SELECT C.BUYER_ID AS "거래처코드",
       C.BUYER_NAME AS "거래처명",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "매출금액합계"
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,4) = '2005'
 GROUP BY C.BUYER_ID, C.BUYER_NAME
 ORDER BY 1;