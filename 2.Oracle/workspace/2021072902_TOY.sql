��뿹)��ٱ������̺��� 4���� 5���� �Ǹŵ� ��ǰ �� 4���� �Ǹŵ� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �����հ�, �Ǹűݾ��հ踦 ���Ͻÿ�

SELECT B.PROD_ID, B.PROD_NAME--, SUM(A.CART_QTY), SUM(A.CART_QTY * B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) = '200504'
 --GROUP BY B.PROD_ID, B.PROD_NAME
MINUS
SELECT B.PROD_ID, B.PROD_NAME--, SUM(A.CART_QTY), SUM(A.CART_QTY * B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) = '200505'
 --GROUP BY B.PROD_ID, B.PROD_NAME
MINUS
SELECT B.PROD_ID, B.PROD_NAME--, SUM(A.CART_QTY), SUM(A.CART_QTY * B.PROD_PRICE)
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID AND SUBSTR(A.CART_NO,1,6) = '200504'
 --GROUP BY B.PROD_ID, B.PROD_NAME

��뿹)ȸ�����̺��� ���ϸ����� ���� ȸ������ ���ʴ�� ����(���)�� �ο��Ͻÿ�
      ȸ����ȣ, ȸ����, ���ϸ���, ���

SELECT MEM_ID, MEM_NAME, MEM_MILEAGE, RANK() OVER(ORDER BY MEM_MILEAGE DESC)
  FROM MEMBER
  
��뿹)ȸ�����̺��� ���ϸ����� ���� ȸ������ ���ʴ�� ����(���)�� �ο��ϰ� ���� 5����
      ȸ����ȣ, ȸ����, ���ϸ���, ����� ����Ͻÿ�
SELECT *
  FROM (SELECT MEM_ID, MEM_NAME, MEM_MILEAGE, RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS RK
          FROM MEMBER)
 WHERE RK <= 5

��뿹)��ٱ��� ���̺��� 2005�� 5�� ���űݾ��� ���� ȸ������ ������ �ο��Ͽ�        
      ȸ����ȣ, ȸ����, ���űݾ�, ������ ����Ͻÿ�

SELECT B.MEM_ID, B.MEM_NAME, SUM(A.CART_QTY * C.PROD_PRICE), RANK() OVER(ORDER BY SUM(A.CART_QTY * C.PROD_PRICE) DESC)
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID AND A.CART_PROD = C.PROD_ID AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.MEM_ID, B.MEM_NAME