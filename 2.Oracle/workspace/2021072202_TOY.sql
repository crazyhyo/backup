��뿹)2005�� 5�� ȸ���� �Ǹž��� ����ϰ� ���� 5���� �ڷḦ ����Ͻÿ�
      ALIAS�� ȸ����ȣ, ȸ����, ���űݾ��հ�
SELECT A.MID AS "ȸ����ȣ",
       A.MNAME AS "ȸ����",
       A.AMT AS "���űݾ��հ�"
FROM    (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNAME,
               SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
WHERE ROWNUM <= 5;

��뿹)2005�� 5�� �����հ�
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "�����հ�"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID, B.PROD_NAME;

��뿹)2005�� 5�� �����հ�
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       SUM(B.PROD_COST * A.BUY_QTY) AS "�����հ�"
  FROM BUYPROD A, PROD B
 WHERE A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
 GROUP BY B.PROD_ID, B.PROD_NAME;
       

��뿹)2005�� 5�� ���Ծװ� ������� ��ȸ�Ͻÿ�
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Ծ��հ�, ������հ�

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "���Ծ��հ�",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "������հ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531'))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
SELECT B.PROD_ID AS AID,
       SUM(A.CART_QTY * B.PROD_PRICE) AS AAMT
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID;
 
SELECT BUY_PROD AS BID,
       SUM(BUY_QTY * BUY_COST) AS BAMT
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
 GROUP BY BUY_PROD;

SELECT C.PROD_ID AS "��ǰ�ڵ�",
       C.PROD_NAME AS "��ǰ��",
       NVL(A.AAMT,0) AS "������հ�",
       NVL(B.BAMT,0) AS "���Ծ��հ�"
FROM      (SELECT B.PROD_ID AS AID,
                   SUM(A.CART_QTY * B.PROD_PRICE) AS AAMT
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
                   AND SUBSTR(A.CART_NO,1,6) = '200505'
             GROUP BY B.PROD_ID) A,
            (SELECT BUY_PROD AS BID,
                   SUM(BUY_QTY * BUY_COST) AS BAMT
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
             GROUP BY BUY_PROD) B, PROD C
WHERE A.AID (+)= C.PROD_ID
      AND B.BID (+)= C.PROD_ID
ORDER BY 1;
      
      
��뿹)������̺��� ������� ��ձ޿����� �� ���� �޿��� �޴� ����� �����ȣ, �����, �μ���, �޿�, ��ձ޿��� ����Ͻÿ�
SELECT B.EMPLOYEE_ID AS "�����ȣ",
       B.EMP_NAME AS "�����",
       C.DEPARTMENT_ID AS "�μ���",
       B.SALARY AS "�޿�",
       A.AVER AS "��ձ޿�"
FROM    (SELECT ROUND(AVG(SALARY)) AS AVER
          FROM HR.EMPLOYEES) A, HR.EMPLOYEES B, HR.DEPARTMENTS C
WHERE B.DEPARTMENT_ID = C.DEPARTMENT_ID
      AND B.SALARY > A.AVER
ORDER BY 1;

SELECT B.EMPLOYEE_ID AS "�����ȣ",
       B.EMP_NAME AS "�����",
       C.DEPARTMENT_ID AS "�μ���",
       B.SALARY AS "�޿�",
       A.AVER AS "��ձ޿�"
FROM   HR.EMPLOYEES B 
INNER JOIN HR.DEPARTMENTS C ON(B.DEPARTMENT_ID = C.DEPARTMENT_ID)
INNER JOIN (SELECT ROUND(AVG(SALARY)) AS AVER
          FROM HR.EMPLOYEES) A ON(B.SALARY > A.AVER)
ORDER BY 1;

��뿹)[2005�� 6�� ���� ���� �ݾ��� ������ ��]�� �ּ��� �̿��� �ּ����� �����ϴ� ȸ���� ȸ����ȣ, ȸ����, �ּҸ� ��ȸ�Ͻÿ�.
SELECT B.MEM_ID AS "ȸ����ȣ",
       B.MEM_NAME AS "ȸ����",
       B.MEM_ADD1 || ' ' || B.MEM_ADD2 AS "�ּ�"
FROM    (SELECT A.MID AS MID,
                A.ADD1 AS ADD1
        FROM    (SELECT B.MEM_ID AS MID,
                        B.MEM_ADD1 AS ADD1,
                       SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
                  FROM CART A
                 INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID
                       AND SUBSTR(A.CART_NO,1,6) = '200506')
                 INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
                 GROUP BY B.MEM_ID, B.MEM_ADD1
                 ORDER BY 2 DESC) A
        WHERE ROWNUM = 1) A, MEMBER B
WHERE A.ADD1 <> B.MEM_ADD1; 
 
  

DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_AMT NUMBER:=0;
    
    CURSOR CUR_MEM01 IS
      SELECT A.MID
        FROM (SELECT MEM_ID AS MID
                FROM MEMBER
               ORDER BY MEM_MILEAGE DESC) A
       WHERE ROWNUM <= ROUND((SELECT COUNT(*)
                                FROM MEMBER) * 0.2);
BEGIN
    OPEN CUR_MEM01;
    LOOP
      FETCH CUR_MEM01 INTO V_ID;
      EXIT WHEN CUR_MEM01%NOTFOUND;
      
      SELECT C.MEM_NAME, SUM(A.CART_QTY * B.PROD_PRICE)
        INTO V_NAME, V_AMT
        FROM CART A, PROD B, MEMBER C
       WHERE A.CART_MEMBER = C.MEM_ID
             AND A.CART_PROD = B.PROD_ID
             AND A.CART_MEMBER = V_ID
             AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
       GROUP BY C.MEM_NAME;
             
        DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_ID);
        DBMS_OUTPUT.PUT_LINE('ȸ���� : '||V_NAME);
        DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;      
    CLOSE CUR_MEM01;    
END;    