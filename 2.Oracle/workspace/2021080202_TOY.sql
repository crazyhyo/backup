��뿹)Ű����� 10~110������ �μ���ȣ�� �Է¹޾� �ش�μ������� ���� �Ի����� ���� ��� ������ ����Ͻÿ�
      ALIAS�� �����ȣ, �����, �Ի���, ��å�ڵ��̴�
      
ACCEPT P_DID PROMPT '�μ���ȣ �Է�'
DECLARE
    V_EID   HR.EMPLOYEES.EMPLOYEE_ID    %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME       %TYPE;
    V_HIRE  HR.EMPLOYEES.HIRE_DATE      %TYPE;
    V_JOBID HR.EMPLOYEES.JOB_ID         %TYPE;
BEGIN
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.HIRE_DATE, A.JOB_ID
      INTO V_EID, V_ENAME, V_HIRE, V_JOBID
      FROM (SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
              FROM HR.EMPLOYEES
             WHERE DEPARTMENT_ID = TO_NUMBER('&P_DID')
             ORDER BY 3) A
     WHERE ROWNUM = 1;
     
     DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || V_EID);
     DBMS_OUTPUT.PUT_LINE('����� : ' || V_ENAME);
     DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || V_HIRE);
     DBMS_OUTPUT.PUT_LINE('������ : ' || V_JOBID);
     
     EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܹ߻� : ' || SQLERRM);
END;
      
��뿹)������ ���� �Է� �޾� ¦������ Ȧ������ �Ǻ��Ͻÿ�

ACCEPT P_NUM PROMPT '���� �Է�'
DECLARE
BEGIN
    IF MOD(TO_NUMBER('&P_NUM'),2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EVEN');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ODD');
    END IF;
END;


��뿹)ȸ�����̺��� ȸ������ ���ϸ����� ��ȸ�Ͽ� �� ���� 5000�̻��̸� 'VIP ȸ��'�� 
      3000 �̻��̸� '��ȸ��'��, �� �����̸� '��ȸ��'�� ȸ����ȣ, ȸ����, ���ϸ����� �Բ� ����Ͻÿ�.
      
DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_MNAME MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_GD    VARCHAR2(30);
    
    CURSOR CUR_MEM01 IS
        SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,
               CASE WHEN MEM_MILEAGE >= 5000 THEN   'VIP ȸ��'
                    WHEN MEM_MILEAGE >= 3000 THEN   '��ȸ��'
                    ELSE                            '��ȸ��'
               END
          FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_MNAME, V_MILE, V_GD;
        EXIT WHEN CUR_MEM01%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(V_MID);
        DBMS_OUTPUT.PUT_LINE(V_MNAME);
        DBMS_OUTPUT.PUT_LINE(V_MILE);
        DBMS_OUTPUT.PUT_LINE(V_GD);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
    
END;

DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_MNAME MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_RES   VARCHAR2(100);
    
    CURSOR CUR_MEM01 IS
        SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
          FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_MNAME, V_MILE;
        EXIT WHEN CUR_MEM01 % NOTFOUND;
        
        IF      V_MILE >= 5000  THEN    V_RES := 'VIP ȸ��';
        ELSIF   V_MILE >= 3000  THEN    V_RES := '��ȸ��';
        ELSE                            V_RES := '��ȸ��';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(V_MID || ' ' || V_MNAME || ' ' || V_MILE || ' ' || V_RES);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
END;
      
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
      
      
ACCEPT P_INPUT PROMPT '���� ��뷮 �Է�(�� ����)'
DECLARE
    V_AMT   NUMBER;
    V_RES   NUMBER;
BEGIN
    V_AMT := TO_NUMBER('&P_INPUT');
    
    IF V_AMT <= 10 THEN
        V_RES := V_AMT * 275 + V_AMT * 120;
    ELSIF V_AMT <= 20 THEN
        V_RES := (V_AMT - 10) * 305 + V_AMT * 120 + 10 * 275;
    ELSIF V_AMT <= 30 THEN
        V_RES := (V_AMT - 20) * 350 + V_AMT * 120 + 10 * 275 + 10 * 305;
    ELSIF V_AMT <= 40 THEN
        V_RES := (V_AMT - 30) * 415 + V_AMT * 120 + 10 * 275 + 10 * 305 + 10 * 350;
    ELSE
        V_RES := (V_AMT - 40) * 500 + V_AMT * 120 + 10 * 275 + 10 * 305 + 10 * 350 + 10 * 415;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
    
END;