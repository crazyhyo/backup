1. ���� ���� �ο��� ��ȸ
2. ���ݱ��� �ѹ��� ��ǰ�� ������ ���� ���� ȸ���� �������� ��ȸ(���̵�, �̸�, �̸���)
3. ��ϵ� ��ǰ�� �Ѱǵ� ���� ��ǰ�з� ��ȸ(��ǰ�з��ڵ�, �з���)
4. ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
5.   ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
6. �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)
7.   �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)
8. ���� ���� ���� �������� ���� ��ǰ ��ȸ(����, ��ǰ�ڵ�, ��ǰ��, �з���)
9. �� ȸ���� ���� �Ѿ� ��ȸ(ȸ�����̵�, ȸ����, �����Ѿ�)
10. �� ��ǰ�� ���ſ� ��ȸ(���ſվ��̵�, ȸ����, �����Ѿ�)


       UPDATE   MEMBER
       SET      MEM_REGNO1 = '010409',
                MEM_REGNO2 = '4000000',
                MEM_BIR = TO_DATE('20010409')
       WHERE    MEM_ID = 'd001';
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '000323',
                MEM_REGNO2 = '3011014',
                MEM_BIR = TO_DATE('20000323')
       WHERE    MEM_ID = 'n001';
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '020131',
                MEM_REGNO2 = '4402712',
                MEM_BIR = TO_DATE('20020131')
       WHERE    MEM_ID = 'v001';

1. ���� ���� �ο��� ��ȸ
SOL_1
SELECT      *
FROM        (SELECT     
                        COUNT(*)    AS  "����ȸ����"
            FROM        MEMBER
            WHERE       SUBSTR(MEM_REGNO2,1,1) IN('1','3')) A,
            (SELECT     
                        COUNT(*)    AS  "����ȸ����"
            FROM        MEMBER
            WHERE       SUBSTR(MEM_REGNO2,1,1) IN('2','4')) B;

2. ���ݱ��� �ѹ��� ��ǰ�� ������ ���� ���� ȸ���� �������� ��ȸ(���̵�, �̸�, �̸���)
SOL_2
SELECT      A.CART_MEMBER
FROM        CART A, MEMBER B
WHERE       A.CART_MEMBER = B.MEM_ID
GROUP BY    A.CART_MEMBER;

SELECT      CART_MEMBER
FROM        CART
GROUP BY    CART_MEMBER;

SELECT      B.MEM_ID
FROM        (SELECT      CART_MEMBER
            FROM        CART
            GROUP BY    CART_MEMBER) A, MEMBER B
WHERE       NOT B.MEM_ID IN(A.CART_MEMBER)
ORDER BY    1;

SELECT      A.CART_MEMBER
FROM        CART A, MEMBER B
WHERE       A.CART_MEMBER = B.MEM_ID
GROUP BY    A.CART_MEMBER;
--HAVING      NOT B.MEM_ID IN(A.CART_MEMBER);

3. ��ϵ� ��ǰ�� �Ѱǵ� ���� ��ǰ�з� ��ȸ(��ǰ�з��ڵ�, �з���)

4. ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
--SELECT      B.PROD_ID                                   AS  ��ǰ�ڵ�,
--            B.PROD_NAME                                 AS  ��ǰ��,
--            C.LPROD_NM                                  AS  ��ǰ�з���,
--            D.BUYER_NAME                                AS  �ŷ�ó��,
--            B.PROD_MILEAGE                              AS  ���ϸ���
--FROM        CART A, PROD B,
--            LPROD C, BUYER D
--WHERE       A.CART_PROD = B.PROD_ID
--            AND     B.PROD_LGU = C.LPROD_GU
--            AND     B.PROD_BUYER = D.BUYER_ID
--GROUP BY    
--HAVING      ;
--
--
--Q ���� ���� �ȸ� ��ǰ�� ��� �̾Ƴ���?
--�������� �ۼ��ؾ� �ϳ�
--
--SELECT      MAX(A.QTY1),
--            A.PROD1
--FROM        (SELECT      CART_PROD      AS  PROD1,
--                        SUM(CART_QTY)   AS  QTY1
--            FROM        CART
--            GROUP BY    CART_PROD
--            ORDER BY    1) A,
--            (SELECT      CART_PROD      AS  PROD2,
--                        SUM(CART_QTY)   AS  QTY2
--            FROM        CART
--            GROUP BY    CART_PROD
--            ORDER BY    1) B
--WHERE       A.PROD1 = B.PROD2
--GROUP BY    A.PROD1;
--
--SELECT      MAX(A.QTY)
--FROM        (SELECT      CART_PROD      AS  PROD,
--                        SUM(CART_QTY)   AS  QTY
--            FROM        CART
--            GROUP BY    CART_PROD
--            ORDER BY    1) A
--            
--SELECT      CART_PROD      AS  PROD,
--            SUM(CART_QTY)   AS  QTY
--FROM        CART
--GROUP BY    CART_PROD;            
--
--SELECT      A.PROD,
--            A.QTY
--FROM        (SELECT      CART_PROD      AS  PROD,
--                        SUM(CART_QTY)   AS  QTY
--            FROM        CART
--            GROUP BY    CART_PROD)      A,
--            (SELECT      MAX(B.QTY)                 AS  MQTY
--            FROM        (SELECT      CART_PROD      AS  PROD,
--                                    SUM(CART_QTY)   AS  QTY
--                        FROM        CART
--                        GROUP BY    CART_PROD)      B)          C
--WHERE       A.QTY = C.MQTY;
--                        
--
--
--SELECT      *
--FROM        (SELECT      A.PROD                                 AS  MPROD,
--                         A.QTY                                  AS  MPROD_QTY
--            FROM        (SELECT      CART_PROD                  AS  PROD,
--                                    SUM(CART_QTY)               AS  QTY
--                        FROM        CART
--                        GROUP BY    CART_PROD)
--                        A,
--                        (SELECT      MAX(B.QTY)                 AS  MQTY
--                        FROM        (SELECT      CART_PROD      AS  PROD,
--                                                SUM(CART_QTY)   AS  QTY
--                                    FROM        CART
--                                    GROUP BY    CART_PROD)
--                                    B)
--                        C
--            WHERE       A.QTY = C.MQTY)
--            D;

SELECT      DISTINCT B.PROD_ID                                           AS  ��ǰ�ڵ�,
            B.PROD_NAME                                         AS  ��ǰ��,
            C.LPROD_NM                                          AS  ��ǰ�з���,
            D.BUYER_NAME                                        AS  �ŷ�ó��,
            B.PROD_MILEAGE                                      AS  ���ϸ���
FROM        CART A, PROD B,
            LPROD C, BUYER D,
            (SELECT      A.PROD                                 AS  MPROD,
                         A.QTY                                  AS  MPROD_QTY
            FROM        (SELECT      CART_PROD                  AS  PROD,
                                    SUM(CART_QTY)               AS  QTY
                        FROM        CART
                        GROUP BY    CART_PROD)
                        A,
                        (SELECT      MAX(B.QTY)                 AS  MQTY
                        FROM        (SELECT      CART_PROD      AS  PROD,
                                                SUM(CART_QTY)   AS  QTY
                                    FROM        CART
                                    GROUP BY    CART_PROD)
                                    B)
                        C
            WHERE       A.QTY = C.MQTY)
            E
WHERE       A.CART_PROD = B.PROD_ID
            AND     B.PROD_LGU = C.LPROD_GU
            AND     B.PROD_BUYER = D.BUYER_ID
            AND     E.MPROD = A.CART_PROD
            AND     E.MPROD = B.PROD_ID;
--GROUP BY    B.PROD_ID, B.PROD_NAME, C.LPROD_NM, D.BUYER_NAME, B.PROD_MILEAGE;

5.   ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
SELECT      DISTINCT B.PROD_ID                                           AS  ��ǰ�ڵ�,
            B.PROD_NAME                                         AS  ��ǰ��,
            C.LPROD_NM                                          AS  ��ǰ�з���,
            D.BUYER_NAME                                        AS  �ŷ�ó��,
            B.PROD_MILEAGE                                      AS  ���ϸ���
FROM        CART A, PROD B,
            LPROD C, BUYER D,
            (SELECT      A.PROD                                 AS  MPROD,
                         A.QTY                                  AS  MPROD_QTY
            FROM        (SELECT      CART_PROD                  AS  PROD,
                                    SUM(CART_QTY)               AS  QTY
                        FROM        CART
                        GROUP BY    CART_PROD)
                        A,
                        (SELECT      MIN(B.QTY)                 AS  MQTY
                        FROM        (SELECT      CART_PROD      AS  PROD,
                                                SUM(CART_QTY)   AS  QTY
                                    FROM        CART
                                    GROUP BY    CART_PROD)
                                    B)
                        C
            WHERE       A.QTY = C.MQTY)
            E
WHERE       A.CART_PROD = B.PROD_ID
            AND     B.PROD_LGU = C.LPROD_GU
            AND     B.PROD_BUYER = D.BUYER_ID
            AND     E.MPROD = A.CART_PROD
            AND     E.MPROD = B.PROD_ID;
            
SELECT      CART_PROD      AS  PROD,
            SUM(CART_QTY)   AS  QTY
FROM        CART
GROUP BY    CART_PROD
ORDER BY    2;


6. �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)

--SELECT      C.BUYER_ID,
--            B.PROD_ID
--FROM        BUYPROD A, PROD B, BUYER C
--WHERE       A.BUY_PROD = B.PROD_ID
--            AND     B.PROD_BUYER = C.BUYER_ID
--GROUP BY    C.BUYER_ID, B.PROD_ID
--ORDER BY    B.PROD_ID; 
--
SELECT      A.BUYERID                                               AS  BUYERID,
            COUNT(A.PRODID)                                         AS  KIND_OF_PROD
FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                        B.PROD_ID                                   AS  PRODID
            FROM        BUYPROD A, PROD B, BUYER C
            WHERE       A.BUY_PROD = B.PROD_ID
                        AND     B.PROD_BUYER = C.BUYER_ID
            GROUP BY    C.BUYER_ID, B.PROD_ID
            ORDER BY    B.PROD_ID)
            A
GROUP BY    A.BUYERID
HAVING      COUNT(A.PRODID) = (SELECT      MAX(A.KIND_OF_PROD)                                                 AS  MAXKIND
                                FROM        (SELECT      A.BUYERID                                              AS  BUYERID,
                                                        COUNT(A.PRODID)                                         AS  KIND_OF_PROD
                                            FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                                                                    B.PROD_ID                                   AS  PRODID
                                                        FROM        BUYPROD A, PROD B, BUYER C
                                                        WHERE       A.BUY_PROD = B.PROD_ID
                                                                    AND     B.PROD_BUYER = C.BUYER_ID
                                                        GROUP BY    C.BUYER_ID, B.PROD_ID
                                                        ORDER BY    B.PROD_ID)
                                                        A
                                            GROUP BY    A.BUYERID)
                                            A
                                );
<- HAVING�� �̿�!

-- �� ���̺� ��Ī�ο��ϰ� �ʹ�
--
----SELECT      A.BUYERID                                                           AS  BUYERID,
SELECT      MAX(A.KIND_OF_PROD)                                                 AS  MAXKIND
FROM        (SELECT      A.BUYERID                                              AS  BUYERID,
                        COUNT(A.PRODID)                                         AS  KIND_OF_PROD
            FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                                    B.PROD_ID                                   AS  PRODID
                        FROM        BUYPROD A, PROD B, BUYER C
                        WHERE       A.BUY_PROD = B.PROD_ID
                                    AND     B.PROD_BUYER = C.BUYER_ID
                        GROUP BY    C.BUYER_ID, B.PROD_ID
                        ORDER BY    B.PROD_ID)
                        A
            GROUP BY    A.BUYERID)
            A;
--A
--
--SELECT      B.BUYERID                                                                  AS  BUYERID
--FROM        (SELECT      MAX(A.KIND_OF_PROD)                                                AS  MAXKIND
--            FROM        (SELECT      A.BUYERID                                              AS  BUYERID,
--                                    COUNT(A.PRODID)                                         AS  KIND_OF_PROD
--                        FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
--                                                B.PROD_ID                                   AS  PRODID
--                                    FROM        BUYPROD A, PROD B, BUYER C
--                                    WHERE       A.BUY_PROD = B.PROD_ID
--                                                AND     B.PROD_BUYER = C.BUYER_ID
--                                    GROUP BY    C.BUYER_ID, B.PROD_ID
--                                    ORDER BY    B.PROD_ID)
--                                    A
--                        GROUP BY    A.BUYERID)
--                        A)
--            A,
--            (SELECT      A.BUYERID                                               AS  BUYERID,
--                        COUNT(A.PRODID)                                         AS  KIND_OF_PROD
--            FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
--                                    B.PROD_ID                                   AS  PRODID
--                        FROM        BUYPROD A, PROD B, BUYER C
--                        WHERE       A.BUY_PROD = B.PROD_ID
--                                    AND     B.PROD_BUYER = C.BUYER_ID
--                        GROUP BY    C.BUYER_ID, B.PROD_ID
--                        ORDER BY    B.PROD_ID)
--                        A
--            GROUP BY    A.BUYERID)
--            B
--WHERE       A.MAXKIND = B.KIND_OF_PROD;

SELECT      B.BUYER_ID                                                                                  AS  �ŷ�ó�ڵ�,
            B.BUYER_NAME                                                                                AS  �ŷ�ó��,
            B.BUYER_LGU                                                                                 AS �ŷ�ó�з���,
            B.BUYER_BANKNAME                                                                            AS  ����ڸ�
FROM        (SELECT      B.BUYERID                                                                      AS  BUYERID
            FROM        (SELECT      MAX(A.KIND_OF_PROD)                                                AS  MAXKIND
                        FROM        (SELECT      A.BUYERID                                              AS  BUYERID,
                                                COUNT(A.PRODID)                                         AS  KIND_OF_PROD
                                    FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                                                            B.PROD_ID                                   AS  PRODID
                                                FROM        BUYPROD A, PROD B, BUYER C
                                                WHERE       A.BUY_PROD = B.PROD_ID
                                                            AND     B.PROD_BUYER = C.BUYER_ID
                                                GROUP BY    C.BUYER_ID, B.PROD_ID
                                                ORDER BY    B.PROD_ID)
                                                A
                                    GROUP BY    A.BUYERID)
                                    A)
                        A,
                        (SELECT      A.BUYERID                                              AS  BUYERID,
                                    COUNT(A.PRODID)                                         AS  KIND_OF_PROD
                        FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                                                B.PROD_ID                                   AS  PRODID
                                    FROM        BUYPROD A, PROD B, BUYER C
                                    WHERE       A.BUY_PROD = B.PROD_ID
                                                AND     B.PROD_BUYER = C.BUYER_ID
                                    GROUP BY    C.BUYER_ID, B.PROD_ID
                                    ORDER BY    B.PROD_ID)
                                    A
                        GROUP BY    A.BUYERID)
                        B
            WHERE       A.MAXKIND = B.KIND_OF_PROD)
            A,
            BUYER B
WHERE       A.BUYERID =  B.BUYER_ID;

7. �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)

SELECT      B.BUYER_ID                                                                                  AS  �ŷ�ó�ڵ�,
            B.BUYER_NAME                                                                                AS  �ŷ�ó��,
            B.BUYER_LGU                                                                                 AS �ŷ�ó�з���,
            B.BUYER_BANKNAME                                                                            AS  ����ڸ�
FROM        (SELECT      B.BUYERID                                                                      AS  BUYERID
            FROM        (SELECT      MIN(A.KIND_OF_PROD)                                                AS  MINKIND
                        FROM        (SELECT      A.BUYERID                                              AS  BUYERID,
                                                COUNT(A.PRODID)                                         AS  KIND_OF_PROD
                                    FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                                                            B.PROD_ID                                   AS  PRODID
                                                FROM        BUYPROD A, PROD B, BUYER C
                                                WHERE       A.BUY_PROD = B.PROD_ID
                                                            AND     B.PROD_BUYER = C.BUYER_ID
                                                GROUP BY    C.BUYER_ID, B.PROD_ID
                                                ORDER BY    B.PROD_ID)
                                                A
                                    GROUP BY    A.BUYERID)
                                    A)
                        A,
                        (SELECT      A.BUYERID                                              AS  BUYERID,
                                    COUNT(A.PRODID)                                         AS  KIND_OF_PROD
                        FROM        (SELECT      C.BUYER_ID                                 AS  BUYERID,
                                                B.PROD_ID                                   AS  PRODID
                                    FROM        BUYPROD A, PROD B, BUYER C
                                    WHERE       A.BUY_PROD = B.PROD_ID
                                                AND     B.PROD_BUYER = C.BUYER_ID
                                    GROUP BY    C.BUYER_ID, B.PROD_ID
                                    ORDER BY    B.PROD_ID)
                                    A
                        GROUP BY    A.BUYERID)
                        B
            WHERE       A.MINKIND = B.KIND_OF_PROD)
            A,
            BUYER B
WHERE       A.BUYERID =  B.BUYER_ID;


8. ���� ���� ���� �������� ���� ��ǰ ��ȸ(����, ��ǰ�ڵ�, ��ǰ��, �з���)           ?


9. �� ȸ���� ���� �Ѿ� ��ȸ(ȸ�����̵�, ȸ����, �����Ѿ�)

SELECT      B.MEM_ID                        AS  ȸ�����̵�,
            B.MEM_NAME                      AS  ȸ����,
            SUM(A.CART_QTY * C.PROD_PRICE)  AS  �����Ѿ�
FROM        CART A, MEMBER B, PROD C
WHERE       A.CART_MEMBER = B.MEM_ID
            AND     A.CART_PROD = C.PROD_ID
GROUP BY    B.MEM_ID, B.MEM_NAME;

10. �� ��ǰ�� ���ſ� ��ȸ(���ſվ��̵�, ȸ����, �����Ѿ�)

SELECT      C.PROD_NAME                     AS  ��ǰ��,
            B.MEM_ID                        AS  ���ſվ��̵�,
            B.MEM_NAME                      AS  ȸ����,
            SUM(A.CART_QTY)
FROM        CART A, MEMBER B, PROD C
WHERE       A.CART_MEMBER = B.MEM_ID
            AND     A.CART_PROD = C.PROD_ID
GROUP BY    C.PROD_NAME, B.MEM_ID, B.MEM_NAME
ORDER BY    1;


SELECT      *
FROM        CART A, MEMBER B, PROD C
WHERE       A.CART_MEMBER = B.MEM_ID
            AND     A.CART_PROD = C.PROD_ID;
            
--�� ��ǰ�� ���ſ��� ���غ���
SELECT      C.PROD_NAME                         AS  ��ǰ��,
            MAX(A.CART_QTY)                     AS  �ִ뱸�ŷ�
FROM        CART A, MEMBER B, PROD C
WHERE       A.CART_MEMBER = B.MEM_ID
            AND     A.CART_PROD = C.PROD_ID
GROUP BY    C.PROD_NAME
ORDER BY    1;

SELECT      DISTINCT A.PRODNAME,
            C.CART_MEMBER,
            C.CART_QTY,
            C.CART_PROD
FROM        (SELECT      C.PROD_NAME                         AS  PRODNAME,
                        C.PROD_ID                           AS  PRODID,
                        MAX(A.CART_QTY)                     AS  MAXQANT
            FROM        CART A, MEMBER B, PROD C
            WHERE       A.CART_MEMBER = B.MEM_ID
                        AND     A.CART_PROD = C.PROD_ID
            GROUP BY    C.PROD_NAME, C.PROD_ID)
            A,  CART C
WHERE       A.MAXQANT = C.CART_QTY
            AND     A.PRODID = C.CART_PROD
ORDER BY    A.PRODNAME;          

SELECT      A.PRODNAME                  AS  ��ǰ��,
            A.CARTMEMBER                AS  ���ſվ��̵�,
            B.MEM_NAME                  AS  ȸ����,
            A.CARTQTY * C.PROD_PRICE    AS  �����Ѿ�
FROM        (SELECT      DISTINCT A.PRODNAME                            AS  PRODNAME,
                        C.CART_MEMBER                                   AS  CARTMEMBER,
                        C.CART_QTY                                      AS  CARTQTY,
                        C.CART_PROD                                     AS  PRODID
            FROM        (SELECT      C.PROD_NAME                         AS  PRODNAME,
                                    C.PROD_ID                           AS  PRODID,
                                    MAX(A.CART_QTY)                     AS  MAXQANT
                        FROM        CART A, MEMBER B, PROD C
                        WHERE       A.CART_MEMBER = B.MEM_ID
                                    AND     A.CART_PROD = C.PROD_ID
                        GROUP BY    C.PROD_NAME, C.PROD_ID)
                        A,  CART C
            WHERE       A.MAXQANT = C.CART_QTY
                        AND     A.PRODID = C.CART_PROD
            ORDER BY    A.PRODNAME)
            A, MEMBER B, PROD C
WHERE       A.CARTMEMBER = B.MEM_ID
            AND     A.PRODID = C.PROD_ID;
