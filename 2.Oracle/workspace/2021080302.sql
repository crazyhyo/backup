2021-0803-02)Ŀ��(CURSOR)
  - ����Ŭ SQL��ɿ� ���Ͽ� ������� ����� ����
  - SELECT���� ���� ��ȯ�� ��� ������ ����� ���ʴ�� �����ؾ� �ϴ� ��� ���
  - �����ڰ� ����� ���������� ������ �ʿ䰡 �ִ� ��� ���
  - IMPLICIT, EXPLICIT CURSOR
  - Ŀ���� ����� FOR���� �����ϰ� ���� (����) -> OPEN -> FETCH -> CLOSE �ܰ踦 ���ʴ�� ����
  (1)�͸�Ŀ��(IMPLICIT CURSOR)
   - �̸��� ���� Ŀ��
   - SELECT���� ����Ǹ� ���(Ŀ��)�� �ڵ����� OPEN�� �� ������ ���� �ڵ����� CLOSE��(���� �Ұ�)
   - Ŀ���Ӽ�
     SQL%ISOPEN : Ŀ���� OPEN �����̸� ��(TRUE) ��ȯ - �׻� ����(FALSE)[�͸�Ŀ���̱� ������]
     SQL%NOTFOUND : Ŀ���� �ڷᰡ �������� ������ ��(TRUE) ��ȯ
     SQL%FOUND : Ŀ���� �ڷᰡ ���������� ��(TRUE) ��ȯ
     SQL%ROWCOUNT : Ŀ���� �����ϴ� �ڷ��� ��
     

FOR���� ����ϸ� OPEN, FETCH, CLOSE�� ��� ���� ������(CURSOR�� ���� FOR���� ���� ����)
WHILE���� SQL%FOUND, LOOP���� EXIT WHEN SQL%NOTFOUND�� ����ϴ� ���� �Ϲ���

  (2)����� Ŀ��(EXPLICIT CURSOR)
   - �̸��� �ο��� Ŀ��
   (�������� - �����)
    CURSOR Ŀ����[(���� Ÿ�Ը�[,���� Ÿ�Ը�,...])] IS
    SELECT ��;
    
    (�����)
    OPEN Ŀ����[(�Ű�����[,�Ű�����,...])];
    
    FETCH Ŀ���� INTO ����LIST;
    
    CLOSE Ŀ����;
    
SQL%NOTFOUND, SQL%FOUND�� FETCH���� ����� �Ŀ� ���ǵ�

��뿹1)2005�� 5�� �԰��ǰ�� �����Ȳ�� ��ȸ�ϴ� Ŀ���� �ۼ��Ͻÿ�.
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, ����

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    V_CNT                   NUMBER := 0; --���ⵥ���Ͱ� �ִ��� ������
    
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
        ELSE        --���� �ڵ�(IF�� CNT�� ���ǵ��� �ʾ��� ��)���� ������ �߻��� �κ�
                    --������ ������ ������ ���»�ǰ�� ��� SELECT���� �� ���̺��� ��ȯ�Ͽ� INTO V_PNAME, V_AMT ����ȵ�
                    --���⿡�� �� ���� ������ �� ���ٰ�(?) ������ ����
            DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || V_PID || '�� �Ǹŵ��� ����');
            DBMS_OUTPUT.PUT_LINE('-----------------------');
        END IF;
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� : ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('�Ǹż��� : ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-----------------------');
    END LOOP;
    CLOSE CUR_BUY01;
END;

��뿹2)2005�� ��ǰ�� �԰�����հ踦 ����ϴ� ����� Ŀ���� �̿��Ͽ� �ۼ��Ͻÿ�
      ALIAS�� ��ǰ�ڵ�, ��ǰ��, �԰����
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
        
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('�԰���� ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('ī��Ʈ ' || V_CNT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
         
    END LOOP;
    
    CLOSE CUR_PROD01;
END;

FETCH INTO�� �ϳ��� ����, FETCH�� Ŀ���� �� �� ��ü�� ��������. �׷��� Ŀ���� ���� �� ��ŭ�� ������ �����Ͽ� ��� �޾ƾ� �Ѵ�.
�ȱ׷��� ����. Ŀ���� FETCH�� �� ������ ���ʷ� �����´�(ORDER BY�� Ȯ���غ�)
Ŀ���� ��ü�� �ƴϴ�. VIEW�δ� �ϳ��� �о�� �� ����. Ŀ���� �Ű������� ����ϴ� ���� Ŀ����
�����ϴ� SELECT���� �Ű������� ����ϰ� ���� ���̴�(���� ���ǿ� �Ű������� Ȱ���Ѵ�). ������ ��ٷο�Ƿ� ����

2005�� ��ǰ�� �԰���� �հ�

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
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('�԰���� ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    END LOOP;
    
    CLOSE CUR_BUY02;
END;

����)�� 1���� 2���� WHILE���� ����Ͽ� �ۼ��Ͻÿ�.

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
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('�԰���� ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FETCH CUR_BUY02 INTO V_PID, V_PNAME, V_AMT;
    END LOOP;
    
    CLOSE CUR_BUY02;
END;

DECLARE
    V_PID   PROD.PROD_ID    %TYPE;
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_AMT                   NUMBER := 0;
    V_CNT                   NUMBER := 0; --���ⵥ���Ͱ� �ִ��� ������
    
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
            DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || V_PID || '�� �Ǹŵ��� ����');
            DBMS_OUTPUT.PUT_LINE('-----------------------');
        END IF;
        DBMS_OUTPUT.PUT_LINE('��ǰ�ڵ� : ' || V_PID);
        DBMS_OUTPUT.PUT_LINE('��ǰ�� : ' || V_PNAME);
        DBMS_OUTPUT.PUT_LINE('�Ǹż��� : ' || V_AMT);
        DBMS_OUTPUT.PUT_LINE('-----------------------');
        
        FETCH CUR_BUY01 INTO V_PID;
        
    END LOOP;
    CLOSE CUR_BUY01;
END;

