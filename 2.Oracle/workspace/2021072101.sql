2021-0721-01)���̺� ����
  - ������ �����ͺ��̽��� �ٽ� ���
  - �������� ���̺� �л�� �ڷḦ ��ȸ�ϱ� ����
  - ���̺� ���̿� ����(Relationship)�� �ξ��� �־�� ��
  - ����
   - �Ϲ����� / ANSI JOIN
    - �Ϲ����� - CARTESIAN PRODUCT, EQUI JOIN, NON EQUI JOIN, SELF JOIN, OUTER JOIN
    - ANSI JOIN - CROSS JOIN, NATURAL JOIN, INNER JOIN, OUTER JOIN
   - �������� / �ܺ�����
 
 (�Ϲ� �������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1], ���̺��2 [��Ī2][, ���̺��3 [��Ī3],...]
   WHERE ��������1
    [AND ��������2]
    [AND �Ϲ�����]...
    
   - ���ο� ���� ���̺��� n���� �� ���������� ������ n-1�� �̻��̾�� ��
   - �������ǰ� �Ϲ������� ��� ������ �ǹ̾���(������ ����� ���� ���� �ϴ°� �����غ� �� ������?)
 
 (ANSI INNER JOIN �������)
  SELECT �÷�list
    FROM ���̺��1 [��Ī1]
   INNER JOIN ���̺��2 [��Ī2] ON(��������1 [AND �Ϲ�����1])
   [INNER JOIN ���̺��3 [��Ī3] ON(��������2 [AND �Ϲ�����2])]
          :
   WHERE �Ϲ�����n...
   
   - '���̺��1'�� '���̺��2'�� �ݵ�� ���� ������ ���̺��� ��(�Ϲ������� ���踦 ������ �ִ� ���̺��� ���Ѵ�. ���������δ� ���� ���Ѵ�<- ���谡 ��� �������� ���ΰ���)
   - '���̺��3' ���ʹ� '���̺��1'�� '���̺��2'�� ����� ����(INNER JOIN�� �ݺ��ؼ� ����� �� �� �ݺ����� ���������� ó���Ѵ�)
   - ON ���� ���Ǵ� �Ϲ�����1�� '���̺��1'�� '���̺��2'���� �ش��ϴ� ��������
   - WHERE ���� ���������� ��� ���̺� ����Ǵ� ��������
   
�Ϲ� ����������δ� ǥ�� �������� ANSI INNER JOIN ���δ� ǥ�� �� �� �ִ� ������ �ִ�.
��) ��ǰ���� ���� ������Ȳ�� ��ȸ�� �� CART�� �����ϰ� �Ǵµ�, CART���� ������ �߻��� ��ǰ�� �����ϰ� �־
    �Ϲ� ����������� ���������� �ۼ��ϸ� ������ ������ ������ ���� ��ǰ�� ��ȸ���� ���Ѵ�.
    �̷� ��� ���������� ��ü�� �����ϴ� ���� �ƴ϶� ������ ��� ���̺�鿡�Ը� �����ų �� �ִ� INNER JOIN�������� �ذ��Ѵ�.

  1. CARTESIAN PRODUCT
   - ��� ������ ����� ������ ����� ��ȯ
   - ANSI������ CROSS JOIN�� �̿� �ش�
   - Ư���� ���� �̿ܿ��� ������ ����
   - ���������� ���ų� �߸��� ��� �߻�

��뿹)
SELECT *
  FROM CART, BUYPROD, PROD
 WHERE BUYPROD.BUY_PROD = PROD.PROD_ID
       AND PROD.PROD_ID = CART.CART_PROD
 ORDER BY 2;
  
SELECT COUNT(*) FROM BUYPROD;  
SELECT COUNT(*) FROM CART;
SELECT COUNT(*) FROM PROD;

SELECT 148 * 207 FROM DUAL;

��뿹)
SELECT COUNT(*)
  FROM CART, BUYPROD, PROD;
  
SELECT COUNT(*)
  FROM CART
 CROSS JOIN BUYPROD
 CROSS JOIN PROD;


  2. EQUI-JOIN
   - ��������
   - ���� ���ǿ� '='�����ڰ� ���� ����
   - ANSI JOIN�� INNER JOIN�� �̿� �ش�
   - �������� �Ǵ� SELECT�� ���Ǵ� �÷� �� �� ���̺��� ���� �÷������� ���ǵ� ���
     '���̺��.�÷���' �Ǵ� '���̺� ��Ī.�÷���' �������� ���

��뿹)�������̺��� 2005�� 1�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���Լ����հ�, ���Աݾ� �հ�
    
    (�Ϲ���������)
    SELECT B.PROD_ID AS "��ǰ�ڵ�",
           B.PROD_NAME AS "��ǰ��",
           SUM(A.BUY_QTY) AS "���Լ����հ�",
           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "���Աݾ� �հ�"
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
    
    (ANSI����)
    SELECT B.PROD_ID AS "��ǰ�ڵ�",
           B.PROD_NAME AS "��ǰ��",
           SUM(A.BUY_QTY) AS "���Լ����հ�",
           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "���Աݾ� �հ�"
      FROM BUYPROD A
     INNER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;

    SELECT B.PROD_ID AS "��ǰ�ڵ�",
           B.PROD_NAME AS "��ǰ��",
           SUM(A.BUY_QTY) AS "���Լ����հ�",
           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "���Աݾ� �հ�"
      FROM BUYPROD A
     INNER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID)
     WHERE A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
    
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
======================================================
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       C.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID
   AND B.MANAGER_ID = 121)
 INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID);       
======================================================
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       C.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A
 INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
 INNER JOIN HR.JOBS C ON(A.JOB_ID = C.JOB_ID)
 WHERE B.MANAGER_ID = 121;       


��뿹)2005�� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� �ŷ�ó�ڵ�, �ŷ�ó��, ����ݾ��հ�
     
    SELECT C.BUYER_ID AS "�ŷ�ó�ڵ�",
           C.BUYER_NAME AS "�ŷ�ó��",
           SUM(A.CART_QTY * B.PROD_PRICE) AS "����ݾ��հ�"
      FROM CART A, PROD B, BUYER C
     WHERE A.CART_PROD = B.PROD_ID
           AND C.BUYER_ID = B.PROD_BUYER
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY C.BUYER_ID, C.BUYER_NAME
     ORDER BY 1;
     
    SELECT C.BUYER_ID AS "�ŷ�ó�ڵ�",
           C.BUYER_NAME AS "�ŷ�ó��",
           SUM(A.CART_QTY * B.PROD_PRICE) AS "����ݾ��հ�"
      FROM CART A
     INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID)
     INNER JOIN BUYER C ON(C.BUYER_ID = B.PROD_BUYER)
     WHERE SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY C.BUYER_ID, C.BUYER_NAME
     ORDER BY 1; 
     
    SELECT C.BUYER_ID AS "�ŷ�ó�ڵ�",
           C.BUYER_NAME AS "�ŷ�ó��",
           SUM(A.CART_QTY * B.PROD_PRICE) AS "����ݾ��հ�"
      FROM CART A
     INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005')
     INNER JOIN BUYER C ON(C.BUYER_ID = B.PROD_BUYER)
     GROUP BY C.BUYER_ID, C.BUYER_NAME
     ORDER BY 1; 
     
     
    (�Ϲ���������)
--    SELECT B.PROD_ID AS "��ǰ�ڵ�",
--           B.PROD_NAME AS "��ǰ��",
--           SUM(A.BUY_QTY) AS "���Լ����հ�",
--           TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999') AS "���Աݾ� �հ�"
--      FROM BUYPROD A, PROD B
--     WHERE A.BUY_PROD(+)= B.PROD_ID
--           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')) 
--     GROUP BY B.PROD_ID, B.PROD_NAME
--     ORDER BY 1;
--
--������ �ٸ� ���! (+)=�� �Ϲ����� ���û��

     SELECT DISTINCT A.BUY_PROD AS PRODID,
           B.PROD_NAME AS PRODNAME
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD(+)= B.PROD_ID
     ORDER BY 1;
     
     (ANSI����)
     SELECT B.PROD_ID AS "��ǰ�ڵ�",
           B.PROD_NAME AS "��ǰ��",
           NVL(SUM(A.BUY_QTY),0) AS "���Լ����հ�",
           NVL(TO_CHAR(SUM(A.BUY_QTY * B.PROD_COST),'999,999,999'),LPAD('0',12)) AS "���Աݾ� �հ�"
      FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')))
     GROUP BY B.PROD_ID, B.PROD_NAME
     ORDER BY 1;
     
���ν� �÷��� ��� �� ���� �ݵ�� ��� ���̺� �Ҽ����� ��Ÿ���� ������ ������     
  
EQUI JOIN : = �����ڸ� ����� ����
NON EQUI JOIN : = �̿��� �����ڸ� ����� ����
SELF JOIN : �ڽŰ� �ڽ��� �����ϴ� ���
��������� ��������(���������� ���� �ʴ� ���� ���ܽ�Ŵ)

���� ���� �������� �����ϴ� ���� �ܺ������̶�� ��
��) �μ��ڵ�� 10~270�� ���� ����, ����� ���� �μ��ڵ�� 10~110�� ���� ����
�������� �� ���� 110�������� ������, �ܺ������� �μ��������� �� �� 270���� ��� ���� ��°���

CROSS JOIN = CARTESIAN PRODUCT
NATURAL JOIN = �Ⱦ�, ���������� ������� �ʾƵ� �ڵ������� ó���ȴٴµ� ���Ҹ��� �𸣰ڴ�
INNER JOIN / OUTER JOIN �Ϲ����ΰ� ANSI JOIN�� ������ �ƿ� �ٸ�
OUTER JOIN���ʹ� �Ϲ����κ��� OUTER JOIN�� �ξ� ��Ȯ��
   
���� : ������ �����ͺ��̽��� ���� �ٽ��� ��
���� ���� ���� �÷��� �����Ѵ� : �θ��� �⺻Ű�� �ڽ��� �⺻Ű�� �Ǵ� ���(�ĺ��ڰ���, ��������)
                            �θ��� �⺻Ű�� �ڽ��� �Ϲ� �÷��� �Ǵ� ���(��ĺ�����, ��������)
�ĺ����� : �θ� ������ �ڽĵ� ���� �� ���� ���
��) �ֹ��� ������ ���� �ֹ��� ������ ���絵 ����.
��ĺ����� : �θ� �������ٰ� �ڽ��� ��������� �ʴ� ���
��) �б��� ������ٰ� �ص� ���簡 ������ų�, �л��� ������ų�, �б��ǹ��� ������� ����
�θ��� ���������� �ڽ��� ���������� ���� �������� ���谡 ��ĺ� �����̴�.

B���̺��� A���̺��� ��ӹ޴´ٰ� ����(EX - �ֹ����̺��� ��ǰ���̺��� ��ӹ���
���� ��ǰ�� ���Ŷ�� ���踦 ����, �� ������ CARDINALITY�� �ٴ�� M:N��
�ٴ�� ����� ������ �𵨸������� ����.

������ ���� -> ���� ���� -> ������ ����
����Ƽ      -> �����̼�   -> ���̺�

�ĺ����� : �θ� ���̺��� �⺻Ű�� �ڽ����̺��� �⺻Ű�� ����ϴ� ����
��ĺ����� : �θ� ���̺��� �⺻Ű�� �ڽ����̺��� �⺻Ű�� ������� �ʴ� ����(�Ϲ� �÷����� ����ϴ� ����)

��ü���� ���� ������Ʈ�� ����� �� : ��ü���� ���߹����
������ �ð��� ����

***
����ȭ�� ������ ȿ������ �����Ͱ���
�ʹ� ���������� ����ȭ�� �� ���� ����ȭ�� ���� ����ȭ�� �ϰ� �ִ��� �Ǵ��ؾ� �Ѵ�.
�ɰ��� ������ �߻����� �ʰ� ����ȭ�� �����ϴ� ���� ���󿡼� �� ������ �� ������ȭ Ȥ�� ������ȭ�� �� �� �ִ�.
��) �����ȣ, �����ּҸ� �ϳ��� �����ϴ� ���
ȿ������ �����Ͱ����� ���� ���� ���̺� ������ ���踦 ���� ���� ���ϴ� ������ �������� ���� �����̴�.
��ȸ�ϰ��� �ϴ� �÷��� ������ �ּ� ��� ���̺� ������ �����ϴ��� �Ǵ� �� �� ���̺���� ���踦 ������� �����Ͽ� ã�°��� �⺻