사용예)회원들의 자료에서 성별 평균마일리지를 구하고 자신의 성별 평균마일리지보다 많은 마일리지를 보유한 회원의
      2005년 4~6월 구매현황을 조회하시오. / 회원번호, 회원명, 구매수량, 구매금액, 마일리지, 성별, 성별평균마일리지

CREATE OR REPLACE VIEW V_GEN_MEMBER AS
SELECT MEM_ID AS MID,
       MEM_NAME AS MNAME,
       MEM_MILEAGE AS MIL,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여자'
       END AS GEN
  FROM MEMBER
WITH READ ONLY;


 
CREATE OR REPLACE VIEW V_AMIL AS
SELECT GEN,
       AVG(MIL) AS AMIL
  FROM V_GEN_MEMBER
 GROUP BY GEN
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP AS
SELECT C.MID AS "회원번호",
       C.MNAME AS "회원명",
       SUM(A.CART_QTY) AS "구매수량",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "구매금액"
--       C.MIL AS "마일리지",
--       C.GEN AS "성별",
--       ROUND(C.AMIL) AS "성별평균 마일리지"
  FROM CART A, PROD B,
       (SELECT A.MID, A.MNAME, A.MIL, A.GEN, B.AMIL
          FROM V_GEN_MEMBER A, V_AMIL B
         WHERE A.GEN = B.GEN
               AND A.MIL >= B.AMIL) C
 WHERE A.CART_MEMBER = C.MID
       AND A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
 GROUP BY C.MID, C.MNAME
 ORDER BY 1
 WITH READ ONLY;

SELECT A."회원번호", A."회원명", A."구매수량", A."구매금액",
       B.MIL AS "마일리지", B.GEN AS "성별", ROUND(B.AMIL) AS "성별 평균마일리지"
  FROM V_TEMP A, 
       (SELECT A.MID, A.MNAME, A.MIL, A.GEN, B.AMIL
          FROM V_GEN_MEMBER A, V_AMIL B
         WHERE A.GEN = B.GEN
               AND A.MIL >= B.AMIL) B
 WHERE A."회원번호" = B.MID;
 
사용예)사원테이블에서 'Seattle'에 근무하는 사원과 'IT'부서에 근무하는 사원의
      사원번호, 사원명, 부서명, 직무명, 근무지를 조회하시오
      
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       D.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND A.JOB_ID = D.JOB_ID
       AND C.CITY = 'Seattle'
 UNION
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       D.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = D.JOB_ID
       AND B.DEPARTMENT_NAME = 'IT';
       
사용예)회원테이블에서 마일리지가 3000이상인 회원과 직업이 공무원인 회원의 
      회원번호, 회원명, 주소, 마일리지를 조회하시오      
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
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_JOB = '공무원';

SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 3000
INTERSECT
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_JOB = '공무원'
      
사용예)회원테이블에서 마일리지가 2000이상인 회원과 직업이 주부인 회원의 
      회원번호, 회원명, 주소, 마일리지를 조회하시오      
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 2000
UNION
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       MEM_MILEAGE AS "마일리지"
  FROM MEMBER
 WHERE MEM_JOB = '주부';
      
사용예)2005년 4월에 판매된 상품 중 7월에도 팔린 상품정보를 조회하시오
      ALIAS 상품코드, 상품명, 판매가, 거래처명     
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       B.PROD_PRICE AS "판매가",
       C.BUYER_NAME AS "거래처명"
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504'
INTERSECT
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       B.PROD_PRICE AS "판매가",
       C.BUYER_NAME AS "거래처명"
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,6) = '200507';
       
       

      
사용예)부서명이 'Shipping'에 속한 사원 중 'Matthew Weiss'사원의 팀에 소속된 사원을 조회하시오
      사원번호, 사원명, 부서명, 입사일, 급여   
      
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       A.HIRE_DATE AS "입사일",
       A.SALARY AS "급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
       (SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE EMP_NAME = 'Matthew Weiss') C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_NAME = 'Shipping'
       AND A.MANAGER_ID = C.EMPLOYEE_ID

SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       A.HIRE_DATE AS "입사일",
       A.SALARY AS "급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_NAME = 'Shipping'
INTERSECT
SELECT C.EMPLOYEE_ID AS "사원번호",
       C.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       C.HIRE_DATE AS "입사일",
       C.SALARY AS "급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.EMPLOYEES C
 WHERE A.EMP_NAME = 'Matthew Weiss'
       AND C.MANAGER_ID = A.EMPLOYEE_ID
       AND C.DEPARTMENT_ID = B.DEPARTMENT_ID
       
1. 남녀 성별 인원수 조회

SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '여자'
            END AS "성별",
       COUNT(MEM_ID) AS "인원수"
  FROM MEMBER
 GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '여자'
            END;

2. 지금까지 한번도 상품을 구매한 적이 없는 회원의 인적사항 조회(아이디, 이름, 이메일)
CREATE OR REPLACE VIEW V_TEMP AS 
SELECT A.MEM_ID AS MID,
       A.MEM_NAME AS MNAME,
       A.MEM_MAIL AS MMAIL
  FROM MEMBER A, CART B
 WHERE A.MEM_ID = B.CART_MEMBER
 GROUP BY A.MEM_ID, A.MEM_NAME, A.MEM_MAIL
WITH READ ONLY;

SELECT A.MEM_ID AS MID,
       A.MEM_NAME AS MNAME,
       A.MEM_MAIL AS MMAIL
  FROM MEMBER A
 WHERE NOT EXISTS(SELECT *
                    FROM V_TEMP B
                   WHERE B.MID = A.MEM_ID);
                   
DROP VIEW V_TEMP;                   
3. 등록된 상품이 한건도 없는 상품분류 조회(상품분류코드, 분류명)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT DISTINCT A.LPROD_ID AS LID,
              A.LPROD_NM AS LNM
         FROM LPROD A, PROD B
        WHERE A.LPROD_GU = B.PROD_LGU
WITH READ ONLY;
SELECT C.LPROD_ID AS "상품분류코드",
       C.LPROD_NM AS "분류명"
  FROM LPROD C
 WHERE NOT EXISTS (SELECT LID
                     FROM V_TEMP D
                    WHERE D.LID = C.LPROD_ID);
                    
DROP VIEW V_TEMP;
4. 지금까지 가장 많이 팔린 상품 조회(상품코드, 상품명, 상품분류명, 거래처명, 마일리지)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT CART_PROD AS CID,
       SUM(CART_QTY) AS CQTY
  FROM CART
 GROUP BY CART_PROD
WITH READ ONLY;

SELECT MAX(CQTY) AS MQTY
  FROM V_TEMP;

SELECT A.PROD_ID AS "상품코드",
       A.PROD_NAME AS "상품명",
       B.LPROD_NM AS "상품분류명",
       C.BUYER_NAME AS "마일리지",
       D.MQTY AS "판매수량"
  FROM PROD A, LPROD B, BUYER C,
       (SELECT CID, MQTY
          FROM V_TEMP A,
               (SELECT MAX(CQTY) AS MQTY
                  FROM V_TEMP) B
         WHERE A.CQTY = B.MQTY) D
 WHERE A.PROD_ID = D.CID
       AND A.PROD_LGU = B.LPROD_GU
       AND A.PROD_BUYER = C.BUYER_ID;
5.   지금까지 가장 적게 팔린 상품 조회(상품코드, 상품명, 상품분류명, 거래처명, 마일리지)
SELECT A.PROD_ID AS "상품코드",
       A.PROD_NAME AS "상품명",
       B.LPROD_NM AS "상품분류명",
       C.BUYER_NAME AS "마일리지",
       D.MQTY AS "판매수량"
  FROM PROD A, LPROD B, BUYER C,
       (SELECT CID, MQTY
          FROM V_TEMP A,
               (SELECT MIN(CQTY) AS MQTY
                  FROM V_TEMP) B
         WHERE A.CQTY = B.MQTY) D
 WHERE A.PROD_ID = D.CID
       AND A.PROD_LGU = B.LPROD_GU
       AND A.PROD_BUYER = C.BUYER_ID;
6. 거래처 중 거래 품목 수가 가장 많은 거래처 조회(거래처코드, 거래처명, 거래처분류명, 담당자명)

CREATE OR REPLACE VIEW V_TEMP AS
SELECT A.BUYER_ID, B.PROD_ID
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
       AND B.PROD_ID = C.BUY_PROD
 GROUP BY A.BUYER_ID, B.PROD_ID
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP2 AS
SELECT BUYER_ID AS BID, COUNT(PROD_ID) AS CNT
  FROM V_TEMP
 GROUP BY BUYER_ID
WITH READ ONLY;

SELECT * FROM V_TEMP2;

SELECT A.BUYER_ID AS "거래처코드",
       A.BUYER_NAME AS "거래처명",
       A.BUYER_LGU AS "거래처분류명",
       A.BUYER_CHARGER AS "담당자명"
  FROM BUYER A
 WHERE EXISTS(SELECT C.BID
                FROM V_TEMP2 C, 
                     (SELECT MAX(CNT) AS MCNT
                        FROM V_TEMP2) D
               WHERE D.MCNT = C.CNT
                     AND C.BID = A.BUYER_ID);
 
 
7.   거래처 중 거래 품목 수가 가장 적은 거래처 조회(거래처코드, 거래처명, 거래처분류명, 담당자명)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT A.BUYER_ID, B.PROD_ID
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
       AND B.PROD_ID = C.BUY_PROD
 GROUP BY A.BUYER_ID, B.PROD_ID
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP2 AS
SELECT BUYER_ID AS BID, COUNT(PROD_ID) AS CNT
  FROM V_TEMP
 GROUP BY BUYER_ID
WITH READ ONLY;

SELECT * FROM V_TEMP2;

SELECT A.BUYER_ID AS "거래처코드",
       A.BUYER_NAME AS "거래처명",
       A.BUYER_LGU AS "거래처분류명",
       A.BUYER_CHARGER AS "담당자명"
  FROM BUYER A
 WHERE EXISTS(SELECT C.BID
                FROM V_TEMP2 C, 
                     (SELECT MIN(CNT) AS MCNT
                        FROM V_TEMP2) D
               WHERE D.MCNT = C.CNT
                     AND C.BID = A.BUYER_ID);

8. 남녀 성별 각각 구매율이 높은 상품 조회(성별, 상품코드, 상품명, 분류명)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT MEM_ID AS MID,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '남'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '여'
       END AS GEN
  FROM MEMBER
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP2 AS
SELECT B.PROD_ID AS PID,
       B.PROD_NAME AS PNAME,
       C.GEN AS GEN,
       A.CART_QTY AS QTY,
       D.LPROD_NM AS LPNM
  FROM CART A, PROD B, V_TEMP C, LPROD D
 WHERE A.CART_MEMBER = C.MID
       AND A.CART_PROD = B.PROD_ID
       AND B.PROD_LGU = D.LPROD_GU
WITH READ ONLY;

SELECT PID, GEN, SUM(QTY), RANK() OVER(ORDER BY SUM(QTY) DESC) AS RK
  FROM V_TEMP2
 GROUP BY PID, GEN
-- ORDER BY 1;

9. 각 회원별 구매 총액 조회(회원아이디, 회원명, 구매총액)
SELECT B.MEM_ID AS "회원아이디",
       B.MEM_NAME AS "회원명",
       SUM(A.CART_QTY * C.PROD_PRICE) AS "구매총액"
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
 GROUP BY B.MEM_ID, B.MEM_NAME
 ORDER BY 1;
       
10. 각 상품별 구매왕 조회(구매왕아이디, 회원명, 구매총액)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT C.PROD_ID AS PID,
       B.MEM_ID AS MID,
       SUM(A.CART_QTY) AS CNT
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
 GROUP BY C.PROD_ID, B.MEM_ID
WITH READ ONLY;

SELECT C.PROD_ID AS "상품번호",
       C.PROD_NAME AS "상품명",
       A.MEM_ID AS "구매왕아이디",
       A.MEM_NAME AS "회원명",
       C.PROD_PRICE * D.MCNT AS "구매총액"
  FROM MEMBER A, V_TEMP B, PROD C,
       (SELECT PID,
               MAX(CNT) AS MCNT
          FROM V_TEMP
         GROUP BY PID) D
 WHERE A.MEM_ID = B.MID
       AND B.CNT = D.MCNT
       AND B.PID = D.PID
       AND C.PROD_ID = B.PID
       AND C.PROD_ID = D.PID
 ORDER BY 1;
 
 