1. 남녀 성별 인원수 조회
2. 지금까지 한번도 상품을 구매한 적이 없는 회원의 인적사항 조회(아이디, 이름, 이메일)
3. 등록된 상품이 한건도 없는 상품분류 조회(상품분류코드, 분류명)
4. 지금까지 가장 많이 팔린 상품 조회(상품코드, 상품명, 상품분류명, 거래처명, 마일리지)
5.   지금까지 가장 적게 팔린 상품 조회(상품코드, 상품명, 상품분류명, 거래처명, 마일리지)
6. 거래처 중 거래 품목 수가 가장 많은 거래처 조회(거래처코드, 거래처명, 거래처분류명, 담당자명)
7.   거래처 중 거래 품목 수가 가장 적은 거래처 조회(거래처코드, 거래처명, 거래처분류명, 담당자명)
8. 남녀 성별 각각 구매율이 높은 상품 조회(성별, 상품코드, 상품명, 분류명)
9. 각 회원별 구매 총액 조회(회원아이디, 회원명, 구매총액)
10. 각 상품별 구매왕 조회(구매왕아이디, 회원명, 구매총액)


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

1. 남녀 성별 인원수 조회
SOL_1
SELECT      *
FROM        (SELECT     
                        COUNT(*)    AS  "남자회원수"
            FROM        MEMBER
            WHERE       SUBSTR(MEM_REGNO2,1,1) IN('1','3')) A,
            (SELECT     
                        COUNT(*)    AS  "여자회원수"
            FROM        MEMBER
            WHERE       SUBSTR(MEM_REGNO2,1,1) IN('2','4')) B;

2. 지금까지 한번도 상품을 구매한 적이 없는 회원의 인적사항 조회(아이디, 이름, 이메일)
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

3. 등록된 상품이 한건도 없는 상품분류 조회(상품분류코드, 분류명)

4. 지금까지 가장 많이 팔린 상품 조회(상품코드, 상품명, 상품분류명, 거래처명, 마일리지)
--SELECT      B.PROD_ID                                   AS  상품코드,
--            B.PROD_NAME                                 AS  상품명,
--            C.LPROD_NM                                  AS  상품분류명,
--            D.BUYER_NAME                                AS  거래처명,
--            B.PROD_MILEAGE                              AS  마일리지
--FROM        CART A, PROD B,
--            LPROD C, BUYER D
--WHERE       A.CART_PROD = B.PROD_ID
--            AND     B.PROD_LGU = C.LPROD_GU
--            AND     B.PROD_BUYER = D.BUYER_ID
--GROUP BY    
--HAVING      ;
--
--
--Q 가장 많이 팔린 상품은 어떻게 뽑아내지?
--서브쿼리 작성해야 하나
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

SELECT      DISTINCT B.PROD_ID                                           AS  상품코드,
            B.PROD_NAME                                         AS  상품명,
            C.LPROD_NM                                          AS  상품분류명,
            D.BUYER_NAME                                        AS  거래처명,
            B.PROD_MILEAGE                                      AS  마일리지
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

5.   지금까지 가장 적게 팔린 상품 조회(상품코드, 상품명, 상품분류명, 거래처명, 마일리지)
SELECT      DISTINCT B.PROD_ID                                           AS  상품코드,
            B.PROD_NAME                                         AS  상품명,
            C.LPROD_NM                                          AS  상품분류명,
            D.BUYER_NAME                                        AS  거래처명,
            B.PROD_MILEAGE                                      AS  마일리지
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


6. 거래처 중 거래 품목 수가 가장 많은 거래처 조회(거래처코드, 거래처명, 거래처분류명, 담당자명)

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
<- HAVING절 이용!

-- 아 테이블에 명칭부여하고 싶다
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

SELECT      B.BUYER_ID                                                                                  AS  거래처코드,
            B.BUYER_NAME                                                                                AS  거래처명,
            B.BUYER_LGU                                                                                 AS 거래처분류명,
            B.BUYER_BANKNAME                                                                            AS  담당자명
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

7. 거래처 중 거래 품목 수가 가장 적은 거래처 조회(거래처코드, 거래처명, 거래처분류명, 담당자명)

SELECT      B.BUYER_ID                                                                                  AS  거래처코드,
            B.BUYER_NAME                                                                                AS  거래처명,
            B.BUYER_LGU                                                                                 AS 거래처분류명,
            B.BUYER_BANKNAME                                                                            AS  담당자명
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


8. 남녀 성별 각각 구매율이 높은 상품 조회(성별, 상품코드, 상품명, 분류명)           ?


9. 각 회원별 구매 총액 조회(회원아이디, 회원명, 구매총액)

SELECT      B.MEM_ID                        AS  회원아이디,
            B.MEM_NAME                      AS  회원명,
            SUM(A.CART_QTY * C.PROD_PRICE)  AS  구매총액
FROM        CART A, MEMBER B, PROD C
WHERE       A.CART_MEMBER = B.MEM_ID
            AND     A.CART_PROD = C.PROD_ID
GROUP BY    B.MEM_ID, B.MEM_NAME;

10. 각 상품별 구매왕 조회(구매왕아이디, 회원명, 구매총액)

SELECT      C.PROD_NAME                     AS  상품명,
            B.MEM_ID                        AS  구매왕아이디,
            B.MEM_NAME                      AS  회원명,
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
            
--각 상품별 구매왕을 구해보자
SELECT      C.PROD_NAME                         AS  상품명,
            MAX(A.CART_QTY)                     AS  최대구매량
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

SELECT      A.PRODNAME                  AS  상품명,
            A.CARTMEMBER                AS  구매왕아이디,
            B.MEM_NAME                  AS  회원명,
            A.CARTQTY * C.PROD_PRICE    AS  구매총액
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
