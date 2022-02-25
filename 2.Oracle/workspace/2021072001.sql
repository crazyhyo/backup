2021-0720-01)
  3. MAX(column명), MIN(column명)
   - MAX : 주어진 컬럼명 중 최대 값을 반환
   - MIN : 주어진 컬럼명 중 최소 값을 반환
   - 집계함수는 다른 집계함수를 포함 할 수 없다.
   
사용예)2005년 월별 매입액 중 최대매입액, 최소매입액
      Alias는 월, 최대매입액, 최소매입액

    SELECT EXTRACT(MONTH FROM BUY_DATE) AS  "월",
           MAX(BUY_QTY * BUY_COST)      AS  "최대매입액",
           MIN(BUY_QTY * BUY_COST)      AS  "최소매입액"
      FROM BUYPROD
     WHERE EXTRACT(YEAR FROM BUY_DATE) = 2005
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
     ORDER BY 1;

기간은 일반조건으로 처리해주어야 한다, WHERE에서 다룸

사용예)2005년 5월 최대구매 고객정보를 조회하시오.
      Alias는 회원번호, 회원명, 구매금액

    SELECT B.MEM_ID             AS  "회원번호",
           B.MEM_NAME           AS  "회원명",
           SUM(A.CART_QTY * C.PROD_PRICE)   AS  "구매금액"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,6) = '200505'
     GROUP BY B.MEM_ID, B.MEM_NAME;
     ORDER BY 3 DESC;

최대구매금액을 가지는 회원만 가져오는 것은 지금은 서브쿼리 없이는 불가함
    
    (SUBQUERY)
SELECT  A.MID               AS  "회원번호",
        A.MNAME             AS  "회원명",
        A.AMT               AS  "구매금액"
  FROM  (SELECT B.MEM_ID             AS  MID,
               B.MEM_NAME           AS  MNAME,
               SUM(A.CART_QTY * C.PROD_PRICE)   AS  AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
 WHERE ROWNUM = 1;         

SELECT  D.MID               AS  "회원번호",
        D.MNAME             AS  "회원명",
        E.MEM_ADD1 ||' ' || E.MEM_ADD2               AS  "주소",
        E.MEM_HP AS "연락처",
        D.AMT               AS  "구매금액"
  FROM  (SELECT B.MEM_ID             AS  MID,
               B.MEM_NAME           AS  MNAME,
               SUM(A.CART_QTY * C.PROD_PRICE)   AS  AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) D, MEMBER E
 WHERE D.MID = E.MEM_ID
       AND ROWNUM = 1;
         
직선을 사용할 때는 식별자관계이고 점선을 사용할 때는 비식별자 관계이다
부모없이 태어나는 엔터티를 키엔터티 혹은 DB모델러들은 앤코아가 잘나간다
게시글번호 그날의 차례대로 숫자부여하게 특수문자 없는 숫자로만 구성된 문자열로 설정하고 MAX + 1로 업데이트해라(시퀀스로도 해결가능 니 능력이 된다면)
특정 행위에 종속된 엔터티 : 액션 엔터티, 부모 엔터티에 종속됨
데이터베이스는 1촌만 안다
서브쿼리의 테이블 별칭과 바깥쪽의 테이블 별칭은 겹쳐도 상관없다.

커서라는 것을 쓰면 됨 PL/SQL에서 사용

ROWNUM과 정렬 이용해서 하나만 뽑아내는거 괜찮긴 하네

