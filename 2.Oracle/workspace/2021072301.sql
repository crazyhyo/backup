2021-0723-01)
  4. SELF JOIN
   - �ϳ��� ���̺� ���� �ٸ� ��Ī�� �ο��Ͽ� �����ϴ� ����
��뿹)�ŷ�ó '������'�� ������ ����(�����õ�)�� �����ϰ� �ִ� �ŷ�ó ������ ��ȸ�Ͻÿ�
      ALIAS�� �ŷ�ó�ڵ�, �ŷ�ó��, �ּ�, ������̴�.

SELECT B.BUYER_ID AS "�ŷ�ó�ڵ�",
       B.BUYER_NAME AS "�ŷ���",
       B.BUYER_ADD1 || ' ' || B.BUYER_ADD2 AS "�ּ�",
       B.BUYER_CHARGER AS "�����"
  FROM BUYER A, BUYER B
 WHERE A.BUYER_NAME = '������'
       AND SUBSTR(B.BUYER_ADD1,1,2) <> SUBSTR(A.BUYER_ADD1,1,2);
       
��뿹)�����ȣ 108�� ����� ���� �μ��� ���� ����� �����ȣ, �����, �μ���, �����ڵ带 ��ȸ�Ͻÿ�
SELECT C.EMPLOYEE_ID AS "�����ȣ",
       C.EMP_NAME AS "�����",
       B.DEPARTMENT_ID AS "�μ���",
       C.JOB_ID AS "�����ڵ�"
FROM    (SELECT DEPARTMENT_ID AS DID
          FROM HR.EMPLOYEES
         WHERE EMPLOYEE_ID = 108) A
INNER JOIN HR.DEPARTMENTS B ON(A.DID = B.DEPARTMENT_ID)
INNER JOIN HR.EMPLOYEES C ON(B.DEPARTMENT_ID = C.DEPARTMENT_ID);

SELECT C.EMPLOYEE_ID AS "�����ȣ",
       C.EMP_NAME AS "�����",
       B.DEPARTMENT_ID AS "�μ���",
       C.JOB_ID AS "�����ڵ�"
FROM    (SELECT DEPARTMENT_ID AS DID
          FROM HR.EMPLOYEES
         WHERE EMPLOYEE_ID = 108) A, HR.DEPARTMENTS B, HR.EMPLOYEES C
WHERE A.DID = B.DEPARTMENT_ID
      AND B.DEPARTMENT_ID = C.DEPARTMENT_ID;

SELECT C.EMPLOYEE_ID AS "�����ȣ",
       C.EMP_NAME AS "�����",
       B.DEPARTMENT_ID AS "�μ���",
       C.JOB_ID AS "�����ڵ�"
FROM  HR.EMPLOYEES A
INNER JOIN HR.EMPLOYEES C ON(A.EMPLOYEE_ID = 108
      AND A.DEPARTMENT_ID = C.DEPARTMENT_ID)
INNER JOIN HR.DEPARTMENTS B ON(C.DEPARTMENT_ID = B.DEPARTMENT_ID);

SELECT C.EMPLOYEE_ID AS "�����ȣ",
       C.EMP_NAME AS "�����",
       B.DEPARTMENT_ID AS "�μ���",
       C.JOB_ID AS "�����ڵ�"
FROM  HR.EMPLOYEES A, HR.EMPLOYEES C, HR.DEPARTMENTS B
WHERE A.EMPLOYEE_ID = 108
      AND A.DEPARTMENT_ID = C.DEPARTMENT_ID
      AND C.DEPARTMENT_ID = B.DEPARTMENT_ID;
      
  5. �ܺ�����(OUTER JOIN)
   - ���������� ���������� �����ϴ� �����͸� �������� ����� ��ȯ
   - �ܺ������� ���������� �������� ���ϴ� �����͸� �������� ������ ���̺� NULL������ ä���� ���� �����Ͽ� ���� ����
   - �������ǿ��� ������ �����͸� ������ �ִ� ���̺� ���� ���̺� ���� ���̸� ������ '(+)'�����ڸ� �߰���
   - ���� ���������� �ܺ������� ����Ǿ�� �ϴ� ��� ��� '(+)'�����ڸ� ����ؾ� ��
   - ���ÿ� �� ���̺� �������� �ܺ������� '(+)'�����ڸ� ����� �� ����. ��, A,B,C���̺���
     �ܺ����ο� ������ �� A�� �������� A�� �������� B�� Ȯ���԰� ���ÿ� C�� �������� B�� Ȯ���� �� ����
     (WHERE A = B(+) AND C = B(+) => ���ȵ�)
   - �Ϲݿܺ������� ��� �Ϲ������� ���Ǹ� �������� ����� ��ȯ(�ذ��� : ANSI �ܺ����� �Ǵ� �������� ���)
   - �ܺ������� ����� ó���ӵ��� ���� ����
   
  (�Ϲݿܺ����� �������)
   SELECT �÷�LIST
     FROM ���̺��1, ���̺��2[, ���̺��3,...]
    WHERE ���̺��1.�÷���[(+)]=���̺��2.[(+)]
                    :
   - ���� ��� ������ �ܺ������� ��� �ȵ�(WHERE A.COL(+) = B.COL(+))
   
  (ANSI�ܺ����� �������)
   SELECT �÷�LIST
     FROM ���̺��1
   LEFT|RIGHT|FULL OUTER JOIN ���̺��2 ON(��������1 [AND �Ϲ�����1])
  [LEFT|RIGHT|FULL OUTER JOIN ���̺��3 ON(��������2 [AND �Ϲ�����2])]
                                :
  [WHERE �Ϲ�����n]
   - ���̺��1�� ���̺��2�� �ݵ�� ���� ������ ��
   - �Ϲ�����1�� ���̺��1 �Ǵ� ���̺��2�� ���ѵ� ����
   - �Ϲ�����n�� ��ü ���̺� ����Ǵ� �������� ������ ��� ������ �� �����
   - LEFT|RIGHT|FULL : ���̺��1�� ������ ������ �� ���� ��� LEFT, �ݴ��� ��� RIGHT, ���� ��� ������ ��� FULL ���

-- ����ȭ�� �Ǿ������� FULL OUTER JOIN�� ����ϰ� �Ǵ� ��� : FK�� NULL�� ���� ������ ���̴�. �����ؼ� �����ϵ���

��뿹)��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
      ����� �÷��� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ��̴�.
    (ANSI�ܺ�����)
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
 GROUP BY B.PROD_ID, B.PROD_NAME;
 
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM BUYPROD A, PROD B
 WHERE A.BUY_PROD(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

��뿹)2005�� 1�� ��� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
      ����� �÷��� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ��̴�.
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'))
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(A.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM BUYPROD A
 RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
 WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
 GROUP BY B.PROD_ID, B.PROD_NAME;
--�� ���� ���̺��� ����Ǵ� ������ �ܺ����� ���� ����Ǿ� �ܺ����� ������� �Ϲ����ǿ� ���� �ʴ� ���� ���ư����� �ǵ��� �ٸ� ����� ����� ��

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.QTT),0) AS "���Լ���",
       NVL(SUM(A.QTT * B.PROD_COST),0) AS "���Աݾ�"
  FROM (SELECT BUY_PROD AS BID,
               BUY_QTY AS QTT
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')) A, PROD B
 WHERE A.BID(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.QTT),0) AS "���Լ���",
       NVL(SUM(A.QTT * B.PROD_COST),0) AS "���Աݾ�"
  FROM PROD B,--(2005�⵵ 1�� ��������(��������)) A
 WHERE A.BID(+) = B.PROD_ID
 GROUP BY B.PROD_ID, B.PROD_NAME;

--(2005�⵵ 1�� ��������(��������)) A
SELECT BUY_PROD AS BID,
       SUM(BUY_QTY) AS QAMT,
       SUM(BUY_QTY * BUY_COST) AS MANT
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
 GROUP BY BUY_PROD;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(A.QAMT,0) AS "���Լ���",
       NVL(A.MANT,0) AS "���Աݾ�"
  FROM PROD B,(SELECT BUY_PROD AS BID,
                      SUM(BUY_QTY) AS QAMT,
                      SUM(BUY_QTY * BUY_COST) AS MANT
                 FROM BUYPROD
                WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
                GROUP BY BUY_PROD) A
 WHERE A.BID(+) = B.PROD_ID;

���/��ü�� ���Ҵ� -> �ܺ������� ���� -> COUNT�� ���ٸ� *�� ���� ���� : �� ��Ʈ��.
OUTER JOIN�� ���Ǵ� ��� : '���' Ȥ�� '��ü'��� ���ľ �ٴ� ���
                            �� ���ư��� COUNT(*) ��� COUNT(�÷��� <- PK�� ���)���� �����ؾ� �ϴ� �͵� ���� ����
�����ʵ尡 ���Ǵ� �÷��� "�ݵ��" NVL�� ������ش�

��뿹)��� �μ��� ������� ��ȸ�Ͻÿ�.
      ����� �μ��ڵ�, �μ���, ������̴�.
SELECT LPAD(NVL(TO_CHAR(A.DEPARTMENT_ID),'CEO'),6) AS "�μ��ڵ�",
       A.DEPARTMENT_NAME AS "�μ���",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "�����"
  FROM HR.DEPARTMENTS A
  FULL OUTER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;      

SELECT A.DEPARTMENT_ID AS "�μ��ڵ�",
       A.DEPARTMENT_NAME AS "�μ���",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "�����"
  FROM HR.DEPARTMENTS A
  FULL OUTER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1; 
  
SELECT A.DEPARTMENT_ID AS "�μ��ڵ�",
       A.DEPARTMENT_NAME AS "�μ���",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "�����"
  FROM HR.DEPARTMENTS A
  LEFT OUTER JOIN HR.EMPLOYEES B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;
 
SELECT A.DEPARTMENT_ID AS "�μ��ڵ�",
       A.DEPARTMENT_NAME AS "�μ���",
       NVL(COUNT(B.EMPLOYEE_ID),0) AS "�����"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;

SELECT A.DEPARTMENT_ID AS "�μ��ڵ�",
       A.DEPARTMENT_NAME AS "�μ���",
       COUNT(*) AS "�����"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
 GROUP BY A.DEPARTMENT_ID, A.DEPARTMENT_NAME
 ORDER BY 1;
 
SELECT A.DEPARTMENT_ID AS "�μ��ڵ�",
       A.DEPARTMENT_NAME AS "�μ���",
       COUNT(B.EMPLOYEE_ID) AS "�����"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+)
 GROUP BY ROLLUP(A.DEPARTMENT_ID, A.DEPARTMENT_NAME)
 ORDER BY 1;
 
��뿹)2005�� 4�� ��� ��ǰ�� ���� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
      ����� ������ ��ǰ�ڵ�, ��ǰ��, �Ǹż���, �Ǹűݾ��̴�.

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.CART_QTY),0) AS "�Ǹż���",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "�Ǹűݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504')
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
SELECT C.PROD_ID AS "��ǰ�ڵ�",
       C.PROD_NAME AS "��ǰ��",
       NVL(SUM(B.CART_QTY),0) AS "�Ǹż���",
       NVL(SUM(B.CART_QTY * C.PROD_PRICE),0) AS "�Ǹűݾ�"
  FROM CART A, CART B, PROD C
 WHERE SUBSTR(A.CART_NO,1,6) = '200504'
       AND A.CART_NO = B.CART_NO
       AND B.CART_PROD = C.PROD_ID(+)
 GROUP BY C.PROD_ID, C.PROD_NAME
 ORDER BY 1;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(A.CQTY),0) AS "�Ǹż���",
       NVL(SUM(A.CQTY * B.PROD_PRICE),0) AS "�Ǹűݾ�"
  FROM (SELECT CART_PROD AS CPID,
               CART_QTY AS CQTY
          FROM CART
         WHERE SUBSTR(CART_NO,1,6) = '200504') A,
         PROD B
 WHERE B.PROD_ID = A.CPID(+)
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 3;
 
 
 SELECT B.PROD_ID AS ��ǰ�ڵ�,
        B.PROD_NAME AS ��ǰ��,
        NVL(SUM(A.CART_QTY),0) AS �Ǹż���,
        NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS �Ǹűݾ�
   FROM CART A
  RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
        AND SUBSTR(A.CART_NO,1,6) = '200504')
  GROUP BY B.PROD_ID, B.PROD_NAME
  ORDER BY 1;

��뿹)2005�� 4�� ��� ��ǰ�� ���� �����հ�� �����հ踦 ��ȸ�Ͻÿ�