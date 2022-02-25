2021-0727-02)
사용예)회원테이블에서 평균마일리지보다 많은 마일리지를 보유한 회원의 회원번호, 회원명, 마일리지를 출력하시오
SELECT B.MEM_ID AS "회원번호",
       B.MEM_NAME AS "회원명",
       B.MEM_MILEAGE AS "마일리지",
       ROUND(A.MIL) AS "평균마일리지"
  FROM (SELECT AVG(MEM_MILEAGE) AS MIL
          FROM MEMBER) A, MEMBER B
 WHERE B.MEM_MILEAGE > A.MIL
 
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_MILEAGE AS "마일리지",
       (SELECT ROUND(AVG(MEM_MILEAGE))
          FROM MEMBER) AS "평균마일리지"
  FROM MEMBER
 WHERE MEM_MILEAGE > (SELECT AVG(MEM_MILEAGE) AS MIL
                        FROM MEMBER)

SELECT 절의 서브쿼리 실행수 : WHERE절에서 조건이 참인 행의 개수
WHERE절의 서브쿼리 실행 수 : 참조 테이블별 행의 수의 곱만큼 실행
FROM절의 서브쿼리 실행 수 : 한번 실행 후 메인쿼리의 실행기간동안 뷰로 생존

사용예)회원들의 자료에서 성별 평균마일리지를 구하고 자신의 성별 평균마일리지보다 적은 마일리지를 보유한 회원의
      2005년 4~6월 구매현황을 조회하시오.
      ALIAS회원번호, 회원명, 구매금액합계
1)회원들의 자료에서 성별 평균 마일리지를 구하고 성별 평균마일리지보다 적은 마일리지를 보유한 회원정보
메인쿼리 : 회원테이블에서 (서브쿼리)조건을 만족하는 회원정보 출력      

SELECT MEM_ID, MEM_NAME
  FROM MEMBER
 WHERE MEM_MILEAGE < (서브쿼리)

서브쿼리 : 성별 평균 마일리지
SELECT TBLA.AMILE
  FROM (SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN
                         '남성회원'
               ELSE      '여성회원' END,
               SUBSTR(MEM_REGNO2,1,1) AS GEN,
               AVG(MEM_MILEAGE) AS AMILE
          FROM MEMBER
         GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN
                            '남성회원'
                  ELSE      '여성회원' END) TBLA.AMILE, MEMBER B
 WHERE B.MEM_REGNO2 LIKE TBLA.GEN || '%'
2)2005년 4~6월 구매현황

SELECT TBLA.MID AS "회원번호",
       TBLA.MNAME AS "회원명",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "구매금액 합계"
  FROM (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNAME,
               A.AVGMIL AS AAVG,
               B.MEM_MILEAGE AS BMIL
          FROM (SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남자'
                            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여자'
                       END AS GENDER,
                       ROUND(AVG(MEM_MILEAGE)) AS AVGMIL
                  FROM MEMBER
                 GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남자'
                               WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여자'
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

SELECT TBLA.MEM_ID AS "회원번호",
       TBLA.MEM_NAME AS "회원명",
       SUM(B.CART_QTY * C.PROD_PRICE) AS "구매금액 합계"
  FROM (SELECT C.MEM_ID,
               C.MEM_NAME,
               C.GEN,
               C.MEM_MILEAGE,
               ROUND(B.AMILE)
          FROM (SELECT A.GEN AS G1,
                       AVG(MEM_MILEAGE) AS AMILE
                  FROM (SELECT MEM_ID, MEM_NAME,
                               CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남'
                                    WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여'
                               END AS GEN,
                               MEM_MILEAGE
                          FROM MEMBER) A
                 GROUP BY A.GEN) B,
               (SELECT MEM_ID, MEM_NAME,
                       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남'
                            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여'
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
                       CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남'
                            WHEN SUBSTR(MEM_REGNO2,1,1) IN('2','4') THEN '여'
                       END AS GEN,
                       MEM_MILEAGE
                  FROM MEMBER;
                  
SELECT * FROM V_MEM01;

SELECT TBLA.MEM_ID AS "회원번호",
       TBLA.MEM_NAME AS "회원명",
       SUM(B.CART_QTY * C.PROD_PRICE) AS "구매금액 합계"
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

SELECT TBLA.MEM_ID AS "회원번호",
       TBLA.MEM_NAME AS "회원명",
       SUM(B.CART_QTY * C.PROD_PRICE) AS "구매금액 합계"
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

 
VIEW는 항상 원본과 참조무결성 관계를 만족한다(원본이 바뀌면 그 원본을 참조하는 뷰의 데이터는 자동으로 업데이트된다)
VIEW를 수정하거나 삭제하면 원본 테이블이 수정되거나 삭제된다
->이는 우리가 원하는 결과가 아니므로 WITH READ ONLY 나 WITH CHECK ONLY등의 예약어를 통해 뷰에서의 데이터 변경이
원본 테이블의 변경을 가져오지 못하도록 설정 할 수 있다.

이미 만들어진 VIEW는 READ ONLY 옵션을 부여할 수 없다!!!

집합연산 : 합집합은 UNION 교집합은 INTERSECT 차집합은 MINUS / 실무에서 굉장히 많이 쓴다.

