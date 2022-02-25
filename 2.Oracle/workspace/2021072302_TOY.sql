��뿹)�ŷ�ó '������'�� ������ ����(�����õ�)�� �����ϰ� �ִ� �ŷ�ó ������ ��ȸ�Ͻÿ�
      ALIAS�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, ������̴�.

SELECT B.BUYER_ID AS "�ŷ�ó�ڵ�",
       B.BUYER_NAME AS "�ŷ�ó��",
       B.BUYER_ADD1 || ' ' || B.BUYER_ADD2 AS "�ּ�",
       B.BUYER_CHARGER AS "�����"
  FROM BUYER A, BUYER B
 WHERE A.BUYER_NAME = '������'
       AND B.BUYER_ADD1 <> A.BUYER_ADD1;

SELECT B.BUYER_ID AS "�ŷ�ó�ڵ�",
       B.BUYER_NAME AS "�ŷ�ó��",
       B.BUYER_ADD1 || ' ' || B.BUYER_ADD2 AS "�ּ�",
       B.BUYER_CHARGER AS "�����"
  FROM BUYER A
 INNER JOIN BUYER B ON(A.BUYER_NAME = '������'
       AND B.BUYER_ADD1 <> A.BUYER_ADD1);
      
��뿹)�����ȣ 108�� ����� ���� �μ��� ���� ����� �����ȣ, �����, �μ���, �����ڵ带 ��ȸ�Ͻÿ�      

SELECT B.EMPLOYEE_ID AS "�����ȣ",
       B.EMP_NAME AS "�����",
       C.DEPARTMENT_NAME AS "�μ���",
       B.JOB_ID AS "�����ڵ�"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.EMPLOYEES B ON(A.EMPLOYEE_ID = 108
       AND A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 INNER JOIN HR.DEPARTMENTS C ON(B.DEPARTMENT_ID = C.DEPARTMENT_ID);
 
SELECT B.EMPLOYEE_ID AS "�����ȣ",
       B.EMP_NAME AS "�����",
       C.DEPARTMENT_NAME AS "�μ���",
       B.JOB_ID AS "�����ڵ�"
  FROM HR.EMPLOYEES A, HR.EMPLOYEES B, HR.DEPARTMENTS C
 WHERE A.EMPLOYEE_ID =108
       AND B.DEPARTMENT_ID = A.DEPARTMENT_ID
       AND B.DEPARTMENT_ID = C.DEPARTMENT_ID;

��뿹)2005�� 1�� ��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
      ����� �÷��� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ��̴�.

SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       NVL(SUM(B.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(B.BUY_QTY * A.PROD_PRICE),0) AS "���Աݾ�"
  FROM PROD A
  LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD
       AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
 GROUP BY A.PROD_ID, A.PROD_NAME
 ORDER BY 1;

SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       NVL(SUM(B.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(B.BUY_QTY * A.PROD_PRICE),0) AS "���Աݾ�"
  FROM PROD A
  LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD
       AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
 GROUP BY A.PROD_ID, A.PROD_NAME
 ORDER BY 1;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.BQTY),0) AS "���Լ���",
       NVL(SUM(A.BQTY * B.PROD_PRICE),0) AS "���Աݾ�"
  FROM (SELECT BUY_QTY AS BQTY,
               BUY_PROD AS BID
          FROM BUYPROD
         WHERE BUY_DATE  BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')) A, PROD B
 WHERE A.BID(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

��뿹)��� �μ��� ������� ��ȸ�Ͻÿ�.      
SELECT NVL(LPAD(TO_CHAR(B.DEPARTMENT_ID),3),'CEO') AS "�μ���ȣ",
       B.DEPARTMENT_NAME AS "�μ���",
       COUNT(A.EMPLOYEE_ID) AS "�����"
  FROM HR.EMPLOYEES A
  FULL OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY NVL(LPAD(TO_CHAR(B.DEPARTMENT_ID),3),'CEO'), B.DEPARTMENT_NAME;

��뿹)2005�� 4�� ��� ��ǰ�� ���� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
      ����� ������ ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �Ǹűݾ��̴�.

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.CQTY),0) AS "�Ǹż���",
       NVL(SUM(A.CQTY * B.PROD_PRICE),0) AS "�Ǹűݾ�"
FROM    (SELECT CART_PROD AS CID,
               CART_QTY AS CQTY
          FROM CART
         WHERE SUBSTR(CART_NO,1,6) = '200504') A, PROD B
WHERE A.CID (+)= B.PROD_ID
GROUP BY B.PROD_ID, B.PROD_NAME
ORDER BY 1;


SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.CART_QTY),0) AS "�Ǹż���",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "�Ǹűݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
      
��뿹)2005�� 4�� ��� ��ǰ�� ���� �����հ�� �����հ踦 ��ȸ�Ͻÿ�

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "�Ǹűݾ�",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "�����հ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050401')))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
