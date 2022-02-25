2021-0719-01)
  2. AVG(expr)
   - 'expr'�� ���ǵ� �÷��̳� ������ ���� ���� ������ ���� ��ȯ

��뿹)��� ȸ������ ��� ���ϸ����� ��ȸ�Ͻÿ�

    SELECT ROUND(AVG(MEM_MILEAGE))     "��� ���ϸ���"
      FROM MEMBER;

��뿹)��� ����ȸ������ ��� ���ϸ����� ��ȸ�Ͻÿ�

    SELECT ROUND(AVG(MEM_MILEAGE))     "���� ��� ���ϸ���"
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1) IN('2', '4');

��뿹)ȸ������ ���� ��� ���ϸ����� ��ȸ�Ͻÿ�

    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '2'
                  OR SUBSTR(MEM_REGNO2,1,1) = '4' THEN '����ȸ��'
                ELSE
                     '����ȸ��' END AS     "����",
           ROUND(AVG(MEM_MILEAGE))  AS  "��ո��ϸ���"
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '2'
                  OR SUBSTR(MEM_REGNO2,1,1) = '4' THEN '����ȸ��'
                ELSE
                     '����ȸ��' END;
    
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('2', '4') THEN '����ȸ��'
                   ELSE
                     '����ȸ��' END AS     "����",
           ROUND(AVG(MEM_MILEAGE))  AS  "��ո��ϸ���"
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('2', '4') THEN '����ȸ��'
                   ELSE
                     '����ȸ��' END;

��뿹)������̺��� �� �μ��� ��ձ޿��� ��ȸ�Ͻÿ�.

    SELECT --0B.DEPARTMENT_ID          AS  "�μ��ڵ�",
    --       B.DEPARTMENT_NAME        AS  "�μ���",
           ROUND(AVG(A.SALARY))     AS  "��ձ޿�"
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
     --GROUP BY B.DEPARTMENT_NAME, B.DEPARTMENT_ID
     
     SELECT *
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     ORDER BY A.EMPLOYEE_ID;
     --GROUP BY B.DEPARTMENT_NAME, B.DEPARTMENT_ID
 
��뿹)2005�� 1~6�� ���� ��ո��Ծ��� ��ȸ�Ͻÿ�.

    SELECT EXTRACT(MONTH FROM BUY_DATE) || '��'                                 AS  "��",
           TO_CHAR(ROUND(AVG(BUY_COST * BUY_QTY)),'999,999,999L')        AS  "��ո��Ծ�"
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050601'))
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
     ORDER BY 1;

��뿹)2005�� 1~6�� ���� ���԰Ǽ�, ��ո��Ծװ� ���Ծ����� ��ȸ�ϵ� ���Ծ��� 400���� �̻��� ���� ��ȸ�Ͻÿ�.
    SELECT COUNT(*)                                                        AS  "���԰Ǽ�",
           EXTRACT(MONTH FROM BUY_DATE) || '��'                                 AS  "��",
           TO_CHAR(ROUND(AVG(BUY_COST * BUY_QTY)),'999,999,999')         AS  "��ո��Ծ�",
           TO_CHAR(SUM(BUY_COST * BUY_QTY),'999,999,999')                AS "���Ծ� �հ�"
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050601'))
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    HAVING AVG(BUY_COST * BUY_QTY) >= 4000000
     ORDER BY 1;
     
HAVING�� ���Ǵ� ��� : �����Լ��� ������ �ο��� �� ���

��뿹)2005�� ȸ���� ��ո��Աݾ��� ��ȸ�Ͻÿ�.

    SELECT  B.MEM_ID AS "ȸ����ȣ",
            B.MEM_NAME  AS  "ȸ����",
            ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "��ո��Աݾ�"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY B.MEM_ID, B.MEM_NAME
     ORDER BY 1;
     
     SELECT  *
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID;
    --       AND SUBSTR(A.CART_NO,1,4) = '2005'
    -- GROUP BY B.MEM_ID, B.MEM_NAME;
 

��뿹)2005�� ȸ���� ���ŰǼ��� ��ȸ�Ͻÿ�.
    SELECT  B.MEM_ID AS "ȸ����ȣ",
            B.MEM_NAME  AS  "ȸ����",
            COUNT(*) AS "���ŰǼ�"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY B.MEM_ID, B.MEM_NAME
     ORDER BY 1;

��뿹)2005�� �з��� ��ձ��űݾ��� ��ȸ�Ͻÿ�.
    SELECT  B.LPROD_ID                              AS  "�з���ȣ",
            B.LPROD_NM                              AS  "�з���",
            ROUND(AVG(A.CART_QTY * C.PROD_SALE))    AS  "����Ǹűݾ�"
      FROM CART A, LPROD B, PROD C
     WHERE B.LPROD_GU = C.PROD_LGU
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY B.LPROD_ID, B.LPROD_NM
     ORDER BY 1;


��뿹)2005�� ȸ���� ���ɴ뺰 ��ձ��űݾ��� ��ȸ�Ͻÿ�.

    --SELECT EXTRACT(YEAR FROM B.MEM_BIR)    AS  "����⵵",
    --       ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "��ձ��űݾ�"
    --  FROM CART A, MEMBER B, PROD C
    -- WHERE A.CART_MEMBER = B.MEM_ID
    --       AND A.CART_PROD = C.PROD_ID
    --       AND SUBSTR(A.CART_NO, 1, 4) = '2005'
    -- GROUP BY EXTRACT(YEAR FROM B.MEM_BIR)
    -- ORDER BY 1;
    
    --SELECT WIDTH_BUCKET(EXTRACT(YEAR FROM B.MEM_BIR),1960,2010,5)    AS  "���ɴ�",
    --       ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "��ձ��űݾ�"
    --  FROM CART A, MEMBER B, PROD C
    -- WHERE A.CART_MEMBER = B.MEM_ID
    --       AND A.CART_PROD = C.PROD_ID
    --       AND SUBSTR(A.CART_NO, 1, 4) = '2005'
    -- GROUP BY EXTRACT(YEAR FROM B.MEM_BIR)
    -- ORDER BY 1;
    
    SELECT (7 - WIDTH_BUCKET(EXTRACT(YEAR FROM B.MEM_BIR),1960,2010,5)) * 10 || '��'    AS  "���ɴ�",
           ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "��ձ��űݾ�"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO, 1, 4) = '2005'
     GROUP BY WIDTH_BUCKET(EXTRACT(YEAR FROM B.MEM_BIR),1960,2010,5)
     ORDER BY 1;
    
    SELECT (WIDTH_BUCKET(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR),10,100,10)-1) * 10  || '��'    AS  "���ɴ�",
           COUNT(*)                                                                                         AS  "���ŰǼ�",
           TO_CHAR(ROUND(AVG(A.CART_QTY * C.PROD_SALE)), '9,999,999')                                       AS  "��ձ��űݾ�"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO, 1, 4) = '2005'
     GROUP BY (WIDTH_BUCKET(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR),10,100,10)-1) 
     ORDER BY 1;

SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR))/10) * 10 || '��'    AS  "���ɴ�",
           COUNT(*)                                                                                         AS  "���ŰǼ�",
           TO_CHAR(ROUND(AVG(A.CART_QTY * C.PROD_SALE)), '9,999,999')                                       AS  "��ձ��űݾ�"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO, 1, 4) = '2005'
     GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR))/10) * 10
     ORDER BY 1;

����)����� �� �ڱⰡ ���� �μ��� ��� �޿����� ���� �޿��� �޴� ��������� ��ȸ�Ͻÿ�.
    Alias�� �����ȣ, �����, �μ���ȣ, �μ���, �޿�, �μ���ձ޿�
    
    �������� : 7�� 31�ϱ���
    ������ : ����� PC ���������� ����(SEM-PC D:\��������\Oracle\homework1
    ����Ÿ�� : �޸��忡�� ����� TEXT����
    ������ : �����̸�_0731.TXT

 SELECT B.EMPLOYEE_ID               AS  "�����ȣ",
        B.EMP_NAME                  AS  "�����",
        A.DEPTID                    AS  "�μ���ȣ",
        A.DEPTNAME                  AS  "�μ���",
        B.SALARY                    AS  "�޿�",
        A.DEPTAVG                   AS  "�μ���ձ޿�"
   FROM (SELECT B.DEPARTMENT_ID       AS  DEPTID,
               B.DEPARTMENT_NAME      AS  DEPTNAME,
               ROUND(AVG(A.SALARY))   AS  DEPTAVG
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
         GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME) A,
         HR.EMPLOYEES B
  WHERE A.DEPTID = B.DEPARTMENT_ID
        AND B.SALARY < A.DEPTAVG
  ORDER BY 3;
  

SELECT B.DEPARTMENT_ID       AS  "�μ���ȣ",
       B.DEPARTMENT_NAME       AS  "�μ���"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;

  3. COUNT(column��|*)
   - �׷쳻�� ���� ��(�ڷ��� ��)�� ��ȯ
   - �ܺ����ο��꿡 ���Ǵ� ��� '*'�� ����ϸ� ����Ȯ�� ����� ��ȯ�ϱ� ������ �ش� ���̺��� �÷����� ����ؾ� ��
   
�ܺ����ο����� ���ǿ� ���� �ʴ� �����ͱ��� ���� ������� �۵��ϱ� ������ �ڽ��� �ǵ��� �ٿ� ������ Ȯ���ؾ� �Ѵ�.
   
��뿹)������̺��� �� �μ��� ������� ��ȸ�Ͻÿ�
    
    SELECT DEPARTMENT_ID    AS "�μ��ڵ�",
           COUNT(*)         AS "�����1",
           COUNT(LAST_NAME) AS "�����2"
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;
    
    SELECT DEPARTMENT_ID    AS "�μ��ڵ�",
           COUNT(*)         AS "�����1",
           COUNT(LAST_NAME) AS "�����2"
      FROM HR.EMPLOYEES
     GROUP BY ROLLUP(DEPARTMENT_ID)
     ORDER BY 1;

��뿹)2005�� 5�� �з��� �ǸŰǼ��� ��ȸ�Ͻÿ�

    SELECT B.PROD_LGU               AS  "�з��ڵ�",
           C.LPROD_NM               AS  "�з���",
           COUNT(*)                 AS  "�ǸŰǼ�"
      FROM CART A, PROD B, LPROD C
     WHERE A.CART_PROD = B.PROD_ID 
           AND B.PROD_LGU = C.LPROD_GU
           AND SUBSTR(A.CART_NO,1,6) = '200505'
     GROUP BY B.PROD_LGU, C.LPROD_NM;
     
��뿹)2005�� 5~6�� ȸ���� ����ȸ���� ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ����ȸ��
    
SELECT  A.MEMBERID                  AS  "ȸ����ȣ",
        COUNT(*)                    AS  "����ȸ��"
FROM    (SELECT CART_MEMBER          AS  MEMBERID,
                CART_NO              AS  CARTNO
           FROM CART
          WHERE SUBSTR(CART_NO, 1, 6) IN('200505', '200506')
          GROUP BY CART_MEMBER, CART_NO
          ORDER BY 1)    A
GROUP BY A.MEMBERID
ORDER BY 1;

SELECT  A.MEMBERID                  AS  "ȸ����ȣ",
        COUNT(*)                    AS  "����ȸ��"
FROM    (SELECT DISTINCT CART_NO                    AS  CARTNO,
                CART_MEMBER                         AS  MEMBERID
           FROM CART
          WHERE SUBSTR(CART_NO, 1, 6) IN('200505', '200506'))    A
GROUP BY A.MEMBERID
ORDER BY 1;
     
--  DISTINCT�� ������ �޴� �÷������� ���� ����� �ѹ��� ��µȴ�.

    SELECT CART_MEMBER          AS  "ȸ����ȣ"
      FROM CART
     WHERE SUBSTR(CART_NO, 1, 6) IN('200505', '200506')
     ORDER BY 1;
     
��뿹) 2005�� 6�� ��� ��ǰ�� ���� ������Ȳ�� ��ȸ�Ͻÿ�
��뿹) ��� �μ��� ������� ��ȸ�Ͻÿ�(NULL�μ��ڵ�� ����)
   SELECT B.DEPARTMENT_ID     AS "�μ��ڵ�",
          B.DEPARTMENT_NAME   AS "�μ���",
--          COUNT(*)          AS "�����1"
          COUNT(A.SALARY)       AS "�����"
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;
    
����) COUNT(*)�� NULL�� �������� �����Ƿ� �ܺ����ο��� ���� ��µ� �ƴ��� ��鵵 �����Ѵ�.
ANSI�� ���� � SQL������ ��� ����ȴ�.
����Ŭ�̳� �ٸ� ���� �� ���� Ư���� ������ ����Ѵٸ�, �� ������ �� �� Ưȭ��, ����ȭ�� ���� ��ɾ��̴�.
    
   SELECT B.DEPARTMENT_ID     AS "�μ��ڵ�",
          B.DEPARTMENT_NAME   AS "�μ���",
          COUNT(*)          AS "�����1"
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE B.DEPARTMENT_ID(+)= A.DEPARTMENT_ID
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;   
 
SELECT DEPARTMENT_ID    AS "�μ��ڵ�",
           COUNT(*)         AS "�����1",
           COUNT(LAST_NAME) AS "�����2"
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;


����̶�� �ܾ ������ �� ����� �Ǵ� �÷��� ������� �ܺ������� ������ �ϸ� �ȴ�.

�����ͺ��̽��� ������ ���¸� ������ �� ���� �Ӹ� �ƴ϶� ���� �� �̷����� Ȯ�强�� �������� ����Ǿ�� �Ѵ�.
������ ��ٰ� ������ ���� �ʴ� �μ��ڵ� Ȥ�� ������ �� ���ɼ��� ���� �μ��ڵ尡 ���� �� �����Ƿ� ���� �����͸� ��ȸ�ϸ� NULL�� �μ��ڵ� �߻�
�׸��� �̷� ������ ����� �����ͺ��̽��� �⺻�� ���� �����ͺ��̽���.
�ƿ��������� ��ų �� ����� �Ǵ� �� ���̺��� ��� ������ �κ��� �ִ� ���, �׷��� �����͵� ��� ����ϴ� �ƿ��� ������ FULL OUTER JOIN�̴�.
�ܺ����ο��� �����Ͱ� �� ���� ���̺��� �ڷ��� ���� �ƴ϶� ������ ���� ���� ���̺��̴�. �� ���̺��� �������� �ܺ����� �Ѵ�.
�� �ܺ����ο��� ����� �÷� COL�� �������� �������� ���� ����, ������ ���� A ���̺� �ִ� COL�� ������ B ���̺� �ִ� COL�� ������ ������ ��


























     