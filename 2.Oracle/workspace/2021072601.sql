2021-0726-01)
��뿹)2005�� 4~6�� ��� �з��� ������Ȳ�� ��ȸ�Ͻÿ�.
      ALIAS�� �з��ڵ�, �з���, ���Լ���, ���Աݾ�

SELECT A.LPROD_ID AS "�з��ڵ�",
       A.LPROD_NM AS "�з���",
       NVL(SUM(C.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON(A.LPROD_GU = B.PROD_LGU)
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 GROUP BY A.LPROD_ID, A.LPROD_NM
 ORDER BY 1;
 
SELECT B.LPROD_ID AS "�з��ڵ�",
       B.LPROD_NM AS "�з���",
       NVL(A.QTY,0) AS "���Լ���",
       NVL(A.CST,0) AS "���Աݾ�"
  FROM (SELECT A.PROD_LGU AS PGU,
               SUM(B.BUY_QTY) AS QTY,
               SUM(B.BUY_QTY * A.PROD_COST) AS CST
          FROM PROD A, BUYPROD B
         WHERE B.BUY_PROD = A.PROD_ID
               AND B.BUY_DATE BETWEEN  TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601'))
               GROUP BY A.PROD_LGU) A, LPROD B
 WHERE A.PGU(+) = B.LPROD_GU
 ORDER BY 1;

(�Ϲݿܺ�����<-�������� ����ؾ� ��)
SELECT B.LPROD_ID AS "�з��ڵ�",
       B.LPROD_NM AS "�з���",
       NVL(SUM(A.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(A.BUY_QTY * C.PROD_COST),0) AS "���Աݾ�"
  FROM BUYPROD A, LPROD B, PROD C
 WHERE A.BUY_PROD(+) = C.PROD_ID
       AND C.PROD_LGU(+) = B.LPROD_GU
       AND A.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
 GROUP BY B.LPROD_ID, B.LPROD_NM
 ORDER BY 1;

SELECT D.LPROD_ID AS �з��ڵ�,
       D.LPROD_NM AS �з���,
       NVL(TBLA.BCNT,0) AS ���Լ���,
       NVL(TBLA.BAMT,0) AS ���Աݾ�
  FROM (SELECT B.LPROD_GU AS BID,
               SUM(A.BUY_QTY) AS BCNT,
               SUM(A.BUY_QTY * C.PROD_COST) AS BAMT
          FROM BUYPROD A, LPROD B, PROD C
         WHERE A.BUY_PROD(+) = C.PROD_ID
               AND C.PROD_LGU(+) = B.LPROD_GU
               AND A.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
         GROUP BY B.LPROD_GU) TBLA,
       LPROD D
 WHERE D.LPROD_GU = TBLA.BID(+)
 ORDER BY 1;

(ANSI�ܺ�����)       
SELECT A.LPROD_ID AS "�з��ڵ�",
       A.LPROD_NM AS "�з���",
       NVL(SUM(C.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�"
  FROM BUYPROD C
 RIGHT OUTER JOIN PROD B ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 RIGHT OUTER JOIN LPROD A ON(B.PROD_LGU = A.LPROD_GU)
 GROUP BY A.LPROD_ID, A.LPROD_NM
 ORDER BY 1;       

��뿹)2005�� 4~6�� ��� �з��� ������Ȳ�� ��ȸ�Ͻÿ�
      ALIAS�� �з��ڵ�, �з���, �������, ����ݾ�

SELECT C.LPROD_ID AS "�з��ڵ�",
       C.LPROD_NM AS "�з���",
       NVL(SUM(A.CART_QTY),0) AS "�������",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "����ݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506')
 RIGHT OUTER JOIN LPROD C ON(B.PROD_LGU = C.LPROD_GU)
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;

SELECT C.LPROD_ID AS "�з��ڵ�",
       C.LPROD_NM AS "�з���",
       NVL(TBLA.QTY,0) AS "�������",
       NVL(TBLA.AMT,0) AS "����ݾ�"
  FROM (SELECT B.PROD_LGU AS BID,
               SUM(A.CART_QTY) AS QTY,
               SUM(A.CART_QTY * B.PROD_PRICE) AS AMT
          FROM CART A, PROD B
         WHERE A.CART_PROD = B.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
         GROUP BY B.PROD_LGU) TBLA,
       LPROD C
 WHERE TBLA.BID(+)=C.LPROD_GU
 ORDER BY 1;
 
       
 
������ : ���ʴ�� �ο��Ǵ� ���ڰ��� �� ���̺� ���ӽ�Ű�� �ʰ� �ٸ� ���̺��� ��ȸ�� �� �ִ� ��ü, ���̺� �ۿ��� �ڵ����� ����
�ٸ� DBMS���� �������� �������� ������ AUTO INCREASEMENT�� YES�� �صθ� �⺻Ű�� ����µ� ������, �� ���̺����� ��밡��
BETWEEN�� ���ڿ��� ���� ���� ���ڿ��� �ƽ�Ű�ڵ�� ��ȯ�Ͽ��� ������ ���ϹǷ�, %�� ���� �ʴ� ���� ����.

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
 RIGHT OUTER JOIN LPROD C ON(B.PROD_LGU = C.LPROD_GU)
  LEFT OUTER JOIN BUYPROD D ON(B.PROD_ID = D.BUY_PROD
       AND D.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630'))
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;
 
 
SELECT A.LPROD_ID AS "�з��ڵ�",
       A.LPROD_NM AS "�з���",
       NVL(SUM(C.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "���Աݾ�",
       NVL(SUM(D.CART_QTY),0) AS "�������",
       NVL(SUM(D.CART_QTY * B.PROD_PRICE),0) AS "����ݾ�"
  FROM LPROD A
  LEFT OUTER JOIN PROD B ON(A.LPROD_GU = B.PROD_LGU)
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630'))
  LEFT OUTER JOIN CART D ON(B.PROD_ID = D.CART_PROD
       AND SUBSTR(D.CART_NO,1,6) BETWEEN '200504' AND '200506')
 GROUP BY A.LPROD_ID, A.LPROD_NM
 ORDER BY 1;

SELECT B.LPROD_ID AS "�з��ڵ�",
       B.LPROD_NM AS "�з���",
       NVL(TBLA.CQTY,0) AS "�������",
       TBLA.CAMT AS "����ݾ�",
       TBLA.BQTY AS "���Լ���",
       TBLA.BAMT AS "���Աݾ�"
  FROM (SELECT B.PROD_LGU AS PGU,
              SUM(A.CART_QTY) AS CQTY,
              SUM(A.CART_QTY * B.PROD_PRICE) AS CAMT,
              SUM(C.BUY_QTY) AS BQTY,
              SUM(C.BUY_QTY * B.PROD_COST) AS BAMT
         FROM CART A, PROD B, BUYPROD C
        WHERE A.CART_PROD = B.PROD_ID
              AND B.PROD_ID = C.BUY_PROD
              AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
              AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
        GROUP BY B.PROD_LGU) TBLA,
       LPROD B
 WHERE TBLA.PGU(+) = B.LPROD_GU
 ORDER BY 1;
--�ذ��Ϸ��� ���������� ���� ��� ��.

��뿹)2005�� 4~6�� ��� ��ǰ�� ������Ȳ/������Ȳ
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ���Լ���, ���Աݾ�, �������, ����ݾ�
      
SELECT B.PROD_ID AS "��ǰ�ڵ�",
       B.PROD_NAME AS "��ǰ��",
       NVL(SUM(C.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "�����հ�",
       NVL(SUM(A.CART_QTY),0) AS "�������",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "����ݾ�"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506')
  LEFT OUTER JOIN BUYPROD C ON(C.BUY_PROD = B.PROD_ID
       AND C.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
       
SELECT A.PROD_ID AS "��ǰ�ڵ�",
       A.PROD_NAME AS "��ǰ��",
       NVL(SUM(B.BUY_QTY),0) AS "���Լ���",
       NVL(SUM(B.BUY_QTY * A.PROD_COST),0) AS "�����հ�"
--       NVL(SUM(C.CART_QTY),0) AS "�������",
--       NVL(SUM(C.CART_QTY * A.PROD_PRICE),0) AS "����ݾ�"
  FROM PROD A
--  LEFT OUTER JOIN CART C ON(C.CART_PROD = A.PROD_ID
--       AND SUBSTR(C.CART_NO,1,6) BETWEEN '200504' AND '200506')
  LEFT OUTER JOIN BUYPROD B ON(B.BUY_PROD = A.PROD_ID
       AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND LAST_DAY(TO_DATE('20050601')))
 GROUP BY A.PROD_ID, A.PROD_NAME
 ORDER BY 1; 

--�̰͵� ������ 2�辿 ���´� / ���� ������ ����