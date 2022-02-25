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

CREATE TABLE REMAIN(
    REMAIN_DATE CHAR(4) NOT NULL,
    PROD_ID VARCHAR(10) NOT NULL,
    REMAIN_J_00 NUMBER(5) DEFAULT 0,
    REMAIN_I NUMBER(5) DEFAULT 0,
    REMAIN_O NUMBER(5) DEFAULT 0,
    REMAIN_J_99 NUMBER(5) DEFAULT 0,
    REMAIN_DATE DATE
);

ALTER TABLE REMAIN ADD CONSTRAINT pk_remain PRIMARY KEY(REMAIN_DATE, PROD_ID);
ALTER TABLE REMAIN ADD CONSTRAINT fk_remain_prod FOREIGN KEY(PROD_ID) REFERENCES PROD(PROD_ID);


INSERT INTO REMAIN A(A.REMAIN_YEAR, A.PROD_ID, A.REMAIN_J_00, A.REMAIN_J_99, A.REMAIN_DATE)
SELECT '2005', B.PROD_ID, B.PROD_PROPERSTOCK, B.PROD_PROPERSTOCK, TO_DATE('20041231')  FROM PROD B;
SELECT * FROM REMAIN;
  사용예) 재고수불테이블(REMAIN)에 PROD 테이블의 자료를 이용하여 기초데이터를 입력하시오
  
  사용예)2005년 1월 상품별 매입정보를 이용하여 REMAIN테이블을 변경하시오
UPDATE REMAIN A
   SET (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE) = 
       (SELECT A.REMAIN_I + TBLA.BQTY, A.REMAIN_J_99 + TBLA.BQTY, TO_DATE('20050131')
          FROM (SELECT BUY_PROD AS BID,
                       SUM(BUY_QTY) AS BQTY
                  FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
              GROUP BY BUY_PROD) TBLA
         WHERE A.PROD_ID = TBLA.BID)
 WHERE A.PROD_ID IN (SELECT BUY_PROD FROM BUYPROD WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')));

SELECT BUY_PROD AS BID,
       SUM(BUY_QTY) AS BQTY
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
 GROUP BY BUY_PROD;

  사용예)장바구니테이블에서 2005년 5월 회원번호가 'p001'인 자료를 삭제하시오.

DELETE CART A
 WHERE EXISTS(SELECT CART_NO
                FROM CART B
               WHERE CART_MEMBER = 'p001'
                     AND SUBSTR(CART_NO,1,6) = '200505'
                     AND A.CART_NO = B.CART_NO)

SELECT CART_NO
  FROM CART
 WHERE CART_MEMBER = 'p001'
       AND SUBSTR(CART_NO,1,6) = '200505'

  사용예)2005년 6월 상품 'P302000001'의 매출자료 중 판매 수량이 5개 이상인 자료만 삭제하시오.  
DELETE CART A
 WHERE EXISTS (SELECT CART_PROD, CART_NO
                 FROM CART B
                WHERE SUBSTR(CART_NO,1,6) = '200506'
                      AND CART_PROD = 'P302000001'
                      AND CART_QTY >= 5
                      AND A.CART_PROD = B.CART_PROD
                      AND A.CART_NO = B.CART_NO); 
ROLLBACK;

  사용예)2005년 4월 판매자료 중 판매 금액이 5만원 이하의 자료만 삭제하시오
DELETE CART TBLA
 WHERE EXISTS (SELECT A.CART_NO, B.PROD_ID
                 FROM CART A, PROD B
                WHERE A.CART_PROD = B.PROD_ID
                      AND SUBSTR(A.CART_NO,1,6) = '200504'
                      AND A.CART_QTY * B.PROD_PRICE <= 50000
                      AND A.CART_NO = TBLA.CART_NO
                      AND A.CART_PROD = TBLA.CART_PROD)
 
SELECT A.CART_NO, B.PROD_ID
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504'
       AND A.CART_QTY * B.PROD_PRICE <= 50000

  사용예)회원테이블에서 평균마일리지보다 많은 마일리지를 보유한 회원의 회원번호, 회원명, 마일리지를 출력하시오

SELECT A.MEM_ID AS "회원번호",
       A.MEM_NAME AS "회원명",
       A.MEM_MILEAGE AS "마일리지"
  FROM MEMBER A, (SELECT AVG(MEM_MILEAGE) AS AVE
                    FROM MEMBER) B
 WHERE A.MEM_MILEAGE > B.AVE
                        
  
  사용예)회원들의 자료에서 성별 평균마일리지를 구하고 자신의 성별 평균마일리지보다 적은 마일리지를 보유한 회원의
      2005년 4~6월 구매현황을 조회하시오.
      ALIAS회원번호, 회원명, 구매금액합계
SELECT       
SELECT A.GEN, AVG(A.MIL)
  FROM (SELECT MEM_ID AS MID,
       MEM_NAME AS MNAME,
       MEM_MILEAGE AS MIL,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남자'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여자'
       END AS GEN
  FROM MEMBER) A
 GROUP BY A.GEN


