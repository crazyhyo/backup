2021-0805-02)Ʈ���� TRIGGER
  - Ư�� �̺�Ʈ�� �߻� �� �Ǵ� ���� �ڵ����� ����Ǿ� �� ���ν���
  - Ʈ���Ŵ� ������� Ʈ���ſ� ����� Ʈ���ŷ� ����
  - ������� Ʈ���� ���� �� Ʈ���Ű� �Ϸ���� ���� ���¿��� �Ǵٸ� Ʈ���� ȣ���
    ���̺��� �ϰ��� ������ ���� �ش����̺��� ������ ������
  
  (�������)
  CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    timming[BEFORE|AFTER] event[INSERT|UPDATE|DELETE]
    ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
    [DECLARE
        �����
    ]
    BEGIN
        �����
    END;
     - 'BEFORE|AFTER' : '�����'(Ʈ���� ����)�� ����� ����
     - 'INSERT|UPDATE|DELETE' : Ʈ���Ÿ� �߻���Ű�� �̺�Ʈ�� OR �����ڷ� ������ ��� ����
       EX) INSERT OR DELETE, INSERT OR UPDATE OR DELETE etc..
     - 'FOR EACH ROW' : ����� Ʈ���� �� ���(�����ϸ� ������� Ʈ����)
     - 'WHEN ����' : ����� Ʈ���ſ����� ��� �����ϸ�, �̺�Ʈ �߻��� ���� ��ü���� ���� ���
     
Ʈ���� ���� ���� ���ǰ� �ʿ���. ���ν����� ����
BEFORE�� ����ϴ� TRIGGER�� ������ ����.(īƮ/��ǰ�� ���� ��ǰ�� �Ǹ��ϴ� �Ͱ� ���� �������� ��쿡 �ʿ�)
����� Ʈ���� : �� �࿡ ���Ͽ� INSERT, DELETE OR UPDATE �� ����� ������ Ʈ���Ÿ� ����
OLD�� NEW�� �̿��Ͽ� ȿ���� TRIGGER �ۼ� ����[����� Ʈ���ſ����� ����]
Ʈ���� �Լ� ����

������� Ʈ���� : INSERT, UPDATE, DELETE�� ����Ǿ��� �� ������� ���� ���� ������� ��ɸ��� �� ���� �����ϴ� Ʈ����

(������� Ʈ����)
�з����̺� ���ο� �з��ڵ带 �����Ͻÿ�. ���� �� '���ο� �з��� �߰��Ǿ����ϴ�.'�� ����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
[�з��ڵ� 'P502', �з��� : '�ӻ깰', ���� : 11]

CREATE OR REPLACE TRIGGER TG_LPROD_INSERT
    AFTER INSERT ON LPROD
BEGIN
    DBMS_OUTPUT.PUT_LINE('���ο� �з��� �߰��Ǿ����ϴ�.');
END;

CREATE OR REPLACE TRIGGER TG_LPROD_DELETE
    AFTER DELETE ON LPROD
BEGIN
    DBMS_OUTPUT.PUT_LINE('�з��� �����Ǿ����ϴ�.');
END;

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(11, 'P502', '�ӻ깰');

SELECT * FROM LPROD;    --���� ��ɰ� ���� ����� �� �� �������� �޼����� ���´�.

COMMIT;                 --�� �������� �޼����� ���´�
SELECT * FROM LPROD;

TRIGGER ���ο����� COMMIT�̳� ROLLBACK����

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(12, 'P503', '��깰');
COMMIT;                 --�� �������� �޼����� ���´�

COMMIT�� ���� ������ MEMORY�󿡼��� ����Ǿ��� ��, COMMIT�� �ؾ� �޽����� ���(Ʈ���� ����)�ȴ�.
��, ������� Ʈ���Ÿ� �ߵ���Ű�� DML�� SELECT���� ���ÿ� �����ϸ� �޽����� ���(Ʈ���� ����)�ȴ�.
Ʈ���� ���ο��� ���ν����� �Լ��� ����� �� �ִ�.

INSERT INTO LPROD(LPROD_ID, LPROD_GU, LPROD_NM) VALUES(13, 'P504', '����깰');

SELECT * FROM LPROD;    --���� ��ɰ� ���� ����� �� �� �������� �޼����� ���´�.

DML����� ����� ���� COMMIT�ϴ� ������ ������

DELETE LPROD WHERE LPROD_ID = 11;

SELECT * FROM LPROD;    --���� ��ɰ� ���� ����� �� �� �������� �޼����� ���´�.

COMMIT;

(����� Ʈ����)
������ 2005�� 6�� 11���̶�� �����ϰ�, ��ǰ�ڵ尡 'P102000005'�� ��ǰ 10�븦 �����ߴٰ� ����.
�� ������ �������̺� ������ �� ��� ���� ���̺��� �����ϴ� Ʈ���Ÿ� �ۼ��Ͻÿ�.
[�ܼ�ȭ ���� : �� ���������� INSERT�� ����ȴ�]

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
           
    DBMS_OUTPUT.PUT_LINE(:NEW.BUY_PROD || '��ǰ�� ' || V_QTY || '�� �԰�Ǿ����ϴ�.');
  --DBMS_OUTPUT.PUT_LINE(:NEW.BUY_PROD || '��ǰ�� ' || :NEW.BUY_QTY || '�� �԰�Ǿ����ϴ�.');
END;

INSERT INTO BUYPROD
SELECT TO_DATE('20050611'), PROD_ID, 10, PROD_COST
  FROM PROD
 WHERE PROD_ID = 'P102000005';

COMMIT;

���� BUYPROD�� CART���̺��� PK�� (BUY_DATE, BUY_PROD), (CART_NO, CART_PROD)�� �����Ǿ� ����
���� ���� ��(Ȥ�� ���� ���̸� �α׾ƿ� ���� �ʾ��� �Ⱓ����) ���� ��ǰ�� ����/���� �ϰ� �Ǹ�
���� ���� PK�� ������ ���ڵ带 �˻��Ͽ� �׷��� ���ڵ尡 ���ٸ� INSERT��, �ִٸ� UPDATE�� ���̺��� �����ϰ� �ȴ�.

:NEW�� ���ο� ���ڵ带 ��Ÿ����. :OLD�� ������ ���ڵ带 ��Ÿ����.

  1)Ʈ���� �ǻ緹�ڵ�
   (1) :NEW - INSERT, UPDATE �̺�Ʈ�� ���
              �����Ͱ� ����(����)�Ǵ� ��� ���Ӱ� ���� ��
              DELETE �ÿ��� ��� NULL��
   (2) :OLD - DELETE, UPDATE �̺�Ʈ�� ���
              �����Ͱ� ����(����)�Ǵ� ��� �̹� �����ϰ� �ִ� ��
              INSERT �ÿ��� ��� NULL��
              
  2)Ʈ���� �Լ� - ����� Ʈ���ſ����� ��� ����
   - Ʈ������ �̺�Ʈ�� �����ϱ� ���� �Լ�
   (1) INSERTING : Ʈ������ �̺�Ʈ�� INSERT�̸� ��
   (2) UPDATING : Ʈ������ �̺�Ʈ�� UPDATE�̸� ��
   (3) DELETING : Ʈ������ �̺�Ʈ�� DELETE�̸� ��   

��뿹)����('20050806')'b001'ȸ��(����ȣ)�� ��ǰ 'P202000019'�� 5�� �������� �� CART���̺��
      ���������̺� �ڷḦ ���� �� �����Ͻÿ�(Ʈ���� �̿�)

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
        DBMS_OUTPUT.PUT_LINE('�����߻� : '
        || SQLERRM);
END;

INSERT�Ǿ����ų� UPDATE�Ǿ����ų� DELETE�Ǿ��� �� �ϳ��� Ʈ���ŷ� REMAIN���̺��� ������Ű�� �ʹ�

TRIGGER������ �������� DML����� �������� ���ϰ� �� �� ����
���� �� ���� 30���� �ִµ� CART���� ������� 50���� ���´ٸ� TRIGGER������ INSERT�� ���� ���ϰ� �� �� ����

�������� DML����� �����Ϸ��� DML����� PL/SQL���� �־ IF�� ���ؼ� ó���ؾ� �Ѵ�.

�̰��� �������� �ʰ� Ʈ���ſ����� ���� �ϰ����� �����ϰ� �ʹٸ� �� IF�� �ȿ��ٰ� EXIT�� �־ TRIGGER�� ���� �� ����
�׷��� �������� DML��ɿ� ���Ͽ� TRIGGER���� ������̺� ������Ʈ�� ������ CART���� �������� ���ڵ尡 �״�� ������ ��
�� �κп��� INTEGRITY�� �ѼյǹǷ� �ش� DML����� �����ϴ� ����� �ʿ��ϴ�.

(����)

ACCEPT P_AMT PROMPT '���� : '
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
