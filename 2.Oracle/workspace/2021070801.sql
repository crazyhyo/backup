2021-0708-01)
1)SELECT �� ����
  SELECT [DISTINCT] �÷���(����|������) [AS] ["][��Ī]["]
    - 'DISTINCT' : �ߺ��� �� ����
    - '[AS]["][��Ī]["]' : �÷��� �ο��� �Ǵٸ� �̸����� Ư������ ���� " "�� ���� ���
        -��½� �÷��� ����
��뿹)  ȸ�����̺�(MEMBER)�� �ֹι�ȣ(MEM_REGNO1)�� ����Ͽ� ȸ���� ���̸� ��ȸ�Ͻÿ�.
        ��, Alias�� ȸ����ȣ, ȸ����, �ֹι�ȣ, �����̴�.
    
    SELECT  MEM_ID                                                                  AS  "ȸ����ȣ",
            MEM_NAME                                                                AS  "ȸ����",
            MEM_REGNO1 || '-' || MEM_REGNO2                                         AS  "�ֹ� ��ȣ",
            EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900) AS  "����"
    FROM    MEMBER;
    
    (1)������(operator)
    - ��������� : +, -, *, /
��뿹) HR������ ������̺�(EMPLOYEES)���� ���ʽ��� ����Ͽ� �޿��� ���޾��� ��ȸ�Ͻÿ�
       ���ʽ� = �޿� * ���������ڵ�(COMMISION_PCT)�� 35%
       ���޾� = �޿� + ���ʽ�
       ��� : �����ȣ, �����, �޿�, ���ʽ�, ���޾�

       SELECT   A.EMPLOYEE_ID                                                   AS      "�����ȣ",
                A.FIRST_NAME || ' ' || A.LAST_NAME                              AS      "�����",
                A.SALARY                                                        AS      "�޿�",
                A.SALARY * NVL(A.COMMISSION_PCT,0) * 0.35                       AS      "���ʽ�",
                A.SALARY + A.SALARY * NVL(A.COMMISSION_PCT,0) * 0.35            AS      "���޾�"
       FROM HR.EMPLOYEES A;

       SELECT   EMPLOYEE_ID                                     AS  �����ȣ,
                FIRST_NAME || ' ' || LAST_NAME                  AS  �����,
                SALARY                                          AS  �޿�,
                SALARY * NVL(COMMISSION_PCT,0) * 0.35           AS  ���ʽ�,
                SALARY + SALARY * NVL(COMMISSION_PCT,0) * 0.35  AS  ���޾�
       FROM     HR.EMPLOYEES;
                
    - ���迬���� : ��Һ�, TRUE/FALSE �� ����� ��ȯ, <, >, <=, >=, =, !=, <>
                ���ǹ� ������ �ַ� ��� (WHERE ��)
��뿹) ȸ�����̺��� ���ϸ����� 4000�̻��� ȸ���� ȸ����ȣ, ȸ����, ����, ���ϸ����� ��ȸ�Ͻÿ�.
       ���ϸ����� ���� ȸ������ ��ȸ
    SELECT      MEM_ID      AS  ȸ����ȣ,
                MEM_NAME    AS  ȸ����,
                MEM_JOB     AS  ����,
                MEM_MILEAGE AS  ���ϸ���
    FROM        MEMBER
    WHERE       MEM_MILEAGE >= 200
    ORDER BY    MEM_MILEAGE DESC, MEM_ID DESC;


**ȸ�����̺� ���� ����
    1) d001ȸ���� �ֹε�Ϲ�ȣ 460409-2000000, ��������� 1946/04/09
       ->        �ֹε�Ϲ�ȣ 010409-4000000, ��������� 2001/04/09
    2) n001ȸ���� �ֹε�Ϲ�ȣ 750323-1011014, ��������� 1975/03/23
       ->        �ֹε�Ϲ�ȣ 000323-3011014, ��������� 2000/03/23
    2) v001ȸ���� �ֹε�Ϲ�ȣ 520131-2402712, ��������� 1952/01/31
       ->        �ֹε�Ϲ�ȣ 020131-4402712, ��������� 2002/01/31

**�������� : UPDATE��
    UPDATE  ���̺��
    SET     �÷��� = ��[,
            �÷��� = �� ,
                :
    [WHERE ����]; 
       
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '010409',
                MEM_REGNO2 = '4000000',
                MEM_BIR = TO_DATE('20010409')
       WHERE    MEM_ID = 'd001';
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '000323',
                MEM_REGNO2 = '3011014',
                MEM_BIR = TO_DATE('20000323')
       WHERE    MEM_ID = 'n001';
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '020131',
                MEM_REGNO2 = '4402712',
                MEM_BIR = TO_DATE('20020131')
       WHERE    MEM_ID = 'v001';
       
    SELECT      MEM_ID,  MEM_REGNO1, MEM_REGNO2, MEM_BIR
    FROM        MEMBER
    WHERE       MEM_ID IN('d001','v001','n001');

��뿹) ȸ�����̺��� ����ȸ�������� ��ȸ�Ͻÿ�.
       Alias ȸ����ȣ, �п���, �������, ���ϸ���, ���    
    
       SELECT       MEM_ID      AS  ȸ����ȣ,
                    MEM_NAME    AS  ȸ����,
                    MEM_BIR     AS  �������,
                    MEM_MILEAGE AS  ���ϸ���,
                    CASE WHEN   SUBSTR(MEM_REGNO2,1,1) = ANY('2','4')   THEN
                                '����ȸ��'
                    ELSE
                                '����ȸ��'
                    END
                                AS  ���
--                  '����ȸ��'  AS  ���
       FROM         MEMBER
       WHERE        SUBSTR(MEM_REGNO2,1,1) = ANY('2','4');

    - �������� : NOT, AND, OR
        NOT : ������
        AND OR �� ����ǥ���
        ----------------------------
        �Է�1 �Է�2 ���
                   OR   AND (EX-OR)
        ----------------------------
        0     0    0    0   0
        0     1    1    0   1
        1     0    1    0   1
        1     1    1    1   0
        ----------------------------
        MEM_MILEAGE >= 2000 OR  EXTRACT(YEAR FROM MEM_BIR) <= 2000
��뿹)  ������̺��� ��ձ޿� �̻� �޿��� �޴� ����� ��ȸ�Ͻÿ�.
        Alias�� �����ȣ, �����, �޿�, �μ���ȣ
        
        SELECT      EMPLOYEE_ID     AS  �����ȣ,
                    FIRST_NAME      AS  �����,
                    SALARY          AS  �޿�,
                    DEPARTMENT_ID   AS  �μ���ȣ,
                    ROUND((SELECT AVG(SALARY)
                    FROM    HR.EMPLOYEES),0)    AS  ��ձ޿�
        FROM        HR.EMPLOYEES
        WHERE       NOT SALARY  < (SELECT    AVG(SALARY)
                                  FROM  HR.EMPLOYEES);
                                  
    - ��Ÿ������ : IN, ANY, SOME, ALL, EXISTS, BETWEEN, LIKE �� ����
                IN�� OR�� ����� �Ͱ� �Ȱ���


        
    SELECT * FROM HR.EMPLOYEES;

