2021-0721-01)테이블 조인
  - 관계형 데이터베이스의 핵심 기능
  - 복수개의 테이블에 분산된 자료를 조회하기 위함
  - 테이블 사이에 관계(Relationship)가 맺어져 있어야 함
  - 구분
   - 일반조인 / ANSI JOIN
    - 일반조인 - CARTESIAN PRODUCT, EQUI JOIN, NON EQUI JOIN, SELF JOIN, OUTER JOIN
    - ANSI JOIN - CROSS JOIN, NATURAL JOIN, INNER JOIN, OUTER JOIN
   - 내부조인 / 외부조인
 
 (일반 사용형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1], 테이블명2 [별칭2][, 테이블명3 [별칭3],...]
   WHERE 조인조건1
    [AND 조인조건2]
    [AND 일반조건]...
    
   - 조인에 사용된 테이블이 n개일 때 조인조건의 개수는 n-1개 이상이어야 함
   - 조인조건과 일반조건의 기술 순서는 의미없음(가독성 고려시 조인 먼저 하는거 생각해볼 만 할지도?)
 
 (ANSI INNER JOIN 사용형식)
  SELECT 컬럼list
    FROM 테이블명1 [별칭1]
   INNER JOIN 테이블명2 [별칭2] ON(조인조건1 [AND 일반조건1])
   [INNER JOIN 테이블명3 [별칭3] ON(조인조건2 [AND 일반조건2])]
          :
   WHERE 일반조건n...
   
   - '테이블명1'과 '테이블명2'는 반드시 조인 가능한 테이블일 것(일반적으로 관계를 가지고 있는 테이블을 말한다. 예외적으로는 값을 비교한다<- 관계가 없어도 컨텐츠로 조인가능)
   - '테이블명3' 부터는 '테이블명1'과 '테이블명2'의 결과와 조인(INNER JOIN을 반복해서 사용할 때 각 반복마다 교집합으로 처리한다)
   - ON 절에 사용되는 일반조건1은 '테이블명1'과 '테이블명2'에만 해당하는 조인조건
   - WHERE 절의 조인조건은 모든 테이블에 적용되는 조인조건
   
일반 사용형식으로는 표현 못하지만 ANSI INNER JOIN 으로는 표현 할 수 있는 조인이 있다.
예) 상품별로 매입 매출현황을 조회할 때 CART를 참조하게 되는데, CART에는 매출이 발생한 상품만 보유하고 있어서
    일반 사용형식으로 조인조건을 작성하면 매입은 있지만 매출은 없는 상품을 조회하지 못한다.
    이런 경우 조인조건을 전체에 적용하는 것이 아니라 조인할 대상 테이블들에게만 적용시킬 수 있는 INNER JOIN구문으로 해결한다.

  1. CARTESIAN PRODUCT
   - 모든 가능한 행들의 집합을 결과로 반환
   - ANSI에서는 CROSS JOIN이 이에 해당
   - 특별한 목적 이외에는 사용되지 않음
   - 조인조건이 없거나 잘못된 경우 발생

사용예)
SELECT *
  FROM CART, BUYPROD, PROD
 WHERE BUYPROD.BUY_PROD = PROD.PROD_ID
       AND PROD.PROD_ID = CART.CART_PROD
 ORDER BY 2;
  
SELECT COUNT(*) FROM BUYPROD;  
SELECT COUNT(*) FROM CART;
SELECT COUNT(*) FROM PROD;

SELECT 148 * 207 FROM DUAL;

사용예)
SELECT COUNT(*)
  FROM CART, BUYPROD, PROD;
  
SELECT COUNT(*)
  FROM CART
 CROSS JOIN BUYPROD
 CROSS JOIN PROD;


  2. EQUI-JOIN
   - 동등조인
   - 조인 조건에 '='연산자가 사용된 조인
   - ANSI JOIN은 INNER JOIN이 이에 해당
   - 조인조건 또는 SELECT에 사용되는 컬럼 중 두 테이블에서 같은 컬럼명으로 정의된 경우
     '테이블명.컬럼명' 또는 '테이블 별칭.컬럼명' 형식으로 기술

사용예)매입테이블에서 2005년 1월 상품별 매입현황을 조회하시오
      Alias는 상품코드, 상품명, 매입수량합계, 매입금액 합계
    
    (일반조인형식)
    SELECT B.PROD_ID AS "상품코드",
           B.PROD_NAME AS "상품명",
           SUM(A.BUY_QTY) AS "매입수량합계",
           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "매입금액 합계"
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
    
    (ANSI형식)
    SELECT B.PROD_ID AS "상품코드",
           B.PROD_NAME AS "상품명",
           SUM(A.BUY_QTY) AS "매입수량합계",
           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "매입금액 합계"
      FROM BUYPROD A
     INNER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;

    SELECT B.PROD_ID AS "상품코드",
           B.PROD_NAME AS "상품명",
           SUM(A.BUY_QTY) AS "매입수량합계",
           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "매입금액 합계"
      FROM BUYPROD A
     INNER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
     WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
    
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
======================================================
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       C.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND B.MANAGER_ID = 121)
 INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID);       
======================================================
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       C.JOB_TITLE AS "직무명"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID)
 WHERE B.MANAGER_ID = 121;       


사용예)2005년 거래처별 매출현황을 조회하시오
      Alias는 거래처코드, 거래처명, 매출금액합계
     
    SELECT C.BUYER_ID AS "거래처코드",
           C.BUYER_NAME AS "거래처명",
           SUM(A.CART_QTY * B.PROD_PRICE) AS "매출금액합계"
      FROM CART A, PROD B, BUYER C
     WHERE A.CART_PROD = B.PROD_ID
           AND C.BUYER_ID = B.PROD_BUYER
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY C.BUYER_ID, C.BUYER_NAME
     ORDER BY 1;
     
    SELECT C.BUYER_ID AS "거래처코드",
           C.BUYER_NAME AS "거래처명",
           SUM(A.CART_QTY * B.PROD_PRICE) AS "매출금액합계"
      FROM CART A
     INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID)
     INNER JOIN BUYER C ON(C.BUYER_ID = B.PROD_BUYER)
     WHERE SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY C.BUYER_ID, C.BUYER_NAME
     ORDER BY 1; 
     
    SELECT C.BUYER_ID AS "거래처코드",
           C.BUYER_NAME AS "거래처명",
           SUM(A.CART_QTY * B.PROD_PRICE) AS "매출금액합계"
      FROM CART A
     INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005')
     INNER JOIN BUYER C ON(C.BUYER_ID = B.PROD_BUYER)
     GROUP BY C.BUYER_ID, C.BUYER_NAME
     ORDER BY 1; 
     
     
    (일반조인형식)
--    SELECT B.PROD_ID AS "상품코드",
--           B.PROD_NAME AS "상품명",
--           SUM(A.BUY_QTY) AS "매입수량합계",
--           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "매입금액 합계"
--      FROM BUYPROD A, PROD B
--     WHERE A.BUY_PROD(+)= B.PROD_ID
--           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')) 
--     GROUP BY B.PROD_ID, B.PROD_NAME
--     ORDER BY 1;
--
--목적과 다른 결과! (+)=과 일반조건 동시사용

     SELECT DISTINCT A.BUY_PROD AS PRODID,
           B.PROD_NAME AS PRODNAME
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD(+)= B.PROD_ID
     ORDER BY 1;
     
     (ANSI형식)
     SELECT B.PROD_ID AS "상품코드",
           B.PROD_NAME AS "상품명",
           NVL(SUM(A.BUY_QTY),0) AS "매입수량합계",
           NVL(TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999'),LPAD('0',12)) AS "매입금액 합계"
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
     
조인시 컬럼을 기술 할 때는 반드시 어느 테이블 소속인지 나타내는 습관을 가져라     
  
EQUI JOIN : = 연산자를 사용한 조인
NON EQUI JOIN : = 이외의 연산자를 사용한 조인
SELF JOIN : 자신과 자신을 조인하는 경우
여기까지는 내부조인(조인조건이 맞지 않는 행은 제외시킴)

많은 쪽을 기준으로 조인하는 것을 외부조인이라고 함
예) 부서코드는 10~270번 까지 있음, 사원이 속한 부서코드는 10~110번 까지 있음
내부조인 할 때는 110번까지만 나오고, 외부조인을 부서기준으로 할 때 270까지 모든 행을 출력가능

CROSS JOIN = CARTESIAN PRODUCT
NATURAL JOIN = 안씀, 조인조건을 기술하지 않아도 자동적으로 처리된다는데 뭔소린지 모르겠다
INNER JOIN / OUTER JOIN 일반조인과 ANSI JOIN의 문법이 아예 다름
OUTER JOIN부터는 일반조인보다 OUTER JOIN이 훨씬 정확함
   
조인 : 관계형 데이터베이스의 가장 핵심이 됨
같은 값을 가진 컬럼이 존재한다 : 부모의 기본키가 자식의 기본키가 되는 경우(식별자관계, 직선연결)
                            부모의 기본키가 자식의 일반 컬럼이 되는 경우(비식별관계, 점선연결)
식별관계 : 부모가 없으면 자식도 있을 수 없는 경우
예) 주문과 결재의 관계 주문이 없으면 결재도 없다.
비식별관계 : 부모가 없어진다고 자식이 사라지지는 않는 경우
예) 학교가 사라진다고 해도 교사가 사라지거나, 학생이 사라지거나, 학교건물이 사라지지 않음
부모의 생존영역과 자식의 생존영역이 서로 독립적인 관계가 비식별 관계이다.

B테이블이 A테이블을 상속받는다고 하자(EX - 주문테이블은 상품테이블을 상속받음
고객과 상품은 구매라는 관계를 맺음, 이 관계의 CARDINALITY는 다대다 M:N임
다대다 관계는 개념적 모델링까지만 허용됨.

개념적 설계 -> 논리적 설계 -> 물리적 설계
엔터티      -> 릴레이션   -> 테이블

식별관계 : 부모 테이블의 기본키를 자식테이블의 기본키로 사용하는 관계
비식별관계 : 부모 테이블의 기본키를 자식테이블의 기본키로 사용하지 않는 관계(일반 컬럼으로 사용하는 관계)

객체지향 언어로 프로젝트를 만드는 것 : 객체지향 개발방법론
세가지 시각이 있음

***
정규화의 목적은 효율적인 데이터관리
너무 세부적으로 정규화가 될 때는 정규화를 위한 정규화를 하고 있는지 판단해야 한다.
심각한 오류가 발생되지 않고 정규화를 포기하는 것이 비용상에서 더 유리할 때 역정규화 혹은 비정규화를 할 수 있다.
예) 우편번호, 세부주소를 하나로 관리하는 경우
효율적인 데이터관리를 위해 나뉜 테이블 사이의 관계를 통해 내가 원하는 정보를 가져오는 것이 조인이다.
조회하고자 하는 컬럼의 집합이 최소 몇개의 테이블에 나뉘어 존재하는지 판단 후 그 테이블들을 관계를 기반으로 연결하여 찾는것이 기본