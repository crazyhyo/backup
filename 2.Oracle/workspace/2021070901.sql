2021-0709-01)
 4) ��Ÿ������
    (1) IN / ANY, SOME [ANY�� SOME�� = �� �Բ� ���]
     - �־��� �� �� ��� �ϳ��� ��ġ�ϸ� TRUE�� ��ȯ
     - OR �����ڷ� ġȯ ����
     - NOT �����ڿ� �Բ� ��밡����
  (�������)
   expr IN(��1[,��2,...])
   ������ �ش��ϴ� ������ ��ȸ�� AND Ȥ�� BETWEEN �����ڸ� �̿��Ͽ� ���� ��
   Ư���� ��Ģ�� ����(Ȥ�� ���ӵ��� ����) ������ ��ȸ�� IN, OR, EXISTS ���� ������ ���
   
** ������̺��� EMP_NAME VARCHAR2(80) �÷��� �߰�
    (�÷��� �߰�)
    ALTER TABLE ���̺��
        ADD(�÷���    ������Ÿ��[(ũ��)]  [NOT NULL]   [DEFAULT �ʱⰪ]);

    ALTER TABLE HR.EMPLOYEES
        ADD(EMP_NAME    VARCHAR2(80));
    COMMIT;

** FIRST_NAME�� LAST_NAME�� ���� EMP_NAME�� ����
    UPDATE  HR.EMPLOYEES
        SET EMP_NAME = FIRST_NAME || ' ' || LAST_NAME;
        
    SELECT  EMP_NAME
    FROM    HR.EMPLOYEES;
    
    (�÷��̸��� ����)
    ALTER TABLE ���̺��    RENAME  COLUMN  �����÷���   TO  ���ο��÷���;
    
    (�÷��� ����)
    ALTER TABLE ���̺��    DROP  COLUMN  �÷���;
    
    (�÷�Ÿ�� ����)
    ALTER TABLE ���̺��    
        MODIFY(�÷���    ������Ÿ��[(ũ��)]  [NOT NULL]   [DEFAULT �ʱⰪ]);
    
        
��뿹)������̺��� 10, 30, 40, 60�� �μ��� ���� ������� �����ȣ, �����, �μ��ڵ�, �Ի����� ��ȸ�Ͻÿ�.
      (OR ������ ���)
        SELECT      EMPLOYEE_ID AS  �����ȣ,
                    EMP_NAME  AS  �����,
                    DEPARTMENT_ID   AS  �μ��ڵ�,
                    HIRE_DATE   AS  �Ի���
        FROM        HR.EMPLOYEES
        WHERE       DEPARTMENT_ID = 10
                    OR  DEPARTMENT_ID = 30
                    OR  DEPARTMENT_ID = 40
                    OR  DEPARTMENT_ID = 60
        ORDER BY    3;
      (IN ������ ���)              
        SELECT      EMPLOYEE_ID AS  �����ȣ,
                    EMP_NAME  AS  �����,
                    DEPARTMENT_ID   AS  �μ��ڵ�,
                    HIRE_DATE   AS  �Ի���
        FROM        HR.EMPLOYEES
        WHERE       DEPARTMENT_ID IN(10,30,40,60)
        ORDER BY    3;
      (ANY, SOME ������ ���)              
        SELECT      EMPLOYEE_ID AS  �����ȣ,
                    EMP_NAME  AS  �����,
                    DEPARTMENT_ID   AS  �μ��ڵ�,
                    HIRE_DATE   AS  �Ի���
        FROM        HR.EMPLOYEES
        WHERE       DEPARTMENT_ID = ANY(10,30,40,60)
        --          DEPARTMENT_ID = SOME(10,30,40,60)
        ORDER BY    3;
        
    (2) ALL
     - ( )�ȿ� �־��� ������ ��� �����ؾ� ����� ��(TRUE)�� ��
     - AND�� ġȯ ����, ��ȣ�� �Բ� ���Ұ�
    (�������)
     �÷��� ���迬���� ALL(��1[,��2,...])
     
��뿹) ������̺��� 20,40,70�� �μ��� ���� ������� �޿����� �޿� ���� ����� �����ȣ, �����, �޿�, �μ���ȣ�� ��ȸ�Ͻÿ�.

SELECT      EMPLOYEE_ID     AS      �����ȣ,
            EMP_NAME        AS      �����,
            SALARY          AS      �޿�,
            DEPARTMENT_ID    AS      �μ���ȣ
FROM        HR.EMPLOYEES
WHERE       SALARY  > ALL(SELECT    SALARY
                          FROM      HR.EMPLOYEES
                          WHERE     DEPARTMENT_ID IN(20,40,70));

(SELECT    MAX(SALARY)
                          FROM      HR.EMPLOYEES
                          WHERE     DEPARTMENT_ID IN(20,40,70));




    (3) BETWEEN ~ AND
     - ������ �����Ͽ� ���� ��ȸ�ϴ� ���ǹ� ������ ���, ����� ����, ����, ��¥ ��� ����
     - �� ������ 'AND'�� ġȯ ����

LIKE�����ڴ� �񱳴���� ���ڿ���. ��, LIKE�� ���� �䱸���� ���Ƽ� �ӵ��� ����
��¥�񱳽ô� LIKE�� �ƴ϶� BETWEEN�� ����ؾ� ��.

��뿹)�����������̺�(BUYPROD)���� 2005�� 3�� ������Ȳ�� ����Ͻÿ�.        <-      ��������, WHERE�� �����
      Alias�� ��¥, ��ǰ�ڵ�, ���Լ���, ���Աݾ��̴�.

(AND ������ ���)
SELECT  BUY_DATE            AS  ��¥,
        BUY_PROD            AS  ��ǰ�ڵ�,
        BUY_QTY             AS  ���Լ���,
        BUY_QTY * BUY_COST  AS  ���Աݾ�
FROM    BUYPROD
WHERE   BUY_DATE >= TO_DATE('20050301')
        AND     BUY_DATE <= LAST_DAY(TO_DATE('20050301'));

SELECT  BUY_DATE            AS  ��¥,
        BUY_PROD            AS  ��ǰ�ڵ�,
        BUY_QTY             AS  ���Լ���,
        BUY_QTY * BUY_COST  AS  ���Աݾ�
FROM    BUYPROD
WHERE   BUY_DATE            
        BETWEEN TO_DATE('20050301')    AND     LAST_DAY(TO_DATE('20050301'));

BUY_QTY * BUY_COST  AS  ���Աݾ�            <-      ����ȭ ���ݿ���, ������ �̻� �Ͼ
AUTO CAST : �ڵ�����ȯ(������ ���� ū ������ �ٲ���)
CAST(��ȯ��� AS ��������)
�ڹٿ����� ���ڿ��� ���� ������
����Ŭ������ ���ڰ� ���� ������, 
BUY_DATE >= '20050301' : ��ǻ�ʹ� �����ڸ� �а� ������ �ϰڴٰ� �ؼ�
���� ���� �� ����� ������ Ÿ�� ��, ���ڴ� DATE Ÿ��, ���ڴ� ���ڿ�
���ڿ��� ���� ������ ����ȯ �켱������ ���� ������ DATE Ÿ������ ��ȯ����(����)
BOOLEAN ���� ��ȯ
EXTRACT �Լ��� DATE Ÿ���� ARGUMENT�� �޾� ���ڸ� ��ȯ�Ѵ�!
��¥ ���� ����� ��(DAY)������ ����Ѵ�.

��뿹)ȸ�����̺��� 40�� ȸ���� ȸ����ȣ, ȸ����, ���ϸ����� ��ȸ�Ͻÿ�.

SELECT      MEM_ID      AS  ȸ����ȣ,
            MEM_NAME    AS  ȸ����,
            MEM_MILEAGE AS  ���ϸ���
FROM        MEMBER
WHERE       (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)) BETWEEN 40 AND 49;

**ȸ���� ������� �÷����� ���� �����Ͻÿ�.
    SELECT  EXTRACT(MONTH FROM MEM_BIR),
            SUBSTR(MEM_BIR,6,2)
    FROM    MEMBER;
    
**ȸ�����̺��� �̹� �޿� ������ �ִ� ȸ����ȣ, ȸ������ ��ȸ
    SELECT  MEM_ID      AS  ȸ����ȣ,
            MEM_NAME    AS  ȸ����
    FROM    MEMBER
    WHERE   EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM MEM_BIR);

��뿹)�з��ڵ尡 P2�� �����ϴ� ��ǰ�� ���Ͽ� 2005�� 5�� ��������� ��ȸ�Ͻÿ�.
      ��ǰ�ڵ�, ��ǰ��, �з��ڵ�, �з���, �Ǹż���, �ݾ�
    
SELECT      A.PID       AS  ��ǰ�ڵ�,
            A.PNAME     AS  ��ǰ��,
            LPROD_GU    AS  �з��ڵ�,
            LPROD_NM    AS  �з���,
            A.QANT      AS  �Ǹż���,
            A.MANT      AS  �ݾ�
FROM        LPROD, (    SELECT      CART_PROD                     AS  PID,
                                    PROD_NAME                     AS  PNAME,
                                    SUM(CART_QTY)                 AS  QANT,
                                    SUM(CART_QTY * PROD_PRICE)    AS  MANT
                        FROM        CART , PROD 
                        WHERE       CART_PROD = PROD_ID
                                    AND CART_NO LIKE '200505%'
                                    AND PROD_LGU BETWEEN 'P200' AND 'P299'
                        GROUP BY    CART_PROD, PROD_NAME)   A,
            PROD
WHERE       PROD_ID = PID
            AND PROD_LGU=LPROD_GU
ORDER BY    1;

���� �� ���� ���� 1. ������ ��Ʈ 2. ���� ��Ʈ
�ڹٴ� COLLECTIONS��� �ݷ��ǿ��� SORT��� �޼ҵ尡 �־ �˾Ƽ� ���Ľ�����
�پ��� ���Ĺ��� ���� ���� : �ý����̳� ���α׷����� �����ϴ� ���Ĺ���� ������� ���ϴ� ��찡 �ݵ�� �߻��ϱ� ����.
<�������>
1. ������ �����ؼ� ����� (�ڹ�) �ڵ�� ����
2. ť�� �����ؼ� ����� (�ڹ�) �ڵ�� ����
3. ����
// ������ ȸ��� �ڵ��׽�Ʈ �� ��.

������ ���� ��: ���� �޿�/�����Ļ�
������ ���� ��: ª�� ����(40�� �߹�)/�����ؼ� �� ���� ���� ���� <- ���α׷��� ���ϰ� �ַ� ������ �ϱ� ������, ���α׷����ϴ� ����� �ؼҼ�

���� �Ի���   1. �������� ����(���� ����, ġ���� ���� �ʿ�)
                2. ���ϴ� ȸ���� ��ûȸ��(����) Ȥ�� �� ��ûȸ�翡 �����ڷ� �Ի��Ͽ� �ΰ��� ��Ÿ�� Ưä�� ä��
�����Ƿڴ� > 50, �������� BETWEEN 22 AND 25  BUT ��ΰ� ��������Ǵ� �� �ƴϴ�.
����) MAX�Լ��� ���� ���ϴ� ��� : MAX�� ������ GROUP BY���� ����ؾ� �Ѵ�.
�׷��� GROUP BY�� ���� ���ϸ� MAX�Լ��� �� ���ϱ� �� ��쿡 ALL�����ڸ� ����ؾ� �Ѵ�.
SUM AVG MAX MIN COUNT   �� �ݵ�� GROUP BY��� ���� ��� ��
���� ���� �ڵ� ������ �Ϲ��÷��� �� �������Ƿ� ���̺��� ����Ʈ �׷����� �����Ͽ� �����Ѵ�.
�Ϲ��÷��� �� ���� ���� ���̺��� �ϳ��� �׷����� ����.
����) ��Ÿ���� <- ������ ��Ȱȭ

EXTRACT(MONTH) �� �ϴ� ���: ELP SYSTEM���� �̹� �޿� ������ �������� � �۾��� �� ��
YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
���۸��ؼ� �� �� �ƹ� �ڵ峪 ���� ���� �ȵ�
���� ���� �ڵ�� �ڹ� ������Ʈ Ʃ�丮�� �ȿ� �������.
�װ� ����ȭ�� �ڵ���

���� SUBSTR�� ����� ���ڿ��̴�. DATEŸ�Կ��� SUBSTR�� ���� ����.(���ư��� ������ �� ����ΰŴ�.)
DATE�� STR�� �ؼ�