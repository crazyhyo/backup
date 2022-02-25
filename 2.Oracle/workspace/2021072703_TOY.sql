 ** ��� ����ó���� ���� ���̺��� �����Ͻÿ�
  1) ���̺� �� : REMAIN
  2) �÷���
  -----------------------------------------------------------
  �÷���         ������Ÿ��       NULLABLE        �������
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
  ��뿹) ���������̺�(REMAIN)�� PROD ���̺��� �ڷḦ �̿��Ͽ� ���ʵ����͸� �Է��Ͻÿ�
  
  ��뿹)2005�� 1�� ��ǰ�� ���������� �̿��Ͽ� REMAIN���̺��� �����Ͻÿ�
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

  ��뿹)��ٱ������̺��� 2005�� 5�� ȸ����ȣ�� 'p001'�� �ڷḦ �����Ͻÿ�.

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

  ��뿹)2005�� 6�� ��ǰ 'P302000001'�� �����ڷ� �� �Ǹ� ������ 5�� �̻��� �ڷḸ �����Ͻÿ�.  
DELETE CART A
 WHERE EXISTS (SELECT CART_PROD, CART_NO
                 FROM CART B
                WHERE SUBSTR(CART_NO,1,6) = '200506'
                      AND CART_PROD = 'P302000001'
                      AND CART_QTY >= 5
                      AND A.CART_PROD = B.CART_PROD
                      AND A.CART_NO = B.CART_NO); 
ROLLBACK;

  ��뿹)2005�� 4�� �Ǹ��ڷ� �� �Ǹ� �ݾ��� 5���� ������ �ڷḸ �����Ͻÿ�
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

  ��뿹)ȸ�����̺��� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ����Ͻÿ�

SELECT A.MEM_ID AS "ȸ����ȣ",
       A.MEM_NAME AS "ȸ����",
       A.MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER A, (SELECT AVG(MEM_MILEAGE) AS AVE
                    FROM MEMBER) B
 WHERE A.MEM_MILEAGE > B.AVE
                        
  
  ��뿹)ȸ������ �ڷῡ�� ���� ��ո��ϸ����� ���ϰ� �ڽ��� ���� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ����
      2005�� 4~6�� ������Ȳ�� ��ȸ�Ͻÿ�.
      ALIASȸ����ȣ, ȸ����, ���űݾ��հ�
SELECT       
SELECT A.GEN, AVG(A.MIL)
  FROM (SELECT MEM_ID AS MID,
       MEM_NAME AS MNAME,
       MEM_MILEAGE AS MIL,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '����'
       END AS GEN
  FROM MEMBER) A
 GROUP BY A.GEN


