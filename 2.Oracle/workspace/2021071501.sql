2021-0715-01)
  3. ��¥�Լ�
   1) SYSDATE
    - �ý��ۿ��� �����ϴ� ��¥����(��,��,��,��,��,��) ��ȯ
    - '+', '-'������ ���                //  ���� '-'�� DATE - NUMBER �� DATE - DATE �����ϳ� ���� '+'�� DATE + NUMBER �� �����Ѵ�
    - ��¥ - ��¥ : �� ��¥ ������ ���� (DAYS) ��ȯ, NUMBER TYPE
    
��뿹)
SELECT  SYSDATE -10,
        TO_CHAR(SYSDATE, 'YYYY MM DD HH24:MI:SS'),
        TRUNC(SYSDATE-TO_DATE('19900715','YYYY-MM-DD'))
FROM    DUAL;

����Ͻú��ʸ� ����� ���� ���·� �ٷ�� �ʹٸ� ����� / �ú��� �� ������ ���� ������ �� ��ȯ�� ���� �ʾ� ���� �߻�
��¥ ���˿� ��Ȯ�ϰ� ���߾ �Է��ؾ� ��. �⺻ ������ ��||'/'||��||'/'||�� �� ���·� ��� Ȥ�� '-'�� �������� �뽬��ȣ�� ���
��¥������ ����ڰ� �����ؼ� ��¥�� ��ȯ�ϰ��� �Ѵٸ�   -> �׷��� ���� ���ڿ��� �Ű��� ��¥ ������ �ٷ�. ��¥�� �ʿ��� �� TO_DATE(C)
������ �� ���ڿ��� ����, ��¥Ÿ���� �ʿ��ϸ� �ؼ��ؼ� ���
TO_CHAR(D) <- ����� ���� ����ȯ, ����� ���� ��¥�������� ����      TO_DATE�� ��������� ��¥���� ���� ��������

   2) ADD_MONTHS(d, n)
    - ��¥������ �ڷ� d�� n��ŭ�� ���� ���� ��¥ ��ȯ
��뿹)����� ���� �Ի����� ���� 3������ ���� ��¥�̴�. �� ����� �� ȸ�礿�� ó�� �������� �Ի��� ��¥�� ���Ͻÿ�
      Alias�� �����ȣ, �����, �Ի���, �����Ի���, �ҼӺμ���

SELECT      A.EMPLOYEE_ID                                           AS  �����ȣ,
            A.EMP_NAME                                              AS  �����,
            A.HIRE_DATE                                             AS  �Ի���,
            ADD_MONTHS(A.HIRE_DATE, -3)                             AS  �����Ի���,
            B.DEPARTMENT_NAME                                       AS  �ҼӺμ���
FROM        HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE       A.DEPARTMENT_ID = B.DEPARTMENT_ID
ORDER BY    5;

���ν� ������ ��
1. ���谡 �ξ����ִ°�
2. � ���̺��� �θ��̰� � ���̺��� �ڽ��ΰ�(�θ��ڽİ���)
3. �߸� ���̺��� �ִ°�
�ǹ����� ���̺� �־�����. ���� �ʿ��� ���� �� ERD��. �׷��ٸ� ���̺��� �� ERD�� �׷��� �� �ִ� ����� ����.(������)     <-  �̰��� ���� �۾�����
�� ERD�� ���̺��� ������� �ִ�(������)
ADD_MONTHS      S�� ���� ��Ȯ�� �Լ����̴�
�׳� = �� ����ϴ� ���� ��������, ���ǿ� �´� �����͸� ���, �� ���� ���̺� �������� ����Ѵٰ� ������ �� ����
�ܺ�����    ���ǿ� ���� �ʴ� �����͵� �� ū ���̺��� �����͸� ��� ã�Ƽ� ���


���̺��� 2�� �̻� ��ȸ�ϴ� ��쿡�� �ݵ�� WHERE ���� �ʿ���   <-  �ݵ�� ������ �߻��ǰ� WHERE���̴� ī���׽þ� ������ �����͸� �����´�
                                                            �̰� ��������. �׸��� �Ȱ��� �÷����� ���� ��찡 ��κ��̱� ������
                                                            ��Ī�ο��� �ݵ�� �ؾ��Ѵ�. ���� SELECT���� �÷����� ����ϴ� ��쿡��
                                                            �ݵ�� ��Ī�� �ο��ϴ� ������ ������
��ȸ���� ���� ��ǥ���� ������ SELECT FROM    WHERE;

   3) NEXT_DAY(d, expr)
    - �־��� ���� d���� �ٰ��� ���� ���� 'expr'������ ��¥ ��ȯ
    - expr : ��,ȭ,...,��, ������,ȭ����,...,�Ͽ���

��뿹)
    SELECT  NEXT_DAY(SYSDATE, '��'),
            NEXT_DAY(SYSDATE, '��'),
            NEXT_DAY(SYSDATE, 'ȭ����'),
            NEXT_DAY(SYSDATE, '�Ͽ���'),
            NEXT_DAY(SYSDATE, '��')
    FROM    DUAL;

���⼭�� expr�� ���ڿ��� '��', 'ȭ����', ... ������ ����� �� <- NLS�������� �ѱ۷� �����߱� ������
������ ��ȯ���� ����     /       ���� ��������� ����

   4) LAST_DAY(d)
    - ��¥�ڷ� d�� ���Ե� ���� ������ ���� ��ȯ          -- �ַ� 2�� ��ȸ�� ��� / ��ȯ ������ ��¥����

��뿹)�������̺�(BUY_PROD)���� 2���� ���Ե� ���԰Ǽ��� ��ȸ�Ͻÿ�.
    SELECT  COUNT(*)    AS  ���԰Ǽ�
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN TO_DATE('20050201') AND     LAST_DAY(TO_DATE('20050201'));
    
���̺� �ִ� �������� ������ ���� �Լ� : COUNT
COUNT(*)�� ������� ���ϴ� ��� : �ܺ� ������ ����� ��

   5) MONTHS_BETWEEN(d1, d2)
    - �� ��¥ �ڷ� ������ ���� �� ��ȯ                   --  ���ϰ��� NUMBER

��뿹)
    SELECT      TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))  AS  �ټӰ�����
    FROM        HR.EMPLOYEES;
    
    SELECT      EMP_NAME,
                HIRE_DATE,
                TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12)||'��'||
                MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)),12) ||'����'   AS  �ټӱⰣ
    FROM        HR.EMPLOYEES;

   6) EXTRACT(fmt FROM d)
    - ��¥�ڷ� d���� 'fmt'�� ����� �ڷḦ ������
    - ��ȯ���� ������ ����������
    - 'fmt' : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
    
��뿹)
    SELECT  EMP_NAME,
            TO_CHAR(HIRE_DATE,'YYYY-MM-DD HH:MM:SS'),
--            EXTRACT(YEAR FROM HIRE_DATE),
--            EXTRACT(MONTH FROM HIRE_DATE),
--            EXTRACT(DAY FROM HIRE_DATE),
--            EXTRACT(HOUR FROM TO_TIMESTAMP(HIRE_DATE)),
            HIRE_DATE,
            TO_TIMESTAMP(HIRE_DATE)
    FROM    HR.EMPLOYEES;
��뿹)
    SELECT  EXTRACT(HOUR FROM SYSDATE),
            EXTRACT(MINUTE FROM SYSDATE),
            EXTRACT(SECOND FROM SYSDATE)
    FROM    DUAL;
    
���� : SYSDATE > EXTRACT > LAST_DAY    

��뿹)�̹� �޿� ������ �ִ� ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ, ȸ����, ��������̴�.

    SELECT  MEM_ID  AS  ȸ����ȣ,
            MEM_NAME    AS  ȸ����,
            MEM_BIR     AS  �������
    FROM    MEMBER
    WHERE   EXTRACT(MONTH FROM  SYSDATE) = EXTRACT(MONTH FROM  MEM_BIR);

HOUR, MINUTE, SECOND�� 

������ ��ȯ�Լ�
TO_CHAR / TO_DATE   / TO_NUMBER
������ Ÿ�Կ� ���� �ʱⰪ ������ �ٸ�.
���ڴ� 0 / 0.0 ���ڴ� ' ' ���� FALSE�� �ʱ�ȭ (IN JAVA)
����Ŭ�� � Ÿ���̵� NULL�� �ʱ�ȭ�� /   NULL���� ��� �������� NULL.   ->  ����Ŭ������ NULLó�� �Լ� ���
(NULLIF,  NVL, NVL2,    ISNULL,  ISNOTNULL)

�����Լ��� 90% �̻��� �ݵ�� GROUP BY �ʿ�
���� �����Լ�->JOIN ������ ��� ����
