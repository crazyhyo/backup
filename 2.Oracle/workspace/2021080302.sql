2021-0803-02)커서(CURSOR)
  - 오라클 SQL명령에 의하여 영향받은 행들의 집합
  - SELECT문에 의해 반환된 결과 집합의 행들을 차례대로 접근해야 하는 경우 사용
  - 개발자가 결과를 수동적으로 제어할 필요가 있는 경우 사용
  - IMPLICIT, EXPLICIT CURSOR
  - 커서의 사용은 FOR문을 제외하고 생성 (선언) -> OPEN -> FETCH -> CLOSE 단계를 차례대로 실행
  (1)익명커서(IMPLICIT CURSOR)
   - 이름이 없는 커서
   - SELECT문이 실행되면 결과(커서)가 자동으로 OPEN된 후 결과출력 직후 자동으로 CLOSE됨(참조 불가)
   - 커서속성
     SQL%ISOPEN : 커서가 OPEN 상태이면 참(TRUE) 반환 - 항상 거짓(FALSE)[익명커서이기 때문에]
     SQL%NOTFOUND : 커서에 자료가 남아있지 않으면 참(TRUE) 반환
     SQL%FOUND : 커서에 자료가 남아있으면 참(TRUE) 반환
     SQL%ROWCOUNT : 커서에 존재하는 자료의 수
     

FOR문을 사용하면 OPEN, FETCH, CLOSE를 모두 생략 가능함(CURSOR는 보통 FOR문과 같이 쓴다)
WHILE문은 SQL%FOUND, LOOP문은 EXIT WHEN SQL%NOTFOUND를 사용하는 것이 일반적

  (2)명시적 커서(EXPLICIT CURSOR)
   - 이름이 부여된 커서
   (선언형식 - 선언부)
    CURSOR 커서명[(변수 타입명[,변수 타입명,...])] IS
    SELECT 문;
    
    (실행부)
    OPEN 커서명[(매개변수[,매개변수,...])];
    
    FETCH 커서명 INTO 변수LIST;
    
    CLOSE 커서명;
    
SQL%NOTFOUND, SQL%FOUND는 FETCH문이 실행된 후에 정의됨

사용예1)2005년 5월 입고상품별 출고현황을 조회하는 커서를 작성하시오.
      ALIAS는 상품코드, 상품명, 수량

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    V_CNT                   NUMBER := 0; --매출데이터가 있는지 없는지
    
    CURSOR CUR_BUY01(PDATE DATE) IS
--    CURSOR CUR_BUY01 IS
    SELECT DISTINCT BUY_PROD
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN PDATE AND LAST_DAY(PDATE);
--     WHERE BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501'));
    
BEGIN
    OPEN CUR_BUY01(TO_DATE('20050501'));
--    OPEN CUR_BUY01;
    LOOP
        FETCH CUR_BUY01 INTO V_PID;
        EXIT WHEN CUR_BUY01%NOTFOUND;
        SELECT COUNT(*) INTO V_CNT
          FROM CART
         WHERE CART_PROD = V_PID
               AND SUBSTR(CART_NO,1,6) = '200505';
        IF V_CNT != 0 THEN
            SELECT B.PROD_NAME, SUM(A.CART_QTY)
              INTO V_PNAME, V_AMT
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
                   AND A.CART_PROD = V_PID
                   AND SUBSTR(A.CART_NO,1,6) = '200505'
             GROUP BY B.PROD_NAME;
        ELSE        --기존 코드(IF와 CNT가 정의되지 않았을 때)에서 에러가 발생한 부분
                    --매입은 있으나 매출은 없는상품의 경우 SELECT절이 빈 테이블을 반환하여 INTO V_PNAME, V_AMT 실행안됨
                    --여기에서 빈 것을 대입할 수 없다고(?) 오류가 나옴
            DBMS_OUTPUT.PUT_LINE('상품코드 : ' || V_PID || '는 판매되지 않음');
            DBMS_OUTPUT.PUT_LINE('-----------------------');
        END IF;
        DBMS_OUTPUT.PUT_LINE('상품코드 : ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('상품명 : ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('판매수량 : ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-----------------------');
    END LOOP;
    CLOSE CUR_BUY01;
END;

사용예2)2005년 상품별 입고수량합계를 출력하는 블록을 커서를 이용하여 작성하시오
      ALIAS는 상품코드, 상품명, 입고수량
DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    V_CNT                   NUMBER := 0;
    
    CURSOR CUR_PROD01 IS
    SELECT DISTINCT BUY_PROD
      FROM BUYPROD
     ORDER BY 1 DESC;
BEGIN
    OPEN CUR_PROD01;
    
    LOOP
        V_CNT := V_CNT + 1;
        FETCH CUR_PROD01 INTO V_PID;
        EXIT WHEN CUR_PROD01%NOTFOUND;
        
        SELECT B.PROD_NAME, SUM(A.BUY_QTY)
          INTO V_PNAME, V_AMT
          FROM BUYPROD A, PROD B
         WHERE A.BUY_PROD = B.PROD_ID
               AND EXTRACT(YEAR FROM A.BUY_DATE) = 2005
               AND B.PROD_ID = V_PID
         GROUP BY B.PROD_NAME;
        
        DBMS_OUTPUT.PUT_LINE('상품코드 ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('상품명 ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('입고수량 ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('카운트 ' || V_CNT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
         
    END LOOP;
    
    CLOSE CUR_PROD01;
END;

FETCH INTO는 하나의 문법, FETCH는 커서의 한 행 전체를 내보낸다. 그래서 커서의 열의 수 만큼의 변수를 생성하여 모두 받아야 한다.
안그러면 에러. 커서를 FETCH할 때 위부터 차례로 빼내온다(ORDER BY로 확인해봄)
커서는 객체가 아니다. VIEW로는 하나씩 읽어올 수 없다. 커서에 매개변수를 사용하는 경우는 커서를
정의하는 SELECT절에 매개변수를 사용하고 싶을 때이다(보통 조건에 매개변수를 활용한다). 문법이 까다로우므로 주의

2005년 상품별 입고수량 합계

SELECT B.PROD_ID, B.PROD_NAME, SUM(A.BUY_QTY)
  FROM BUYPROD A, PROD B
 WHERE A.BUY_PROD = B.PROD_ID
       AND EXTRACT(YEAR FROM BUY_DATE) = 2005
 GROUP BY B.PROD_ID, B.PROD_NAME
 ORDER BY 1;
 
DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    
    CURSOR CUR_BUY02 IS
    SELECT B.PROD_ID AS BID, B.PROD_NAME AS BNAME, SUM(A.BUY_QTY) AS AMT
      FROM BUYPROD A, PROD B
    WHERE A.BUY_PROD = B.PROD_ID
           AND EXTRACT(YEAR FROM BUY_DATE) = 2005
    GROUP BY B.PROD_ID, B.PROD_NAME
    ORDER BY 1;
BEGIN
    OPEN CUR_BUY02;
    
    LOOP
        FETCH CUR_BUY02 INTO V_PID, V_PNAME, V_AMT;
        EXIT WHEN CUR_BUY02 %NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('상품코드 ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('상품명 ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('입고수량 ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;
    
    CLOSE CUR_BUY02;
END;

숙제)위 1번과 2번을 WHILE문을 사용하여 작성하시오.

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    
    CURSOR CUR_BUY02 IS
    SELECT B.PROD_ID AS BID, B.PROD_NAME AS BNAME, SUM(A.BUY_QTY) AS AMT
      FROM BUYPROD A, PROD B
    WHERE A.BUY_PROD = B.PROD_ID
           AND EXTRACT(YEAR FROM BUY_DATE) = 2005
    GROUP BY B.PROD_ID, B.PROD_NAME
    ORDER BY 1;
BEGIN
    OPEN CUR_BUY02;
    
    FETCH CUR_BUY02 INTO V_PID, V_PNAME, V_AMT;
    WHILE CUR_BUY02 %FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('상품코드 ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('상품명 ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('입고수량 ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FETCH CUR_BUY02 INTO V_PID, V_PNAME, V_AMT;
    END LOOP;
    
    CLOSE CUR_BUY02;
END;

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    V_CNT                   NUMBER := 0; --매출데이터가 있는지 없는지
    
    CURSOR CUR_BUY01(PDATE DATE) IS
    SELECT DISTINCT BUY_PROD
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN PDATE AND LAST_DAY(PDATE);
    
BEGIN
    OPEN CUR_BUY01(TO_DATE('20050501'));
    FETCH CUR_BUY01 INTO V_PID;
    WHILE CUR_BUY01%FOUND LOOP
        
        SELECT COUNT(*) INTO V_CNT
          FROM CART
         WHERE CART_PROD = V_PID
               AND SUBSTR(CART_NO,1,6) = '200505';
        IF V_CNT != 0 THEN
            SELECT B.PROD_NAME, SUM(A.CART_QTY)
              INTO V_PNAME, V_AMT
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
                   AND A.CART_PROD = V_PID
                   AND SUBSTR(A.CART_NO,1,6) = '200505'
             GROUP BY B.PROD_NAME;
        ELSE       
            DBMS_OUTPUT.PUT_LINE('상품코드 : ' || V_PID || '는 판매되지 않음');
            DBMS_OUTPUT.PUT_LINE('-----------------------');
        END IF;
        DBMS_OUTPUT.PUT_LINE('상품코드 : ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('상품명 : ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('판매수량 : ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-----------------------');
        
        FETCH CUR_BUY01 INTO V_PID;
        
    END LOOP;
    CLOSE CUR_BUY01;
END;

