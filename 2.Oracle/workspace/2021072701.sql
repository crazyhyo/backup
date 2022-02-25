2021-0727-01)
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

REMAIN_YEAR
REMAIN_J_00 : �������, ���⵵ 12�� 31�ϳ� �ľ��� ����� �� / �� ���� ������ ��� 1��,2��,...
REMAIN_J_99 : �⸻���, ����� ���, �����
REMAIN_I : �԰�
REMAIN_O : ���
REMAIN_DATE : �ֽź��泯¥

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

����߻�����
(īƮ���̺� ���� �Է���
������̺��� PROD_ID�� ã��
REMAIN_O�� +�ϰ�
REMAIN_J_99�� -�ϰ�
REMAIN_DATE�� ���� ��¥�� ������Ʈ)

--CREATE TRIGGER tg_remain_cart
--AFTER INSERT CART
--ON REMAIN
--FOR EACH ROW
--DECLARE
--num INTEGER := 0;
--BEGIN
--
--END;


 4)DML ��ɿ� �������� ���
  (1) INSERT ���� �������� ���
   - '()'�� ������� �ʰ� �������� ���
   - INSERT ���� VALUES���� ����

�ѹ��� �Է��� �� ����!
   
��뿹) ���������̺�(REMAIN)�� PROD ���̺��� �ڷḦ �̿��Ͽ� ���ʵ����͸� �Է��Ͻÿ�
       �⵵ : '2005'
       ��ǰ�ڵ� : PROD���̺��� ��ǰ�ڵ�(PROD_ID)
       ���������� : PROD���̺��� PROD_PROPERSTOCK
       �԰� �� ��� ���� : ����
       �⸻������ : PROD���̺��� PROD_PROPERSTOCK
       ��¥ : '2004-12-31'
;
INSERT INTO REMAIN(REMAIN_YEAR, PROD_ID, REMAIN_J_00, REMAIN_J_99, REMAIN_DATE)
  SELECT '2005', PROD_ID, PROD_PROPERSTOCK, PROD_PROPERSTOCK, TO_DATE('20041231') FROM PROD;
SELECT * FROM REMAIN;
COMMIT;

  (2) UPDATE ���� �������� ���
   - �������� �÷��� �����ϴ� ��� '()'�ȿ� ������ �÷��� ����Ͽ� �ϳ��� SET���� ó��
   
��뿹)2005�� 1�� ��ǰ�� ���������� �̿��Ͽ� REMAIN���̺��� �����Ͻÿ�
�������� : UPDATE��
UPDATE REMAIN
   SET REMAIN_I = (��������),
       REMAIN_J_99 = (��������),
       REMAIN_DATE = TO_DATE('20050131')
 WHERE ����;
 
UPDATE REMAIN
   SET (REMAIN_I, REMAIN_J_99, REMAIN_DATE) = (��������),
 WHERE ����;

��������:2005�� 1�� ��ǰ�� ��������

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
 
 (����)
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

�������� �÷����� �⺻Ű�� �����Ǿ��� ��� �⺻Ű�� �����ϴ� ��� ����Ű�� ������ �ִ� ���� ���� ȿ������ �˻����
������Ʈ �� �� B.REMAIN_I + A.AMT, B.REMAIN_J_99 + A.AMTó�� ���� ������ ������ �־�� �Ѵ�.
��������� �ʿ��� ������ ���� �߰��� ���� ������ �÷��� ���°� �ٸ��ٸ� ���������� ����Ͽ� �÷��� ��ġ������� �Ѵ�.
FROM���� �̿��ؾ� �Ѵ�!

  (3) DELETE ���� �������� ���
   - WHERE �������� IN�̳� EXISTS �����ڸ� ����Ͽ� ������ �ڷḦ �� �� �����ϰ� ���� �� �� ����
   - ���ǿ� �´� �ڷᰡ �� ������ �����ȴ�.
   
��뿹)��ٱ������̺��� 2005�� 5�� ȸ����ȣ�� 'p001'�� �ڷḦ �����Ͻÿ�.

DELETE CART
WHERE CART_NO IN (SELECT CART_NO
  FROM CART
 WHERE CART_MEMBER = 'p001'
       AND SUBSTR(CART_NO, 1, 6) = '200505')
       
(��������: 2005�� 5�� ȸ����ȣ�� 'p001'�� �ڷ� ��ȸ)
SELECT A.CART_MEMBER,
       B.MEM_NAME
  FROM CART A, MEMBER B
 WHERE A.CART_MEMBER = B.MEM_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
       AND B.MEM_ID = 'p001'

(��������: ���������� �ڷ� ����)
DELETE CART C
 WHERE C.CART_MEMBER = 'p001'
       AND SUBSTR(C.CART_NO,1,6) = '200505'

SELECT * FROM CART;

��뿹)2005�� 6�� ��ǰ 'P302000001'�� �����ڷ� �� �Ǹ� ������ 5�� �̻��� �ڷḸ �����Ͻÿ�.  
DELETE CART A
WHERE EXISTS (SELECT CART_MEMBER
  FROM CART B
 WHERE UPPER(CART_PROD) = 'P302000001'
       AND SUBSTR(CART_NO,1,6) = '200506'
       AND CART_QTY >= 5
       AND A.CART_NO = B.CART_NO
       AND A.CART_PROD = B.CART_PROD)
       
��뿹)2005�� 4�� �Ǹ��ڷ� �� �Ǹ� �ݾ��� 5���� ������ �ڷḸ �����Ͻÿ�
(��������:2005�� 4�� �Ǹ��ڷ� �� �Ǹ� �ݾ��� 5���� ������ �ڷ� �˻�)
SELECT CART_PROD
       CART_QTY * PROD_PRICE
  FROM CART, PROD
 WHERE CART_PROD = PROD_ID
       AND SUBSTR(CART_NO,1,6) = '200504'
       AND CART_QTY * PROD_PRICE >= 50000;
       
(��������: ��ٱ������̺��� �ڷ� ����)
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

                          

�޴����ʸ� ȸ�� : ���ް� ����ľ��� ������ �ܸ��ϴ� ��찡 ����, ������ ����� ����� ���̰� ������
�ذ��� : RFID�� �̿��ؼ� ��ġ�� �ľ�(�Ź�ä ������)

