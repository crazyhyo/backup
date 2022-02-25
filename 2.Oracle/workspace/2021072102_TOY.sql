��뿹) ��� �μ��� ������� ��ȸ�Ͻÿ�(NULL�μ��ڵ�� ����)
SELECT B.DEPARTMENT_ID AS "�μ���ȣ",
       B.DEPARTMENT_NAME AS "�μ���",
       COUNT(A.EMP_NAME) AS "�����"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1;

--SELECT B.DEPARTMENT_ID AS "�μ���ȣ",
--       B.DEPARTMENT_NAME AS "�μ���",
--       COUNT(*) AS "�����"
--  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
-- WHERE A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID
-- GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
-- ORDER BY 1;
 
 SELECT B.DEPARTMENT_ID AS "�μ���ȣ",
       B.DEPARTMENT_NAME AS "�μ���",
       COUNT(A.EMP_NAME) AS "�����"
  FROM HR.EMPLOYEES A
 RIGHT OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID)
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1;
 
--  SELECT B.DEPARTMENT_ID AS "�μ���ȣ",
--       B.DEPARTMENT_NAME AS "�μ���",
--       COUNT(*) AS "�����"
--  FROM HR.EMPLOYEES A
-- RIGHT OUTER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID)
-- GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
-- ORDER BY 1;

��뿹)2005�� ���� ���Ծ� �� �ִ���Ծ�, �ּҸ��Ծ�
      Alias�� ��, �ִ���Ծ�, �ּҸ��Ծ�
SELECT B.MONTH AS "��",
       A.MAXV AS "�ִ���Ծ�",
       A.MINV AS "�ּҸ��Ծ�"
FROM   (SELECT MAX(A.TOTCOST) AS MAXV,
               MIN(A.TOTCOST) AS MINV
        FROM    (SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS MONTH,
                       SUM(B.PROD_COST * A.BUY_QTY) AS TOTCOST
                  FROM BUYPROD A, PROD B
                 WHERE A.BUY_PROD = B.PROD_ID
                       AND EXTRACT(YEAR FROM A.BUY_DATE) = '2005'
                 GROUP BY EXTRACT(MONTH FROM A.BUY_DATE)) A)A,
         (SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS MONTH,
               SUM(B.PROD_COST * A.BUY_QTY) AS TOTCOST
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND EXTRACT(YEAR FROM A.BUY_DATE) = '2005'
         GROUP BY EXTRACT(MONTH FROM A.BUY_DATE)) B
WHERE A.MAXV = B.TOTCOST
      OR A.MINV = B.TOTCOST;
GROUP BY A.MONTH;

SELECT EXTRACT(MONTH FROM BUY_DATE) AS MONTH,
               MAX(BUY_COST * BUY_QTY) AS ASDF,
               MIN(BUY_COST * BUY_QTY) AS QWER
          FROM BUYPROD
         WHERE EXTRACT(YEAR FROM BUY_DATE) = '2005'
         GROUP BY EXTRACT(MONTH FROM BUY_DATE)
         ORDER BY 1;

SELECT A.MONTH,
       A.TOTCOST
FROM    (SELECT EXTRACT(MONTH FROM A.BUY_DATE) AS MONTH,
                       SUM(B.PROD_COST * A.BUY_QTY) AS TOTCOST
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND EXTRACT(YEAR FROM A.BUY_DATE) = '2005'
         GROUP BY EXTRACT(MONTH FROM A.BUY_DATE)
         ORDER BY 2 DESC) A
WHERE ROWNUM = 1;


��뿹)2005�� 5�� �ִ뱸�� �������� ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ, ȸ����, ���űݾ�      

SELECT A.MID, A.MNM, A.MON      
FROM    (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNM,
               SUM(A.CART_QTY * C.PROD_PRICE) AS MON
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
WHERE ROWNUM = 1;

SELECT A.MID, A.MNM, A.MON      
FROM    (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNM,
               SUM(A.CART_QTY * C.PROD_PRICE) AS MON
          FROM CART A
         INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505')
         INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
WHERE ROWNUM = 1;


��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� �����
       �����ȣ, �����, �Ի���, �μ��ڵ�, �޿��� ��ȸ�Ͻÿ�
       
SELECT EMPLOYEE_ID AS "�����ȣ",
       EMP_NAME AS "�����",
       HIRE_DATE AS "�Ի���",
       DEPARTMENT_ID AS "�μ��ڵ�",
       SALARY AS "�޿�"
  FROM HR.EMPLOYEES
 WHERE COMMISSION_PCT IS NOT NULL;
       
��뿹)��ǰ���̺��� PROD_SIZE ���� NULL�̸� '��ǰũ������ ����' ���ڿ��� ����Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ũ��, ���Դܰ�

SELECT PROD_ID AS "��ǰ�ڵ�",
       PROD_NAME AS "��ǰ��",
       NVL(PROD_SIZE,'��ǰũ������ ����') AS "ũ��",
       PROD_COST AS "���Դܰ�"
  FROM PROD;
��뿹)������̺��� �����ȣ, �����, �μ��ڵ�, �����ڵ带 ����Ͻÿ�      
      ��, �μ��ڵ尡 NULL�̸� 'CEO'�� ����Ͻÿ�
SELECT EMPLOYEE_ID AS "�����ȣ",
       EMP_NAME AS "�����",
       NVL(TO_CHAR(DEPARTMENT_ID), 'CEO') AS "�μ��ڵ�",
       JOB_ID AS "�����ڵ�"
  FROM HR.EMPLOYEES;
**��ǰ���̺��� �з��ڵ尡 P301�� ��ǰ�� �ǸŰ��� ���԰��� 90%�� UPDATE�Ͻÿ�
UPDATE PROD
   SET PROD_PRICE = PROD_COST
 WHERE PROD_LGU = 'P301';
��뿹)2005�� 7�� ��� ��ǰ�� ���� �Ǹ������� ��ȸ�Ͻÿ�.
      Alias�� ��ǰ�ڵ�, �Ǹż����հ�, �Ǹűݾ��հ�
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       SUM(A.CART_QTY) AS "�Ǹż����հ�",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "�Ǹűݾ��հ�"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200507'
 GROUP BY B.PROD_ID
 ORDER BY 1;
      
��뿹)������̺��� �����ȣ, �����, �μ��ڵ�, �����ڵ带 ����Ͻÿ�.
      ��, �μ��ڵ尡 NULL�̸� 'CEO'�� ����Ͻÿ�.      
SELECT EMPLOYEE_ID AS "�����ȣ",
       EMP_NAME AS "�����",
       NVL(TO_CHAR(DEPARTMENT_ID),'CEO') AS "�μ��ڵ�",
       JOB_ID AS "�����ڵ�"
  FROM HR.EMPLOYEES;

��뿹)��ǰ���̺��� ��ǰ�� ��������(PROD_COLOR)�� ���� NULL�̸� '�������� ���� ��ǰ'��, NULL�� �ƴϸ� '�������� ���� ��ǰ'�� ����Ͻÿ� 
SELECT PROD_ID AS "��ǰ�ڵ�",
       PROD_NAME AS "��ǰ��",
       NVL2(PROD_COLOR,'�������� ���� ��ǰ','�������� ���� ��ǰ') AS "��������"
  FROM PROD;
��뿹)��ǰ���̺��� �ǸŰ��� ���԰��� ���Ͽ� ���� ������ '�����ǰ', ������ '������ǰ'�� ������ ����Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰�, �ǸŰ�, ���
SELECT PROD_ID AS "��ǰ�ڵ�",
       PROD_NAME AS "��ǰ��",
       PROD_COST AS "���԰�",
       PROD_PRICE AS "�ǸŰ�",
       NVL2(NULLIF(PROD_COST,PROD_PRICE),'�����ǰ','������ǰ') AS "���"
  FROM PROD;
��뿹)��ǰ���̺��� �ǸŰ��� ���԰��� ���Ͽ� ���� ������ �ǸŰ���, ������ '������ǰ'�� �ǸŰ����� ����Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰�, �ǸŰ�
SELECT PROD_ID AS "��ǰ�ڵ�",
       PROD_NAME AS "��ǰ��",
       PROD_COST AS "���԰�",
       NVL(TO_CHAR(NULLIF(PROD_COST,PROD_PRICE)),'������ǰ') AS "�ǸŰ�"
  FROM PROD;
��뿹)�������̺��� 2005�� 1�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ����հ�, ���Աݾ� �հ�
SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       SUM(B.BUY_QTY) AS "���Լ����հ�",
       SUM(B.BUY_QTY * B.BUY_COST) AS "���Աݾ� �հ�"
  FROM PROD A, BUYPROD B
 WHERE B.BUY_PROD = A.PROD_ID
       AND B.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
 GROUP BY A.PROD_ID, A.PROD_NAME;

      
��뿹)������̺��� ������ �����ȣ�� 121���� �μ��� ���� ��� ������ ��ȸ�Ͻÿ�
Alias�� �����ȣ, �����, �μ���, �������̴�.      
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       C.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = C.JOB_ID
       AND B.MANAGER_ID = 121;

SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       C.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.MANAGER_ID = 121)
 INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID);




��뿹)2005�� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�
�ŷ�ó�ڵ� / �ŷ�ó��
      Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��հ�      
      
SELECT C.BUYER_ID AS "�ŷ�ó�ڵ�",
       C.BUYER_NAME AS "�ŷ�ó��",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "����ݾ��հ�"
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,4) = '2005'
 GROUP BY C.BUYER_ID, C.BUYER_NAME
 ORDER BY 1;