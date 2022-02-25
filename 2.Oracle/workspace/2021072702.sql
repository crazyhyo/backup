2021-0727-02)
��뿹)ȸ�����̺��� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ����Ͻÿ�
SELECT B.MEM_ID AS "ȸ����ȣ",
       B.MEM_NAME AS "ȸ����",
       B.MEM_MILEAGE AS "���ϸ���",
       ROUND(A.MIL) AS "��ո��ϸ���"
  FROM (SELECT AVG(MEM_MILEAGE) AS MIL
          FROM MEMBER) A, MEMBER B
 WHERE B.MEM_MILEAGE > A.MIL
 
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_MILEAGE AS "���ϸ���",
       (SELECT ROUND(AVG(MEM_MILEAGE))
          FROM MEMBER) AS "��ո��ϸ���"
  FROM MEMBER
 WHERE MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE) AS MIL
                        FROM MEMBER)

SELECT ���� �������� ����� : WHERE������ ������ ���� ���� ����
WHERE���� �������� ���� �� : ���� ���̺� ���� ���� ����ŭ ����
FROM���� �������� ���� �� : �ѹ� ���� �� ���������� ����Ⱓ���� ��� ����

��뿹)ȸ������ �ڷῡ�� ���� ��ո��ϸ����� ���ϰ� �ڽ��� ���� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ����
      2005�� 4~6�� ������Ȳ�� ��ȸ�Ͻÿ�.
      ALIASȸ����ȣ, ȸ����, ���űݾ��հ�
1)ȸ������ �ڷῡ�� ���� ��� ���ϸ����� ���ϰ� ���� ��ո��ϸ������� ���� ���ϸ����� ������ ȸ������
�������� : ȸ�����̺��� (��������)������ �����ϴ� ȸ������ ���      

SELECT MEM_ID, MEM_NAME
  FROM MEMBER
 WHERE MEM_MILEAGE < (��������)

�������� : ���� ��� ���ϸ���
SELECT TBLA.AMILE
  FROM (SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN
                         '����ȸ��'
               ELSE      '����ȸ��' END,
               SUBSTR(MEM_REGNO2,1,1) AS GEN,
               AVG(MEM_MILEAGE) AS AMILE
          FROM MEMBER
         GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN
                            '����ȸ��'
                  ELSE      '����ȸ��' END) TBLA.AMILE, MEMBER B
 WHERE B.MEM_REGNO2 LIKE TBLA.GEN || '%'
2)2005�� 4~6�� ������Ȳ

SELECT TBLA.MID AS "ȸ����ȣ",
       TBLA.MNAME AS "ȸ����",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "���űݾ� �հ�"
  FROM (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNAME,
               A.AVGMIL AS AAVG,
               B.MEM_MILEAGE AS BMIL
          FROM (SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����'
                            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '����'
                       END AS GENDER,
                       ROUND(AVG(MEM_MILEAGE)) AS AVGMIL
                  FROM MEMBER
                 GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '����'
                               WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '����'
                          END) A, MEMBER B
        WHERE B.MEM_MILEAGE < A.AVGMIL) TBLA, CART A, PROD B
 WHERE TBLA.MID = A.CART_MEMBER
       AND A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200506'
 GROUP BY TBLA.MID, TBLA.MNAME
 ORDER BY 1;
 
SELECT MEN.MID AS MID,
       MEN.MNAME AS MNAME,
       SUM(B.CART_QTY * C.PROD_PRICE) AS AMT
  FROM (SELECT A.MEM_ID AS MID,
               A.MEM_NAME AS MNAME,
               A.MEM_MILEAGE AS MIL,
               B.MAVG AS MAVG
          FROM MEMBER A, (SELECT AVG(MEM_MILEAGE) AS MAVG
                            FROM MEMBER
                           WHERE SUBSTR(MEM_REGNO2,1,1) IN('1','3')) B
         WHERE SUBSTR(A.MEM_REGNO2,1,1) IN('1','3')
               AND A.MEM_MILEAGE < B.MAVG) MEN,
       CART B, PROD C
 WHERE MEN.MID = B.CART_MEMBER
       AND SUBSTR(B.CART_NO,1,6) BETWEEN '200504' AND '200506'
       AND B.CART_PROD = C.PROD_ID
 GROUP BY MEN.MID, MEN.MNAME     
UNION
SELECT WOMEN.MID AS MID,
       WOMEN.MNAME AS MNAME,
       SUM(B.CART_QTY * C.PROD_PRICE) AS AMT
  FROM (SELECT A.MEM_ID AS MID,
               A.MEM_NAME AS MNAME,
               A.MEM_MILEAGE AS MIL,
               B.MAVG AS MAVG
          FROM MEMBER A, (SELECT AVG(MEM_MILEAGE) AS MAVG
                            FROM MEMBER
                           WHERE SUBSTR(MEM_REGNO2,1,1) IN('2','4')) B
         WHERE SUBSTR(A.MEM_REGNO2,1,1) IN('2','4')
               AND A.MEM_MILEAGE < B.MAVG) WOMEN,
       CART B, PROD C
 WHERE WOMEN.MID = B.CART_MEMBER
       AND SUBSTR(B.CART_NO,1,6) BETWEEN '200504' AND '200506'
       AND B.CART_PROD = C.PROD_ID
 GROUP BY WOMEN.MID, WOMEN.MNAME
 ORDER BY 1;

SELECT TBLA.MEM_ID AS "ȸ����ȣ",
       TBLA.MEM_NAME AS "ȸ����",
       SUM(B.CART_QTY * C.PROD_PRICE) AS "���űݾ� �հ�"
  FROM (SELECT C.MEM_ID,
               C.MEM_NAME,
               C.GEN,
               C.MEM_MILEAGE,
               ROUND(B.AMILE)
          FROM (SELECT A.GEN AS G1,
                       AVG(MEM_MILEAGE) AS AMILE
                  FROM (SELECT MEM_ID, MEM_NAME,
                               CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '��'
                                    WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '��'
                               END AS GEN,
                               MEM_MILEAGE
                          FROM MEMBER) A
                 GROUP BY A.GEN) B,
               (SELECT MEM_ID, MEM_NAME,
                       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '��'
                            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '��'
                       END AS GEN,
                       MEM_MILEAGE
                  FROM MEMBER) C
         WHERE C.GEN = B.G1
               AND C.MEM_MILEAGE >= B.AMILE
         ORDER BY 3, 4) TBLA,
       CART B, PROD C
 WHERE TBLA.MEM_ID = B.CART_MEMBER
       AND B.CART_PROD = C.PROD_ID
       AND SUBSTR(B.CART_NO,1,6) BETWEEN '200504' AND '200506'
 GROUP BY TBLA.MEM_ID, TBLA.MEM_NAME
 ORDER BY 1;
 
CREATE OR REPLACE VIEW V_MEM01 AS
          SELECT MEM_ID, MEM_NAME,
                       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '��'
                            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '��'
                       END AS GEN,
                       MEM_MILEAGE
                  FROM MEMBER;
                  
SELECT * FROM V_MEM01;

SELECT TBLA.MEM_ID AS "ȸ����ȣ",
       TBLA.MEM_NAME AS "ȸ����",
       SUM(B.CART_QTY * C.PROD_PRICE) AS "���űݾ� �հ�"
  FROM (SELECT C.MEM_ID,
               C.MEM_NAME,
               C.GEN,
               C.MEM_MILEAGE,
               ROUND(B.AMILE)
          FROM (SELECT A.GEN AS G1,
                       AVG(MEM_MILEAGE) AS AMILE
                  FROM V_MEM01 A
                 GROUP BY A.GEN) B,
               V_MEM01 C
         WHERE C.GEN = B.G1
               AND C.MEM_MILEAGE >= B.AMILE
         ORDER BY 3, 4) TBLA,
       CART B, PROD C
 WHERE TBLA.MEM_ID = B.CART_MEMBER
       AND B.CART_PROD = C.PROD_ID
       AND SUBSTR(B.CART_NO,1,6) BETWEEN '200504' AND '200506'
 GROUP BY TBLA.MEM_ID, TBLA.MEM_NAME
 ORDER BY 1;

SELECT TBLA.MEM_ID AS "ȸ����ȣ",
       TBLA.MEM_NAME AS "ȸ����",
       SUM(B.CART_QTY * C.PROD_PRICE) AS "���űݾ� �հ�"
  FROM (SELECT C.MEM_ID,
               C.MEM_NAME,
               C.GEN,
               C.MEM_MILEAGE,
               ROUND(B.AMILE)
          FROM (SELECT A.GEN AS G1,
                       AVG(MEM_MILEAGE) AS AMILE
                  FROM V_MEM01 A
                 GROUP BY A.GEN) B
         INNER JOIN V_MEM01 C ON(C.GEN = B.G1 
               AND C.MEM_MILEAGE >= B.AMILE)
         ORDER BY 3, 4) TBLA
 INNER JOIN CART B ON(TBLA.MEM_ID = B.CART_MEMBER
       AND SUBSTR(B.CART_NO,1,6) BETWEEN '200504' AND '200506')
 INNER JOIN PROD C ON(B.CART_PROD = C.PROD_ID)
 GROUP BY TBLA.MEM_ID, TBLA.MEM_NAME
 ORDER BY 1;

 
VIEW�� �׻� ������ �������Ἲ ���踦 �����Ѵ�(������ �ٲ�� �� ������ �����ϴ� ���� �����ʹ� �ڵ����� ������Ʈ�ȴ�)
VIEW�� �����ϰų� �����ϸ� ���� ���̺��� �����ǰų� �����ȴ�
->�̴� �츮�� ���ϴ� ����� �ƴϹǷ� WITH READ ONLY �� WITH CHECK ONLY���� ���� ���� �信���� ������ ������
���� ���̺��� ������ �������� ���ϵ��� ���� �� �� �ִ�.

�̹� ������� VIEW�� READ ONLY �ɼ��� �ο��� �� ����!!!

���տ��� : �������� UNION �������� INTERSECT �������� MINUS / �ǹ����� ������ ���� ����.

