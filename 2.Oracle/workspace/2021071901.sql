2021-0719-01)
  2. AVG(expr)
   - 'expr'로 정의된 컬럼이나 수식의 값에 대한 산술평균 값을 반환

사용예)모든 회원들의 평균 마일리지를 조회하시오

    SELECT ROUND(AVG(MEM_MILEAGE))     "평균 마일리지"
      FROM MEMBER;

사용예)모든 여성회원들의 평균 마일리지를 조회하시오

    SELECT ROUND(AVG(MEM_MILEAGE))     "여성 평균 마일리지"
      FROM MEMBER
     WHERE SUBSTR(MEM_REGNO2,1,1) IN('2', '4');

사용예)회원들의 성별 평균 마일리지를 조회하시오

    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '2'
                  OR SUBSTR(MEM_REGNO2,1,1) = '4' THEN '여성회원'
                ELSE
                     '남성회원' END AS     "구분",
           ROUND(AVG(MEM_MILEAGE))  AS  "평균마일리지"
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '2'
                  OR SUBSTR(MEM_REGNO2,1,1) = '4' THEN '여성회원'
                ELSE
                     '남성회원' END;
    
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('2', '4') THEN '여성회원'
                   ELSE
                     '남성회원' END AS     "구분",
           ROUND(AVG(MEM_MILEAGE))  AS  "평균마일리지"
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('2', '4') THEN '여성회원'
                   ELSE
                     '남성회원' END;

사용예)사원테이블에서 각 부서별 평균급여를 조회하시오.

    SELECT --0B.DEPARTMENT_ID          AS  "부서코드",
    --       B.DEPARTMENT_NAME        AS  "부서명",
           ROUND(AVG(A.SALARY))     AS  "평균급여"
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
     --GROUP BY B.DEPARTMENT_NAME, B.DEPARTMENT_ID
     
     SELECT *
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
     ORDER BY A.EMPLOYEE_ID;
     --GROUP BY B.DEPARTMENT_NAME, B.DEPARTMENT_ID
 
사용예)2005년 1~6월 월별 평균매입액을 조회하시오.

    SELECT EXTRACT(MONTH FROM BUY_DATE) || '월'                                 AS  "월",
           TO_CHAR(ROUND(AVG(BUY_COST * BUY_QTY)),'999,999,999L')        AS  "평균매입액"
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050601'))
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
     ORDER BY 1;

사용예)2005년 1~6월 월별 매입건수, 평균매입액과 매입액합을 조회하되 매입액이 400만원 이상인 월만 조회하시오.
    SELECT COUNT(*)                                                        AS  "매입건수",
           EXTRACT(MONTH FROM BUY_DATE) || '월'                                 AS  "월",
           TO_CHAR(ROUND(AVG(BUY_COST * BUY_QTY)),'999,999,999')         AS  "평균매입액",
           TO_CHAR(SUM(BUY_COST * BUY_QTY),'999,999,999')                AS "매입액 합계"
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050601'))
     GROUP BY EXTRACT(MONTH FROM BUY_DATE)
    HAVING AVG(BUY_COST * BUY_QTY) >= 4000000
     ORDER BY 1;
     
HAVING이 사용되는 경우 : 집계함수에 조건이 부여될 때 사용

사용예)2005년 회원별 평균매입금액을 조회하시오.

    SELECT  B.MEM_ID AS "회원번호",
            B.MEM_NAME  AS  "회원명",
            ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "평균매입금액"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY B.MEM_ID, B.MEM_NAME
     ORDER BY 1;
     
     SELECT  *
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID;
    --       AND SUBSTR(A.CART_NO,1,4) = '2005'
    -- GROUP BY B.MEM_ID, B.MEM_NAME;
 

사용예)2005년 회원별 구매건수을 조회하시오.
    SELECT  B.MEM_ID AS "회원번호",
            B.MEM_NAME  AS  "회원명",
            COUNT(*) AS "구매건수"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY B.MEM_ID, B.MEM_NAME
     ORDER BY 1;

사용예)2005년 분류별 평균구매금액을 조회하시오.
    SELECT  B.LPROD_ID                              AS  "분류번호",
            B.LPROD_NM                              AS  "분류명",
            ROUND(AVG(A.CART_QTY * C.PROD_SALE))    AS  "평균판매금액"
      FROM CART A, LPROD B, PROD C
     WHERE B.LPROD_GU = C.PROD_LGU
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO,1,4) = '2005'
     GROUP BY B.LPROD_ID, B.LPROD_NM
     ORDER BY 1;


사용예)2005년 회원의 연령대별 평균구매금액을 조회하시오.

    --SELECT EXTRACT(YEAR FROM B.MEM_BIR)    AS  "출생년도",
    --       ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "평균구매금액"
    --  FROM CART A, MEMBER B, PROD C
    -- WHERE A.CART_MEMBER = B.MEM_ID
    --       AND A.CART_PROD = C.PROD_ID
    --       AND SUBSTR(A.CART_NO, 1, 4) = '2005'
    -- GROUP BY EXTRACT(YEAR FROM B.MEM_BIR)
    -- ORDER BY 1;
    
    --SELECT WIDTH_BUCKET(EXTRACT(YEAR FROM B.MEM_BIR),1960,2010,5)    AS  "연령대",
    --       ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "평균구매금액"
    --  FROM CART A, MEMBER B, PROD C
    -- WHERE A.CART_MEMBER = B.MEM_ID
    --       AND A.CART_PROD = C.PROD_ID
    --       AND SUBSTR(A.CART_NO, 1, 4) = '2005'
    -- GROUP BY EXTRACT(YEAR FROM B.MEM_BIR)
    -- ORDER BY 1;
    
    SELECT (7 - WIDTH_BUCKET(EXTRACT(YEAR FROM B.MEM_BIR),1960,2010,5)) * 10 || '대'    AS  "연령대",
           ROUND(AVG(A.CART_QTY * C.PROD_SALE)) AS "평균구매금액"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO, 1, 4) = '2005'
     GROUP BY WIDTH_BUCKET(EXTRACT(YEAR FROM B.MEM_BIR),1960,2010,5)
     ORDER BY 1;
    
    SELECT (WIDTH_BUCKET(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR),10,100,10)-1) * 10  || '대'    AS  "연령대",
           COUNT(*)                                                                                         AS  "구매건수",
           TO_CHAR(ROUND(AVG(A.CART_QTY * C.PROD_SALE)), '9,999,999')                                       AS  "평균구매금액"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO, 1, 4) = '2005'
     GROUP BY (WIDTH_BUCKET(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR),10,100,10)-1) 
     ORDER BY 1;

SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR))/10) * 10 || '대'    AS  "연령대",
           COUNT(*)                                                                                         AS  "구매건수",
           TO_CHAR(ROUND(AVG(A.CART_QTY * C.PROD_SALE)), '9,999,999')                                       AS  "평균구매금액"
      FROM CART A, MEMBER B, PROD C
     WHERE A.CART_MEMBER = B.MEM_ID
           AND A.CART_PROD = C.PROD_ID
           AND SUBSTR(A.CART_NO, 1, 4) = '2005'
     GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR))/10) * 10
     ORDER BY 1;

숙제)사원들 중 자기가 속한 부서의 평균 급여보다 적은 급여를 받는 사원정보를 조회하시오.
    Alias는 사원번호, 사원명, 부서번호, 부서명, 급여, 부서평균급여
    
    제출일자 : 7월 31일까지
    제출방법 : 교사용 PC 공유폴더에 전송(SEM-PC D:\공유폴더\Oracle\homework1
    문서타입 : 메모장에서 저장된 TEXT문서
    문서명 : 본인이름_0731.TXT

 SELECT B.EMPLOYEE_ID               AS  "사원번호",
        B.EMP_NAME                  AS  "사원명",
        A.DEPTID                    AS  "부서번호",
        A.DEPTNAME                  AS  "부서명",
        B.SALARY                    AS  "급여",
        A.DEPTAVG                   AS  "부서평균급여"
   FROM (SELECT B.DEPARTMENT_ID       AS  DEPTID,
               B.DEPARTMENT_NAME      AS  DEPTNAME,
               ROUND(AVG(A.SALARY))   AS  DEPTAVG
          FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
         WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
         GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME) A,
         HR.EMPLOYEES B
  WHERE A.DEPTID = B.DEPARTMENT_ID
        AND B.SALARY < A.DEPTAVG
  ORDER BY 3;
  

SELECT B.DEPARTMENT_ID       AS  "부서번호",
       B.DEPARTMENT_NAME       AS  "부서명"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;

  3. COUNT(column명|*)
   - 그룹내의 행의 수(자료의 수)를 반환
   - 외부조인연산에 사용되는 경우 '*'를 사용하면 부정확한 결과를 반환하기 때문에 해당 테이블의 컬럼명을 기술해야 함
   
외부조인에서는 조건에 맞지 않는 데이터까지 세는 방법으로 작동하기 때문에 자신이 의도한 바와 같은지 확인해야 한다.
   
사용예)사원테이블에서 각 부서별 사원수를 조회하시오
    
    SELECT DEPARTMENT_ID    AS "부서코드",
           COUNT(*)         AS "사원수1",
           COUNT(LAST_NAME) AS "사원수2"
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;
    
    SELECT DEPARTMENT_ID    AS "부서코드",
           COUNT(*)         AS "사원수1",
           COUNT(LAST_NAME) AS "사원수2"
      FROM HR.EMPLOYEES
     GROUP BY ROLLUP(DEPARTMENT_ID)
     ORDER BY 1;

사용예)2005년 5월 분류별 판매건수를 조회하시오

    SELECT B.PROD_LGU               AS  "분류코드",
           C.LPROD_NM               AS  "분류명",
           COUNT(*)                 AS  "판매건수"
      FROM CART A, PROD B, LPROD C
     WHERE A.CART_PROD = B.PROD_ID 
           AND B.PROD_LGU = C.LPROD_GU
           AND SUBSTR(A.CART_NO,1,6) = '200505'
     GROUP BY B.PROD_LGU, C.LPROD_NM;
     
사용예)2005년 5~6월 회원별 매입회수를 조회하시오
    Alias는 회원번호, 매입회수
    
SELECT  A.MEMBERID                  AS  "회원번호",
        COUNT(*)                    AS  "매입회수"
FROM    (SELECT CART_MEMBER          AS  MEMBERID,
                CART_NO              AS  CARTNO
           FROM CART
          WHERE SUBSTR(CART_NO, 1, 6) IN('200505', '200506')
          GROUP BY CART_MEMBER, CART_NO
          ORDER BY 1)    A
GROUP BY A.MEMBERID
ORDER BY 1;

SELECT  A.MEMBERID                  AS  "회원번호",
        COUNT(*)                    AS  "매입회수"
FROM    (SELECT DISTINCT CART_NO                    AS  CARTNO,
                CART_MEMBER                         AS  MEMBERID
           FROM CART
          WHERE SUBSTR(CART_NO, 1, 6) IN('200505', '200506'))    A
GROUP BY A.MEMBERID
ORDER BY 1;
     
--  DISTINCT에 영향을 받는 컬럼값들이 같은 행들은 한번만 출력된다.

    SELECT CART_MEMBER          AS  "회원번호"
      FROM CART
     WHERE SUBSTR(CART_NO, 1, 6) IN('200505', '200506')
     ORDER BY 1;
     
사용예) 2005년 6월 모든 상품에 대한 매출현황을 조회하시오
사용예) 모든 부서별 사원수를 조회하시오(NULL부서코드는 무시)
   SELECT B.DEPARTMENT_ID     AS "부서코드",
          B.DEPARTMENT_NAME   AS "부서명",
--          COUNT(*)          AS "사원수1"
          COUNT(A.SALARY)       AS "사원수"
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID(+)= B.DEPARTMENT_ID
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;
    
주의) COUNT(*)는 NULL을 무시하지 않으므로 외부조인에서 서로 사맞디 아니한 행들도 집계한다.
ANSI를 쓰면 어떤 SQL에서도 모두 수행된다.
오라클이나 다른 언어에서 그 언어만의 특수한 문법을 사용한다면, 그 문법은 그 언어에 특화된, 최적화를 위한 명령어이다.
    
   SELECT B.DEPARTMENT_ID     AS "부서코드",
          B.DEPARTMENT_NAME   AS "부서명",
          COUNT(*)          AS "사원수1"
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE B.DEPARTMENT_ID(+)= A.DEPARTMENT_ID
    GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
    ORDER BY 1;   
 
SELECT DEPARTMENT_ID    AS "부서코드",
           COUNT(*)         AS "사원수1",
           COUNT(LAST_NAME) AS "사원수2"
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;


모든이라는 단어가 붙으면 그 대상이 되는 컬럼을 대상으로 외부조인할 생각을 하면 된다.

데이터베이스는 현재의 상태를 설명할 수 있을 뿐만 아니라 과거 및 미래로의 확장성을 가지도록 설계되어야 한다.
예전에 썼다가 지금은 쓰지 않는 부서코드 혹은 앞으로 쓸 가능성이 높은 부서코드가 있을 수 있으므로 현재 데이터를 조회하면 NULL인 부서코드 발생
그리고 이런 식으로 설계된 데이터베이스가 기본을 갖춘 데이터베이스다.
아우터조인을 시킬 때 대상이 되는 두 테이블이 모두 부족한 부분이 있는 경우, 그러한 데이터도 모두 출력하는 아우터 조인은 FULL OUTER JOIN이다.
외부조인에서 데이터가 더 많은 테이블은 자료의 수가 아니라 종류의 수가 많은 테이블이다. 이 테이블을 기준으로 외부조인 한다.
ㄴ 외부조인에서 공통된 컬럼 COL을 기준으로 데이터의 수를 세되, 데이터 수는 A 테이블에 있는 COL의 종류와 B 테이블에 있는 COL의 종류의 개수를 비교


























     