2021-0723-01)
  4. SELF JOIN
   - 하나의 테이블에 서로 다른 별칭을 부여하여 수행하는 조인
사용예)거래처 '마르죠'와 동일한 지역(광역시도)에 소재하고 있는 거래처 정보를 조회하시오
      ALIAS는 거래처코드, 거래처명, 주소, 담당자이다.

SELECT B.BUYER_ID AS "거래처코드",
       B.BUYER_NAME AS "거래명",
       B.BUYER_ADD1 || ' ' || B.BUYER_ADD2 AS "주소",
       B.BUYER_CHARGER AS "담당자"
  FROM BUYER A, BUYER B
 WHERE A.BUYER_NAME = '마르죠'
       AND SUBSTR(B.BUYER_ADD1,1,2) <> SUBSTR(A.BUYER_ADD1,1,2);
       
사용예)사원번호 108번 사원과 같은 부서에 속한 사원의 사원번호, 사원명, 부서명, 직무코드를 조회하시오
SELECT C.EMPLOYEE_ID AS "사원번호",
       C.EMP_NAME AS "사원명",
       B.DEPARTMENT_ID AS "부서명",
       C.JOB_ID AS "직무코드"
FROM    (SELECT DEPARTMENT_ID AS DID
          FROM HR.EMPLOYEES
         WHERE EMPLOYEE_ID = 108) A
INNER JOIN HR.DEPARTMENTS B ON(A.DID = B.DEPARTMENT_ID)
INNER JOIN HR.EMPLOYEES C ON(B.DEPARTMENT_ID = C.DEPARTMENT_ID);

SELECT C.EMPLOYEE_ID AS "사원번호",
       C.EMP_NAME AS "사원명",
       B.DEPARTMENT_ID AS "부서명",
       C.JOB_ID AS "직무코드"
FROM    (SELECT DEPARTMENT_ID AS DID
          FROM HR.EMPLOYEES
         WHERE EMPLOYEE_ID = 108) A, HR.DEPARTMENTS B, HR.EMPLOYEES C
WHERE A.DID = B.DEPARTMENT_ID
      AND B.DEPARTMENT_ID = C.DEPARTMENT_ID;

SELECT C.EMPLOYEE_ID AS "사원번호",
       C.EMP_NAME AS "사원명",
       B.DEPARTMENT_ID AS "부서명",
       C.JOB_ID AS "직무코드"
FROM  HR.EMPLOYEES A
INNER JOIN HR.EMPLOYEES C ON(A.EMPLOYEE_ID = 108
      AND A.DEPARTMENT_ID = C.DEPARTMENT_ID)
INNER JOIN HR.DEPARTMENTS B ON(C.DEPARTMENT_ID = B.DEPARTMENT_ID);

SELECT C.EMPLOYEE_ID AS "사원번호",
       C.EMP_NAME AS "사원명",
       B.DEPARTMENT_ID AS "부서명",
       C.JOB_ID AS "직무코드"
FROM  HR.EMPLOYEES A, HR.EMPLOYEES C, HR.DEPARTMENTS B
WHERE A.EMPLOYEE_ID = 108
      AND A.DEPARTMENT_ID = C.DEPARTMENT_ID
      AND C.DEPARTMENT_ID = B.DEPARTMENT_ID;
      
  5. 외부조인(OUTER JOIN)
   - 내부조인은 조인조건을 만족하는 데이터를 기준으로 결과를 반환
   - 외부조인은 조인조건을 만족하지 못하는 데이터를 기준으로 부족한 테이블에 NULL값으로 채워진 행을 삽입하여 조인 수행
   - 조인조건에서 부족한 데이터를 가지고 있는 테이블에 속한 테이블에 속한 열이르 다음에 '(+)'연산자를 추가함
   - 여러 조인조건이 외부조인이 수행되어야 하는 경우 모두 '(+)'연산자를 사용해야 함
   - 동시에 한 테이블에 복수개의 외부조인의 '(+)'연산자를 사용할 수 없다. 즉, A,B,C테이블이
     외부조인에 참여할 때 A를 기준으로 A를 기준으로 B를 확장함과 동시에 C를 기준으로 B를 확장할 수 없음
     (WHERE A = B(+) AND C = B(+) => 허용안됨)
   - 일반외부조인인 경우 일반조건이 사용되면 내부조인 결과를 반환(해결방법 : ANSI 외부조인 또는 서브쿼리 사용)
   - 외부조인의 사용은 처리속도의 저하 유발
   
  (일반외부조인 사용형식)
   SELECT 컬럼LIST
     FROM 테이블명1, 테이블명2[, 테이블명3,...]
    WHERE 테이블명1.컬럼명[(+)]=테이블명2.[(+)]
                    :
   - 양쪽 모두 부족한 외부조인은 허용 안됨(WHERE A.COL(+) = B.COL(+))
   
  (ANSI외부조인 사용형식)
   SELECT 컬럼LIST
     FROM 테이블명1
   LEFT|RIGHT|FULL OUTER JOIN 테이블명2 ON(조인조건1 [AND 일반조건1])
  [LEFT|RIGHT|FULL OUTER JOIN 테이블명3 ON(조인조건2 [AND 일반조건2])]
                                :
  [WHERE 일반조건n]
   - 테이블명1과 테이블명2는 반드시 조인 가능할 것
   - 일반조건1은 테이블명1 또는 테이블명2에 국한된 조건
   - 일반조건n은 전체 테이블에 적용되는 조건으로 조인이 모두 수행한 후 적용됨
   - LEFT|RIGHT|FULL : 테이블명1의 데이터 종류가 더 많은 경우 LEFT, 반대인 경우 RIGHT, 양쪽 모두 부족한 경우 FULL 사용

-- 정규화가 되어있지만 FULL OUTER JOIN을 사용하게 되는 경우 : FK가 NULL인 행이 존재할 때이다. 생각해서 설명하도록

사용예)모든 상품별 매입현황을 조회하시오.
      출력할 컬럼은 상품코드, 상품명, 매입수량, 매입금액이다.
    (ANSI외부조인)
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.BUY_QTY),0) AS "매입수량",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "매입금액"
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
 GROUP BY B.PROD_ID, B.PROD_NAME;
 
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.BUY_QTY),0) AS "매입수량",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "매입금액"
  FROM BUYPROD A, PROD B
 WHERE A.BUY_PROD(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

사용예)2005년 1월 모든 상품별 매입현황을 조회하시오.
      출력할 컬럼은 상품코드, 상품명, 매입수량, 매입금액이다.
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.BUY_QTY),0) AS "매입수량",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "매입금액"
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.BUY_QTY),0) AS "매입수량",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "매입금액"
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
 WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
 GROUP BY B.PROD_ID, B.PROD_NAME;
--한 쪽의 테이블에만 적용되는 조건이 외부조인 이후 수행되어 외부조인 결과에서 일반조건에 맞지 않는 행이 날아가버려 의도와 다른 결과를 출력한 예

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.QTT),0) AS "매입수량",
       NVL(SUM(A.QTT * B.PROD_COST),0) AS "매입금액"
  FROM (SELECT BUY_PROD AS BID,
               BUY_QTY AS QTT
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')) A, PROD B
 WHERE A.BID(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.QTT),0) AS "매입수량",
       NVL(SUM(A.QTT * B.PROD_COST),0) AS "매입금액"
  FROM PROD B,--(2005년도 1월 매입정보(내부조인)) A
 WHERE A.BID(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

--(2005년도 1월 매입정보(내부조인)) A
SELECT BUY_PROD AS BID,
       SUM(BUY_QTY) AS QAMT,
       SUM(BUY_QTY * BUY_COST) AS MANT
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
 GROUP BY BUY_PROD;

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(A.QAMT,0) AS "매입수량",
       NVL(A.MANT,0) AS "매입금액"
  FROM PROD B,(SELECT BUY_PROD AS BID,
                      SUM(BUY_QTY) AS QAMT,
                      SUM(BUY_QTY * BUY_COST) AS MANT
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
                GROUP BY BUY_PROD) A
 WHERE A.BID(+) = B.PROD_ID;

모든/전체를 보았다 -> 외부조인을 쓰자 -> COUNT를 쓴다면 *는 쓰지 말자 : 한 세트다.
OUTER JOIN이 사용되는 경우 : '모든' 혹은 '전체'라는 수식어가 붙는 경우
                            더 나아가서 COUNT(*) 대신 COUNT(컬럼명 <- PK를 써라)으로 접근해야 하는 것도 잊지 말자
숫자필드가 계산되는 컬럼은 "반드시" NVL을 사용해준다

사용예)모든 부서별 사원수를 조회하시오.
      출력은 부서코드, 부서명, 사원수이다.
SELECT LPAD(NVL(TO_CHAR(A.DEPARTMENT_ID),'CEO'),6) AS "부서코드",
       A.DEPARTMENT_NAME AS "부서명",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "사원수"
  FROM HR.DEPARTMENTS A
  FULL OUTER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;      

SELECT A.DEPARTMENT_ID AS "부서코드",
       A.DEPARTMENT_NAME AS "부서명",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "사원수"
  FROM HR.DEPARTMENTS A
  FULL OUTER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1; 
  
SELECT A.DEPARTMENT_ID AS "부서코드",
       A.DEPARTMENT_NAME AS "부서명",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "사원수"
  FROM HR.DEPARTMENTS A
  LEFT OUTER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;
 
SELECT A.DEPARTMENT_ID AS "부서코드",
       A.DEPARTMENT_NAME AS "부서명",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "사원수"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;

SELECT A.DEPARTMENT_ID AS "부서코드",
       A.DEPARTMENT_NAME AS "부서명",
       COUNT(*) AS "사원수"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;
 
SELECT A.DEPARTMENT_ID AS "부서코드",
       A.DEPARTMENT_NAME AS "부서명",
       COUNT(B.EMPLOYEE_ID) AS "사원수"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
 GROUP BY ROLLUP(A.DEPARTMENT_ID, A.DEPARTMENT_NAME)
 ORDER BY 1;
 
사용예)2005년 4월 모든 상품에 대한 판매현황을 조회하시오
      출력할 내용은 상품코드, 상품명, 판매수량, 판매금액이다.

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.CART_QTY),0) AS "판매수량",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "판매금액"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
SELECT C.PROD_ID AS "상품코드",
       C.PROD_NAME AS "상품명",
       NVL(SUM(B.CART_QTY),0) AS "판매수량",
       NVL(SUM(B.CART_QTY * C.PROD_PRICE),0) AS "판매금액"
  FROM CART A, CART B, PROD C
 WHERE SUBSTR(A.CART_NO,1,6) = '200504'
       AND A.CART_NO = B.CART_NO
       AND B.CART_PROD = C.PROD_ID(+)
 GROUP BY C.PROD_ID, C.PROD_NAME
 ORDER BY 1;

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(A.CQTY),0) AS "판매수량",
       NVL(SUM(A.CQTY * B.PROD_PRICE),0) AS "판매금액"
  FROM (SELECT CART_PROD AS CPID,
               CART_QTY AS CQTY
          FROM CART
         WHERE SUBSTR(CART_NO,1,6) = '200504') A,
         PROD B
 WHERE B.PROD_ID = A.CPID(+)
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 3;
 
 
 SELECT B.PROD_ID AS 상품코드,
        B.PROD_NAME AS 상품명,
        NVL(SUM(A.CART_QTY),0) AS 판매수량,
        NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS 판매금액
   FROM CART A
  RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
        AND SUBSTR(A.CART_NO,1,6) = '200504')
  GROUP BY B.PROD_ID, B.PROD_NAME
  ORDER BY 1;

사용예)2005년 4월 모든 상품에 대한 매입합계와 매출합계를 조회하시오