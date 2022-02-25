2021-0805-02)트리거 TRIGGER
  - 특정 이벤트의 발생 전 또는 이후 자동으로 실행되야 할 프로시져
  - 트리거는 문장단위 트리거와 행단위 트리거로 구분
  - 문장단위 트리거 수행 시 트리거가 완료되지 않은 상태에서 또다른 트리거 호출시
    테이블의 일관성 유지를 위해 해당테이블의 접근이 금지됨
  
  (사용형식)
  CREATE [OR REPLACE] TRIGGER 트리거명
    timming[BEFORE|AFTER] event[INSERT|UPDATE|DELETE]
    ON 테이블명
    [FOR EACH ROW]
    [WHEN 조건]
    [DECLARE
        선언부
    ]
    BEGIN
        실행부
    END;
     - 'BEFORE|AFTER' : '실행부'(트리거 본문)가 실행될 시점
     - 'INSERT|UPDATE|DELETE' : 트리거를 발생시키는 이벤트로 OR 연산자로 복수개 사용 가능
       EX) INSERT OR DELETE, INSERT OR UPDATE OR DELETE etc..
     - 'FOR EACH ROW' : 행단위 트리거 시 기술(생략하면 문장단위 트리거)
     - 'WHEN 조건' : 행단위 트리거에서만 사용 가능하며, 이벤트 발생에 대한 구체적인 조건 기술
     
트리거 사용시 많은 주의가 필요함. 프로시저의 일종
BEFORE를 사용하는 TRIGGER가 많지는 않음.(카트/상품에 없는 상품을 판매하는 것과 같이 예외적인 경우에 필요)
행단위 트리거 : 각 행에 대하여 INSERT, DELETE OR UPDATE 가 수행될 때마다 트리거를 실행
OLD와 NEW를 이용하여 효율적 TRIGGER 작성 가능[행단위 트리거에서만 가능]
트리거 함수 가능

문장단위 트리거 : INSERT, UPDATE, DELETE가 수행되었을 때 영향받은 행의 수와 관계없이 명령마다 한 번만 수행하는 트리거

(문장단위 트리거)
분류테이블에 새로운 분류코드를 삽입하시오. 삽입 후 '새로운 분류가 추가되었습니다.'를 출력하는 트리거를 작성하시오.
[분류코드 'P502', 분류명 : '임산물', 순번 : 11]

CREATE OR REPLACE TRIGGER TG_LPROD_INSERT
    AFTER INSERT ON LPROD
BEGIN
    DBMS_OUTPUT.PUT_LINE('새로운 분류가 추가되었습니다.');
END;

CREATE OR REPLACE TRIGGER TG_LPROD_DELETE
    AFTER DELETE ON LPROD
BEGIN
    DBMS_OUTPUT.PUT_LINE('분류가 삭제되었습니다.');
END;

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(11, 'P502', '임산물');

SELECT * FROM LPROD;    --위의 명령과 같이 실행될 때 이 시점에서 메세지가 나온다.

COMMIT;                 --이 시점에서 메세지가 나온다
SELECT * FROM LPROD;

TRIGGER 내부에서는 COMMIT이나 ROLLBACK가능

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(12, 'P503', '축산물');
COMMIT;                 --이 시점에서 메세지가 나온다

COMMIT이 되지 않으면 MEMORY상에서만 저장되어진 것, COMMIT을 해야 메시지가 출력(트리거 실행)된다.
단, 문장단위 트리거를 발동시키는 DML과 SELECT문을 동시에 실행하면 메시지가 출력(트리거 실행)된다.
트리거 내부에서 프로시저나 함수를 사용할 수 있다.

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(13, 'P504', '농축산물');

SELECT * FROM LPROD;    --위의 명령과 같이 실행될 때 이 시점에서 메세지가 나온다.

DML명령을 수행된 이후 COMMIT하는 습관을 가지자

DELETE LPROD WHERE LPROD_ID = 11;

SELECT * FROM LPROD;    --위의 명령과 같이 실행될 때 이 시점에서 메세지가 나온다.

COMMIT;

(행단위 트리거)
오늘이 2005년 6월 11일이라고 가정하고, 제품코드가 'P102000005'인 상품 10대를 매입했다고 하자.
이 정보를 매입테이블에 저장한 후 재고 수불 테이블을 변경하는 트리거를 작성하시오.
[단순화 가정 : 이 시점에서는 INSERT가 수행된다]

CREATE OR REPLACE TRIGGER TG_BUYPROD_INSERT
    AFTER INSERT ON BUYPROD
    FOR EACH ROW
DECLARE
    V_QTY   NUMBER                  := :NEW.BUY_QTY;
    V_PROD  PROD.PROD_ID    %TYPE   := 'P102000005';
BEGIN
    UPDATE REMAIN
       SET REMAIN_I     = REMAIN_I + V_QTY,
         --REMAIN_I     = REMAIN_I + :NEW.BUY_QTY,
           REMAIN_J_99  = REMAIN_J_99 + V_QTY,
         --REMAIN_J_99  = REMAIN_J_99 + :NEW.BUY_QTY,
           REMAIN_DATE  = TO_DATE('20050611')
         --REMAIN_DATE  = :NEW.BUY_DATE
     WHERE REMAIN_YEAR  = '2005'
         --REMAIN_YEAR  = TO_CHAR(EXTRACT(YEAR FROM :NEW.BUY_DATE))
           AND PROD_ID  = :NEW.BUY_PROD;
           
    DBMS_OUTPUT.PUT_LINE(:NEW.BUY_PROD || '상품이 ' || V_QTY || '개 입고되었습니다.');
  --DBMS_OUTPUT.PUT_LINE(:NEW.BUY_PROD || '상품이 ' || :NEW.BUY_QTY || '개 입고되었습니다.');
END;

INSERT INTO BUYPROD
SELECT TO_DATE('20050611'), PROD_ID, 10, PROD_COST
  FROM PROD
 WHERE PROD_ID = 'P102000005';

COMMIT;

현재 BUYPROD와 CART테이블은 PK가 (BUY_DATE, BUY_PROD), (CART_NO, CART_PROD)로 구성되어 있음
따라서 같은 날(혹은 같은 날이며 로그아웃 하지 않았은 기간동안) 같은 상품을 매입/매출 하게 되면
먼저 같은 PK를 가지는 레코드를 검사하여 그러한 레코드가 없다면 INSERT를, 있다면 UPDATE로 테이블을 관리하게 된다.

:NEW는 새로운 레코드를 나타낸다. :OLD는 기존의 레코드를 나타낸다.

  1)트리거 의사레코드
   (1) :NEW - INSERT, UPDATE 이벤트시 사용
              데이터가 삽입(갱신)되는 경우 새롭게 들어온 값
              DELETE 시에는 모두 NULL임
   (2) :OLD - DELETE, UPDATE 이벤트시 사용
              데이터가 삭제(갱신)되는 경우 이미 존재하고 있던 값
              INSERT 시에는 모두 NULL임
              
  2)트리거 함수 - 행단위 트리거에서만 사용 가능
   - 트리거의 이벤트를 구별하기 위한 함수
   (1) INSERTING : 트리거의 이벤트가 INSERT이면 참
   (2) UPDATING : 트리거의 이벤트가 UPDATE이면 참
   (3) DELETING : 트리거의 이벤트가 DELETE이면 참   

사용예)오늘('20050806')'b001'회원(라준호)이 상품 'P202000019'을 5개 구입했을 때 CART테이블과
      재고수불테이블에 자료를 삽입 및 갱신하시오(트리거 이용)

CREATE OR REPLACE TRIGGER TG_CART_CHANGE
    AFTER
    INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
DECLARE
    V_QTY    NUMBER         := 0;
    V_PID    PROD.PROD_ID   %TYPE;
    V_DATE   DATE;
BEGIN
    IF
        INSERTING
    THEN
        V_QTY := NVL(:NEW.CART_QTY,0);
        V_PID :=:NEW.CART_PROD;
        V_DATE:= TO_DATE(SUBSTR(:NEW.CART_NO,1,8) );
    ELSIF UPDATING THEN
        V_QTY := NVL(:NEW.CART_QTY,0) - NVL(:OLD.CART_QTY,0);
        V_PID :=:NEW.CART_PROD;
        V_DATE:= TO_DATE(SUBSTR(:NEW.CART_NO,1,8) );
    ELSIF DELETING THEN
        V_QTY :=-NVL(:OLD.CART_QTY,0);
        V_PID :=:OLD.CART_PROD;
        V_DATE:= TO_DATE(SUBSTR(:OLD.CART_NO,1,8) );
    END IF;

    UPDATE REMAIN
        SET
            REMAIN_O    = REMAIN_O + V_QTY,
            REMAIN_J_99 = REMAIN_J_99 - V_QTY,
            REMAIN_DATE = V_DATE
    WHERE
        REMAIN_YEAR = '2005'
        AND   PROD_ID = V_PID;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류발생 : '
        || SQLERRM);
END;

INSERT되어지거나 UPDATE되어지거나 DELETE되어질 때 하나의 트리거로 REMAIN테이블을 연동시키고 싶다

TRIGGER에서는 부적합한 DML명령을 수행하지 못하게 할 수 없음
예를 들어서 재고는 30개가 있는데 CART에서 출고물량이 50개가 들어온다면 TRIGGER에서는 INSERT를 하지 못하게 할 수 없음

부적합한 DML명령을 방지하려면 DML명령을 PL/SQL블럭에 넣어서 IF를 통해서 처리해야 한다.

이것을 연동하지 않고 트리거에서만 내부 일관성을 유지하고 싶다면 각 IF문 안에다가 EXIT를 넣어서 TRIGGER를 끝낼 수 있음
그러면 부적합한 DML명령에 대하여 TRIGGER에서 재고테이블 업데이트는 막지만 CART에는 부적합한 레코드가 그대로 들어오게 됨
이 부분에서 INTEGRITY가 훼손되므로 해당 DML명령을 제어하는 블록이 필요하다.

(실행)

ACCEPT P_AMT PROMPT '수량 : '
DECLARE
    V_CNT       NUMBER := 0;
    V_CARTNO    CHAR(13);
    V_AMT       NUMBER := TO_NUMBER('&P_AMT');
BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,8) = '20050806';
    
    IF V_CNT = 0 THEN
        V_CARTNO    := '2005080600001';
        INSERT INTO CART(CART_MEMBER, CART_NO, CART_PROD, CART_QTY)
        VALUES('b001', V_CARTNO, 'P202000019', V_AMT);
    ELSE
        IF V_AMT != 0 THEN
            UPDATE CART
               SET CART_QTY     = V_AMT
             WHERE CART_NO      = '2005080600001'
               AND CART_PROD    = 'P202000019';
        ELSE
            DELETE CART
             WHERE CART_NO      = '2005080600001'
               AND CART_PROD    = 'P202000019';
        END IF;
    END IF;
    COMMIT;
END;
