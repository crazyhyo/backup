����] ������̺��� �ٹ������� �޿��հ踦 ���Ͻÿ�.

SELECT D.COUNTRY_NAME               AS  "�ٹ�����",
       SUM(A.SALARY)                AS  "�޿��հ�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.COUNTRY_ID = D.COUNTRY_ID
 GROUP BY D.COUNTRY_NAME;       
       

��뿹)������̺��� �� �μ��� ���ʽ� �հ踦 ���Ͻÿ�
      ����� �μ��ڵ�, �μ���, ���ʽ� �հ��̰�, ���ʽ��� ��������(COMMISION_PCT)��
      �޿��� ���� ����� 30%�� �����Ѵ�.

SELECT B.DEPARTMENT_ID                                      AS  "�μ��ڵ�",
       B.DEPARTMENT_NAME                                    AS  "�μ���",
       SUM(A.SALARY * NVL(A.COMMISSION_PCT,0) * 0.3)              AS  "���ʽ� �հ�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME;


��뿹)2005�� ȸ���� ���ŰǼ��� ��ȸ�Ͻÿ�.

SELECT B.MEM_ID                                 AS  "ȸ����ȣ",
       B.MEM_NAME                               AS  "ȸ����",
       COUNT(A.CARTNO)                          AS  "���ŰǼ�"
  FROM (SELECT DISTINCT     A.CART_NO            AS  CARTNO,
                            B.MEM_ID             AS  MEMID
        FROM CART A, MEMBER B  
        WHERE A.CART_MEMBER = B.MEM_ID) A, MEMBER B
 WHERE A.MEMID = B.MEM_ID
       AND SUBSTR(A.CARTNO,1,4) = '2005'
 GROUP BY B.MEM_ID, B.MEM_NAME;

��뿹)2005�� �з��� ��ձ��űݾ��� ��ȸ�Ͻÿ�.

SELECT C.LPROD_ID               AS      "�з��ڵ�",
       C.LPROD_NM               AS      "�з���",
       ROUND(AVG(B.PROD_SALE * A.CART_QTY))     AS      "��� �Ǹűݾ�"
  FROM CART A, PROD B, LPROD C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_LGU = C.LPROD_GU
       AND SUBSTR(A.CART_NO,1,4) = '2005'
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;

��뿹)2005�� ȸ���� ���ɴ뺰 ��ձ��űݾ��� ��ȸ�Ͻÿ�.

SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR)) / 10) * 10 || '��'  AS  "���ɴ�",
       ROUND(AVG(A.CART_QTY * C.PROD_SALE))                                                 AS   "��ձ��űݾ�"
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
       AND SUBSTR(A.CART_NO,1,4) = '2005'
 GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR)) / 10);
       

   
��뿹)������̺��� �� �μ��� ������� ��ȸ�Ͻÿ�    

SELECT B.DEPARTMENT_ID                          AS  "�μ��ڵ�",
       B.DEPARTMENT_NAME                        AS  "�μ���",
       COUNT(*)                                 AS  "�ο���"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1;
 
��뿹)ȸ������ ���� ��� ���ϸ����� ��ȸ�Ͻÿ�
 

    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����ȸ��'
           ELSE '����ȸ��'  END       AS "����",
           ROUND(AVG(MEM_MILEAGE))     AS  "��� ���ϸ���"
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����ȸ��'
           ELSE '����ȸ��'  END;
    
��뿹)2005�� 5�� �з��� �ǸŰǼ��� ��ȸ�Ͻÿ�

SELECT C.LPROD_ID               AS      "�з��ڵ�",
       C.LPROD_NM               AS      "�з���",
       COUNT(*)                 AS      "�ǸŰǼ�"
  FROM CART A, PROD B, LPROD C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_LGU = C.LPROD_GU
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;

��뿹)2005�� 5~6�� ȸ���� ����ȸ���� ��ȸ�Ͻÿ�
SELECT A.CARTMEM                    AS  "ȸ�����̵�",
       B.MEM_NAME                   AS  "ȸ����",
       COUNT(*)                     AS  "����ȸ��"
FROM    (SELECT DISTINCT CART_NO            AS  CARTNO,
               CART_MEMBER          AS  CARTMEM
          FROM CART
         WHERE SUBSTR(CART_NO,1,6) IN('200505','200506')) A,
         MEMBER B
WHERE A.CARTMEM = B.MEM_ID
GROUP BY A.CARTMEM, B.MEM_NAME;

����)����� �� �ڱⰡ ���� �μ��� ��� �޿����� ���� �޿��� �޴� ��������� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �μ���ȣ, �μ���, �޿�, �μ���ձ޿�
SELECT      B.EMPLOYEE_ID                       AS  "�����ȣ",
            B.EMP_NAME                       AS  "�����",
            A.DEPTID                       AS  "�μ���ȣ",
            C.DEPARTMENT_NAME                       AS  "�μ���",
            B.SALARY                       AS  "�޿�",
            ROUND(A.AVGDEPT)                       AS  "�μ���ձ޿�"
FROM        (SELECT DEPARTMENT_ID                  AS  DEPTID,
                   AVG(SALARY)                  AS  AVGDEPT
              FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID) A,
             HR.EMPLOYEES B, HR.DEPARTMENTS C
WHERE       A.DEPTID = B.DEPARTMENT_ID
            AND B.DEPARTMENT_ID = C.DEPARTMENT_ID
            AND B.SALARY < A.AVGDEPT
ORDER BY 3;