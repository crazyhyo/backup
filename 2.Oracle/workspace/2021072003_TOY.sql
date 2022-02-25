문제] 사원테이블에서 근무국가별 급여합계를 구하시오.

SELECT D.COUNTRY_NAME               AS  "근무국가",
       SUM(A.SALARY)                AS  "급여합계"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C, HR.COUNTRIES D
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
       AND B.LOCATION_ID = C.LOCATION_ID
       AND C.COUNTRY_ID = D.COUNTRY_ID
 GROUP BY D.COUNTRY_NAME;       
       

사용예)사원테이블에서 각 부서별 보너스 합계를 구하시오
      출력은 부서코드, 부서명, 보너스 합계이고, 보너스는 영업실적(COMMISION_PCT)과
      급여를 곱한 결과의 30%를 지급한다.

SELECT B.DEPARTMENT_ID                                      AS  "부서코드",
       B.DEPARTMENT_NAME                                    AS  "부서명",
       SUM(A.SALARY * NVL(A.COMMISSION_PCT,0) * 0.3)              AS  "보너스 합계"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME;


사용예)2005년 회원별 구매건수을 조회하시오.

SELECT B.MEM_ID                                 AS  "회원번호",
       B.MEM_NAME                               AS  "회원명",
       COUNT(A.CARTNO)                          AS  "구매건수"
  FROM (SELECT DISTINCT     A.CART_NO            AS  CARTNO,
                            B.MEM_ID             AS  MEMID
        FROM CART A, MEMBER B  
        WHERE A.CART_MEMBER = B.MEM_ID) A, MEMBER B
 WHERE A.MEMID = B.MEM_ID
       AND SUBSTR(A.CARTNO,1,4) = '2005'
 GROUP BY B.MEM_ID, B.MEM_NAME;

사용예)2005년 분류별 평균구매금액을 조회하시오.

SELECT C.LPROD_ID               AS      "분류코드",
       C.LPROD_NM               AS      "분류명",
       ROUND(AVG(B.PROD_SALE * A.CART_QTY))     AS      "평균 판매금액"
  FROM CART A, PROD B, LPROD C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_LGU = C.LPROD_GU
       AND SUBSTR(A.CART_NO,1,4) = '2005'
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;

사용예)2005년 회원의 연령대별 평균구매금액을 조회하시오.

SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR)) / 10) * 10 || '대'  AS  "연령대",
       ROUND(AVG(A.CART_QTY * C.PROD_SALE))                                                 AS   "평균구매금액"
  FROM CART A, MEMBER B, PROD C
 WHERE A.CART_MEMBER = B.MEM_ID
       AND A.CART_PROD = C.PROD_ID
       AND SUBSTR(A.CART_NO,1,4) = '2005'
 GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM B.MEM_BIR)) / 10);
       

   
사용예)사원테이블에서 각 부서별 사원수를 조회하시오    

SELECT B.DEPARTMENT_ID                          AS  "부서코드",
       B.DEPARTMENT_NAME                        AS  "부서명",
       COUNT(*)                                 AS  "인원수"
  FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
 GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
 ORDER BY 1;
 
사용예)회원들의 성별 평균 마일리지를 조회하시오
 

    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남성회원'
           ELSE '여성회원'  END       AS "성별",
           ROUND(AVG(MEM_MILEAGE))     AS  "평균 마일리지"
      FROM MEMBER
     GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('1','3') THEN '남성회원'
           ELSE '여성회원'  END;
    
사용예)2005년 5월 분류별 판매건수를 조회하시오

SELECT C.LPROD_ID               AS      "분류코드",
       C.LPROD_NM               AS      "분류명",
       COUNT(*)                 AS      "판매건수"
  FROM CART A, PROD B, LPROD C
 WHERE A.CART_PROD = B.PROD_ID
       AND B.PROD_LGU = C.LPROD_GU
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY C.LPROD_ID, C.LPROD_NM
 ORDER BY 1;

사용예)2005년 5~6월 회원별 매입회수를 조회하시오
SELECT A.CARTMEM                    AS  "회원아이디",
       B.MEM_NAME                   AS  "회원명",
       COUNT(*)                     AS  "매입회수"
FROM    (SELECT DISTINCT CART_NO            AS  CARTNO,
               CART_MEMBER          AS  CARTMEM
          FROM CART
         WHERE SUBSTR(CART_NO,1,6) IN('200505','200506')) A,
         MEMBER B
WHERE A.CARTMEM = B.MEM_ID
GROUP BY A.CARTMEM, B.MEM_NAME;

숙제)사원들 중 자기가 속한 부서의 평균 급여보다 적은 급여를 받는 사원정보를 조회하시오.
    Alias는 사원번호, 사원명, 부서번호, 부서명, 급여, 부서평균급여
SELECT      B.EMPLOYEE_ID                       AS  "사원번호",
            B.EMP_NAME                       AS  "사원명",
            A.DEPTID                       AS  "부서번호",
            C.DEPARTMENT_NAME                       AS  "부서명",
            B.SALARY                       AS  "급여",
            ROUND(A.AVGDEPT)                       AS  "부서평균급여"
FROM        (SELECT DEPARTMENT_ID                  AS  DEPTID,
                   AVG(SALARY)                  AS  AVGDEPT
              FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID) A,
             HR.EMPLOYEES B, HR.DEPARTMENTS C
WHERE       A.DEPTID = B.DEPARTMENT_ID
            AND B.DEPARTMENT_ID = C.DEPARTMENT_ID
            AND B.SALARY < A.AVGDEPT
ORDER BY 3;