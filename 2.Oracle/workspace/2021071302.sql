2021-0713-02)�Լ�(FUNCTION)
  - Ư�� ����� ��ȯ�ϱ� ���Ͽ� �̸� �ۼ��Ͽ� �����ϵ� ���
  - ��ȯ���� ����
  - ������ ��Ʈ��ũ ���� ������ �⿩
  - ������ �Լ��� ������ �Լ�(�����Լ�:SUM,AVG,COUNT,MAX,MIN)�� ����
  - ���ڿ�, ����, ��¥, ����ȯ, NULLó��, �����Լ� ���� ����
  - ��ø��� �� �� ����
  
  1. ���ڿ� �Լ�
   1) || (���ڿ� ���� ������)
    - �ڹ��� ���ڿ����� ���Ǵ� '+'�� ����            -- ���� ����� CONCAT, APPEND �޼��� ����, �ٵ� �� �Ⱦ�
    - �� ���ڿ��� �����Ͽ� ���ο� ���ڿ��� ��ȯ
    
��뿹)ȸ�����̺��� �泲�� �����ϴ� ȸ�������� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, �ּ��̸� �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ���
SELECT      MEM_ID                              AS  ȸ����ȣ,
            MEM_NAME                            AS  ȸ����,
            MEM_REGNO1  ||'-'||     MEM_REGNO2  AS  �ֹι�ȣ,
            MEM_ADD1    ||' '||     MEM_ADD2    AS  �ּ�
FROM        MEMBER
WHERE       SUBSTR(MEM_ADD1,1,2) = '�泲'
ORDER BY    1;
--      WHERE   MEM_ADD1    LIKE    '�泲%'

   2) CONCAT(C1, C2)
    - �־��� ���ڿ� �ڷ� C1�� C2�� �����Ͽ� ��ȯ (�Ķ���ʹ� 2�� ����)
    
��뿹)ȸ�����̺��� �泲�� �����ϴ� ȸ�������� ��ȸ�Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, �ּ��̸� �ֹι�ȣ�� 'XXXXXX-XXXXXXX'�������� ���
SELECT      MEM_ID                                      AS  ȸ����ȣ,
            MEM_NAME                                    AS  ȸ����,
            CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2)   AS  �ֹι�ȣ,
            CONCAT(CONCAT(MEM_ADD1,' '),MEM_ADD2)       AS  �ּ�,
            CONCAT(MEM_ID,MEM_REGNO1)                   AS  TEST        --  CHAR�� VARCHAR2�� ��ĥ �� ����
FROM        MEMBER
WHERE       SUBSTR(MEM_ADD1,1,2) = '�泲'
ORDER BY    1;    

   3) ASCII(C1), CHR(N1)
    - ASCII(C1) : C1�� �ش��ϴ� ���ڸ� ��ȯ
    - CHR(N1) : ���� N1�� �ش��ϴ� ASCII �ڵ尪 ��ȯ

��뿹)
    SELECT ASCII(PROD_ID), CHR(65) FROM PROD;
    SELECT ASCII(MEM_ID), CHR(65) FROM MEMBER;
��뿹)
DECLARE

BEGIN
    FOR I IN 1..255 LOOP
        DBMS_OUTPUT.PUT_LINE(I||'='||CHR(I));               --CHR(37)�� %��!
    END LOOP;
END;


    
�Լ��� ��ü��
����� ���� �Լ��� PL/SQL�� �����ƾ
�Լ��� ���ν��� : �Լ��� ��ȯ�� / ��ȯŸ���� �ְ� ���ν����� ��ȯ���� ����(�ڹ��� VOID�� ����)
��ȯŸ���� ������ �޼��� �� �տ� ��ȯŸ�� ����
�з�1 : ����ϴ� ������ Ÿ��
�з�2 : ��ȯ�ϴ� ���� ����(�����Լ�, ���� ���� ��ȯ�ϴ� �Լ�)
        EX) �� ���� �ο��� : 401ȣ, 402ȣ,... �� ���, ������� 6���� ����
        EX2) ���ڿ� ������ �ο��� - ��ȯ���� 2��
������ �÷��� 1�� ���
�������� ���� �ڷᰡ ���� �� �ִ� 

CONCAT�� �� �Ⱦ� <- �����߻� ���� �� �ڵ尡����, �ڵ� �ۼ����̼�

C: ���ڿ�Ÿ��
N: ����Ÿ��
D: ��¥Ÿ��

�Լ��� ������ ���� ���Ǵ� �����ڵ� ����Ǿ�� �Ѵ�
    =   �Լ��� ��ȯ���� �������� ��� ������ �񱳿����� �߻��ϱ� ������

SELECT  EMP_NAME, SALARY
FROM    HR.EMPLOYEES
WHERE   DEPARTMENT_ID    IN(SELECT A.DID
                            FROM    (SELECT         DEPARTMENT_ID   AS  DID,
                                                    COUNT(*)
                                    FROM            HR.EMPLOYEES
                                    GROUP BY        DEPARTMENT_ID
                                    HAVING          COUNT(*) >= 5) A);
                            


   4) RPAD(c1, n[, c2]), LPAD(c1, n[, c2])
    - RPAD : ������ ���� n�� c1�� �����ϰ� ���� ������ ������ c2�� �����Ѵ�.
    - LPAD : ������ ���� n�� c1�� �����ϰ� ���� ���� ������ c2�� �����Ѵ�.
    - c2�� �����Ǹ� ������ ä��
    
��뿹)    SELECT      LPAD('12345',7,'*')     AS  COL1,
                      RPAD('9876',6)          AS  COL2
          FROM        DUAL;

            SELECT      TO_CHAR(PROD_COST)                  AS  COL1,
                        LPAD(PROD_NAME,30)                  AS  COL2,
                        LPAD(TO_CHAR(PROD_COST),10)         AS  COL3,
                        LPAD(TO_CHAR(PROD_COST),10,'#')     AS  "COST"
            FROM        PROD;

   5) RTRIM(c1[, c2]), LTRIM(c1[, c2])
    - RTRIM : �־��� ���ڿ� c1 ���ο� c2 ���ڿ��� �����ʿ��� ã�� ����
    - LTRIM : �־��� ���ڿ� c1 ���ο� c2 ���ڿ��� ���ʿ��� ã�� ����
    - c2�� �����Ǹ� ������ ����
    
�����ͺ��̽��� �ڷḦ ��Ȯ�ϰ� �����ϱ� ���� ����,
���߿��� �����ͺ��̽��� ��޾��� ����� ����, ������ ���̽� ��ü���� ���ڰ� ����ϴ� ���� �ƴ϶�
���� ���ڰ� ����ϴ� ����� ��� ���� ���. �׷��� RAPD, LPAD�� ���� ������� ����
LPAD�� ���ڿ� �ڷḦ ������ �����Ϸ� �� �� ���(���ڷ� �� ���ڿ��� ������ �����ϰ� ���� ��)
LTRIM, RTRIM�� ��ȿ�� ������ ����(���ڿ��� �� �� ���� ���ӵ� ������ ����)
���ڿ��� ���� ������ ������ ���� �ٸ� �Լ� ���

   6) TRIM(c1)
    - �ܾ� ���� �Ǵ� �����ʿ� �߻��� ������ ��� ����
    - �ܾ� ���� ���� ���Ŵ� �Ұ���
    
SELECT  MEM_NAME, MEM_HP, MEM_JOB, MEM_MILEAGE
FROM    MEMBER
WHERE   MEM_NAME = TRIM('������ ');

WHERE�������� �ڵ������� TRIM�ؼ� ���ڿ� ������ ����
PL/SQL������ ���ڿ��� ���� �� �ڵ����� TRIM�� ������ �� ����

   7) SUBSTR(c, n1[, n2])
    - �־��� ���ڿ� c���� n1��° ���� n2 ���� ���ڸ� �����Ͽ� �κ� ���ڿ��� ��ȯ
    - ����� ���ڿ���
    - n1, n2�� 1���� ���۵�
    - n2�� �����ǰų� ������ ������ ū n2�� ����ϸ� n1���� ��� ���ڿ��� ������
    - n1�� �����̸� �������� �������� ó����, �׷��� �� ���۹��ں��� ���������� n2���� ���� ����
    
��뿹)    SELECT    SUBSTR('������ �߱� ��ȫ��', 2, 5),
                    SUBSTR('������ �߱� ��ȫ��', 2),
                    SUBSTR('������ �߱� ��ȫ��', 2, 20),
                    SUBSTR('������ �߱� ��ȫ��', -8, 6)
          FROM      DUAL;

�ڹ��� SUBSTR�� N1�� N2�� ��� �ε�����

��뿹) ������ 2005�� 4�� 1���� ��� CART_NO�� �ڵ� �����Ͻÿ�.
SELECT      TO_CHAR(SYSDATE, 'YYYYMMDD')||LPAD(TO_CHAR((TO_NUMBER(SUBSTR(MAX(CART_NO),-5)) + 1)),5,'0')       AS  PROCESSING
FROM        CART
WHERE       SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE, 'YYYYMMDD');

SELECT      TO_CHAR(SYSDATE, 'YYYYMMDD')||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9)) + 1, '00000'))
FROM        CART
WHERE       CART_NO LIKE    '20050401%';

SELECT  MAX(CART_NO) + 1
FROM    CART
WHERE   CART_NO LIKE '20050401%';

   8) REPLACE(c1, c2[,c3])
    - �־��� ���ڿ� c1�� ���Ե� c2�� ã�� c3�� ġȯ��Ŵ
    - c3�� �����Ǹ� ã�� c2�� ������Ŵ
    - �ܾ� ������ ���� ���ſ� ���� �� ����
��뿹)
            SELECT  REPLACE('���������� �߱� ��ȫ��', '��������', '����'),
                    REPLACE('���������� �߱� ��ȫ��', '����'),
                    REPLACE('���������� �߱� ��ȫ��', ' '),
                    REPLACE('���������� �߱� ��ȫ��', '��')
            FROM    DUAL;
            
   9) INSTR(c1, c2[, m[, n]])                -- INDEX OF (IN?) STRING
    - �־��� ���ڿ� c1���� c2���ڿ��� ó�� ���� ��ġ���� ��ȯ
    - m�� �˻� ������ġ�� ���� ������ �� ���
    - n�� c2���ڿ��� �ݺ� Ƚ���� ���Ͽ� �˻��ϴ� ��� ���
    
��뿹)
SELECT  INSTR('APPLE PERSIMON PEAR BEAR', 'E'),
        INSTR('APPLE PERSIMON PEAR BEAR', 'P', 5),
        INSTR('APPLE PERSIMON PEAR BEAR', 'P', 5, 2),
        INSTR('APPLE PERSIMON PEAR BEAR', 'P', 5, 3)
FROM    DUAL;

����Ŭ�� INDEX�� 1������ ����, ��Ȯ�� ��ġ�ϴ� ���ڿ��� ã��,
�˻��� ����� �Ǵ� ���ڿ����� ã�� ���ڿ��� ù ���ڰ� ���� ��ġ�� ��ȯ, ã�� ���ߴٸ� 0�� ��ȯ
