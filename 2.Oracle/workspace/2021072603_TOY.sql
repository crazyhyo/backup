��뿹)������̺��� ������ ���� 10�� �̻��� �Ǵ� �μ��� �μ��ڵ�, �μ����� ���

(����: IN)  
SELECT C.DEPARTMENT_ID AS "�μ��ڵ�",
       C.DEPARTMENT_NAME AS "�μ���"
  FROM (SELECT A.DID AS DID
          FROM (SELECT DEPARTMENT_ID AS DID,
                       COUNT(EMPLOYEE_ID) AS CNT
                  FROM HR.EMPLOYEES
                 GROUP BY DEPARTMENT_ID
                HAVING COUNT(EMPLOYEE_ID) >= 10) A) B,
       HR.DEPARTMENTS C
 WHERE C.DEPARTMENT_ID IN B.DID;
        

(����: =ANY(=SOME))
SELECT C.DEPARTMENT_ID AS "�μ��ڵ�",
       C.DEPARTMENT_NAME AS "�μ���"
  FROM (SELECT A.DID AS DID
          FROM (SELECT DEPARTMENT_ID AS DID,
                       COUNT(EMPLOYEE_ID) AS CNT
                  FROM HR.EMPLOYEES
                 GROUP BY DEPARTMENT_ID
                HAVING COUNT(EMPLOYEE_ID) >= 10) A) B,
       HR.DEPARTMENTS C
 WHERE C.DEPARTMENT_ID = ANY(B.DID);

(����: EXISTS - �ݵ�� �ڿ� ���������� �´�)
SELECT C.DEPARTMENT_ID AS "�μ��ڵ�",
       C.DEPARTMENT_NAME AS "�μ���"
  FROM HR.DEPARTMENTS C
 WHERE EXISTS (SELECT A.DID
                 FROM (SELECT DEPARTMENT_ID AS DID,
                              COUNT(EMPLOYEE_ID) AS CNT
                         FROM HR.EMPLOYEES
                        GROUP BY DEPARTMENT_ID
                       HAVING COUNT(EMPLOYEE_ID) >= 10) A
                 WHERE A.DID = C.DEPARTMENT_ID)

��뿹)2005�� 4~6�� ��� �з��� ������Ȳ�� ��ȸ�Ͻÿ�
      ALIAS�� �з��ڵ�, �з���, ���Լ���, ���Աݾ�
SELECT A.LPROD_ID AS "�з��ڵ�",
       A.LPROD_NM AS "�з���",
       NVL(SUM(C.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON(A.LPROD_GU = B.PROD_LGU)
  LEFT OUTER JOIN BUYPROD C ON(C.BUY_PROD = B.PROD_ID
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 GROUP BY A.LPROD_ID, A.LPROD_NM
 ORDER BY 1;
 
SELECT B.LPROD_GU AS "�з��ڵ�",
       B.LPROD_NM AS "�з���",
       NVL(A.PCNT,0) AS "���Լ���",
       NVL(A.PAMT,0) AS "���Աݾ�"
  FROM (SELECT A.PROD_LGU AS PGU,
               SUM(B.BUY_QTY) AS PCNT,
               SUM(B.BUY_QTY * A.PROD_COST) AS PAMT
          FROM PROD A, BUYPROD B
         WHERE A.PROD_ID = B.BUY_PROD
               AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601'))
         GROUP BY A.PROD_LGU) A,
       LPROD B
 WHERE A.PGU(+) = B.LPROD_GU
 ORDER BY 1;


��뿹)2005�� 4~6�� ��� �з��� ������Ȳ�� ��ȸ�Ͻÿ�
      ALIAS�� �з��ڵ�, �з���, �������, ����ݾ�
SELECT C.LPROD_ID AS "�з��ڵ�",
       C.LPROD_NM AS "�з���",
       NVL(SUM(A.CART_QTY),0) AS "�������",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "����ݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(CART_NO,1,6) BETWEEN '200504' AND '200506')
 RIGHT OUTER JOIN LPROD C ON(B.PROD_LGU = C.LPROD_GU)
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;


��뿹)2005�� 4~6�� ��� �з��� ����/������Ȳ�� ��ȸ�Ͻÿ�.
      ALIAS�� �з��ڵ�, �з���, ���Լ���, ���Աݾ�, �������, ����ݾ�      

SELECT C.LPROD_ID AS "�з��ڵ�",
       C.LPROD_NM AS "�з���",
       NVL(SUM(D.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(D.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�",
       NVL(SUM(A.CART_QTY),0) AS "�������",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "����ݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506')
 RIGHT OUTER JOIN LPROD C ON(C.LPROD_GU = B.PROD_LGU)
  LEFT OUTER JOIN BUYPROD D ON(D.BUY_PROD = B.PROD_ID
       AND D.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;

��뿹)2005�� 4~6�� ��� ��ǰ�� ������Ȳ/������Ȳ
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�, �������, ����ݾ�  
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(C.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS " ���Աݾ�",
       NVL(SUM(A.CART_QTY),0) AS "�������",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "����ݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
      
      
��뿹)80�� �μ��� �޿��� �μ� ��� �̻��� ����� ��ȸ�Ͻÿ�
SELECT EMPLOYEE_ID AS "�����ȣ",
       EMP_NAME AS "�����",
       SALARY AS "�޿�"
FROM HR.EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                  FROM HR.EMPLOYEES
                 WHERE DEPARTMENT_ID = 80)
     AND DEPARTMENT_ID = 80;
 
 