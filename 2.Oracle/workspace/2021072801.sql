2021-0728-01)���տ�����
  - ���տ����ڴ� SELECT���� ����� ������� ������ ����
  - ������ ���������� ������ ���� �� ����
  - ���� ���� SELECT���� �ϳ��� ���� ���� ����
  - UNION ALL, UNION, INTERSECT, MINUS ����
  ** ���ǻ���
  - �� SELECT���� ���� ���� Ÿ���� �÷��� ��ȸ�ؾ� ��(���տ����� ����� ���� ��Ű���� ������ �־�� �Ѵ�)
  - �� SELECT������ ���� ���� �÷��� ��ȸ�ϴ� ��� ��� �÷��� ���� ���տ��� ����
  - ORDER BY�� ����� �� ������ ������ SELECT�������� ��� ����
  - ����� ù ��° SELECT���� ���Ͽ� ���� ��
  
UNION ALL : �����պκп� �����ϴ� �����͸� �ߺ��Ǵ� ����ŭ ���
UNION : �����պκп� �����ϴ� �����͸� �ѹ��� ���

 1) UNION
  - �������� ����� ��ȯ
  - ������ �κ��� �ߺ��� ������

��뿹)������̺��� 'Seattle'�� �ٹ��ϴ� ����� 'IT'�μ��� �ٹ��ϴ� �����
      �����ȣ, �����, �μ���, �������� ��ȸ�Ͻÿ�

(1)'Seattle'�� �ٹ��ϴ� ����� �����ȣ, �����, ������, �μ���, ������
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       C.CITY AS "������",
       B.DEPARTMENT_NAME AS "�μ���",
       D.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND A.JOB_ID = D.JOB_ID
       AND C.CITY = 'Seattle';
(2)'Administration'�μ��� �ٹ��ϴ� ����� �����ȣ, �����, ������, �μ���, ������
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       D.CITY AS "������",
       B.DEPARTMENT_NAME AS "�μ���",
       C.JOB_ID AS "������"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C, HR.LOCATIONS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = C.JOB_ID
       AND B.LOCATION_ID = D.LOCATION_ID
       AND B.DEPARTMENT_NAME = 'Administration';

(����);
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       C.CITY AS "������",
       B.DEPARTMENT_NAME AS "�μ���",
       D.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND A.JOB_ID = D.JOB_ID
       AND C.CITY = 'Seattle'
UNION
--UNION ALL : 2���� �ߺ��� �״�� ����Ͽ� 20���� �� ���
SELECT A.EMPLOYEE_ID,
       A.EMP_NAME,
       D.CITY,
       B.DEPARTMENT_NAME,
       C.JOB_TITLE
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C, HR.LOCATIONS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = C.JOB_ID
       AND B.LOCATION_ID = D.LOCATION_ID
       AND B.DEPARTMENT_NAME = 'Accounting'
 ORDER BY 1;

��뿹)ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ������ �������� ȸ���� 
      ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�

SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 3000
       OR MEM_JOB = '������'

SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 3000
UNION       
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
--       TO_NUMBER(MEM_REGNO1) AS "�ֹι�ȣ1"
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_JOB = '������'
 
UNION�� ������ �÷��� ���Ͽ� UNION�� ����ȴ�.

 2) UNION ALL
  - �������� ����� ��ȯ
  - ������ �κ�(����κ�)�� �ߺ��Ǿ� ���

��뿹)ȸ�����̺��� ���ϸ����� 2000�̻��� ȸ���� ������ �ֺ��� ȸ���� 
      ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 2000
UNION ALL
--UNIION
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_JOB = '�ֺ�'

��뿹)2005�� 4���� 7���� �ȸ� ��ǰ������ ��ȸ�Ͻÿ�
      ALIAS ��ǰ�ڵ�, ��ǰ��, �ǸŰ�, �ŷ�ó��

SELECT DISTINCT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       B.PROD_PRICE AS �ǸŰ�,
       C.BUYER_NAME AS �ŷ�ó��
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,6) IN('200504','200507')
 ORDER BY 1;
       
SELECT DISTINCT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       B.PROD_PRICE AS �ǸŰ�,
       C.BUYER_NAME AS �ŷ�ó��
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200504%'
UNION
SELECT DISTINCT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       B.PROD_PRICE AS �ǸŰ�,
       C.BUYER_NAME AS �ŷ�ó��
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200507%'
 ORDER BY 1;

 3) INTERSECT
  - ������(����κ�)�� ����� ��ȯ
  
��뿹)2005�� 4���� �Ǹŵ� ��ǰ �� 7������ �ȸ� ��ǰ������ ��ȸ�Ͻÿ�
      ALIAS ��ǰ�ڵ�, ��ǰ��, �ǸŰ�, �ŷ�ó��
SELECT DISTINCT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       B.PROD_PRICE AS �ǸŰ�,
       C.BUYER_NAME AS �ŷ�ó��
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200504%'
INTERSECT
SELECT DISTINCT B.PROD_ID AS ��ǰ�ڵ�,
       B.PROD_NAME AS ��ǰ��,
       B.PROD_PRICE AS �ǸŰ�,
       C.BUYER_NAME AS �ŷ�ó��
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND A.CART_NO LIKE '200507%'
 ORDER BY 1;

DELETE CART
WHERE CART_NO IN (SELECT CART_NO
  FROM CART
 WHERE CART_MEMBER = 'p001'
       AND SUBSTR(CART_NO, 1, 6) = '200505');

DELETE CART C
 WHERE C.CART_MEMBER = 'p001'
       AND SUBSTR(C.CART_NO,1,6) = '200505';
       
DELETE CART A
WHERE EXISTS (SELECT CART_MEMBER
                FROM CART B
               WHERE UPPER(CART_PROD) = 'P302000001'
                     AND SUBSTR(CART_NO,1,6) = '200506'
                     AND CART_QTY >= 5
                     AND A.CART_NO = B.CART_NO
                     AND A.CART_PROD = B.CART_PROD);

DELETE CART A
 WHERE EXISTS (SELECT 1
                 FROM PROD
                WHERE A.CART_PROD = PROD_ID
                      AND A.CART_QTY * PROD_PRICE <= 50000
                      AND A.CART_NO LIKE '200504%');       

ROLLBACK;

��뿹)�μ����� 'Shipping'�� ���� ��� �� 'Matthew Weiss'����� ���� �Ҽӵ� ����� ��ȸ�Ͻÿ�
      �����ȣ, �����, �μ���, �Ի���, �޿�
SELECT B.EMPLOYEE_ID AS "�����ȣ",
       B.EMP_NAME AS "�����",
       A.DEPARTMENT_NAME AS "�μ���",
       B.HIRE_DATE AS "�Ի���",
       B.SALARY AS "�޿�"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B,
       (SELECT MANAGER_ID AS MID
          FROM HR.EMPLOYEES
         WHERE EMP_NAME = 'Matthew Weiss') C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.DEPARTMENT_NAME = 'Shipping'
       AND B.MANAGER_ID = C.MID;

SELECT B.EMPLOYEE_ID AS "�����ȣ",
       B.EMP_NAME AS "�����",
       A.DEPARTMENT_NAME AS "�μ���",
       B.HIRE_DATE AS "�Ի���",
       B.SALARY AS "�޿�"
  FROM HR.DEPARTMENTS A, HR.EMPLOYEES B,
       (SELECT B.MANAGER_ID AS MID,
               B.EMPLOYEE_ID AS EID
          FROM HR.EMPLOYEES A, HR.EMPLOYEES B
         WHERE A.EMP_NAME = 'Matthew Weiss'
               AND A.EMPLOYEE_ID = B.MANAGER_ID) C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.DEPARTMENT_NAME = 'Shipping'
       AND B.EMPLOYEE_ID = C.EID
       AND B.MANAGER_ID = C.MID;
       
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       A.HIRE_DATE AS "�Ի���",
       A.SALARY AS "�޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_NAME = 'Shipping'
INTERSECT
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       A.HIRE_DATE AS "�Ի���",
       A.SALARY AS "�޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.EMP_NAME = 'Matthew Weiss'
       AND B.DEPARTMENT_NAME = 'Shipping'
       
 4) MINUS
  - MINUS ������ �տ� ��ġ�� ������ ������� MINUS �ڿ� ����� ������ �����
    ������ ��� ��ȯ
    
��뿹)��ٱ������̺��� 4���� 5���� �Ǹŵ� ��ǰ �� 4���� �Ǹŵ� ��ǰ�� ��ǰ��ȣ, ��ǰ��, �����հ�, �Ǹűݾ��հ踦 ���Ͻÿ�
--(4�� ��ǰ�� �Ǹ� ����)
SELECT B.PROD_ID AS "��ǰ��ȣ",
       B.PROD_NAME AS "��ǰ��"
--       SUM(A.CART_QTY) AS "�����հ�",
--       SUM(A.CART_QTY * B.PROD_PRICE) AS "�Ǹűݾ��հ�"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504'
 GROUP BY B.PROD_ID, B.PROD_NAME
MINUS
--(5�� ��ǰ�� �Ǹ� ����)
--SELECT B.PROD_ID AS "��ǰ��ȣ",
--       B.PROD_NAME AS "��ǰ��"
--       SUM(A.CART_QTY) AS "�����հ�",
--       SUM(A.CART_QTY * B.PROD_PRICE) AS "�Ǹűݾ��հ�"
--  FROM CART A, PROD B
-- WHERE A.CART_PROD = B.PROD_ID
--       AND SUBSTR(A.CART_NO,1,6) = '200505'
-- GROUP BY B.PROD_ID, B.PROD_NAME
--MINUS
--(7�� ��ǰ�� �Ǹ� ����)
SELECT B.PROD_ID AS "��ǰ��ȣ",
       B.PROD_NAME AS "��ǰ��"
--       SUM(A.CART_QTY) AS "�����հ�",
--       SUM(A.CART_QTY * B.PROD_PRICE) AS "�Ǹűݾ��հ�"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200507'
 GROUP BY B.PROD_ID, B.PROD_NAME


CREATE OR REPLACE VIEW V_TEST AS
SELECT *
  FROM MEMBER
-- ORDER BY 1
UNION
SELECT *
  FROM MEMBER
WITH READ ONLY;

SELECT * FROM V_TEST;
DROP VIEW V_TEST;
DROP VIEW V_MEM01;
DROP VIEW V_TEMP;

������ �ñ��� ���� : �ǻ������ �����ڷ� ����
�����ؾ� �ϴ� ������ �ǻ�Ȱ���� ��ȸ�� ����, ������ ���� ������ �ǹ̰� ����.

������ ���� - Ŭ������ ����� ��Ģ
�̱��� ���� : ���� ������ ����������, ��ü������ �ѹ��� �ϰ� ���� ������ �ϴ� ����
MVC(TWO) ���� : ���� �θ� ����ϴ� ����, �ڹ��� �ٰ��� �Ǵ� ����, �����ͺ��̽��� ������ �� �ݵ�� �����

ħü�� ��° 