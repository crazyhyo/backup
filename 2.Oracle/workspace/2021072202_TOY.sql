사용예)2005년 5월 회원별 판매액을 계산하고 상위 5명의 자료를 출력하시오
      ALIAS는 회원번호, 회원명, 구매금액합계
SELECT A.MID AS "회원번호",
       A.MNAME AS "회원명",
       A.AMT AS "구매금액합계"
FROM    (SELECT B.MEM_ID AS MID,
               B.MEM_NAME AS MNAME,
               SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200505'
         GROUP BY B.MEM_ID, B.MEM_NAME
         ORDER BY 3 DESC) A
WHERE ROWNUM <= 5;

사용예)2005년 5월 매출합계
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       SUM(A.CART_QTY * B.PROD_PRICE) AS "매출합계"
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID, B.PROD_NAME;

사용예)2005년 5월 매입합계
SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       SUM(B.PROD_COST * A.BUY_QTY) AS "매입합계"
  FROM BUYPROD A, PROD B
 WHERE A.BUY_PROD = B.PROD_ID
       AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
 GROUP BY B.PROD_ID, B.PROD_NAME;
       

사용예)2005년 5월 매입액과 매출액을 조회하시오
      ALIAS는 상품코드, 상품명, 매입액합계, 매출액합계

SELECT B.PROD_ID AS "상품코드",
       B.PROD_NAME AS "상품명",
       NVL(SUM(C.BUY_QTY * B.PROD_COST),0) AS "매입액합계",
       NVL(SUM(A.CART_QTY * B.PROD_PRICE),0) AS "매출액합계"
  FROM CART A
 RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505')
  LEFT OUTER JOIN BUYPROD C ON(B.PROD_ID = C.BUY_PROD
       AND C.BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531'))
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
SELECT B.PROD_ID AS AID,
       SUM(A.CART_QTY * B.PROD_PRICE) AS AAMT
  FROM CART A, PROD B
 WHERE A.CART_PROD = B.PROD_ID
       AND SUBSTR(A.CART_NO,1,6) = '200505'
 GROUP BY B.PROD_ID;
 
SELECT BUY_PROD AS BID,
       SUM(BUY_QTY * BUY_COST) AS BAMT
  FROM BUYPROD
 WHERE BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
 GROUP BY BUY_PROD;

SELECT C.PROD_ID AS "상품코드",
       C.PROD_NAME AS "상품명",
       NVL(A.AAMT,0) AS "매출액합계",
       NVL(B.BAMT,0) AS "매입액합계"
FROM      (SELECT B.PROD_ID AS AID,
                   SUM(A.CART_QTY * B.PROD_PRICE) AS AAMT
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
                   AND SUBSTR(A.CART_NO,1,6) = '200505'
             GROUP BY B.PROD_ID) A,
            (SELECT BUY_PROD AS BID,
                   SUM(BUY_QTY * BUY_COST) AS BAMT
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20050501') AND TO_DATE('20050531')
             GROUP BY BUY_PROD) B, PROD C
WHERE A.AID (+)= C.PROD_ID
      AND B.BID (+)= C.PROD_ID
ORDER BY 1;
      
      
사용예)사원테이블에서 사원들의 평균급여보다 더 많은 급여를 받는 사원의 사원번호, 사원명, 부서명, 급여, 평균급여를 출력하시오
SELECT B.EMPLOYEE_ID AS "사원번호",
       B.EMP_NAME AS "사원명",
       C.DEPARTMENT_ID AS "부서명",
       B.SALARY AS "급여",
       A.AVER AS "평균급여"
FROM    (SELECT ROUND(AVG(SALARY)) AS AVER
          FROM HR.EMPLOYEES) A, HR.EMPLOYEES B, HR.DEPARTMENTS C
WHERE B.DEPARTMENT_ID = C.DEPARTMENT_ID
      AND B.SALARY > A.AVER
ORDER BY 1;

SELECT B.EMPLOYEE_ID AS "사원번호",
       B.EMP_NAME AS "사원명",
       C.DEPARTMENT_ID AS "부서명",
       B.SALARY AS "급여",
       A.AVER AS "평균급여"
FROM   HR.EMPLOYEES B 
INNER JOIN HR.DEPARTMENTS C ON(B.DEPARTMENT_ID = C.DEPARTMENT_ID)
INNER JOIN (SELECT ROUND(AVG(SALARY)) AS AVER
          FROM HR.EMPLOYEES) A ON(B.SALARY > A.AVER)
ORDER BY 1;

사용예)[2005년 6월 가장 많은 금액을 구매한 고객]의 주소지 이외의 주소지에 거주하는 회원의 회원번호, 회원명, 주소를 조회하시오.
SELECT B.MEM_ID AS "회원번호",
       B.MEM_NAME AS "회원명",
       B.MEM_ADD1 || ' ' || B.MEM_ADD2 AS "주소"
FROM    (SELECT A.MID AS MID,
                A.ADD1 AS ADD1
        FROM    (SELECT B.MEM_ID AS MID,
                        B.MEM_ADD1 AS ADD1,
                       SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
                  FROM CART A
                 INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID
                       AND SUBSTR(A.CART_NO,1,6) = '200506')
                 INNER JOIN PROD C ON(A.CART_PROD = C.PROD_ID)
                 GROUP BY B.MEM_ID, B.MEM_ADD1
                 ORDER BY 2 DESC) A
        WHERE ROWNUM = 1) A, MEMBER B
WHERE A.ADD1 <> B.MEM_ADD1; 
 
  

DECLARE
    V_ID MEMBER.MEM_ID%TYPE;
    V_NAME MEMBER.MEM_NAME%TYPE;
    V_AMT NUMBER:=0;
    
    CURSOR CUR_MEM01 IS
      SELECT A.MID
        FROM (SELECT MEM_ID AS MID
                FROM MEMBER
               ORDER BY MEM_MILEAGE DESC) A
       WHERE ROWNUM <= ROUND((SELECT COUNT(*)
                                FROM MEMBER) * 0.2);
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
        DBMS_OUTPUT.PUT_LINE('회원번호 : '||V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;      
    CLOSE CUR_MEM01;    
END;    