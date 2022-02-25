2021-0803-01)
   (2) CASE��
     - ǥ�� SQL�� SELECT ���� ���Ǵ� CASEǥ���İ� ����
     - ���� �б� ��� ����
     (������� - 1)
      CASE ����|���� WHEN ��1 THEN ���1;
                    WHEN ��2 THEN ���2;
                             :
                    ELSE          ���n;
      END CASE;
      
     (������� - 2)
      CASE WHEN ����1 THEN ���1;
           WHEN ����2 THEN ���2;
                  :
           ELSE            ���n;
      END CASE;

IF���� ȿ������ �����, SWITCH�� �����ϳ� BREAK�ʿ� ����, PL/SQL�� CASE���� END CASE�� ����

��뿹)10-110������ ������ �߻����� ������ �ش��ϴ� �μ��� ���� ��� �� ù��° ����� �޿��� ��ȸ�Ͽ�
      5000�����̸� '���ӱ� ���', 10000�����̸� '����ӱ� ���', �� �̻��̸� '���ӱ� ���'�� 
      �����ȣ, �����, �μ���� �Բ� ����Ͻÿ�.
      
DECLARE
    V_EID   HR.EMPLOYEES.EMPOLYEE_ID    %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME       %TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
    V_SAL   HR.EMPLOYEES.SALARY         %TYPE;
    V_MESSAGE                           VARCHAR2(20);
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    V_DID := TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
    
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY,
           CASE WHEN SALARY <= 5000     THEN '���ӱ� ���'
                WHEN SALARY <= 10000    THEN '����ӱ� ���'
                ELSE                         '���ӱ� ���'
           END
      INTO V_EID, V_ENAME, V_DNAME, V_SAL, V_MESSAGE
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.DEPARTMENT_ID = V_DID;
    DBMS_OUTPUT.PUT_LINE(V_EID || ' ' || V_ENAME || ' ' || V_DNAME || ' ' || V_SAL || ' ' V_MESSAGE);
END;

DECLARE
    V_EID   HR.EMPLOYEES.EMPLOYEE_ID        %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME           %TYPE;
    V_DNAME HR.DEPARTMENTS.DEPARTMENT_NAME  %TYPE;
    V_SAL   HR.EMPLOYEES.SALARY             %TYPE;
    V_MESSAGE                               VARCHAR2(20);
    V_DID   HR.DEPARTMENTS.DEPARTMENT_ID    %TYPE;
BEGIN
    V_DID := TRUNC(SYS.DBMS_RANDOM.VALUE(10,110),-1);
    
    DBMS_OUTPUT.PUT_LINE(V_DID);
    
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_NAME, A.SALARY
      INTO V_EID, V_ENAME, V_DNAME, V_SAL
      FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
     WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
           AND A.DEPARTMENT_ID = V_DID
           AND ROWNUM = 1;
           
    CASE WHEN V_SAL <= 5000     THEN V_MESSAGE := '���ӱ� ���';
         WHEN V_SAL <= 10000    THEN V_MESSAGE := '����ӱ� ���';
         ELSE                        V_MESSAGE := '���ӱ� ���';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || V_DNAME);
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || V_EID);
    DBMS_OUTPUT.PUT_LINE('����� : ' || V_ENAME);
    DBMS_OUTPUT.PUT_LINE('��� : ' || V_MESSAGE);
END;

  2) �ݺ���
   - ����Ŭ�� �ݺ����� LOOP, WHILE, FOR���� ����
   (1) LOOP ��
    - �ݺ����� �⺻ ����
     (�������)
     LOOP
        �ݺ�ó����ɹ�[N];
        [EXIT WHEN ����;]
     END LOOP;
      - �⺻������ ���ѷ���
      - 'EXIT WHEN ����' : ������ ��(TRUE)�̸� �ݺ��� ���(END LOOP �������� ���� �̵�)

����Ŭ�� �����ͺ��̽�
�ڷḦ ��Ȯ�ϰ� �����ϰ� �����ϴ� �� // ������� �Ǵ��� ���� �ڷ� ������ �ñ����� ��ǥ
���α׷����� ���� ��ɵ��� �ƴ�, �ݺ����� CURSOR�� ���� ���δ�

��뿹) �������� 7���� ����ϴ� ����� �ۼ��Ͻÿ�

DECLARE
    V_CNT NUMBER := 1;
    V_RES NUMBER := 0;
BEGIN
    LOOP
        V_RES := V_CNT * 7;
        EXIT WHEN V_CNT > 9;
        DBMS_OUTPUT.PUT_LINE(7 || ' * ' || V_CNT || ' = ' || V_RES);
        V_CNT := V_CNT + 1;
    END LOOP;
END;

PL/SQL�� �����ߴµ� ����ð��� ���� �ɸ��� ���ں����� �ʱ�ȭ���� �ʰ� ����ߴ��� Ȯ���϶�

   (2) WHILE ��
    - ���߾���� WHILE���� ���� ��� �� ����
    (�������)
     WHILE ���� LOOP
        �ݺ�ó����ɹ�[n];
     END LOOP; 
      - '����'�� ���̸� �ݺ� ����

��뿹)�������� 7���� ����Ͻÿ�.

DECLARE
    V_CNT NUMBER := 1;
    V_RES NUMBER := 0;
BEGIN
    WHILE V_CNT <= 9 LOOP
        V_RES := V_CNT * 7;
        DBMS_OUTPUT.PUT_LINE(7 || ' * ' || V_CNT || ' = ' || V_RES);
        V_CNT := V_CNT + 1;
    END LOOP;
END;

