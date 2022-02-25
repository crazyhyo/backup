2021-0722-01)

사용예)2005년 5월 회원별 판매액을 계산하고 상위 5명의 자료를 출력하시오
      ALIAS는 회원번호, 회원명, 구매금액합계
SELECT A.AID AS "회원번호",
       A.ANAME AS "회원명",
       A.AAMOUNT AS "구매금액합계"
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

SELECT A.AID AS "회원번호",
       A.ANAME AS "회원명",
       A.AAMOUNT AS "구매금액합계"
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

SELECT TBLA.CID AS 회원번호,
       TBLB.MEM_NAME AS 회원명,
       TBLA.AMT AS 구매금액합계
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

SELECT TBLA.CID AS 회원번호,
       TBLB.MEM_NAME AS 회원명,
       TBLA.AMT AS 구매금액합계
  FROM (SELECT A.CART_MEMBER AS CID,
               SUM(A.CART_QTY * B.PROD_PRICE) AS AMT
          FROM CART A
         INNER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
               AND A.CART_NO LIKE '200505%')
         GROUP BY A.CART_MEMBER
         ORDER BY 2 DESC) TBLA
 INNER JOIN MEMBER TBLB ON(TBLA.CID = TBLB.MEM_ID)
 WHERE ROWNUM <= 5;

사용예)회원의 마일리지를 조회하여 상위 20%에 속한 회원들이 2005년 4~6월 구매한 정보를 조회하시오
      ALIAS는 회원번호, 회원명, 상품명, 수량, 금액

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
    --다섯명의 회원 아이디가 저장된 커서를 CUR_MEM01로 이름붙임
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
             
        DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_ID);
        DBMS_OUTPUT.PUT_LINE('회원명 : '||V_NAME);
--        DBMS_OUTPUT.PUT_NAME('회원번호 : '||V_PNAME);
--        DBMS_OUTPUT.PUT_NAME('회원번호 : '||V_CNT)
        DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
/*
LOOP~END LOOP;는 DO의 역할을 함, 최소 한번의 실행을 담보함
FETCH 처음에 V_ID에 CUR_MEM01의 첫번째 것이 들어감
EXID WHEN CUR_MEM01%NOTFOUND; : 더이상 읽을 것이 없을 때 참이 되고 그 때 나감

커서변수:
NOTFOUND읽을 자료가 없으면 참 없으면 거짓
FOUND읽을 자료가 있으면 참 없으면 거짓
ISOPEN커서가 열려있으면 참 닫혀있으면 거짓
ROWCOUNT전체행의수

커서명%커서변수명<-반복을 제어할 때 사용하는 변수
커서의 사용 : 생성 -> 오픈 -> FETCH -> 클로즈
이것을 한번에 하는 방법 : FOR문으로 사용 - FOR문 안에서 생성만 하면 됨
*/
END;
  
DECLARE-BEGIN BLOCK : 변수, ?, 커서 / 선언부
V_ : 변수임
P_ : 파라미터임
레퍼런스 타입
내가 저장하려고 하는 것이 어느 테이블의 어느 컬럼 데이터인지는 알지만 정확한 그 타입은 모를 때
%TYPE은 참조타입으로 선언하면 해당 컬럼의 타입과 같은 데이터타입으로 선언된다.
참조타입으로 한 행을 똑같이 넣을 수도 있음

커서 : 원하는 자료를 참조하기 위해 보관하기 위한 공간?
커서의 본문은 SELECT문
BEGIN-END BLOCK : SELECT INTO FROM WHERE / 실행부

사용예)2005년 5월 매입합계
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       SUM(B.PROD_COST * C.BUY_QTY) AS "매입액합계"
  FROM PROD B, BUYPROD C
 WHERE B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'))
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "상품코드",
       SUM(B.PROD_COST * C.BUY_QTY) AS "매입액합계"
  FROM PROD B, BUYPROD C
 WHERE B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'))
 GROUP BY B.PROD_ID;

사용예)2005년 5월 매출합계
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "매출액합계"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "상품코드",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "매출액합계"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID;

사용예)2005년 5월 매입액과 매출액을 조회하시오
      ALIAS는 상품코드, 상품명, 매입액합계, 매출액합계

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       SUM(B.PROD_COST * C.BUY_QTY) AS "매입액합계",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "매출액합계"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
 GROUP BY B.PROD_ID, B.PROD_NAME;

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(B.PROD_COST * C.BUY_QTY),0) AS "매입액합계",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "매출액합계"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;

(일반조인 형식)
SELECT A.PROD_ID AS "상품코드",
       A.PROD_NAME AS "상품명",
       NVL(TBLA.BAMT,0) AS "매출액합계",
       NVL(TBLB.CAMT,0) AS "매입액합계"
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
       
ANSI JOIN에서 JOIN할 때 조인대상이 되는 컬럼의 종류를 기준으로 많고 적다를 구분한다.
예) 부서테이블에 있는 부서코드 28개(전체), 사원테이블에서 가지고 있는 부서코드개수 14개라면 더 큰 것은 부서테이블이다
(부서코드를 기준으로 조인할 때), 이때 많고 적음은 행(튜플)의 개수를 말하는 것이 아니다.

앞쪽에 기술된 것이 더 많다 : LEFT
뒤쪽에 기술된 것이 더 많다 : RIGHT
양 쪽 모두 부족한 것이 있다 : FULL
조인조건이 일반 조건과 함께 부여될 경우에는 OUTER/INNER JOIN의 ON절에서 조건을 적용해야 한다(WHERE절이면 목적과 다른 결과 출력)

  3. NON-EQUI JOIN
   - 조인조건문이 '=' 이외의 연산자가 사용된 경우
   - IN, ANY, SOME, ALL, EXISTS 등의 복수행 연산자 사용
   
사용예)사원테이블에서 사원들의 평균급여보다 더 많은 급여를 받는 사원의 사원번호, 사원명, 부서명, 급여, 평균급여를 출력하시오

SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       A.SALARY AS "급여",
       (SELECT ROUND(AVG(SALARY))
          FROM HR.EMPLOYEES) AS "평균급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.SALARY > (SELECT AVG(SALARY)
                         FROM HR.EMPLOYEES)
 ORDER BY 4;

--실행속도 관점에서는 사원 수만큼 SELECT절에서, WHERE절에서 서브쿼리가 실행됨, 매우 느림

SELECT A.EMPLOYEE_ID AS "사원번호",
       A.EMP_NAME AS "사원명",
       B.DEPARTMENT_NAME AS "부서명",
       A.SALARY AS "급여",
       C.ASAL AS "평균급여"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
       (SELECT ROUND(AVG(SALARY)) AS ASAL
          FROM HR.EMPLOYEES) C
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND A.SALARY > C.ASAL
 ORDER BY 4;

사용예)2005년 6월 가장 많은 금액을 구매한 고객의 주소지 이외의 주소지에 거주하는 회원의 회원번호, 회원명, 주소를 조회하시오.
SELECT B.MEM_ID AS "회원번호",
       B.MEM_NAME AS "회원명",
       B.MEM_ADD1 || ' ' || B.MEM_ADD2 AS "주소"
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
               


오라클은 TOP이 없다
오라클은 RANKOVER라는 함수를 제공해준다
VIEW는 가상의 테이블이다. FROM절의 뒤에는 테이블과 뷰가 올 수 있다.
서브쿼리에서 작성된 SELECT절은 VIEW로 취급된다.
이름이 없는 VIEW는 다음 VIEW가 나타나는 순간 없어짐.

서브쿼리는 무려 SELECT절, FROM절, WHERE절 모두에서 나타날 수 있다

예시>
사용예)  사원테이블에서 평균급여 이상 급여를 받는 사원을 조회하시오.
        Alias는 사원번호, 사원명, 급여, 부서번호
        
        SELECT      EMPLOYEE_ID     AS  사원번호,
                    FIRST_NAME      AS  사원명,
                    SALARY          AS  급여,
                    DEPARTMENT_ID   AS  부서번호,
                    ROUND((SELECT AVG(SALARY)
                    FROM    HR.EMPLOYEES),0)    AS  평균급여
        FROM        HR.EMPLOYEES
        WHERE       NOT SALARY  < (SELECT    AVG(SALARY)
                                  FROM  HR.EMPLOYEES);

SELECT문에 나오는 VIEW는 CURSOR라고 부름 / CURSOR와 JAVA의 ITERATOR는 거의 비슷함 / ITERATOR은 대상객체가 배열이나 컬렉션 프레임워크
프로그램에서 데이터를 저장하는 방법
LEVEL 1 변수, 한번에 하나만 저장할 수 있음
LEVEL 2 배열, 한번에 여러개를 저장할 수 있음 / 한계1. 크기를 늘이거나 줄일 수 없음 2. 같은 타입의 데이터만 저장 가능
LEVEL 3 구조체(STRUCTURE) 모든게 다 PUBLIC이라 접근제어를 사용할 수 없음 / BEHAVIOR를 가질 수 없음
LEVEL 4 클래스 접근제어와 BEHAIVIOR를 가짐 // 클래스도 변수임

ARRAY마개조
비주얼베이직 : 컴파일러에게 부담이 된다 = 실행속도가 느리다
자바 : 별도의 타입 제공 - 컬렉션 프레임워크, 객체를 받는다
리스트(링크드, 시퀀셜-벡터와 어레이리스트:박싱-언박싱), 셋, 맵
변수를 컬렉션 프레임워크에 넣는 방법 : 객체로 포장해서 넣는다 [포장을 하는 8가지 INTEGER, DOUBLE, LONG, FLOAT, BYTE, BOOLEAN, SHORT, CHAR)
요즘은 오토박싱, 오토언박싱 가능하도록 발전했음

익명 커서 : IMPLICIT 커서 / 화면에 출력될때 OPEN됨, 출력이 끝나면 자동으로 CLOSE됨
        이름이 없으니까 불러올 수 없음.

우리가 처리하는 쿼리는 대부분 한순간에 하나만 가져옴
한 순간에 하나의 집합이 필요하고 그 집합의 데이터 하나하나에 접근을 하고 싶다면 커서가 필요하다.

메서드를 끌고 오는 2가지 방법
1. 레지스터(13번, 14번 - 분기주소, 복귀주소)를 이용해서 호출되는 메서드의 주소로 갔다가 실행이 끝나고 명령어 바로 뒤로 돌아옴
        시간이 많이 
2. 짧은 메서드는 그 짧은 명령어를 그대로 가져다가 썼다가 바로 돌아옴?
인라인 