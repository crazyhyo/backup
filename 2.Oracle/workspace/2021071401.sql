2021-0714-01)

2. �����Լ�
 1) GREATEST(n1, n2[, n3,...]), LEAST(n1, n2[, n3,...])
  - GREATEST : �־��� �� �� ���� ū ���� ��ȯ
  - LEAST : �־��� �� �� ���� ū ���� ��ȯ
��뿹)
SELECT  GREATEST(50, 70, 90),
        LEAST(50, 70, 90)
FROM    DUAL;

��뿹)  ȸ�����̺��� ���ϸ����� 1000�̸��� ��� ȸ���� ���ϸ����� 1000���� ���� ����Ͻÿ�.
        Alias�� ȸ����ȣ, ȸ����, ���� ���ϸ���, ���� ���ϸ���
        
SELECT      MEM_ID                              AS  ȸ����ȣ,
            MEM_NAME                            AS  ȸ����,
            GREATEST(MEM_MILEAGE, 1000)         AS  "���� ���ϸ���"
FROM        MEMBER;

SELECT      GREATEST(MEM_MILEAGE)
FROM        MEMBER;

SELECT      MAX(MEM_MILEAGE)
FROM        MEMBER;

����>  ALIAS�� ���Ⱑ ������ �ֵ���ǥ�� ����ؾ� �Ѵ�.
      GREATEST�� COLUMN ������ �ȴ�

 2) ROUND(n[, i]), TRUNC(n[, i])
  - ROUND : �־��� �� n�� �Ҽ��� ���� i+1��° �ڸ����� �ݿø��Ͽ� i��
            MEM_MILEAGE                         AS  "���� ���ϸ���",° ���� ���
            i�� �����̸� �����κ� i��°���� �ݿø�
            i�� �����Ǹ� 0���� ����(�Ҽ��� ù ��° �ڸ����� �ݿø�)
  - TRUNC : ROUND�� ���� ����ǳ� �ݿø��� �ƴ϶� ����ó���Ѵ�.
  
��뿹)  ������̺��� �޿��� ���޾��� ����Ͽ� ����Ͻÿ�
        Alias�� �����ȣ, �����, �޿�, ����, ���޾�
        ���� = �޿����� 17%
        ���޾� = �޿��� - ����
        �Ҽ��� 1�ڸ����� ���

SELECT  EMPLOYEE_ID                     AS  �����ȣ,
        EMP_NAME                        AS  �����,
        SALARY                          AS  �޿�,
        TRUNC(SALARY * 0.17,1)          AS  ����,
        SALARY - TRUNC(SALARY * 0.17,1) AS  ���޾�
FROM    HR.EMPLOYEES;

-- ������ ��ݳ����� �����̴ϱ� ����� �� �ֵ��� TRUNC ���

��뿹)  2005�� 1��~3�� ��ǰ�з��� ��ո��Ծ��� ��ȸ�Ͻÿ�.
        Alias �з��ڵ�, �з���, ��ո��Աݾ�
        ��ո��Աݾ� ������ ǥ��
        
        SELECT  �з��ڵ�, �з���, ��ո��Աݾ�
        FROM    BUYPROD A, PROD B, LPROD C
        WHERE   A.BUY_PROD = B.PROD_ID
                AND B.PROD_LGU = C.LPROD_GU
                AND     A.BUY_DATE >= TO_DATE('20050101')
                AND     A.BUY_DATE <= (TO_DATE('20050331'));

        SELECT      C.PROD_LGU                              AS  �з��ڵ�,
                    B.LPROD_NM                              AS  �з���,
                    ROUND(AVG(A.BUY_QTY * C.PROD_COST),-1)  AS  ��ո��Աݾ�
        FROM        BUYPROD A, LPROD B, PROD C
        WHERE       A.BUY_PROD = C.PROD_ID
                    AND     C.PROD_LGU = B.LPROD_GU
                    AND     A.BUY_DATE BETWEEN '20050101' AND '20050331'
        GROUP BY    C.PROD_LGU, B.LPROD_NM;

OO�� : �ش��ϴ� ���� �������� ����� �� / GROUP BY �ʿ�
���Ծ� = �ܰ� * ����
�����Լ� ���� �ݵ�� GROUP BY �ʿ�, �ڿ� ���� ���� SELECT���� �������� ���� ��� �÷��� ���ָ� �ȴ�

GREATEST�� MAX�� ����: GREATEST�� ���� �����ؾ� ��, MAX�� �÷��� ���� ���� �ݵ�� GROUP BY�� ��� ������ GREATEST�� �ƴ�.
EX) GREATEST(MEM_MILEAGE) <- ���������� �ƴϳ�... �׳� �÷��� �� �����µ�?

��������� ROUND���(���� ���� ���� �ݿø�), ����� �� ���� TRUNC ���
���� �� ���� ROUND, ���� ���� ���� TRUNC
�����ͺ��̽��� ��Ȯ�� �ڷḦ ������ �ǹ��� ����.
�����ͺ��̽� ���������� �������ϸ� �ݿø� ���� ����. �������� ó���� ��� ����


���̺� ��Ī�� �ݵ�� �������� �ϴ� ��� : �� ���̺��� ���� �÷����� ������ �ִ� ���, �Ҽ� ���̺���� Ȯ���ϰ� ������� ��.
                                     �׷��� �� ���̺���� �ʹ� �� ��� ��Ī�� ����Ͽ� �����Ѵ�.
��Ī�ο��ϱ� �Ⱦ ���̺� �÷����� �ٸ� �̸��� ���   <-  ���� ������
�ܷ�Ű, ���谡 �ִ� ���̺��� ���踦 �����ϴ� �÷��� �̸��� ���ƾ� �Ѵ�.

��Ī�ο���� 1. ��ü�� ���� �ο��ϴ� ���, ���Ǿü ����, SYNONYM (CREATE SYNONYM)

���̺��� 2�� �̻� ���Ǹ� JOIN�� ���Ǿ�� ��. ���̺��� N���� ���Ǹ� ���������� ��� N-1�� �̻� ����Ѵ�.

 3) FLOOR(n), CEIL(n)
  - n�� ����� ������ ��ȯ
  - FLOOR : n�� ���ų� ���� ���� �� ���� ū ����
  - CEIL : n�� ���ų� ū ���� �� ���� ���� ����
  - ����, �޿�ó�� �ݾװ� ���õ� ���Ŀ� �ַ� ���
��뿹)
    SELECT  FLOOR(12.5), CEIL(12.5), FLOOR(12), CEIL(12), FLOOR(-12.5), CEIL(-12.5)    FROM    DUAL;
  
FLOOR(-1.2) = -2, CEIL(-1.2) = -1
����Ŭ������ %�����ڰ� �������� ���ϴµ� ���̴� ���� �ƴ϶� ���ڿ��� ���ϵ�ī��� ����. -> ������ ���ϴ� ������ ����
-> MOD�� REMAINDER �Լ��� �̿��Ͽ� ������ ����        /           ���� ��������� ����

 4) MOD(n, i), REMAINDER(n, i)
  - �������� ��ȯ
  - MOD : n�� i�� ���� ������ ��ȯ
            ������ = ������ - ���� * FLOOR(������ / ����)
            MOD(15,6) = 3
                      = 15 - 6 * FLOOR(15/6)
                      = 15 - 6 * 2
  - REMAINDER : n�� i�� ���� �������� i�� ���� ������ ���̸� MOD�� ����.
                �������� �ʰ��ϸ� ���� ���� �Ǳ� ���� �������� �� �� ��ȯ
            ������ = ������ - ���� * ROUND(������ / ����)
            REMAINDER(15,6) = -3
                            = 15 - 6 * ROUND(15/6)
                            = 15 - 6 * 3
                            = -3
��뿹)
    SELECT  MOD(15,6), REMAINDER(16,6), MOD(15,7), REMAINDER(15,7), MOD(15,4), REMAINDER(15,4) FROM DUAL;
��뿹)������ �⵵�� �Է� �޾� ����� ����� �����Ͻÿ�.
        ���� : 4�� ����̸鼭 100�� ����� �ƴϰų� 400�� ����� �⵵
        
        
        ACCEPT P_YEAR   PROMPT  '�⵵ �Է�'
        DECLARE
            V_YEAR NUMBER(4):= &P_YEAR;               --      �Է¹��� P_YEAR�� �����ϱ� ���� &���, ''�ȿ� ��� ���ڿ��� ��ȯ
                                                        --      �̰��� NUMBER�� �����ϸ鼭 ����ȯ �Ͼ(??)
            V_RES VARCHAR2(100);
        BEGIN
            IF(MOD(V_YEAR,4) = 0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400) = 0) THEN
                V_RES:= V_YEAR || '���� �����Դϴ�.';
            ELSE
                V_RES:= V_YEAR || '���� ����Դϴ�.';
            END IF;     
            DBMS_OUTPUT.PUT_LINE(V_RES);
        END;
        
        SELECT  
        (MOD(,4) = 0 AND MOD(,100) != 0)
        OR      MOD(,400) = 0

����) ACCEPT �������� �����ݷ�, �ݷ�, �޸� ��� �ȵ�
ACCEPT  ������     PROMPT  '��¸޽���'
DECLARE
    ������ ��������    :=  &������ <- �Է¹��� ������ �޾ƿ��ڴ�
BEGIN
    IF  ����  THEN
    ELSE
    END IF;
END;
    
��ǻ�� �׷��Ƚ����� �ﰢ�Լ�/��������� �ſ� ���� �� (ȸ��, ����, ���, Ȯ��, ���) 

 5) WIDTH_BUCKET(n, min, max, b)
  - min���� max������ b���� �������� ������ �־��� �� n�� �� ���� �� ��� ������ ���ϴ��� �Ǻ��Ͽ� ������ �ε����� ��ȯ
  - n�� max�̻��̸� b + 1, min�̸��̸� 0 ��ȯ[�⺻ ������ �̻�-�̸����� ������ ������ ����]
��뿹)
    SELECT  WIDTH_BUCKET(120, -1, 120, 20) FROM DUAL;
��뿹)ȸ�����̺��� ȸ������ ���ϸ����� 3���� �׷����� ������ �� ȸ������ ���ϸ����� ���� �׷��� ��ȸ�Ͽ�
      1�׷쿡 ���� ȸ���� '����ȸ��', 2�׷쿡 ���� ȸ���� '���� ȸ��', 3�׷쿡 ���� ȸ���� 'VIP ȸ��'���� ������ ����Ͻÿ�.
      Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���, ���
      
      SELECT    MEM_ID                                                              AS  ȸ����ȣ,
                MEM_NAME                                                            AS  ȸ����,
                MEM_JOB                                                             AS  ����,
                MEM_MILEAGE                                                         AS  ���ϸ���,
                CASE    WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 3) = 1 THEN
                                '���� ȸ��'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 3) = 2 THEN
                                '���� ȸ��'
                        ELSE    
                                'VIP ȸ��'
                END
                                                                                    AS  ���
      FROM      MEMBER;

SELECT    MEM_ID                                                              AS  ȸ����ȣ,
                MEM_NAME                                                            AS  ȸ����,
                MEM_JOB                                                             AS  ����,
                MEM_MILEAGE                                                         AS  ���ϸ���,
                CASE    WHEN    WIDTH_BUCKET(MEM_MILEAGE,   (SELECT  MIN(MEM_MILEAGE)
                                                            FROM    MEMBER),
                                                            (SELECT  MAX(MEM_MILEAGE)
                                                            FROM    MEMBER), 3) = 1 THEN
                                '���� ȸ��'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE,   (SELECT  MIN(MEM_MILEAGE)
                                                            FROM    MEMBER),
                                                            (SELECT  MAX(MEM_MILEAGE)
                                                            FROM    MEMBER), 3) = 2 THEN
                                '���� ȸ��'
                        ELSE    
                                'VIP ȸ��'
                END
                                                                                    AS  ���
      FROM      MEMBER;

��뿹)ȸ�����̺��� ȸ������ ���ϸ����� 5���� �׷����� ������ ����� ������ ���
      Alias�� ȸ����ȣ, ȸ����, ����, ���ϸ���, ����̸�, ����� ���ϸ����� ���� ȸ���� 1����̰�,
      ���� ���� ȸ���� 5����̴�.
      
      SELECT    MEM_ID                                                                  AS  ȸ����ȣ,
                MEM_NAME                                                                AS  ȸ����,
                MEM_JOB                                                                 AS  ����,
                MEM_MILEAGE                                                             AS  ���ϸ���,
                WIDTH_BUCKET(-MEM_MILEAGE, -9000, -500, 5)                              AS  ���
      FROM      MEMBER;

      SELECT    MEM_ID                                                                  AS  ȸ����ȣ,
                MEM_NAME                                                                AS  ȸ����,
                MEM_JOB                                                                 AS  ����,
                MEM_MILEAGE                                                             AS  ���ϸ���,
                6 - WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5)                             AS  ���
      FROM      MEMBER;

      SELECT    MEM_ID                                                                  AS  ȸ����ȣ,
                MEM_NAME                                                                AS  ȸ����,
                MEM_JOB                                                                 AS  ����,
                MEM_MILEAGE                                                             AS  ���ϸ���,
                CASE    WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 1 THEN
                                '5���'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 2 THEN
                                '4���'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 3 THEN
                                '3���'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 4 THEN
                                '2���'
                        ELSE    
                                '1���'
                END
                                                                                        AS  ���
      FROM      MEMBER;

CASE WHEN�� SELECT �������� ��� ����      

[���ڵ��� ǥ����]
CASE ���� WHEN �� THEN
CASE WHEN 
PL/SQL