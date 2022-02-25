2021-0805-01)User Defined Function(�Լ�)
  - ���ν����� ���� ���� ����
  - ��ȯ ���� ����
  - ���� ���Ǵ� �������� �Ǵ� ������ ����� ���� �Լ��� ����
  - SELECT ���� SELECT��, WHERE���� ��밡��
  
  (�������)
  CREATE [OR REPLACE] FUNCTION �Լ���[(
    �Ű����� [MODE] Ÿ�� [:=��][,
              :
    �Ű����� [MODE] Ÿ�� [:=��]])]
    RETURN ������ Ÿ��
  IS|AS
    ���𿵿�
  BEGIN
    ���࿵��
    RETURN ��|expr;
  END;
   - 'RETURN ������ Ÿ��' : ��ȯ�� ������ Ÿ��(�⺻ ������ Ÿ��, ������ ������Ÿ��(���̺��̳� ��)�� ��ȯ�Ұ�)
   - 'RETURN ��|expr' : ��ȯ�ؾ� �ϴ� ���̳� ���� �����ϴ� ���� ������ �ݵ�� 1�� �̻� �����ؾ� ��
   - OUT �Ű������� �̿��� �� ��ȯ�� ����� ���ؼ� �ݵ�� PL/SQL �͸����� �ʿ���.
     �׷��� �Լ��� OUT�Ű������� ���� Ȱ���ϴ� ���� ���� ����
     
��ȯ : �ش� �Լ����� ����Ǿ����� ��ġ�� �� �ϳ��� ��ȯ ������� ��
���ν����� �Ϲ� ���������� ����� �Ұ��ϳ� �Լ��� �Ϲ� ����(SELECT, INSERT ���� ��������)���� ����� �� �ִ�.

��ȯ�ؾ� �ϴ� ���� �������� �� ����.
�ݵ�� �������� ��ȯ�ϰ� ������ ��� ���ڿ��� ��� ��ȯ�ϴ� ������ Ȱ��

��뿹)'����'�� �����ϴ� ȸ����ȣ�� �Է¹޾� �ش�ȸ���� 2005�� 6�� ���űݾ��� ����ϴ� �Լ��� �ۼ��Ͻÿ�.

(�Լ�)
CREATE OR REPLACE FUNCTION FN_SUM01(
    P_MID   MEMBER.MEM_ID   %TYPE)  --�Ű������� MODE�� �����ϸ� DEFAULT�� IN
    RETURN  NUMBER
IS
    V_SUM   NUMBER := 0;    --���űݾ� �հ�
    V_CNT   NUMBER := 0;    --�ش�ȸ���� �ڷ�(CART) ��������
                            --BOOLEAN���� �� ���� ������ SELECT ���� COUNT�� ���� ���� ���� ���� �Ҵ��ϴ� �����ʿ�
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

(����)
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_ADD1 || ' ' || MEM_ADD2 AS "�ּ�",
       FN_SUM01(MEM_ID) AS "���űݾ�"
  FROM MEMBER
 WHERE SUBSTR(MEM_ADD1,1,2) = '����';
 
��뿹)��ǰ�ڵ�� �⵵ �� ���� �Է¹޾� �ش� ��ǰ�� ���ż����� ���űݾ��� ����ϴ� �Լ��� �ۼ��Ͻÿ�.

(�Լ�) : FN_BUY01

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
    V_RES := '���ż��� : ' || V_AMT || ', ���űݾ� : ' || V_SUM;
    RETURN V_RES;
END;

(����)
SELECT PROD_ID, PROD_NAME, FN_BUY01(PROD_ID, '2005', '05')
  FROM PROD;
  
(�Լ�) : FN_BUY02

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

(����)
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

��뿹)�⵵�� ���� 6�ڸ� ���ڿ��� �Է� �޾� �ش���� ���� ���� ��ǰ�� ����(�ݾױ���)�� ȸ���� �̸��� ���űݾ��� ����ϴ� �Լ��� �ۼ��Ͻÿ�
      �Լ���:FN_MAXMEM

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
    
--    RETURN 'ȸ���̸� : ' || V_MNAME || ', ���űݾ� : ' || V_SUM;
    RETURN 'ȸ���̸� : ';

END;

SELECT FN_MAXMEM('200506') AS "�ְ��Ű�" FROM DUAL;

����)
LIKE ���� : CART_NO LIKE P_DATE||'%'
VARCHAR2, CHAR ������Ÿ���� VARCHAR2(ũ��), CHAR(ũ��)���� ũ�� �Ⱦ��� �����Ͽ����� �߻��Ѵ�
SELECT INTO���� SELECT �� ���� ����� NULL�� ���� ������ ������ ������ ��ȸ�غ��� NULL�� �Ǿ��ִ�.
PL/SQL�� ���� SELECT INTO���� ���ڵ尡 ���ٸ� Ư�� ���� RETURN���� �׻� ����ϰ��� �ص� NULL�� ��µȴ�(����?)


ACCEPT  P_DATE  PROMPT  '���(YYYYMM) : '
DECLARE
    V_RES   VARCHAR2(50);
BEGIN
    V_RES := FN_MAXMEM('&P_DATE');
    DBMS_OUTPUT.PUT_LINE(SUBSTR('&P_DATE',1,4) || '�� ' || SUBSTR('&P_DATE',5,2) || '��');
    DBMS_OUTPUT.PUT_LINE(V_RES);
END;