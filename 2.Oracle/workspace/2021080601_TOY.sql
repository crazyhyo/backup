분류테이블에 새로운 분류코드를 삽입하시오. 삽입 후 '새로운 분류가 추가되었습니다.'를 출력하는 트리거를 작성하시오.
[분류코드 'P502', 분류명 : '임산물', 순번 : 11]

CREATE OR REPLACE TRIGGER TG_LPROD_INSERT
    AFTER INSERT ON LPROD
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('새로운 분류가 추가되었습니다.');
END;

INSERT INTO LPROD SELECT 11, 'P502', '임산물' FROM DUAL;
COMMIT;

SELECT * FROM LPROD ORDER BY 1 DESC;
DELETE LPROD WHERE LPROD_ID = 11;
ROLLBACK;

오늘이 2005년 6월 11일이라고 가정하고, 제품코드가 'P102000005'인 상품 10대를 매입했다고 하자.
이 정보를 매입테이블에 저장한 후 재고 수불 테이블을 변경하는 트리거를 작성하시오.
[단순화 가정 : 이 시점에서는 INSERT가 수행된다]

CREATE OR REPLACE TRIGGER TG_CART_INSERT_REMAIN
    AFTER INSERT ON CART
    FOR EACH ROW
DECLARE
    
BEGIN
    UPDATE REMAIN A
       SET (REMAIN_I, REMAIN_J_99, REMAIN_DATE) =
           (SELECT REMAIN_I + 
              FROM 
END;


INSERT INTO REMAIN
SELECT '2005', PROD_ID, PROD_PROPERSTOCK, 0, 0, PROD_PROPERSTOCK, TO_DATE('20041231') FROM PROD;

사용예)2005년 1월 상품별 매입정보를 이용하여 REMAIN테이블을 변경하시오

CREATE OR REPLACE FUNCTION FN_BUYPROD_AMT(P_PID PROD.PROD_ID%TYPE, P_DATE VARCHAR2)
    RETURN NUMBER
IS
    V_DATE  DATE            := TO_DATE(P_DATE || '01');
    V_PID   PROD.PROD_ID    %TYPE;
    V_AMT   NUMBER          := 0;
BEGIN
    SELECT BUY_PROD, SUM(BUY_QTY) INTO V_PID, V_AMT
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE)
           AND BUY_PROD = P_PID
     GROUP BY BUY_PROD;
     
     RETURN V_AMT;
END;

SELECT FN_BUYPROD_AMT('P102000001', '200502') FROM DUAL;


UPDATE REMAIN A
   SET (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE) =
       (SELECT A.REMAIN_I + FN_BUYPROD_AMT(PROD_ID, '200501'),
               A.REMAIN_J_99 + FN_BUYPROD_AMT(PROD_ID, '200501'),
               TO_DATE('20050131')
          FROM PROD B
         WHERE A.PROD_ID = B.PROD_ID)
 WHERE A.PROD_ID IN (SELECT DISTINCT BUY_PROD
                       FROM BUYPROD
                      WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101')));
 
ROLLBACK;

UPDATE REMAIN B
   SET (B.REMAIN_I, B.REMAIN_J_99, B.REMAIN_DATE) =
       (SELECT B.REMAIN_I + A.AMT, B.REMAIN_J_99 + A.AMT, TO_DATE('20050131')
          FROM (SELECT BUY_PROD AS BID,
                       SUM(BUY_QTY) AS AMT
                  FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND LAST_DAY(TO_DATE('20050101'))
                 GROUP BY BUY_PROD) A
         WHERE B.PROD_ID = A.BID)
 WHERE B.REMAIN_YEAR = '2005'
       AND B.PROD_ID IN (SELECT DISTINCT BUY_PROD AS BID
                                    FROM BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20050101')
                                                  AND LAST_DAY(TO_DATE('20050101')));
 
사용예)오늘('20050806')'b001'회원(라준호)이 상품 'P202000019'을 5개 구입했을 때 CART테이블과
      재고수불테이블에 자료를 삽입 및 갱신하시오(트리거 이용)
      
      
EXEC PROC_CART('P202000019', 'b001', 6, '20050806');

CREATE OR REPLACE TRIGGER TG_CART_REMAIN
    BEFORE INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
DECLARE
    V_AMT                   NUMBER := 0;
    V_PID   PROD.PROD_ID    %TYPE;
    V_DATE  DATE;
BEGIN
    IF INSERTING THEN
        V_AMT :=:NEW.CART_QTY;
        V_DATE:= TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        V_PID :=:NEW.CART_PROD;
    ELSIF UPDATING THEN
        V_AMT :=:NEW.CART_QTY - :OLD.CART_QTY;
        V_DATE:= TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        V_PID :=:NEW.CART_PROD;
    ELSIF DELETING THEN
        V_AMT := -:OLD.CART_QTY;
        V_DATE:= TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
        V_PID :=:OLD.CART_PROD;
    END IF;
    
    UPDATE REMAIN
       SET REMAIN_O     = REMAIN_O + V_AMT,
           REMAIN_J_99  = REMAIN_J_99 - V_AMT,
           REMAIN_DATE  = V_DATE
     WHERE REMAIN_YEAR  = '2005'
           AND PROD_ID  = V_PID;
END;

DROP TRIGGER TG_CART_REMAIN;

CREATE OR REPLACE PROCEDURE PROC_CART
    (P_PID      PROD.PROD_ID    %TYPE,
    P_MID       MEMBER.MEM_ID   %TYPE,
    P_QTY       NUMBER,
    P_DATE      VARCHAR2)
IS
    V_CNO       CART.CART_NO    %TYPE;
    V_CNT       NUMBER          := 0;
    V_QTY       NUMBER          := 0;
    V_RM        NUMBER          := 0;
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,8)      = P_DATE
           AND CART_PROD            = P_PID
           AND CART_MEMBER          = P_MID;
    
    IF V_CNT = 0 THEN
        IF P_QTY > 0 THEN
            SELECT REMAIN_J_99 - P_QTY INTO V_RM
              FROM REMAIN
             WHERE REMAIN_YEAR = '2005'
                   AND PROD_ID = P_PID;
            IF V_RM < 0 THEN
                DBMS_OUTPUT.PUT_LINE('재고가 부족합니다.');
            ELSE
                INSERT INTO CART(CART_NO, CART_MEMBER, CART_PROD, CART_QTY)
                VALUES(FN_CART_GETNO(P_PID, P_MID, P_DATE),
                       P_MID, P_PID, P_QTY);
                DBMS_OUTPUT.PUT_LINE('주문이 완료되었습니다.');
            END IF;       
        END IF;
    ELSIF V_CNT > 0 THEN
        IF P_QTY = 0 THEN
            DELETE CART
             WHERE CART_NO = FN_CART_GETNO(P_PID, P_MID, P_DATE)
                   AND CART_PROD = P_PID;
            DBMS_OUTPUT.PUT_LINE('주문을 취소했습니다.');
        ELSIF P_QTY > 0 THEN
            SELECT SUM(CART_QTY) INTO V_QTY
              FROM CART
             WHERE SUBSTR(CART_NO,1,8)      = P_DATE
                   AND CART_PROD            = P_PID
                   AND CART_MEMBER          = P_MID;
            IF P_QTY > V_QTY THEN
                SELECT REMAIN_J_99 - P_QTY INTO V_RM
                  FROM REMAIN
                 WHERE REMAIN_YEAR = '2005'
                       AND PROD_ID = P_PID;
                IF V_RM < 0 THEN
                    DBMS_OUTPUT.PUT_LINE('재고가 부족합니다.');
                END IF;
            ELSIF P_QTY < V_QTY THEN
                UPDATE CART
                   SET CART_QTY         = P_QTY
                 WHERE CART_NO          = FN_CART_GETNO(P_PID, P_MID, P_DATE)
                       AND CART_PROD    = P_PID
                       AND CART_MEMBER  = P_MID;
                DBMS_OUTPUT.PUT_LINE('주문이 변경되었습니다.');
            END IF;
        END IF;
    END IF;
END;



CREATE OR REPLACE FUNCTION FN_CART_GETNO
    (P_PID      PROD.PROD_ID    %TYPE,
    P_MID       MEMBER.MEM_ID   %TYPE,
    P_DATE      VARCHAR2)
    RETURN      CART.CART_NO    %TYPE
IS
    V_CNT       NUMBER          := 0;
    V_RES       CART.CART_NO    %TYPE;
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,8)      = P_DATE
           AND CART_PROD            = P_PID
           AND CART_MEMBER          = P_MID;
    IF V_CNT = 0 THEN
        V_RES := P_DATE || '00001';
    ELSE
        SELECT CART_NO INTO V_RES
          FROM CART
         WHERE SUBSTR(CART_NO,1,8)      = P_DATE
               AND CART_PROD            = P_PID
               AND CART_MEMBER          = P_MID;
    END IF;
    
    RETURN V_RES;
END;

CREATE OR REPLACE PROCEDURE PROC_CART
    (P_PID      PROD.PROD_ID    %TYPE,
    P_MID       MEMBER.MEM_ID   %TYPE,
    P_QTY       NUMBER,
    P_DATE      VARCHAR2)
IS
    V_CNO       CART.CART_NO    %TYPE;
    V_CNT       NUMBER          := 0;
    V_RM        NUMBER          := 0;
    V_AMT       NUMBER          := 0;
    V_PID       PROD.PROD_ID    %TYPE;
    
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,8)      = P_DATE
           AND CART_PROD            = P_PID
           AND CART_MEMBER          = P_MID;
    

    
    IF V_CNT = 0 THEN
        IF P_QTY > 0 THEN
            SELECT REMAIN_J_99 - P_QTY INTO V_RM
              FROM REMAIN
             WHERE REMAIN_YEAR = '2005'
                   AND PROD_ID = P_PID;
            IF V_RM < 0 THEN
                DBMS_OUTPUT.PUT_LINE('재고가 부족합니다.');
            ELSE
                V_CNO := P_DATE || '00001';
                
                INSERT INTO CART(CART_NO, CART_MEMBER, CART_PROD, CART_QTY)
                VALUES(V_CNO, P_MID, P_PID, P_QTY);
                
                UPDATE REMAIN
                   SET REMAIN_O     = REMAIN_O + P_QTY,
                       REMAIN_J_99  = REMAIN_J_99 - P_QTY,
                       REMAIN_DATE  = TO_DATE(P_DATE)
                 WHERE REMAIN_YEAR  = '2005'
                       AND PROD_ID  = P_PID;
                
                DBMS_OUTPUT.PUT_LINE('주문이 완료되었습니다.');
            END IF;       
        END IF;
    ELSIF V_CNT > 0 THEN
        
        SELECT CART_PROD, SUM(CART_QTY) INTO V_PID, V_AMT
          FROM CART
         WHERE SUBSTR(CART_NO,1,8)      = P_DATE
               AND CART_PROD            = P_PID
               AND CART_MEMBER          = P_MID
         GROUP BY CART_PROD;
        
        SELECT CART_NO INTO V_CNO
          FROM CART
         WHERE SUBSTR(CART_NO,1,8)      = P_DATE
               AND CART_PROD            = P_PID
               AND CART_MEMBER          = P_MID;
        
        IF P_QTY = 0 THEN
        
            DELETE CART
             WHERE CART_NO = V_CNO
                   AND CART_PROD = P_PID;
            
            UPDATE REMAIN
                   SET REMAIN_O     = REMAIN_O - V_AMT,
                       REMAIN_J_99  = REMAIN_J_99 + V_AMT,
                       REMAIN_DATE  = TO_DATE(P_DATE)
                 WHERE REMAIN_YEAR  = '2005'
                       AND PROD_ID  = P_PID;
            
            DBMS_OUTPUT.PUT_LINE('주문을 취소했습니다.');
        ELSIF P_QTY > 0 THEN
            IF P_QTY > V_AMT THEN
                SELECT REMAIN_J_99 - P_QTY INTO V_RM
                  FROM REMAIN
                 WHERE REMAIN_YEAR = '2005'
                       AND PROD_ID = P_PID;
                IF V_RM < 0 THEN
                    DBMS_OUTPUT.PUT_LINE('재고가 부족합니다.');
                ELSE
                    UPDATE CART
                       SET CART_QTY         = P_QTY
                     WHERE CART_NO          = V_CNO
                           AND CART_PROD    = P_PID
                           AND CART_MEMBER  = P_MID;
                    UPDATE REMAIN
                       SET REMAIN_O     = REMAIN_O + P_QTY - V_AMT,
                           REMAIN_J_99  = REMAIN_J_99 - P_QTY + V_AMT,
                           REMAIN_DATE  = TO_DATE(P_DATE)
                     WHERE REMAIN_YEAR  = '2005'
                           AND PROD_ID  = P_PID;
                    DBMS_OUTPUT.PUT_LINE('주문이 변경되었습니다.');
                END IF;
            ELSIF P_QTY < V_AMT THEN
                UPDATE CART
                   SET CART_QTY         = P_QTY
                 WHERE CART_NO          = V_CNO
                       AND CART_PROD    = P_PID
                       AND CART_MEMBER  = P_MID;
                       
                UPDATE REMAIN
                   SET REMAIN_O     = REMAIN_O + P_QTY - V_AMT,
                       REMAIN_J_99  = REMAIN_J_99 - P_QTY + V_AMT,
                       REMAIN_DATE  = TO_DATE(P_DATE)
                 WHERE REMAIN_YEAR  = '2005'
                       AND PROD_ID  = P_PID;
                
                DBMS_OUTPUT.PUT_LINE('주문이 변경되었습니다.');
            END IF;
        END IF;
    END IF;
END;
