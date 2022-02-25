��뿹)'����'�� �����ϴ� ȸ����ȣ�� �Է¹޾� �ش�ȸ���� 2005�� 6�� ���űݾ��� ����ϴ� �Լ��� �ۼ��Ͻÿ�.

CREATE OR REPLACE FUNCTION FN_MEM01
    (P_MID   MEMBER.MEM_ID   %TYPE)
    RETURN  NUMBER
IS
    V_MNAME MEMBER.MEM_NAME %TYPE;
    V_SUM   NUMBER := 0;
    V_CNT   NUMBER := 0;
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,6) = '200506'
           AND CART_MEMBER = P_MID;
    
    IF V_CNT > 0 THEN
        SELECT B.MEM_NAME, NVL(SUM(A.CART_QTY * C.PROD_PRICE),0) INTO V_MNAME, V_SUM
          FROM CART A, MEMBER B, PROD C
         WHERE A.CART_MEMBER = B.MEM_ID
               AND A.CART_PROD = C.PROD_ID
               AND SUBSTR(A.CART_NO,1,6) = '200506'
               AND B.MEM_ID = P_MID
         GROUP BY B.MEM_NAME;
    END IF;
    
     RETURN V_SUM;
END;

SELECT MEM_ID, MEM_NAME, FN_MEM01(MEM_ID)
  FROM MEMBER
 WHERE SUBSTR(MEM_ADD1,1,2) = '����';

��뿹)��ǰ�ڵ�� �⵵ �� ���� �Է¹޾� �ش� ��ǰ�� ���ż����� ���űݾ��� ����ϴ� �Լ��� �ۼ��Ͻÿ�.

CREATE OR REPLACE FUNCTION FN_CART01
    (P_PID      PROD.PROD_ID    %TYPE,
    P_YEAR      VARCHAR2,
    P_MONTH     VARCHAR2)
    RETURN  VARCHAR2
IS
    V_DATE  DATE            := TO_DATE(P_YEAR || P_MONTH || '01');
    V_PNAME PROD.PROD_NAME  %TYPE;
    V_QTY   NUMBER          := 0;
    V_AMT   NUMBER          := 0;
    V_CNT   NUMBER          := 0;
BEGIN
    SELECT COUNT(*) INTO V_CNT
      FROM BUYPROD
     WHERE BUY_PROD = P_PID
           AND BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE);
           
    IF V_CNT > 0 THEN
    
    SELECT B.PROD_NAME, SUM(A.BUY_QTY), SUM(A.BUY_QTY * B.PROD_COST) INTO V_PNAME, V_QTY, V_AMT
      FROM BUYPROD A, PROD B
     WHERE A.BUY_PROD = B.PROD_ID
           AND A.BUY_DATE BETWEEN V_DATE AND LAST_DAY(V_DATE)
           AND A.BUY_PROD = P_PID
     GROUP BY B.PROD_NAME;
           
    END IF;
    
    RETURN '���ż��� : ' || V_QTY || ', ���űݾ� : ' || V_AMT;
END;

SELECT PROD_ID, FN_CART01(PROD_ID, '2005', '06')
  FROM PROD;

��뿹)�⵵�� ���� 6�ڸ� ���ڿ��� �Է� �޾� �ش���� ���� ���� ��ǰ�� ����(�ݾױ���)�� ȸ���� �̸��� ���űݾ��� ����ϴ� �Լ��� �ۼ��Ͻÿ�
      �Լ���:FN_MAXMEM

CREATE OR REPLACE FUNCTION FN_MEM_AMT
    (P_DATE     VARCHAR2)
    RETURN      VARCHAR2
IS
    V_MNAME MEMBER.MEM_NAME %TYPE;
    V_AMT   NUMBER          := 0;
    V_CNT   NUMBER          := 0;
BEGIN
    SELECT COUNT(CART_NO) INTO V_CNT
      FROM CART
     WHERE SUBSTR(CART_NO,1,6) = P_DATE;
     
    IF V_CNT > 0 THEN
    
    SELECT MNAME, AMT INTO V_MNAME, V_AMT
      FROM (SELECT B.MEM_NAME AS MNAME, SUM(A.CART_QTY * C.PROD_PRICE) AS AMT
              FROM CART A, MEMBER B, PROD C
             WHERE A.CART_MEMBER = B.MEM_ID
                   AND A.CART_PROD = C.PROD_ID
                   AND SUBSTR(A.CART_NO,1,6) = P_DATE
             GROUP BY B.MEM_NAME
             ORDER BY 2 DESC)
     WHERE ROWNUM = 1;
     
     ELSE
     
     V_MNAME := '';
     
     END IF;
     
     RETURN 'ȸ���� : ' || V_MNAME || ', ���űݾ� : ' || V_AMT;
END;

SELECT FN_MEM_AMT('200505') FROM DUAL;
