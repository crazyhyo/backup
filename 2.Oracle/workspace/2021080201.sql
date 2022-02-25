2021-0802-01)PL/SQL(Procedual Language SQL)

  - ǥ�� SQL�� ������ Ȯ���� SQL
  - ������ ���డ���� ������ ���ȭ �� �������α׷�
  - block ������ ����
  - ���ȭ, ĸ��ȭ
  - Anonymous Block, User Defined Function(Function), Stored Procedure(Procedure),
    Package, Trigger ���� ������

1.�͸���(Anonymous Block)
 - PL/SQL�� �⺻����
 - �ܼ� ��ũ��Ʈ���� ����Ǵ� ���
 (�������)
 DECLARE
    �����(����, ���, Ŀ�� ����);
 BEGIN
    �����(�����Ͻ� ���� ó���� ���� sql��)
    [EXCEPTION 
        ����ó����;]
 END;

��뿹)Ű����� 10~110������ �μ���ȣ�� �Է¹޾� �ش�μ������� ���� �Ի����� ���� ��� ������ ����Ͻÿ�
      ALIAS�� �����ȣ, �����, �Ի���, ��å�ڵ��̴�
      
    ACCEPT P_DID PROMPT '�μ��ڵ�(10~110)'
    DECLARE
        V_EID       HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
        V_NAME      HR.EMPLOYEES.EMP_NAME   %TYPE;
        V_HIRE      HR.EMPLOYEES.HIRE_DATE  %TYPE;
        V_JOBID     HR.EMPLOYEES.JOB_ID     %TYPE;
    BEGIN
        SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.HIRE_DATE, A.JOB_ID
          INTO V_EID, V_NAME, V_HIRE, V_JOBID
          FROM (SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
                FROM HR.EMPLOYEES
                WHERE DEPARTMENT_ID = TO_NUMBER('&P_DID')
                ORDER BY 3) A;
         WHERE ROWNUM = 1;
         
        DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || V_EID);
        DBMS_OUTPUT.PUT_LINE('����� : ' || V_NAME);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || V_HIRE);
        DBMS_OUTPUT.PUT_LINE('��å�ڵ� : ' || V_JOBID);
        
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('���ܹ߻� : ' || SQLERRM);
    END;
 
PL/SQL�� SQL�� ANSI�� ���� �������� ǥ�ؾ��� ����(����Ŭ, MYSQL ��� �ٸ�)
���ȭ - �ϳ��� ��⿡ �ϳ��� ��ɸ��� ��ƾ� �Ѵ�.
ĸ��ȭ/����ȭ - �� ��Ⱓ�� �������� ���� �����ؼ��� �ȵ�
�Լ��� ���ν����� ��ȯ���� ������ ���е�
PL/SQL�� ��ü���� �������� ��� ��ü�ε�, �κ����ε� ���� �� �� �ִ� ����

��Ű���� ����δ� ������Ÿ��(�߻�޼ҵ�)�� ����
����ο��� ��ü������ �����Ѵ�

�͸����� Ư¡ : ����Ǿ����� �ʴ´� = �ٽ� �ҷ��鿩�� �� �� ����.

��ü������ ���� ����

������ V_�� ����, �Ű������� P_�� ����
WHEN OTHERS THEN (EXCEPTION Ŭ������ ���� ��� ���ܸ� ó���ϰ��� �� �� ���)

PLSQL�� DBMSâ�� �����־�� ��� ����

����->DBMSâ���� ����, �ڵ����� �������� ����, ���찳��ư���� ����

PL/SQL�� ���� �ٱ��ʿ� �ִ� SELECT ���� �ݵ�� INTO�� ����ؾ� ��
������ ���� �� �ڷḦ ����ϴ� ��� INTO�� ���� �� ����(�����߻�) �̸� �ذ��ϱ� ���� ���� Ŀ��

DBMS_OUTPUT.PUT_LINE = SYSOUT
WHEN OTHERS THEN = EXCEPTION e
DBMS_OUTPUT.PUT_LINE(SQLERRM) = e.printStackTrace()

ACCEPT�� �Է¹޴� �ڷ����� ���ڿ�(VARCHAR2)

  1) ������ ���
   - ����ο��� ����� ������ ���
   - SCALA ���� : �ϳ��� �����͸� �����ϴ� ����
    - REFERENCE ���� : ������ ���̺� �����ϴ� �÷��� Ÿ�԰� ũ�⸦ �����ϴ� ����
    - COMPOSITE ���� : PL/SQL���� ����ϴ� �迭 ���� - RECORD TYPE, TABLE TYPE
    - BIND ���� : �Ķ���ͷ� �Ѱ����� IN, OUT���� ���Ǵ� ����, ���ϰ��� �����ϱ� ���� ���Ǵ� ����
  (�������)
   ������[CONSTANT] ������Ÿ��[(ũ��)]|[���̺��.�÷���%TYPE|���̺��%ROWTYPE[:=�ʱⰪ]];
     - 'CONSTANT' : ��� ����
     - '���̺��.�÷���%TYPE|���̺��%ROWTYPE' : ����Ÿ��
     - ������ ������ ��� �ݵ�� �ʱ�ȭ �ؾ���
     - ������Ÿ�� : SQL���� ����ϴ� ������ Ÿ��,
        - BINARY_INTEGER, PLS_INTEGER : -2147483648 ~ 2147483647 ������ ���� ���
        - BOOLEAN : true, false, null�� ����ϴ� ���� ����

(LEFT VALUE) := (RIGHT VALUE)
':=' : ASSIGNMENT OPERATOR
LEFT VALUE : ������ �� �� ����
RIGHT VALUE : ���� ������ � ���̵� �� �� ����

������ SCALA ���� : �� ������ �ϳ��� ���� ������ �� �ִ� ����
COMPOSITE ���� : �� �� ��ü(RECORD TYPE)�� �ްų� �� ���̺� ��ü(TABLE TYPE)�� ���� �� �ִ� ����
BINDING TIME : ���� �����ϴ� ����
������ ��� BINDING TIME�� ���α׷� ���� ����, ������ ����
���������� ��� BINDING TIME�� ���α׷� ���� ��(��Ÿ��)
���̺��%ROWTYPE : �� �� ��ü�� ������ ��, ������ RECORD TYPE���� ����
:=�� %TYPE���Ŀ� ���� ���� ����Ѵ�

CREATE�ȿ��� CREATE�� ����� �� ����.
���� CREATE�� �����ϴ� PROCEDURE, FUNCTION, TRIGGER�ȿ����� CREATE���� ����� ���̺� ������ �Ұ����ϴ�
(�� Ŭ���� �ȿ� MAIN�޼��带 �ΰ� �̻� �����ϴ� ��, �����Ͽ���)
PL/SQL�ȿ��� ���̺��� �����ϴ��� BOOLEAN TYPE���� ���� ������ Ÿ���� ���ϴ� ���� �Ұ��ϴ�
PL/SQL�ȿ����� ���Ǵ� ������ Ÿ���� �������� ����ȴٰ� ��������

  2) �б���
  - ���α׷��� ���� ������ �����ϴ� ���
  - IF, CASE WHEN ���� ����
  (1) IF��
    - ���߾���� IF���� ������ ��� ����
    (������� - 1)
    IF ���� THEN
        ���1;
    [ELSE
        ���2;]
    END IF;
    
    (������� - 2)
    IF ���� THEN
        ���1;
    ELSIF ���� THEN
        ���2;
        :
    [ELSE
        ���n;]
    END IF;
    
    (������� - 3)
    IF ���� THEN
        ���1;
        IF ���� THEN
            ���2;
        ELSE
            ���3;
        END IF;
    ELSE
        ���n;
    END IF;
    
����Ŭ�� �߰�ȣ{}�� ���� ���ϱ� ������ IF ~ END IF;, CASE WHEN ~ END;, LOOP ~ END LOOP; BEGIN ~ END;
����Ŭ���� FOR�� �ȿ� FOR���� �ۼ��� �� �� ������ �� ���� ����

��뿹)������ ���� �Է� �޾� ¦������ Ȧ������ �Ǻ��Ͻÿ�
ACCEPT P_NUM PROMPT '�� �Է� : '
DECLARE
--    V_NUM NUMBER := 0;
    V_NUM NUMBER := TO_NUMBER('&P_NUM');
    V_RES VARCHAR2(100);
--    V_FLAG BOOLEAN := FALSE;
BEGIN
--    IF V_FLAG THEN
--        V_RES := 'TRUE';
--    ELSIF V_FLAG IS NULL THEN
--        V_RES := 'NULL';
--    ELSE 
--        V_RES := 'FALSE';
--    END IF;
--    
--    DBMS_OUTPUT.PUT_LINE(V_RES);
--    V_NUM := TO_NUMBER('&P_NUM');
    IF MOD(V_NUM,2) = 0 THEN
        V_RES := TO_CHAR(V_NUM)||'�� ¦�� �Դϴ�.';
--        DBMS_OUTPUT.PUT_LINE('¦�� �Դϴ�.');
    ELSE
        V_RES := TO_CHAR(V_NUM)||'�� Ȧ�� �Դϴ�.';
--        DBMS_OUTPUT.PUT_LINE('Ȧ�� �Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
--    EXCEPTION WHEN OTHERS THEN
--        DBMS_OUTPUT.PUT_LINE('����! : ' || SQLERRM);
END;
    
IF(A == 3)
    3;

IF ~ THEN ���̿� ������ ���ǿ��� BOOLEAN�� �� �� ������, ELSE �� BOOLEAN�� ���� �ƴ� ���� NULL�� FALSE�� ��� �޴´�

��뿹)ȸ�����̺��� ȸ������ ���ϸ����� ��ȸ�Ͽ� �� ���� 5000�̻��̸� 'VIP ȸ��'�� 
      3000 �̻��̸� '��ȸ��'��, �� �����̸� '��ȸ��'�� ȸ����ȣ, ȸ����, ���ϸ����� �Բ� ����Ͻÿ�.
      
SELECT MEM_ID AS "ȸ����ȣ",
       MEM_NAME AS "ȸ����",
       MEM_MILEAGE AS "���ϸ���",
       CASE WHEN MEM_MILEAGE >= 5000 THEN 'VIP ȸ��'
            WHEN MEM_MILEAGE >= 3000 THEN '��ȸ��'
            ELSE '��ȸ��'
       END AS "���"
  FROM MEMBER;
  
DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_NAME  MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_RES   VARCHAR2(100);
    
    CURSOR CUR_MEM01 IS
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
      FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_NAME, V_MILE;
        EXIT WHEN CUR_MEM01%NOTFOUND;
        IF      V_MILE >= 5000 THEN
            V_RES := TO_CHAR(V_MID) || ', ' || TO_CHAR(V_NAME) || ', ' || TO_CHAR(V_MILE)|| ', ' || 'VIP ȸ��';
        ELSIF   V_MILE >= 3000 THEN
            V_RES := TO_CHAR(V_MID) || ', ' || TO_CHAR(V_NAME) || ', ' || TO_CHAR(V_MILE)|| ', ' || '��ȸ��';
        ELSE
            V_RES := TO_CHAR(V_MID) || ', ' || TO_CHAR(V_NAME) || ', ' || TO_CHAR(V_MILE)|| ', ' || '��ȸ��';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
END;

DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_NAME  MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_RES   VARCHAR2(100);
    
    CURSOR CUR_MEM01 IS
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE, 
           CASE WHEN MEM_MILEAGE >= 5000 THEN 'VIP ȸ��'
                WHEN MEM_MILEAGE >= 3000 THEN '��ȸ��'
                ELSE '��ȸ��'
           END
      FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_NAME, V_MILE, V_RES;
        EXIT WHEN CUR_MEM01%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_MID || ' ' || V_NAME || ' ' || V_MILE || ' ' || V_RES);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
END;


����) PL/SQL������ �׻� �����ݷ��� �ٴ´ٰ� �����ض�.


��뿹)����ڷκ��� ���� ��뷮(�� ����)�� �Է� �޾� ��������� ����Ͽ� ����Ͻÿ�.
      ��뷮(��)     �����ܰ�(���)
        0-10            275
       10-20            305
       20-30            350
       30-40            415
       40-              500
      
      �ϼ��� ����� : ��뷮 * 120��
      EX)27���� ����� ���
      ó�� 10�� : 275 * 10 = 2750
      10-20�� : 305 * 10 = 3050
      20-27�� : 350 * 7 = 2450
      �ϼ��� ����� : 120 * 27 = 3240
      
      �� 11490��
;     
ACCEPT P_AMT PROMPT '������뷮 �Է�(�� ����)'
DECLARE
    REMAIN NUMBER := 0;
    AMT NUMBER := 0;
    RES NUMBER := 0;
BEGIN
    AMT := TO_NUMBER('&P_AMT');
    REMAIN := MOD(AMT,10);
    
    IF AMT <= 10 THEN
        RES := AMT * 275 + AMT * 120;
    ELSIF AMT <= 20 THEN
        RES := 10 * 275 + REMAIN * 305 + AMT * 120;
    ELSIF AMT <= 30 THEN
        RES := 10 * 275 + 10 * 305 + REMAIN * 350 + AMT * 120;
    ELSIF AMT <= 40 THEN
        RES := 10 * 275 + 10 * 305 + 10 * 350 + REMAIN * 415 + AMT * 120;
    ELSE
        RES := 10 * 275 + 10 * 305 + 10 * 350 + 10 * 415 + (AMT-40) * 500 + AMT * 120;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��������� ' || TO_CHAR(RES) || '�� �Դϴ�.');
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�Է¿��� : ' || SQLERRM);
END;

ACCEPT P_AMT PROMPT '������뷮 �Է�(�� ����)'
DECLARE
    REMAIN NUMBER := 0;
    AMT NUMBER := 0;
    RES NUMBER := 0;
BEGIN
    AMT := TO_NUMBER('&P_AMT');
    REMAIN := MOD(AMT,10);
    
    IF (AMT <= 10 AND AMT >= 0) THEN
        RES := AMT * 275 + AMT * 120;
    ELSIF AMT <= 20 THEN
        RES := 10 * 275 + REMAIN * 305 + AMT * 120;
    ELSIF AMT <= 30 THEN
        RES := 10 * 275 + 10 * 305 + REMAIN * 350 + AMT * 120;
    ELSIF AMT <= 40 THEN
        RES := 10 * 275 + 10 * 305 + 10 * 350 + REMAIN * 415 + AMT * 120;
    ELSIF AMT > 40 THEN
        RES := 10 * 275 + 10 * 305 + 10 * 350 + 10 * 415 + REMAIN * 500 + AMT * 120;
    ELSIF AMT < 0 THEN
        DBMS_OUTPUT.PUT_LINE('����� �Է����ּ���');
  
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��������� ' || TO_CHAR(RES) || '�� �Դϴ�.');
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�Է¿��� : ' || SQLERRM);
END;

����) PL/SQL���� ������ ���� �Ҵ� �� ���� :=�� �̿��Ѵ�(������ =���� �ϴϱ� ���� �ߴ���