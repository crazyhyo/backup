2021-0729-01)������(RANK �Լ�)
  - ����, �޿�, ���� ���� ������ ���Ҷ� ���
  - ORDER BY ���� ROWNUM�� �÷��� ����Ŭ�� WHERE���� ORDER BY���� ���� ���������� ��Ȯ�� ��� ��ȯ�� �Ұ��� ��
  - �̸� �ذ��ϱ� ���� RANK�� DENSE_RANK, ROW_NUMBER �Լ� ����
  - RANK�� DENSE_RANK �Լ��� ������
   - RANK : �ߺ� ������ �߻��ϸ� �ߺ��� �� ��ŭ ������������ ����      (EX 1,1,1,4,5,5,7,...)
   - DENSE_RANK : �ߺ� ������ �߻��ص� ���� ������ �������� ���� ����  (EX 1,1,1,2,3,3,4,...)
   - ROW_NUMBER : �ߺ��� ������� ���� ������ ����                   (EX 1,2,3,4,5,6,7,...)
  - SELECT ������ ���
  (�������)
   SELECT �÷�LIST
          RANK() OVER(ORDER BY ���� �÷��� DESC|ASC) AS �÷���Ī
                :
     FROM ���̺��;            

����Ŭ���� ����Ǵ� ������ ������ ������ �ֱ� ������ ����ڰ� ���ϴ� ������� ������ �� ����
(EX ORDER BY ���Ŀ� ROWNUM�� �����Ű�� ����)

��뿹)ȸ�����̺��� ���ϸ����� ���� ȸ������ ���ʴ�� ����(���)�� �ο��Ͻÿ�
      ȸ����ȣ, ȸ����, ���ϸ���, ���
      
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_MILEAGE AS "���ϸ���",
       DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "���"
  FROM MEMBER;
  
RANK�Լ��� OVER���� ���� �÷��� ������ ���� �� �ִ�.
������ ���������� ���� �� ����.
SELECT ������ �ο��� �÷���Ī���� ������ �� ����.

��뿹)ȸ�����̺��� ���ϸ����� ���� ȸ������ ���ʴ�� ����(���)�� �ο��ϰ� ���� 5����
      ȸ����ȣ, ȸ����, ���ϸ���, ����� ����Ͻÿ�
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_MILEAGE AS "���ϸ���",
       MRANK AS "���"
  FROM (SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS MRANK
          FROM MEMBER)
--  WHERE MRANK <=5;
 WHERE ROWNUM <= 5;
 
SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,
       RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS MRANK
  FROM MEMBER
 WHERE ROWNUM <= 5;
 
SELECT A.MID AS ȸ����ȣ,
       B.MEM_NAME AS ȸ����,
       B.MEM_MILEAGE AS ���ϸ���,
       A.MRK AS ���
  FROM MEMBER B,
       (SELECT MEM_ID AS MID,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS MRK
          FROM MEMBER) A
 WHERE A.MID = B.MEM_ID
       AND A.MRK <= 5;
       
��뿹)��ٱ��� ���̺��� 2005�� 5�� ���űݾ��� ���� ȸ������ ������ �ο��Ͽ�        
      ȸ����ȣ, ȸ����, ���űݾ�, ������ ����Ͻÿ�
SELECT A.MEM_ID AS "ȸ����ȣ",
       A.MEM_NAME AS "ȸ����",
       B.AMT AS "���űݾ�",
       RANK() OVER(ORDER BY AMT DESC) AS "����"
  FROM MEMBER A,
       (SELECT B.MEM_ID AS MID,
               SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 2) B
 WHERE A.MEM_ID = B.MID;
 
SELECT B.MEM_ID AS "ȸ����ȣ",
       B.MEM_NAME AS "ȸ����",
       SUM(A.CART_QTY * C.PROD_PRICE) AS "���űݾ�",
       RANK() OVER(ORDER BY SUM(A.CART_QTY * C.PROD_PRICE) DESC) AS "����"
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.MEM_ID, B.MEM_NAME;
 
RANK�� ������ ORDER BY�� �ش� SELECT���� ���Ľ����ش�.
RANK OVER(ORDER BY �÷���)���� �÷��� �����Լ��� ������ �� �÷��� GROUP BY �� ������� �ʾƵ� �ȴ�(�����÷� ��޵ȴ�)
���� ���⼭�� �÷��� �����Լ��� �����ٸ� �Ϲ��÷����� ��޵Ǿ� GROUP BY���� ����ؾ� �Ѵ�.

SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_MILEAGE AS "���ϸ���",
--       RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "���"
--       DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "���"
       ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS "���"       
  FROM MEMBER;


����� �������� �� ���� ������ �������� �� ���� ���� ����� ������ �޶��� �� �ִ�.
������������ ���� 5���� �μ��� �����Ѵٰ� �ϸ� DENSE_RANK()�� ���� ���� �ڿ�������
���� 5�� ������ �Ѵٸ� RANK�� ��� �Ѵ�.
��, 1���� 6���̸� ������Ģ�� ���� ó���ϰ� �ȴ�(����� �������� �� ��)
ROW_NUMBER�� ������ ���� ���ȣ�� �ο��ϴ� ���
