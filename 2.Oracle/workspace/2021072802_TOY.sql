��뿹)ȸ������ �ڷῡ�� ���� ��ո��ϸ����� ���ϰ� �ڽ��� ���� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ����
      2005�� 4~6�� ������Ȳ�� ��ȸ�Ͻÿ�. / ȸ����ȣ, ȸ����, ���ż���, ���űݾ�, ���ϸ���, ����, ������ո��ϸ���

CREATE OR REPLACE VIEW V_GEN_MEMBER AS
SELECT MEM_ID AS MID,
       MEM_NAME AS MNAME,
       MEM_MILEAGE AS MIL,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '����'
       END AS GEN
  FROM MEMBER
WITH READ ONLY;


 
CREATE OR REPLACE VIEW V_AMIL AS
SELECT GEN,
       AVG(MIL) AS AMIL
  FROM V_GEN_MEMBER
 GROUP BY GEN
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP AS
SELECT C.MID AS "ȸ����ȣ",
       C.MNAME AS "ȸ����",
       SUM(A.CART_QTY) AS "���ż���",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "���űݾ�"
--       C.MIL AS "���ϸ���",
--       C.GEN AS "����",
--       ROUND(C.AMIL) AS "������� ���ϸ���"
  FROM CART A, PROD B,
       (SELECT A.MID, A.MNAME, A.MIL, A.GEN, B.AMIL
          FROM V_GEN_MEMBER A, V_AMIL B
         WHERE A.GEN = B.GEN
               AND A.MIL >= B.AMIL) C
 WHERE A.CART_MEMBER = C.MID
       AND A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
 GROUP BY C.MID, C.MNAME
 ORDER BY 1
 WITH READ ONLY;

SELECT A."ȸ����ȣ", A."ȸ����", A."���ż���", A."���űݾ�",
       B.MIL AS "���ϸ���", B.GEN AS "����", ROUND(B.AMIL) AS "���� ��ո��ϸ���"
  FROM V_TEMP A, 
       (SELECT A.MID, A.MNAME, A.MIL, A.GEN, B.AMIL
          FROM V_GEN_MEMBER A, V_AMIL B
         WHERE A.GEN = B.GEN
               AND A.MIL >= B.AMIL) B
 WHERE A."ȸ����ȣ" = B.MID;
 
��뿹)������̺��� 'Seattle'�� �ٹ��ϴ� ����� 'IT'�μ��� �ٹ��ϴ� �����
      �����ȣ, �����, �μ���, ������, �ٹ����� ��ȸ�Ͻÿ�
      
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       D.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND A.JOB_ID = D.JOB_ID
       AND C.CITY = 'Seattle'
 UNION
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       D.JOB_TITLE AS "������"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.JOB_ID = D.JOB_ID
       AND B.DEPARTMENT_NAME = 'IT';
       
��뿹)ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ������ �������� ȸ���� 
      ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�      
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
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_JOB = '������';

SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 3000
INTERSECT
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_JOB = '������'
      
��뿹)ȸ�����̺��� ���ϸ����� 2000�̻��� ȸ���� ������ �ֺ��� ȸ���� 
      ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�      
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_MILEAGE >= 2000
UNION
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       MEM_MILEAGE AS "���ϸ���"
  FROM MEMBER
 WHERE MEM_JOB = '�ֺ�';
      
��뿹)2005�� 4���� �Ǹŵ� ��ǰ �� 7������ �ȸ� ��ǰ������ ��ȸ�Ͻÿ�
      ALIAS ��ǰ�ڵ�, ��ǰ��, �ǸŰ�, �ŷ�ó��     
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       B.PROD_PRICE AS "�ǸŰ�",
       C.BUYER_NAME AS "�ŷ�ó��"
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,6) = '200504'
INTERSECT
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       B.PROD_PRICE AS "�ǸŰ�",
       C.BUYER_NAME AS "�ŷ�ó��"
  FROM CART A, PROD B, BUYER C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_BUYER = C.BUYER_ID
       AND SUBSTR(A.CART_NO,1,6) = '200507';
       
       

      
��뿹)�μ����� 'Shipping'�� ���� ��� �� 'Matthew Weiss'����� ���� �Ҽӵ� ����� ��ȸ�Ͻÿ�
      �����ȣ, �����, �μ���, �Ի���, �޿�   
      
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       A.HIRE_DATE AS "�Ի���",
       A.SALARY AS "�޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
       (SELECT EMPLOYEE_ID FROM HR.EMPLOYEES WHERE EMP_NAME = 'Matthew Weiss') C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_NAME = 'Shipping'
       AND A.MANAGER_ID = C.EMPLOYEE_ID

SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       A.HIRE_DATE AS "�Ի���",
       A.SALARY AS "�޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.DEPARTMENT_NAME = 'Shipping'
INTERSECT
SELECT C.EMPLOYEE_ID AS "�����ȣ",
       C.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       C.HIRE_DATE AS "�Ի���",
       C.SALARY AS "�޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.EMPLOYEES C
 WHERE A.EMP_NAME = 'Matthew Weiss'
       AND C.MANAGER_ID = A.EMPLOYEE_ID
       AND C.DEPARTMENT_ID = B.DEPARTMENT_ID
       
1. ���� ���� �ο��� ��ȸ

SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '����'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '����'
            END AS "����",
       COUNT(MEM_ID) AS "�ο���"
  FROM MEMBER
 GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '����'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '����'
            END;

2. ���ݱ��� �ѹ��� ��ǰ�� ������ ���� ���� ȸ���� �������� ��ȸ(���̵�, �̸�, �̸���)
CREATE OR REPLACE VIEW V_TEMP AS 
SELECT A.MEM_ID AS MID,
       A.MEM_NAME AS MNAME,
       A.MEM_MAIL AS MMAIL
  FROM MEMBER A, CART B
 WHERE A.MEM_ID = B.CART_MEMBER
 GROUP BY A.MEM_ID, A.MEM_NAME, A.MEM_MAIL
WITH READ ONLY;

SELECT A.MEM_ID AS MID,
       A.MEM_NAME AS MNAME,
       A.MEM_MAIL AS MMAIL
  FROM MEMBER A
 WHERE NOT EXISTS(SELECT *
                    FROM V_TEMP B
                   WHERE B.MID = A.MEM_ID);
                   
DROP VIEW V_TEMP;                   
3. ��ϵ� ��ǰ�� �Ѱǵ� ���� ��ǰ�з� ��ȸ(��ǰ�з��ڵ�, �з���)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT DISTINCT A.LPROD_ID AS LID,
              A.LPROD_NM AS LNM
         FROM LPROD A, PROD B
        WHERE A.LPROD_GU = B.PROD_LGU
WITH READ ONLY;
SELECT C.LPROD_ID AS "��ǰ�з��ڵ�",
       C.LPROD_NM AS "�з���"
  FROM LPROD C
 WHERE NOT EXISTS (SELECT LID
                     FROM V_TEMP D
                    WHERE D.LID = C.LPROD_ID);
                    
DROP VIEW V_TEMP;
4. ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT CART_PROD AS CID,
       SUM(CART_QTY) AS CQTY
  FROM CART
 GROUP BY CART_PROD
WITH READ ONLY;

SELECT MAX(CQTY) AS MQTY
  FROM V_TEMP;

SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       B.LPROD_NM AS "��ǰ�з���",
       C.BUYER_NAME AS "���ϸ���",
       D.MQTY AS "�Ǹż���"
  FROM PROD A, LPROD B, BUYER C,
       (SELECT CID, MQTY
          FROM V_TEMP A,
               (SELECT MAX(CQTY) AS MQTY
                  FROM V_TEMP) B
         WHERE A.CQTY = B.MQTY) D
 WHERE A.PROD_ID = D.CID
       AND A.PROD_LGU = B.LPROD_GU
       AND A.PROD_BUYER = C.BUYER_ID;
5.   ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       B.LPROD_NM AS "��ǰ�з���",
       C.BUYER_NAME AS "���ϸ���",
       D.MQTY AS "�Ǹż���"
  FROM PROD A, LPROD B, BUYER C,
       (SELECT CID, MQTY
          FROM V_TEMP A,
               (SELECT MIN(CQTY) AS MQTY
                  FROM V_TEMP) B
         WHERE A.CQTY = B.MQTY) D
 WHERE A.PROD_ID = D.CID
       AND A.PROD_LGU = B.LPROD_GU
       AND A.PROD_BUYER = C.BUYER_ID;
6. �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)

CREATE OR REPLACE VIEW V_TEMP AS
SELECT A.BUYER_ID, B.PROD_ID
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
       AND B.PROD_ID = C.BUY_PROD
 GROUP BY A.BUYER_ID, B.PROD_ID
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP2 AS
SELECT BUYER_ID AS BID, COUNT(PROD_ID) AS CNT
  FROM V_TEMP
 GROUP BY BUYER_ID
WITH READ ONLY;

SELECT * FROM V_TEMP2;

SELECT A.BUYER_ID AS "�ŷ�ó�ڵ�",
       A.BUYER_NAME AS "�ŷ�ó��",
       A.BUYER_LGU AS "�ŷ�ó�з���",
       A.BUYER_CHARGER AS "����ڸ�"
  FROM BUYER A
 WHERE EXISTS(SELECT C.BID
                FROM V_TEMP2 C, 
                     (SELECT MAX(CNT) AS MCNT
                        FROM V_TEMP2) D
               WHERE D.MCNT = C.CNT
                     AND C.BID = A.BUYER_ID);
 
 
7.   �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT A.BUYER_ID, B.PROD_ID
  FROM BUYER A, PROD B, BUYPROD C
 WHERE A.BUYER_ID = B.PROD_BUYER
       AND B.PROD_ID = C.BUY_PROD
 GROUP BY A.BUYER_ID, B.PROD_ID
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP2 AS
SELECT BUYER_ID AS BID, COUNT(PROD_ID) AS CNT
  FROM V_TEMP
 GROUP BY BUYER_ID
WITH READ ONLY;

SELECT * FROM V_TEMP2;

SELECT A.BUYER_ID AS "�ŷ�ó�ڵ�",
       A.BUYER_NAME AS "�ŷ�ó��",
       A.BUYER_LGU AS "�ŷ�ó�з���",
       A.BUYER_CHARGER AS "����ڸ�"
  FROM BUYER A
 WHERE EXISTS(SELECT C.BID
                FROM V_TEMP2 C, 
                     (SELECT MIN(CNT) AS MCNT
                        FROM V_TEMP2) D
               WHERE D.MCNT = C.CNT
                     AND C.BID = A.BUYER_ID);

8. ���� ���� ���� �������� ���� ��ǰ ��ȸ(����, ��ǰ�ڵ�, ��ǰ��, �з���)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT MEM_ID AS MID,
       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3') THEN '��'
            WHEN SUBSTR(MEM_REGNO2,1,1) IN ('2','4') THEN '��'
       END AS GEN
  FROM MEMBER
WITH READ ONLY;

CREATE OR REPLACE VIEW V_TEMP2 AS
SELECT B.PROD_ID AS PID,
       B.PROD_NAME AS PNAME,
       C.GEN AS GEN,
       A.CART_QTY AS QTY,
       D.LPROD_NM AS LPNM
  FROM CART A, PROD B, V_TEMP C, LPROD D
 WHERE A.CART_MEMBER = C.MID
       AND A.CART_PROD = B.PROD_ID
       AND B.PROD_LGU = D.LPROD_GU
WITH READ ONLY;

SELECT PID, GEN, SUM(QTY), RANK() OVER(ORDER BY SUM(QTY) DESC) AS RK
  FROM V_TEMP2
 GROUP BY PID, GEN
-- ORDER BY 1;

9. �� ȸ���� ���� �Ѿ� ��ȸ(ȸ�����̵�, ȸ����, �����Ѿ�)
SELECT B.MEM_ID AS "ȸ�����̵�",
       B.MEM_NAME AS "ȸ����",
       SUM(A.CART_QTY * C.PROD_PRICE) AS "�����Ѿ�"
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
 GROUP BY B.MEM_ID, B.MEM_NAME
 ORDER BY 1;
       
10. �� ��ǰ�� ���ſ� ��ȸ(���ſվ��̵�, ȸ����, �����Ѿ�)
CREATE OR REPLACE VIEW V_TEMP AS
SELECT C.PROD_ID AS PID,
       B.MEM_ID AS MID,
       SUM(A.CART_QTY) AS CNT
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
 GROUP BY C.PROD_ID, B.MEM_ID
WITH READ ONLY;

SELECT C.PROD_ID AS "��ǰ��ȣ",
       C.PROD_NAME AS "��ǰ��",
       A.MEM_ID AS "���ſվ��̵�",
       A.MEM_NAME AS "ȸ����",
       C.PROD_PRICE * D.MCNT AS "�����Ѿ�"
  FROM MEMBER A, V_TEMP B, PROD C,
       (SELECT PID,
               MAX(CNT) AS MCNT
          FROM V_TEMP
         GROUP BY PID) D
 WHERE A.MEM_ID = B.MID
       AND B.CNT = D.MCNT
       AND B.PID = D.PID
       AND C.PROD_ID = B.PID
       AND C.PROD_ID = D.PID
 ORDER BY 1;
 
 