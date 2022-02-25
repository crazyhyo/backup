2021-0722-01)

��뿹)2005�� 5�� ȸ���� �Ǹž��� ����ϰ� ���� 5���� �ڷḦ ����Ͻÿ�
      ALIAS�� ȸ����ȣ, ȸ����, ���űݾ��հ�
SELECT A.AID AS "ȸ����ȣ",
       A.ANAME AS "ȸ����",
       A.AAMOUNT AS "���űݾ��հ�"
FROM    (SELECT B.MEM_ID AS AID,
               B.MEM_NAME AS ANAME,
               SUM(A.CART_QTY * C.PROD_PRICE) AS AAMOUNT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC)A
WHERE ROWNUM <= 5;

SELECT A.AID AS "ȸ����ȣ",
       A.ANAME AS "ȸ����",
       A.AAMOUNT AS "���űݾ��հ�"
FROM    (SELECT B.MEM_ID AS AID,
               B.MEM_NAME AS ANAME,
               SUM(A.CART_QTY * C.PROD_PRICE) AS AAMOUNT
          FROM CART A
         INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505')
         INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC)A
WHERE ROWNUM <= 5;

SELECT TBLA.CID AS ȸ����ȣ,
       TBLB.MEM_NAME AS ȸ����,
       TBLA.AMT AS ���űݾ��հ�
  FROM (SELECT A.CART_MEMBER AS CID,
               SUM(A.CART_QTY * B.PROD_PRICE) AS AMT
          FROM CART A, PROD B
         WHERE A.CART_PROD = B.PROD_ID
               AND A.CART_NO LIKE '200505%'
         GROUP BY A.CART_MEMBER
         ORDER BY 2 DESC) TBLA,
        MEMBER TBLB
 WHERE TBLA.CID = TBLB.MEM_ID
       AND ROWNUM <= 5;

SELECT TBLA.CID AS ȸ����ȣ,
       TBLB.MEM_NAME AS ȸ����,
       TBLA.AMT AS ���űݾ��հ�
  FROM (SELECT A.CART_MEMBER AS CID,
               SUM(A.CART_QTY * B.PROD_PRICE) AS AMT
          FROM CART A
         INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
               AND A.CART_NO LIKE '200505%')
         GROUP BY A.CART_MEMBER
         ORDER BY 2 DESC) TBLA
 INNER JOIN MEMBER TBLB ON(TBLA.CID = TBLB.MEM_ID)
 WHERE ROWNUM <= 5;

��뿹)ȸ���� ���ϸ����� ��ȸ�Ͽ� ���� 20%�� ���� ȸ������ 2005�� 4~6�� ������ ������ ��ȸ�Ͻÿ�
      ALIAS�� ȸ����ȣ, ȸ����, ��ǰ��, ����, �ݾ�

DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
--    V_PNAME PROD.PROD_NAME%TYPE;
--    V_CNT NUMBER:=0;
    V_AMT NUMBER:=0;
    
    CURSOR CUR_MEM01 IS
      SELECT A.MID
        FROM (SELECT MEM_ID AS MID
                FROM MEMBER
               ORDER BY MEM_MILEAGE DESC) A
       WHERE ROWNUM <= ROUND((SELECT COUNT(*)
                                FROM MEMBER) * 0.2);
    --�ټ����� ȸ�� ���̵� ����� Ŀ���� CUR_MEM01�� �̸�����
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
--        DBMS_OUTPUT.PUT_NAME('ȸ����ȣ : '||V_PNAME);
--        DBMS_OUTPUT.PUT_NAME('ȸ����ȣ : '||V_CNT)
        DBMS_OUTPUT.PUT_LINE('ȸ����ȣ : '||V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
/*
LOOP~END LOOP;�� DO�� ������ ��, �ּ� �ѹ��� ������ �㺸��
FETCH ó���� V_ID�� CUR_MEM01�� ù��° ���� ��
EXID WHEN CUR_MEM01%NOTFOUND; : ���̻� ���� ���� ���� �� ���� �ǰ� �� �� ����

Ŀ������:
NOTFOUND���� �ڷᰡ ������ �� ������ ����
FOUND���� �ڷᰡ ������ �� ������ ����
ISOPENĿ���� ���������� �� ���������� ����
ROWCOUNT��ü���Ǽ�

Ŀ����%Ŀ��������<-�ݺ��� ������ �� ����ϴ� ����
Ŀ���� ��� : ���� -> ���� -> FETCH -> Ŭ����
�̰��� �ѹ��� �ϴ� ��� : FOR������ ��� - FOR�� �ȿ��� ������ �ϸ� ��
*/
END;
  
DECLARE-BEGIN BLOCK : ����, ?, Ŀ�� / �����
V_ : ������
P_ : �Ķ������
���۷��� Ÿ��
���� �����Ϸ��� �ϴ� ���� ��� ���̺��� ��� �÷� ������������ ������ ��Ȯ�� �� Ÿ���� �� ��
%TYPE�� ����Ÿ������ �����ϸ� �ش� �÷��� Ÿ�԰� ���� ������Ÿ������ ����ȴ�.
����Ÿ������ �� ���� �Ȱ��� ���� ���� ����

Ŀ�� : ���ϴ� �ڷḦ �����ϱ� ���� �����ϱ� ���� ����?
Ŀ���� ������ SELECT��
BEGIN-END BLOCK : SELECT INTO FROM WHERE / �����

��뿹)2005�� 5�� �����հ�
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       SUM(B.PROD_COST * C.BUY_QTY) AS "���Ծ��հ�"
  FROM PROD B, BUYPROD C
 WHERE B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'))
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       SUM(B.PROD_COST * C.BUY_QTY) AS "���Ծ��հ�"
  FROM PROD B, BUYPROD C
 WHERE B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'))
 GROUP BY B.PROD_ID;

��뿹)2005�� 5�� �����հ�
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "������հ�"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "������հ�"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID;

��뿹)2005�� 5�� ���Ծװ� ������� ��ȸ�Ͻÿ�
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Ծ��հ�, ������հ�

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       SUM(B.PROD_COST * C.BUY_QTY) AS "���Ծ��հ�",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "������հ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(B.PROD_COST * C.BUY_QTY),0) AS "���Ծ��հ�",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "������հ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;

(�Ϲ����� ����)
SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       NVL(TBLA.BAMT,0) AS "������հ�",
       NVL(TBLB.CAMT,0) AS "���Ծ��հ�"
  FROM (SELECT B.PROD_ID AS BID,
            SUM(A.CART_QTY * B.PROD_PRICE) AS BAMT
       FROM CART A, PROD B
      WHERE A.CART_PROD = B.PROD_ID
            AND SUBSTR(A.CART_NO,1,6) = '200505'
      GROUP BY B.PROD_ID) TBLA,
     (SELECT B.PROD_ID AS CID,
            SUM(B.PROD_COST * C.BUY_QTY) AS CAMT
       FROM PROD B, BUYPROD C
      WHERE B.PROD_ID = C.BUY_PROD
            AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'))
      GROUP BY B.PROD_ID) TBLB,
      PROD A
 WHERE TBLA.BID(+)=A.PROD_ID
       AND TBLB.CID(+)=A.PROD_ID
 ORDER BY 1;
       
ANSI JOIN���� JOIN�� �� ���δ���� �Ǵ� �÷��� ������ �������� ���� ���ٸ� �����Ѵ�.
��) �μ����̺� �ִ� �μ��ڵ� 28��(��ü), ������̺��� ������ �ִ� �μ��ڵ尳�� 14����� �� ū ���� �μ����̺��̴�
(�μ��ڵ带 �������� ������ ��), �̶� ���� ������ ��(Ʃ��)�� ������ ���ϴ� ���� �ƴϴ�.

���ʿ� ����� ���� �� ���� : LEFT
���ʿ� ����� ���� �� ���� : RIGHT
�� �� ��� ������ ���� �ִ� : FULL
���������� �Ϲ� ���ǰ� �Բ� �ο��� ��쿡�� OUTER/INNER JOIN�� ON������ ������ �����ؾ� �Ѵ�(WHERE���̸� ������ �ٸ� ��� ���)

  3. NON-EQUI JOIN
   - �������ǹ��� '=' �̿��� �����ڰ� ���� ���
   - IN, ANY, SOME, ALL, EXISTS ���� ������ ������ ���
   
��뿹)������̺��� ������� ��ձ޿����� �� ���� �޿��� �޴� ����� �����ȣ, �����, �μ���, �޿�, ��ձ޿��� ����Ͻÿ�

SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       A.SALARY AS "�޿�",
       (SELECT ROUND(AVG(SALARY))
          FROM HR.EMPLOYEES) AS "��ձ޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.SALARY > (SELECT AVG(SALARY)
                         FROM HR.EMPLOYEES)
 ORDER BY 4;

--����ӵ� ���������� ��� ����ŭ SELECT������, WHERE������ ���������� �����, �ſ� ����

SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.EMP_NAME AS "�����",
       B.DEPARTMENT_NAME AS "�μ���",
       A.SALARY AS "�޿�",
       C.ASAL AS "��ձ޿�"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
       (SELECT ROUND(AVG(SALARY)) AS ASAL
          FROM HR.EMPLOYEES) C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.SALARY > C.ASAL
 ORDER BY 4;

��뿹)2005�� 6�� ���� ���� �ݾ��� ������ ���� �ּ��� �̿��� �ּ����� �����ϴ� ȸ���� ȸ����ȣ, ȸ����, �ּҸ� ��ȸ�Ͻÿ�.
SELECT B.MEM_ID AS "ȸ����ȣ",
       B.MEM_NAME AS "ȸ����",
       B.MEM_ADD1 || ' ' || B.MEM_ADD2 AS "�ּ�"
FROM        (SELECT A.ADD1 AS ADD1
            FROM    (SELECT B.MEM_ADD1 AS ADD1,
                           SUM(C.PROD_PRICE * A.CART_QTY) AS AMT
                      FROM CART A, MEMBER B, PROD C
                     WHERE A.CART_MEMBER = B.MEM_ID
                           AND A.CART_PROD = C.PROD_ID
                           AND SUBSTR(A.CART_NO,1,6) = '200506'
                     GROUP BY B.MEM_ADD1
                     ORDER BY 2 DESC) A
            WHERE ROWNUM = 1) A, MEMBER B
WHERE B.MEM_ADD1 <> A.ADD1;
               


����Ŭ�� TOP�� ����
����Ŭ�� RANKOVER��� �Լ��� �������ش�
VIEW�� ������ ���̺��̴�. FROM���� �ڿ��� ���̺�� �䰡 �� �� �ִ�.
������������ �ۼ��� SELECT���� VIEW�� ��޵ȴ�.
�̸��� ���� VIEW�� ���� VIEW�� ��Ÿ���� ���� ������.

���������� ���� SELECT��, FROM��, WHERE�� ��ο��� ��Ÿ�� �� �ִ�

����>
��뿹)  ������̺��� ��ձ޿� �̻� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �޿�, �μ���ȣ
        
        SELECT      EMPLOYEE_ID     AS  �����ȣ,
                    FIRST_NAME      AS  �����,
                    SALARY          AS  �޿�,
                    DEPARTMENT_ID   AS  �μ���ȣ,
                    ROUND((SELECT AVG(SALARY)
                    FROM    HR.EMPLOYEES),0)    AS  ��ձ޿�
        FROM        HR.EMPLOYEES
        WHERE       NOT SALARY  < (SELECT    AVG(SALARY)
                                  FROM  HR.EMPLOYEES);

SELECT���� ������ VIEW�� CURSOR��� �θ� / CURSOR�� JAVA�� ITERATOR�� ���� ����� / ITERATOR�� ���ü�� �迭�̳� �÷��� �����ӿ�ũ
���α׷����� �����͸� �����ϴ� ���
LEVEL 1 ����, �ѹ��� �ϳ��� ������ �� ����
LEVEL 2 �迭, �ѹ��� �������� ������ �� ���� / �Ѱ�1. ũ�⸦ ���̰ų� ���� �� ���� 2. ���� Ÿ���� �����͸� ���� ����
LEVEL 3 ����ü(STRUCTURE) ���� �� PUBLIC�̶� ������� ����� �� ���� / BEHAVIOR�� ���� �� ����
LEVEL 4 Ŭ���� ��������� BEHAIVIOR�� ���� // Ŭ������ ������

ARRAY������
���־����� : �����Ϸ����� �δ��� �ȴ� = ����ӵ��� ������
�ڹ� : ������ Ÿ�� ���� - �÷��� �����ӿ�ũ, ��ü�� �޴´�
����Ʈ(��ũ��, ������-���Ϳ� ��̸���Ʈ:�ڽ�-��ڽ�), ��, ��
������ �÷��� �����ӿ�ũ�� �ִ� ��� : ��ü�� �����ؼ� �ִ´� [������ �ϴ� 8���� INTEGER, DOUBLE, LONG, FLOAT, BYTE, BOOLEAN, SHORT, CHAR)
������ ����ڽ�, �����ڽ� �����ϵ��� ��������

�͸� Ŀ�� : IMPLICIT Ŀ�� / ȭ�鿡 ��µɶ� OPEN��, ����� ������ �ڵ����� CLOSE��
        �̸��� �����ϱ� �ҷ��� �� ����.

�츮�� ó���ϴ� ������ ��κ� �Ѽ����� �ϳ��� ������
�� ������ �ϳ��� ������ �ʿ��ϰ� �� ������ ������ �ϳ��ϳ��� ������ �ϰ� �ʹٸ� Ŀ���� �ʿ��ϴ�.

�޼��带 ���� ���� 2���� ���
1. ��������(13��, 14�� - �б��ּ�, �����ּ�)�� �̿��ؼ� ȣ��Ǵ� �޼����� �ּҷ� ���ٰ� ������ ������ ��ɾ� �ٷ� �ڷ� ���ƿ�
        �ð��� ���� 
2. ª�� �޼���� �� ª�� ��ɾ �״�� �����ٰ� ��ٰ� �ٷ� ���ƿ�?
�ζ��� 