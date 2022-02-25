2021-0727-01)
  ** 재고 수불처리를 위한 테이블을 생성하시오
  1) 테이블 명 : REMAIN
  2) 컬럼명
  -----------------------------------------------------------
  컬럼명         데이터타입       NULLABLE        제약사항
  -----------------------------------------------------------
  REMAIN_YEAR   CAHR(4)         N.N             PK
  PROD_ID       VARCHAR2(10)    N.N             PK/FK
  REMAIN_J_00   NUMBER(5)                       DEFAULT 0
  REMAIN_I      NUMBER(5)                       DEFAULT 0
  REMAIN_O      NUMBER(5)                       DEFAULT 0
  REMAIN_J_99   NUMBER(5)                       DEFAULT 0
  REMAIN_DATE   DATE
  -----------------------------------------------------------

REMAIN_YEAR
REMAIN_J_00 : 기초재고, 전년도 12월 31일날 파악한 재고의 양 / 기 시작 시점의 재고 1기,2기,...
REMAIN_J_99 : 기말재고, 전산상 재고, 현재고
REMAIN_I : 입고
REMAIN_O : 출고
REMAIN_DATE : 최신변경날짜

CREATE TABLE REMAIN(
  REMAIN_YEAR CHAR(4) NOT NULL,
  PROD_ID VARCHAR2(10) NOT NULL,
  REMAIN_J_00 NUMBER(5) DEFAULT 0,
  REMAIN_I NUMBER(5) DEFAULT 0,
  REMAIN_O NUMBER(5) DEFAULT 0,
  REMAIN_J_99 NUMBER(5) DEFAULT 0,
  REMAIN_DATE DATE,
  
  CONSTRAINT pk_remain PRIMARY KEY(REMAIN_YEAR, PROD_ID),
  CONSTRAINT fk_remain_prod FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID)
);

매출발생이후
(카트테이블에 한줄 입력후
재고테이블의 PROD_ID를 찾고
REMAIN_O를 +하고
REMAIN_J_99을 -하고
REMAIN_DATE를 오늘 날짜로 업데이트)

--CREATE TRIGGER tg_remain_cart
--AFTER INSERT CART
--ON REMAIN
--FOR EACH ROW
--DECLARE
--num INTEGER := 0;
--BEGIN
--
--END;


 4)DML 명령에 서브쿼리 사용
  (1) INSERT 문에 서브쿼리 사용
   - '()'를 사용하지 않고 서브쿼리 기술
   - INSERT 문의 VALUES절도 생략

한번에 입력할 수 있음!
   
사용예) 재고수불테이블(REMAIN)에 PROD 테이블의 자료를 이용하여 기초데이터를 입력하시오
       년도 : '2005'
       상품코드 : PROD테이블의 상품코드(PROD_ID)
       기초재고수량 : PROD테이블의 PROD_PROPERSTOCK
       입고 및 출고 수량 : 없음
       기말재고수량 : PROD테이블의 PROD_PROPERSTOCK
       날짜 : '2004-12-31'
;
INSERT INTO REMAIN(REMAIN_YEAR, PROD_ID, REMAIN_J_00, REMAIN_J_99, REMAIN_DATE)
  SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20041231') FROM PROD;
SELECT * FROM REMAIN;
COMMIT;

  (2) UPDATE 문에 서브쿼리 사용
   - 복수개의 컬럼을 갱신하는 경우 '()'안에 변경할 컬럼을 기술하여 하나의 SET절로 처리
   
사용예)2005년 1월 상품별 매입정보를 이용하여 REMAIN테이블을 변경하시오
메인쿼리 : UPDATE문
UPDATE REMAIN
   SET REMAIN_I = (서브쿼리),
       REMAIN_J_99 = (서브쿼리),
       REMAIN_DATE = TO_DATE('20050131')
 WHERE 조건;
 
UPDATE REMAIN
   SET (REMAIN_I, REMAIN_J_99, REMAIN_DATE) = (서브쿼리),
 WHERE 조건;

서브쿼리:2005년 1월 상품별 매입정보

--SELECT B.PROD_ID,
--       NVL(SUM(A.BUY_QTY),0),
--       TO_DATE('20050131')
--  FROM BUYPROD A
-- RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
--       AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')))
-- GROUP BY B.PROD_ID;

SELECT BUY_PROD,
       SUM(BUY_QTY)
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
 GROUP BY BUY_PROD;

COMMIT;
 
 (결합)
UPDATE REMAIN B
   SET (B.REMAIN_I, B.REMAIN_J_99, B.REMAIN_DATE) =
       (SELECT B.REMAIN_I + A.AMT, B.REMAIN_J_99 + A.AMT, TO_DATE('20050131')
          FROM (SELECT BUY_PROD AS BID,
                       SUM(BUY_QTY) AS AMT
                  FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
                 GROUP BY BUY_PROD) A
         WHERE B.PROD_ID = A.BID)
 WHERE B.REMAIN_YEAR = '2005'
       AND B.PROD_ID IN (SELECT DISTINCT BUY_PROD AS BID
                                    FROM BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20050101')
                                                  AND LAST_DAY(TO_DATE('20050101')));
                                                  
UPDATE REMAIN B
   SET B.REMAIN_O = (SELECT 3 AS T FROM DUAL)C
 WHERE B.REMAIN_YEAR = '2005'
       AND TO_NUMBER(B.REMAIN_YEAR) > C.T
 
 ROLLBACK;
 SELECT * FROM REMAIN;

복수개의 컬럼으로 기본키가 설정되어진 경우 기본키를 구성하는 모든 복합키에 조건을 주는 것이 가장 효율적인 검색방법
업데이트 할 때 B.REMAIN_I + A.AMT, B.REMAIN_J_99 + A.AMT처럼 실제 로직을 생각해 주어야 한다.
최종결과에 필요한 정보와 내가 중간에 구한 쿼리의 컬럼의 형태가 다르다면 서브쿼리로 사용하여 컬럼을 일치시켜줘야 한다.
FROM절로 이용해야 한다!

  (3) DELETE 문에 서브쿼리 사용
   - WHERE 조건절에 IN이나 EXISTS 연산자를 사용하여 삭제할 자료를 좀 더 세밀하게 선택 할 수 있음
   - 조건에 맞는 자료가 행 단위로 삭제된다.
   
사용예)장바구니테이블에서 2005년 5월 회원번호가 'p001'인 자료를 삭제하시오.

DELETE CART
WHERE CART_NO IN (SELECT CART_NO
  FROM CART
 WHERE CART_MEMBER = 'p001'
       AND SUBSTR(CART_NO, 1, 6) = '200505')
       
(서브쿼리: 2005년 5월 회원번호가 'p001'인 자료 조회)
SELECT A.CART_MEMBER,
       B.MEM_NAME
  FROM CART A, MEMBER B
 WHERE A.CART_MEMBER = B.MEM_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
       AND B.MEM_ID = 'p001'

(메인쿼리: 서브쿼리의 자료 삭제)
DELETE CART C
 WHERE C.CART_MEMBER = 'p001'
       AND SUBSTR(C.CART_NO,1,6) = '200505'

SELECT * FROM CART;

사용예)2005년 6월 상품 'P302000001'의 매출자료 중 판매 수량이 5개 이상인 자료만 삭제하시오.  
DELETE CART A
WHERE EXISTS (SELECT CART_MEMBER
  FROM CART B
 WHERE UPPER(CART_PROD) = 'P302000001'
       AND SUBSTR(CART_NO,1,6) = '200506'
       AND CART_QTY >= 5
       AND A.CART_NO = B.CART_NO
       AND A.CART_PROD = B.CART_PROD)
       
사용예)2005년 4월 판매자료 중 판매 금액이 5만원 이하의 자료만 삭제하시오
(서브쿼리:2005년 4월 판매자료 중 판매 금액이 5만원 이하의 자료 검색)
SELECT CART_PROD
       CART_QTY * PROD_PRICE
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
       AND SUBSTR(CART_NO,1,6) = '200504'
       AND CART_QTY * PROD_PRICE >= 50000;
       
(메인쿼리: 장바구니테이블에서 자료 삭제)
DELETE CART A
 WHERE EXISTS (SELECT 1
                 FROM PROD
                WHERE A.CART_PROD = PROD_ID
                      AND A.CART_QTY * PROD_PRICE <= 50000
                      AND A.CART_NO LIKE '200504%');

DELETE FROM CART A
 WHERE EXISTS(SELECT 1
                FROM PROD
               WHERE A.CART_PROD=PROD_ID
                 AND A.CART_QTY*PROD_PRICE<=50000)
       AND A.CART_NO LIKE '200504%'

ROLLBACK;

DELETE CART
 WHERE CART_NO IN (SELECT CART_NO
                     FROM CART A, PROD B
                    WHERE A.CART_PROD = B.PROD_ID
                          AND SUBSTR(A.CART_NO,1,6) = '200504'
                          AND A.CART_QTY * B.PROD_PRICE <= 50000)

                          

휴대폰필름 회사 : 수급과 재고파악의 문제로 단명하는 경우가 많음, 현재고와 전산상 재고의 차이가 문제임
해결방법 : RFID를 이용해서 위치를 파악(매미채 리더기)

