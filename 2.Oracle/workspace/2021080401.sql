2021-0804-01)
   (3)FOR ��
    - ���߾���� FOR���� ������ ����
    - �Ϲ� �ݺ�ó���� ���� FOR���� CURSORó���� ���� FOR���� ����
 (�Ϲ� FOR�� �������)
  FOR �ε��� IN [REVERSE] �ʱⰪ..�ִ밪 LOOP
    �ݺ�ó����ɹ�(n);
  END LOOP;
   - '�ε���' : ������� ���� �ε����� �ý��ۿ��� �ڵ� ����
   - 'REVERSE' : �������� �ݺ�ó���� ���

��뿹)�������� 7���� ����Ͻÿ�.

DECLARE
BEGIN
    FOR I IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(7 || ' * ' || I || ' = ' || 7 * I);
    END LOOP;
END;

��뿹)ù���� 100���� �����ϰ�, �� ������ ���� ������ 2�辿 ������ �� ���ʷ� 200������ �Ѵ� ���� ����ݾ��� ���Ͻÿ�

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

 (CURSOR�� ���� FOR�� �������)
  FOR ���ڵ�� IN Ŀ����|Ŀ������ LOOP
    �ݺ�ó����ɹ�(n);
  END LOOP;
   - '���ڵ��' : Ŀ���� ����Ű�� ���� ���� ������ �ִ� ������ �ý��ۿ��� ����
   - Ŀ������ ����(�÷�)�� ������ '���ڵ��.Ŀ���� �÷���' �������� ���
   - Ŀ���� OPEN, FETCH, CLOSE ����
   - 'Ŀ������' : ���𿵿����� �����ؾ��� Ŀ������ �� 'SELECT'���� ���������������� ���
   

DECLARE
BEGIN
    FOR REC1 IN (SELECT B.PROD_ID AS BID, B.PROD_NAME AS BNAME, SUM(A.BUY_QTY) AS AMT
                   FROM BUYPROD A, PROD B
                  WHERE A.BUY_PROD = B.PROD_ID
                        AND EXTRACT(YEAR FROM BUY_DATE) = 2005
                  GROUP BY B.PROD_ID, B.PROD_NAME)
    LOOP
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� ' || REC1.BID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� ' || REC1.BNAME);
        DBMS_OUTPUT.PUT_LINE('�԰���� ' || REC1.AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;
END;
   