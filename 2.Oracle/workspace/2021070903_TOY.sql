 ALTER TABLE CART    RENAME    COLUMN CART_PROD   TO  PROD_ID;
 
 
 
SELECT     A.PID       AS  ��ǰ�ڵ�,
            A.PNAME     AS  ��ǰ��,
            LPROD_GU    AS  �з��ڵ�,
            LPROD_NM    AS  �з���,
            A.QANT      AS  �Ǹż���
            --A.MANT      AS  �ݾ�
FROM        LPROD, (    SELECT      PROD_ID                     AS  PID,
                                    PROD_NAME                     AS  PNAME,
                                    SUM(CART_QTY)                 AS  QANT
                                    --SUM(CART_QTY * PROD_PRICE)    AS  MANT
                        FROM        CART , PROD 
                        WHERE       CART_PROD = PROD_ID
                                    AND CART_NO LIKE '200505%'
                                    AND PROD_LGU BETWEEN 'P200' AND 'P299'
                        GROUP BY    PROD_ID, PROD_NAME)   A,
            PROD
WHERE       PROD_ID = PID
            AND PROD_LGU=LPROD_GU
ORDER BY    1;

SELECT                  A.PROD_ID                     AS  PID,
                        PROD_NAME                     AS  PNAME,
                        SUM(CART_QTY)                 AS  QANT,
                        SUM(CART_QTY * PROD_PRICE)    AS  MANT
            FROM        CART A, PROD B
            WHERE       A.PROD_ID = B.PROD_ID
                        AND CART_NO LIKE '200505%'
                        AND PROD_LGU BETWEEN 'P200' AND 'P299'
            GROUP BY    A.PROD_ID, PROD_NAME;
            
SELECT      PROD_ID                       AS  PID,
            PROD_NAME                     AS  PNAME,
            SUM(CART_QTY)                 AS  QANT,
            SUM(CART_QTY * PROD_PRICE)    AS  MANT
FROM        CART , PROD 
WHERE       CART_PROD = PROD_ID
            AND CART_NO LIKE '200505%'
            AND PROD_LGU BETWEEN 'P200' AND 'P299'
GROUP BY    PROD_ID, PROD_NAME;

SELECT      PROD_ID                       AS  PID,
            PROD_NAME                     AS  PNAME,
            SUM(CART_QTY)                 AS  QANT
            SUM(CART_QTY * PROD_PRICE)    AS  MANT
FROM        CART , PROD 
WHERE       CART_PROD = PROD_ID
            AND CART_NO LIKE '200505%'
            AND PROD_LGU BETWEEN 'P200' AND 'P299'
GROUP BY    CART_ID, PROD_NAME;

ALTER TABLE CART    MODIFY(CART_NO    CHAR(1000 CHAR));

SELECT      PROD_ID                      AS  PID,
            PROD_NAME                     AS  PNAME,
--                PROD_PRICE,
            SUM(CART_QTY)                 AS  QANT,
            SUM(CART_QTY * PROD_PRICE)    AS  MANT
FROM        CART , PROD 
WHERE       CART_PROD = PROD_ID
            AND CART_NO LIKE '200505%'
            AND PROD_LGU BETWEEN 'P200' AND 'P299'
GROUP BY    PROD_ID, PROD_NAME;