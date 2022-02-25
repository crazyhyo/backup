2021-0805-01)User Defined Function(함수)
  - 프로시저와 장점 등이 유사
  - 반환 값이 있음
  - 자주 사용되는 서브쿼리 또는 복잡한 산술식 등을 함수로 구현
  - SELECT 문의 SELECT절, WHERE절에 사용가능
  
  (사용형식)
  CREATE [OR REPLACE] FUNCTION 함수명[(
    매개변수 [MODE] 타입 [:=값][,
              :
    매개변수 [MODE] 타입 [:=값]])]
    RETURN 데이터 타입
  IS|AS
    선언영역
  BEGIN
    실행영역
    RETURN 값|expr;
  END;
   - 'RETURN 데이터 타입' : 반환할 데이터 타입(기본 데이터 타입, 참조형 데이터타입(테이블이나 행)은 반환불가)
   - 'RETURN 값|expr' : 반환해야 하는 값이나 값을 산출하는 수식 등으로 반드시 1개 이상 존재해야 함
   - OUT 매개변수를 이용한 값 반환은 사용을 위해서 반드시 PL/SQL 익명블록이 필요함.
     그래서 함수와 OUT매개변수를 같이 활용하는 경우는 많지 않음
     
반환 : 해당 함수명이 기술되어지는 위치에 단 하나의 반환 결과값을 줌
프로시저는 일반 쿼리에서는 사용이 불가하나 함수는 일반 쿼리(SELECT, INSERT 등의 서브쿼리)에서 사용할 수 있다.

반환해야 하는 값이 여러개일 수 없다.
반드시 여러개를 반환하고 싶으면 모두 문자열로 묶어서 반환하는 식으로 활용

사용예)'대전'에 거주하는 회원번호를 입력받아 해당회원의 2005년 6월 구매금액을 출력하는 함수를 작성하시오.

(함수)
CREATE OR REPLACE FUNCTION FN_SUM01(
    P_MID   MEMBER.MEM_ID   %TYPE)  --매개변수의 MODE를 생략하면 DEFAULT가 IN
    RETURN  NUMBER
IS
    V_SUM   NUMBER := 0;    --구매금액 합계
    V_CNT   NUMBER := 0;    --해당회원의 자료(CART) 존재유무
                            --BOOLEAN으로 할 수도 있지만 SELECT 절의 COUNT로 얻은 값을 보고 값을 할당하는 과정필요
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,6) = '200506'
           AND CART_MEMBER = P_MID;
           
    IF  V_CNT != 0 THEN
        SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO V_SUM
          FROM CART A, PROD B
         WHERE A.CART_PROD = B.PROD_ID
               AND A.CART_MEMBER = P_MID
               AND SUBSTR(A.CART_NO,1,6) = '200506';
    ELSE
        V_SUM := 0;
    END IF;
    
    RETURN V_SUM;
END;

(실행)
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "주소",
       FN_SUM01(MEM_ID) AS "구매금액"
  FROM MEMBER
 WHERE SUBSTR(MEM_ADD1,1,2) = '대전';
 
사용예)상품코드와 년도 및 월을 입력받아 해당 상품의 구매수량과 구매금액을 출력하는 함수를 작성하시오.

(함수) : FN_BUY01

CREATE OR REPLACE FUNCTION FN_BUY01(
    P_PID   PROD.PROD_ID    %TYPE,
    P_YEAR                  CHAR,
    P_MONTH                 CHAR)
    RETURN VARCHAR2
IS
    V_CNT   NUMBER          := 0;
    V_DATE  DATE            := TO_DATE(P_YEAR || P_MONTH || '01');
    V_SUM   NUMBER          := 0;
    V_AMT   NUMBER          := 0;
    V_RES   VARCHAR2(100);
BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM BUYPROD
     WHERE BUY_PROD = P_PID
           AND BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE);
           
    IF  V_CNT != 0 THEN
        SELECT SUM(A.BUY_QTY * B.PROD_COST), SUM(A.BUY_QTY) INTO V_SUM, V_AMT
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND A.BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE)
               AND A.BUY_PROD = P_PID;
    ELSE
        V_SUM := 0;
        V_AMT := 0;
    END IF;
    V_RES := '구매수량 : ' || V_AMT || ', 구매금액 : ' || V_SUM;
    RETURN V_RES;
END;

(실행)
SELECT PROD_ID, PROD_NAME, FN_BUY01(PROD_ID, '2005', '05')
  FROM PROD;
  
(함수) : FN_BUY02

CREATE OR REPLACE FUNCTION FN_BUY02(
    P_PID   PROD.PROD_ID    %TYPE,
    P_YEAR                  CHAR,
    P_MONTH                 CHAR,
    P_AMT   OUT             NUMBER)
    RETURN NUMBER
IS
    V_CNT   NUMBER          := 0;
    V_DATE  DATE            := TO_DATE(P_YEAR || P_MONTH || '01');
    V_SUM   NUMBER          := 0;
    V_AMT   NUMBER          := 0;
BEGIN
    SELECT COUNT(BUY_PROD) INTO V_CNT
      FROM BUYPROD
     WHERE BUY_PROD = P_PID
           AND BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE);
           
    IF  V_CNT != 0 THEN
        SELECT SUM(A.BUY_QTY * B.PROD_COST), SUM(A.BUY_QTY) INTO V_SUM, V_AMT
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND A.BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE)
               AND A.BUY_PROD = P_PID;
    ELSE
        V_SUM := 0;
        V_AMT := 0;
    END IF;
    P_AMT := V_AMT;
    RETURN V_SUM;
END;

(실행)
DECLARE
    V_AMT   NUMBER  := 0;
    V_SUM   NUMBER  := 0;
BEGIN
    FOR REC IN 
    (SELECT PROD_ID, PROD_NAME
       FROM PROD)
    LOOP
        V_SUM := FN_BUY02(REC.PROD_ID, '2005', '05', V_AMT);
        
        DBMS_OUTPUT.PUT_LINE(REC.PROD_ID);
        DBMS_OUTPUT.PUT_LINE(REC.PROD_NAME);
        DBMS_OUTPUT.PUT_LINE(V_SUM);
        DBMS_OUTPUT.PUT_LINE(V_AMT);
        DBMS_OUTPUT.PUT_LINE('=======================');
    END LOOP;
END;

사용예)년도와 월을 6자리 문자열로 입력 받아 해당월에 가장 많은 상품을 구매(금액기준)한 회원의 이름과 구매금액을 출력하는 함수를 작성하시오
      함수명:FN_MAXMEM

CREATE OR REPLACE FUNCTION FN_MAXMEM(
    P_MONTH VARCHAR2)
    RETURN  VARCHAR2
IS
    V_CNT   NUMBER          := 0;
    V_SUM   NUMBER          := 0;
    V_MNAME MEMBER.MEM_NAME %TYPE;
    
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,6) = P_MONTH;
     
--    IF V_CNT > 0 THEN
        SELECT MNAME, MSUM INTO V_MNAME, V_SUM
          FROM (SELECT B.MEM_NAME AS MNAME, SUM(A.CART_QTY * C.PROD_PRICE) AS MSUM
                  FROM CART A, MEMBER B, PROD C
                 WHERE A.CART_MEMBER = B.MEM_ID
                       AND A.CART_PROD = C.PROD_ID
                       AND SUBSTR(CART_NO,1,6) = P_MONTH
                 GROUP BY B.MEM_NAME
                 ORDER BY 2 DESC) A
         WHERE ROWNUM = 1;
--    ELSE
--        V_MNAME := '';
--    END IF;
    
--    RETURN '회원이름 : ' || V_MNAME || ', 구매금액 : ' || V_SUM;
    RETURN '회원이름 : ';

END;

SELECT FN_MAXMEM('200506') AS "최고구매고객" FROM DUAL;

주의)
LIKE 사용법 : CART_NO LIKE P_DATE||'%'
VARCHAR2, CHAR 데이터타입은 VARCHAR2(크기), CHAR(크기)에서 크기 안쓰면 컴파일에러가 발생한다
SELECT INTO에서 SELECT 절 실행 결과가 NULL일 때는 에러는 나오지 않으나 조회해보면 NULL로 되어있다.
PL/SQL절 안의 SELECT INTO절의 레코드가 없다면 특정 값을 RETURN으로 항상 출력하고자 해도 NULL로 출력된다(왜죠?)


ACCEPT  P_DATE  PROMPT  '년월(YYYYMM) : '
DECLARE
    V_RES   VARCHAR2(50);
BEGIN
    V_RES := FN_MAXMEM('&P_DATE');
    DBMS_OUTPUT.PUT_LINE(SUBSTR('&P_DATE',1,4) || '년 ' || SUBSTR('&P_DATE',5,2) || '월');
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;