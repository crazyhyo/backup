2021-0804-01)
   (3)FOR 문
    - 개발언어의 FOR문과 유사한 구조
    - 일반 반복처리를 위한 FOR문과 CURSOR처리를 위한 FOR문이 제공
 (일반 FOR문 사용형식)
  FOR 인덱스 IN [REVERSE] 초기값..최대값 LOOP
    반복처리명령문(n);
  END LOOP;
   - '인덱스' : 제어변수로 사용될 인덱스로 시스템에서 자동 설정
   - 'REVERSE' : 역순으로 반복처리시 사용

사용예)구구단의 7단을 출력하시오.

DECLARE
BEGIN
    FOR I IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(7 || ' * ' || I || ' = ' || 7 * I);
    END LOOP;
END;

사용예)첫날에 100원을 저축하고, 그 다음날 부터 전날의 2배씩 저축할 때 최초로 200만원을 넘는 날과 저축금액을 구하시오

DECLARE
    V_SUM   NUMBER := 0;
    V_DSUM  NUMBER := 100;
    V_DATE  NUMBER := 0;
BEGIN
    FOR CNT IN 1..100 LOOP
        
        V_SUM := V_SUM + V_DSUM;
        IF V_SUM >= 2000000 THEN
            V_DATE := CNT;
--            DBMS_OUTPUT.PUT_LINE('DAYS : ' || CNT || ' / TOTAL : ' || V_SUM);
            EXIT;
        END IF;
        
        V_DSUM := V_DSUM * 2;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('DAYS : ' || V_DATE || ' / TOTAL : ' || V_SUM);
    
END;

 (CURSOR를 위한 FOR문 사용형식)
  FOR 레코드명 IN 커서명|커서선언문 LOOP
    반복처리명령문(n);
  END LOOP;
   - '레코드명' : 커서가 가리키는 행의 값을 가지고 있는 변수로 시스템에서 정의
   - 커서내의 값들(컬럼)의 참조는 '레코드명.커서의 컬럼명' 형식으로 기술
   - 커서의 OPEN, FETCH, CLOSE 생략
   - '커서선언문' : 선언영역에서 선언해야할 커서선언문 중 'SELECT'문을 서브쿼리형식으로 기술
   

DECLARE
BEGIN
    FOR REC1 IN (SELECT B.PROD_ID AS BID, B.PROD_NAME AS BNAME, SUM(A.BUY_QTY) AS AMT
                   FROM BUYPROD A, PROD B
                  WHERE A.BUY_PROD = B.PROD_ID
                        AND EXTRACT(YEAR FROM BUY_DATE) = 2005
                  GROUP BY B.PROD_ID, B.PROD_NAME)
    LOOP
        DBMS_OUTPUT.PUT_LINE('상품코드 ' || REC1.BID);
        DBMS_OUTPUT.PUT_LINE('상품명 ' || REC1.BNAME);
        DBMS_OUTPUT.PUT_LINE('입고수량 ' || REC1.AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;
END;
   