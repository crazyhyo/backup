2021-0716-02)�����Լ�
  - �־��� �ڷḦ Ư�� �÷��� �������� �׷����� ������ �׷캰�� �ڷῡ ���� ���踦 ��ȯ�ϴ� �Լ�
  - SUM, AVG, COUNT, MIN, MAX
  (�������)
    SELECT  [�÷�list],
            SUM|AVG|COUNT(column|*)|MIN|MAX(expr),
            
    FROM    ���̺��
    [WHERE ����]
    [GROUP BY �÷���[, �÷���,...]]
    [HAVING ����]
    [ORDER BY �÷���|�÷��ε���[ASC|DESC]][,�÷���|�÷��ε���[ASC|DESC],...];

GROUP BY : Ư�� �÷��� ��ȸ�ϸ� �� �÷��� ���� ���� �ೢ�� ���´�.
GROUP BY �ڿ� �ִ� �÷��� ���� �߿�
���� ���� ���� �׷����� ���� ���� ���������� �����
���ʿ� �÷��� ����ϸ� �� ���� �� �׷� �ȿ��� ���� �÷��� �������� ���� ����� �ݺ��Ѵ�.
GROUP BY�� ����ؼ��� ��ü�� �հ踦 ���� �� ���   ROLLUP(�÷���list) �� �÷��� + 1 ���� �հ踦 ��ȯ
                                                CUBE(�÷���list) �� 2 ^ (�÷���) ���� �հ踦 ��ȯ
�μ��ڵ庰 �ο���, ����ӱ��� ���Ͻÿ�
HAVING ������ �����Լ��� ����� ���� ����
    ���� : SELECT���� ���� ���� [FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY]
    �����Լ��� ������� GROUP BY�� ���� �� ���Ŀ� �� �� �ִ�.
    WHERE�� �����Լ��� ������� �����Ϸ��� �ϴ� ��� ���̺��� ã�� �ٷ� �����Լ��� ������� ��ȸ�ؾ� �ϴµ�
    �� �������� GROUP BY���� ������� �ʾұ� ������ �����Լ��� ������� ã�� �� ���ٴ� ������ �߻���Ų��.
    ���� �����Լ��� ����� ���� ������ GROUP BY�� ���� �� ���Ŀ� �����Ϸ��� ã�� HAVING�� ���� �־�� �Ѵ�.

GROUP BY���� �ʿ� ���� ��� : ��ü �����͸� �ϳ��� �׷����� ������ ��(��ü �������� ���� ���� ��)
    
  1. SUM(expr)
   - 'expr'�� ǥ���Ǵ� ���� �Ǵ� �÷��� ���� ���� �հ踦 ��ȯ

��뿹)������̺��� ��� ����� �޿� �Ѿ��� ���Ͻÿ�
    SELECT      EMP_NAME,
                SUM(SALARY)
    FROM        HR.EMPLOYEES
    GROUP BY    EMP_NAME;
    
    SELECT      --EMP_NAME,
                SUM(SALARY)
    FROM        HR.EMPLOYEES;
    --GROUP BY    EMP_NAME;
    
    SELECT      EMP_NAME
    FROM        HR.EMPLOYEES;
    GROUP BY    SALARY;
   
��뿹)������̺��� �μ��� �޿� �հ踦 ���Ͻÿ�.
    SELECT      DEPARTMENT_ID       AS  "�μ��ڵ�",
                COUNT(*)            AS  "�μ��ο�",
                SUM(SALARY)         AS  "�޿��հ�"
    FROM        HR.EMPLOYEES
    GROUP BY    DEPARTMENT_ID
    ORDER BY    1;

��뿹)������̺��� �μ��� �޿� �հ踦 ���ϵ�, �հ谡 10000�̻��� �μ��� ��ȸ�Ͻÿ�.
    SELECT      DEPARTMENT_ID   AS  "�μ��ڵ�",
                SUM(SALARY)     AS  "�޿��հ�"
    FROM        HR.EMPLOYEES
--    WHERE       SUM(SALARY) >= 10000
--                DEPARTMENT_ID != NULL         ������ �ʴ� ���
--                DEPARTMENT_ID IS NOT NULL     NULL���� �ٷ�Ƿ� ���� NULLó�� �Լ� ȣ��
    GROUP BY    DEPARTMENT_ID
    HAVING      SUM(SALARY) >= 10000
    ORDER BY    1;
    
��뿹)2005�� 5�� ȸ���� ������Ȳ(ȸ����ȣ, ���ż����հ�, ���űݾ��հ�)�� ��ȸ�Ͻÿ�
    SELECT      A.MEM_ID                             AS   "ȸ����ȣ",
                SUM(B.CART_QTY)                      AS   "���ż����հ�",
                TO_CHAR(SUM(B.CART_QTY * C.PROD_PRICE), '999,999,999,999L')        AS   "���űݾ��հ�"
--                SUM(B.CART_QTY * C.PROD_PRICE)        AS   "���űݾ��հ�"
    FROM        MEMBER A, CART B, PROD C
    WHERE       B.CART_MEMBER = A.MEM_ID
                AND B.CART_PROD = C.PROD_ID
                AND SUBSTR(B.CART_NO, 1, 6) = '200505'
    GROUP BY    A.MEM_ID;
    
    SELECT      A.CART_MEMBER                   AS      "ȸ����ȣ",
                SUM(A.CART_QTY)                 AS      "���ż����հ�",
                SUM(A.CART_QTY * B.PROD_PRICE)  AS      "���űݾ��հ�"
    FROM        CART A, PROD B
    WHERE       A.CART_PROD = B.PROD_ID
                AND SUBSTR(A.CART_NO, 1, 6) = '200505'
    GROUP BY    A.CART_MEMBER;
    
��뿹)2005�� ���� ȸ���� ������Ȳ(��, ȸ����ȣ, ���ż����հ�, ���űݾ��հ�)�� ��ȸ�Ͻÿ�.
    SELECT      SUBSTR(A.CART_NO, 5, 2)                                 AS      "��",
                A.CART_MEMBER                                           AS      "ȸ����ȣ",
                SUM(A.CART_QTY)                                         AS      "���ż����հ�",
                SUM(A.CART_QTY * B.PROD_PRICE)                          AS      "���űݾ��հ�"
    FROM        CART A, PROD B
    WHERE       A.CART_PROD = B.PROD_ID
                AND SUBSTR(A.CART_NO, 1, 4) = '2005'
    GROUP BY    SUBSTR(A.CART_NO, 5, 2), A.CART_MEMBER
    ORDER BY    1;
    
����) WHERE������ ',' �� ���ٰ� �����ض�. AND, OR, IN, ANY �� ����. Ư�� AND, OR�� ,�� ��ü�Ѵ�

��뿹)ȸ�����̺��� ������ ���ϸ��� �հ踦 ���Ͻÿ�.

    SELECT      MEM_JOB                                         AS  "����",
--                COUNT(*)                                        AS  "�ο���",
--                TO_CHAR(AVG(MEM_MILEAGE),'9,999.00')            AS  "��� ���ϸ���",
                SUM(MEM_MILEAGE)                                AS  "���ϸ��� �հ�"
    FROM        MEMBER
    GROUP BY    MEM_JOB
    ORDER BY    1;

    
    SELECT      COUNT(*)
    FROM        MEMBER
    WHERE       SUBSTR(MEM_REGNO2, 1, 1) = '2'
                OR  SUBSTR(MEM_REGNO2, 1, 1) = '4';
    
����] ������̺��� �ٹ������� �޿��հ踦 ���Ͻÿ�.

    SELECT      D.COUNTRY_NAME                                          AS      "�ٹ�����",
                SUM(A.SALARY)                                           AS      "�޿��հ�"
    FROM        HR.EMPLOYEES A, HR. DEPARTMENTS B, HR.LOCATIONS C,
                HR.COUNTRIES D
    WHERE       A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND     B.LOCATION_ID = C.LOCATION_ID
                AND     C.COUNTRY_ID = D.COUNTRY_ID
    GROUP BY    D.COUNTRY_NAME;
    
    SELECT      E.REGION_NAME                                           AS      "�ٹ����",
                SUM(A.SALARY)                                           AS      "�޿��հ�"
    FROM        HR.EMPLOYEES A, HR.DEPARTMENTS B,
                HR.LOCATIONS C, HR.COUNTRIES D,
                HR.REGIONS E
    WHERE       A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND     B.LOCATION_ID = C.LOCATION_ID
                AND     C.COUNTRY_ID = D.COUNTRY_ID
                AND     D.REGION_ID = E.REGION_ID
    GROUP BY    E.REGION_NAME;
    
    
    
    SELECT D.COUNTRY_ID                     AS  "�ٹ������ڵ�",
           D.COUNTRY_NAME                   AS  "������",
           COUNT(*)                         AS  "�����",
           TO_CHAR(SUM(A.SALARY),'999,999') AS  "�޿��հ�"
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.COUNTRY_ID = D.COUNTRY_ID
     GROUP BY D.COUNTRY_ID, D.COUNTRY_NAME
     ORDER BY 3 DESC;
     
��뿹)������̺��� �� �μ��� ���ʽ� �հ踦 ���Ͻÿ�
      ����� �μ��ڵ�, �μ���, ���ʽ� �հ��̰�, ���ʽ��� ��������(COMMISION_PCT)��
      �޿��� ���� ����� 30%�� �����Ѵ�.
      
UPDATE HR.EMPLOYEES
   SET COMMISSION_PCT = 0.2
 WHERE EMPLOYEE_ID = 107;
 
 COMMIT;
      
    SELECT A.DEPARTMENT_ID                                  AS  "�μ��ڵ�",
           B.DEPARTMENT_NAME                                AS  "�μ���",
           SUM(A.SALARY * NVL(A.COMMISSION_PCT, 1) * 0.3)    AS  "���ʽ� �հ�"
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
     ORDER BY 1;

