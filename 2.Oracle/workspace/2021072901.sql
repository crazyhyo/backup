2021-0729-01)등수계산(RANK 함수)
  - 성적, 급여, 매출 등의 순위를 구할때 사용
  - ORDER BY 절과 ROWNUM의 컬럼은 오라클의 WHERE절과 ORDER BY절의 실행 순서때문에 정확한 결과 반환이 불가능 함
  - 이를 해결하기 위해 RANK와 DENSE_RANK, ROW_NUMBER 함수 제공
  - RANK와 DENSE_RANK 함수의 차이점
   - RANK : 중복 순위가 발생하면 중복된 수 만큼 다음순위값을 증가      (EX 1,1,1,4,5,5,7,...)
   - DENSE_RANK : 중복 순위가 발생해도 다음 순위는 순차적인 값을 배정  (EX 1,1,1,2,3,3,4,...)
   - ROW_NUMBER : 중복에 관계없이 순차 순위값 배정                   (EX 1,2,3,4,5,6,7,...)
  - SELECT 절에서 사용
  (사용형식)
   SELECT 컬럼LIST
          RANK() OVER(ORDER BY 기준 컬럼명 DESC|ASC) AS 컬럼별칭
                :
     FROM 테이블명;            

오라클에서 수행되는 절들은 각각의 순서가 있기 때문에 사용자가 원하는 방법으로 제어할 수 없음
(EX ORDER BY 이후에 ROWNUM을 적용시키지 못함)

사용예)회원테이블에서 마일리지가 많은 회원부터 차례대로 순위(등수)를 부여하시오
      회원번호, 회원명, 마일리지, 등수
      
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_MILEAGE AS "마일리지",
       DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "등수"
  FROM MEMBER;
  
RANK함수의 OVER절에 들어가는 컬럼은 수식을 취할 수 있다.
하지만 서브쿼리는 취할 수 없다.
SELECT 절에서 부여한 컬럼별칭으로 접근할 수 없다.

사용예)회원테이블에서 마일리지가 많은 회원부터 차례대로 순위(등수)를 부여하고 상위 5명의
      회원번호, 회원명, 마일리지, 등수를 출력하시오
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_MILEAGE AS "마일리지",
       MRANK AS "등수"
  FROM (SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS MRANK
          FROM MEMBER)
--  WHERE MRANK <=5;
 WHERE ROWNUM <= 5;
 
SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,
       RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS MRANK
  FROM MEMBER
 WHERE ROWNUM <= 5;
 
SELECT A.MID AS 회원번호,
       B.MEM_NAME AS 회원명,
       B.MEM_MILEAGE AS 마일리지,
       A.MRK AS 등수
  FROM MEMBER B,
       (SELECT MEM_ID AS MID,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS MRK
          FROM MEMBER) A
 WHERE A.MID = B.MEM_ID
       AND A.MRK <= 5;
       
사용예)장바구니 테이블에서 2005년 5월 구매금액이 많은 회원부터 순위를 부여하여        
      회원번호, 회원명, 구매금액, 순위를 출력하시오
SELECT A.MEM_ID AS "회원번호",
       A.MEM_NAME AS "회원명",
       B.AMT AS "구매금액",
       RANK() OVER(ORDER BY AMT DESC) AS "순위"
  FROM MEMBER A,
       (SELECT B.MEM_ID AS MID,
               SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 2) B
 WHERE A.MEM_ID = B.MID;
 
SELECT B.MEM_ID AS "회원번호",
       B.MEM_NAME AS "회원명",
       SUM(A.CART_QTY * C.PROD_PRICE) AS "구매금액",
       RANK() OVER(ORDER BY SUM(A.CART_QTY * C.PROD_PRICE) DESC) AS "순위"
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.MEM_ID, B.MEM_NAME;
 
RANK의 내부의 ORDER BY가 해당 SELECT문을 정렬시켜준다.
RANK OVER(ORDER BY 컬럼명)에서 컬럼명에 집계함수가 있으면 이 컬럼은 GROUP BY 에 기술하지 않아도 된다(집계컬럼 취급된다)
만약 여기서의 컬럼명에 집계함수가 없었다면 일반컬럼으로 취급되어 GROUP BY절에 기술해야 한다.

SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_MILEAGE AS "마일리지",
--       RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "등수"
--       DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS "등수"
       ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC) AS "등수"       
  FROM MEMBER;


명수를 기준으로 할 때와 순위를 기준으로 할 때에 따라서 결과의 개수가 달라질 수 있다.
영업실적별로 상위 5개의 부서를 포상한다고 하면 DENSE_RANK()를 쓰는 것이 자연스럽다
상위 5명만 포상을 한다면 RANK를 써야 한다.
단, 1등이 6명이면 업무규칙에 따라서 처리하게 된다(명수를 기준으로 할 때)
ROW_NUMBER는 소팅해 놓고 행번호를 부여하는 방식
