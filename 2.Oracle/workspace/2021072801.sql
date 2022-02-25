2021-0728-01)집합연산자
  - 집합연산자는 SELECT문의 결과를 대상으로 연산을 수행
  - 복잡한 서브쿼리나 조인을 줄일 수 있음
  - 여러 개의 SELECT문을 하나로 묶는 역할 수행
  - UNION ALL, UNION, INTERSECT, MINUS 제공
  ** 주의사항
  - 각 SELECT문은 같은 수와 타입의 컬럼을 조회해야 함(집합연산의 대상은 같은 스키마를 가지고 있어야 한다)
  - 각 SELECT문들이 여러 개의 컬럼을 조회하는 경우 모든 컬럼에 대한 집합연산 수행
  - ORDER BY는 사용할 수 있으나 마지막 SELECT문에서만 사용 가능
  - 출력은 첫 번째 SELECT문에 의하여 결정 됨
  
UNION ALL : 교집합부분에 존재하는 데이터를 중복되는 수만큼 출력
UNION : 교집합부분에 존재하는 데이터를 한번만 출력

 1) UNION
  - 합집합의 결과를 반환
  - 교집합 부분의 중복은 배제됨

사용예)사원테이블에서 'Seattle'에 근무하는 사원과 'IT'부서에 근무하는 사원의
      사원번호, 사원명, 부서명, 직무명을 조회하시오

(1)'Seattle'에 근무하는 사원의 사원번호, 사원명, 소재지, 부서명, 직무명
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       C.CITY AS "소재지",
       B.DEPARTMENT_NAME AS "부서명",
       D.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND A.JOB_ID = D.JOB_ID
       AND C.CITY = 'Seattle';
(2)'Administration'부서에 근무하는 사원의 사원번호, 사원명, 소재지, 부서명, 직무명
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       D.CITY AS "소재지",
       B.DEPARTMENT_NAME AS "부서명",
       C.JOB_ID AS "직무명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C, HR.LOCATIONS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = C.JOB_ID
       AND B.LOCATION_ID = D.LOCATION_ID
       AND B.DEPARTMENT_NAME = 'Administration';

(결합);
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       C.CITY AS "소재지",
       B.DEPARTMENT_NAME AS "부서명",
       D.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND A.JOB_ID = D.JOB_ID
       AND C.CITY = 'Seattle'
UNION
--UNION ALL : 2개의 중복을 그대로 출력하여 20개의 행 출력
SELECT A.EMPLOYEE_ID,
       A.EMP_NAME,
       D.CITY,
       B.DEPARTMENT_NAME,
       C.JOB_TITLE
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C, HR.LOCATIONS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = C.JOB_ID
       AND B.LOCATION_ID = D.LOCATION_ID
       AND B.DEPARTMENT_NAME = 'Accounting'
 ORDER BY 1;

사용예)회원테이블에서 마일리지가 3000이상인 회원과 직업이 공무원인 회원의 
      회원번호, 회원명, 주소, 마일리지를 조회하시오

SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 3000
       OR MEM_JOB = '공무원'

SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 3000
UNION       
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
--       TO_NUMBER(MEM_REGNO1) AS "주민번호1"
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_JOB = '공무원'
 
UNION은 각각의 컬럼에 대하여 UNION이 실행된다.

 2) UNION ALL
  - 합집합의 결과를 반환
  - 교집합 부분(공통부분)이 중복되어 출력

사용예)회원테이블에서 마일리지가 2000이상인 회원과 직업이 주부인 회원의 
      회원번호, 회원명, 주소, 마일리지를 조회하시오
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 2000
UNION ALL
--UNIION
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_JOB = '주부'

사용예)2005년 4월과 7월에 팔린 상품정보를 조회하시오
      ALIAS 상품코드, 상품명, 판매가, 거래처명

SELECT DISTINCT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       B.PROD_PRICE AS 판매가,
       C.BUYER_NAME AS 거래처명
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,6) IN('200504','200507')
 ORDER BY 1;
       
SELECT DISTINCT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       B.PROD_PRICE AS 판매가,
       C.BUYER_NAME AS 거래처명
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200504%'
UNION
SELECT DISTINCT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       B.PROD_PRICE AS 판매가,
       C.BUYER_NAME AS 거래처명
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200507%'
 ORDER BY 1;

 3) INTERSECT
  - 교집합(공통부분)의 결과를 반환
  
사용예)2005년 4월에 판매된 상품 중 7월에도 팔린 상품정보를 조회하시오
      ALIAS 상품코드, 상품명, 판매가, 거래처명
SELECT DISTINCT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       B.PROD_PRICE AS 판매가,
       C.BUYER_NAME AS 거래처명
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200504%'
INTERSECT
SELECT DISTINCT B.PROD_ID AS 상품코드,
       B.PROD_NAME AS 상품명,
       B.PROD_PRICE AS 판매가,
       C.BUYER_NAME AS 거래처명
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200507%'
 ORDER BY 1;

DELETE CART
WHERE CART_NO IN (SELECT CART_NO
  FROM CART
 WHERE CART_MEMBER = 'p001'
       AND SUBSTR(CART_NO, 1, 6) = '200505');

DELETE CART C
 WHERE C.CART_MEMBER = 'p001'
       AND SUBSTR(C.CART_NO,1,6) = '200505';
       
DELETE CART A
WHERE EXISTS (SELECT CART_MEMBER
                FROM CART B
               WHERE UPPER(CART_PROD) = 'P302000001'
                     AND SUBSTR(CART_NO,1,6) = '200506'
                     AND CART_QTY >= 5
                     AND A.CART_NO = B.CART_NO
                     AND A.CART_PROD = B.CART_PROD);

DELETE CART A
 WHERE EXISTS (SELECT 1
                 FROM PROD
                WHERE A.CART_PROD = PROD_ID
                      AND A.CART_QTY * PROD_PRICE <= 50000
                      AND A.CART_NO LIKE '200504%');       

ROLLBACK;

사용예)부서명이 'Shipping'에 속한 사원 중 'Matthew Weiss'사원의 팀에 소속된 사원을 조회하시오
      사원번호, 사원명, 부서명, 입사일, 급여
SELECT B.EMPLOYEE_ID AS "사원번호",
       B.EMP_NAME AS "사원명",
       A.DEPARTMENT_NAME AS "부서명",
       B.HIRE_DATE AS "입사일",
       B.SALARY AS "급여"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B,
       (SELECT MANAGER_ID AS MID
          FROM HR.EMPLOYEES
         WHERE EMP_NAME = 'Matthew Weiss') C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.DEPARTMENT_NAME = 'Shipping'
       AND B.MANAGER_ID = C.MID;

SELECT B.EMPLOYEE_ID AS "사원번호",
       B.EMP_NAME AS "사원명",
       A.DEPARTMENT_NAME AS "부서명",
       B.HIRE_DATE AS "입사일",
       B.SALARY AS "급여"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B,
       (SELECT B.MANAGER_ID AS MID,
               B.EMPLOYEE_ID AS EID
          FROM HR.EMPLOYEES A, HR.EMPLOYEES B
         WHERE A.EMP_NAME = 'Matthew Weiss'
               AND A.EMPLOYEE_ID = B.MANAGER_ID) C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.DEPARTMENT_NAME = 'Shipping'
       AND B.EMPLOYEE_ID = C.EID
       AND B.MANAGER_ID = C.MID;
       
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       A.HIRE_DATE AS "입사일",
       A.SALARY AS "급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_NAME = 'Shipping'
INTERSECT
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       A.HIRE_DATE AS "입사일",
       A.SALARY AS "급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.EMP_NAME = 'Matthew Weiss'
       AND B.DEPARTMENT_NAME = 'Shipping'
       
 4) MINUS
  - MINUS 연산자 앞에 위치한 쿼리의 결과에서 MINUS 뒤에 기술된 쿼리의 결과를
    차감한 결과 반환
    
사용예)장바구니테이블에서 4월과 5월에 판매된 상품 중 4월만 판매된 상품의 상품번호, 상품명, 수량합계, 판매금액합계를 구하시오
--(4월 상품별 판매 집계)
SELECT B.PROD_ID AS "상품번호",
       B.PROD_NAME AS "상품명"
--       SUM(A.CART_QTY) AS "수량합계",
--       SUM(A.CART_QTY * B.PROD_PRICE) AS "판매금액합계"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504'
 GROUP BY B.PROD_ID, B.PROD_NAME
MINUS
--(5월 상품별 판매 집계)
--SELECT B.PROD_ID AS "상품번호",
--       B.PROD_NAME AS "상품명"
--       SUM(A.CART_QTY) AS "수량합계",
--       SUM(A.CART_QTY * B.PROD_PRICE) AS "판매금액합계"
--  FROM CART A, PROD B
-- WHERE A.CART_PROD = B.PROD_ID
--       AND SUBSTR(A.CART_NO,1,6) = '200505'
-- GROUP BY B.PROD_ID, B.PROD_NAME
--MINUS
--(7월 상품별 판매 집계)
SELECT B.PROD_ID AS "상품번호",
       B.PROD_NAME AS "상품명"
--       SUM(A.CART_QTY) AS "수량합계",
--       SUM(A.CART_QTY * B.PROD_PRICE) AS "판매금액합계"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200507'
 GROUP BY B.PROD_ID, B.PROD_NAME


CREATE OR REPLACE VIEW V_TEST AS
SELECT *
  FROM MEMBER
-- ORDER BY 1
UNION
SELECT *
  FROM MEMBER
WITH READ ONLY;

SELECT * FROM V_TEST;
DROP VIEW V_TEST;
DROP VIEW V_MEM01;
DROP VIEW V_TEMP;

쿼리의 궁극적 목적 : 의사결정의 기초자료 제공
연습해야 하는 쿼리는 실생활에서 조회할 쿼리, 연습을 위한 쿼리는 의미가 없다.

디자인 패턴 - 클래스를 만드는 규칙
싱글톤 패턴 : 가장 간단한 디자인패턴, 객체생성은 한번만 하고 이후 참조만 하는 형식
MVC(TWO) 패턴 : 가장 널리 사용하는 패턴, 자바의 근간이 되는 패턴, 데이터베이스를 연결할 때 반드시 적용됨

침체기 상승곡선 