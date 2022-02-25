2021-0720-02)NULLó�� �Լ�
  - ����Ŭ���� �� �÷��� �⺻ �ʱⰪ�� ��� NULL��
  - NULL �ڷῡ ���� ��Ģ���� �ܷΰ��� ��� NULL��
  - NULL �ڷῡ ���� ������ �� �Լ��� IS NULL, IS NOT NULL, NVL, NVL2, NULLIF ���� ����
  
  1. IS NULL, IS NOT NULL
   - Ư�� �÷��̳� ���� ���� NULL���� �Ǻ��ϱ� ���� ���
   - '='�����ڷ� NULL�� ���θ� �Ǻ����� ����
   
��뿹) ������̺��� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� �����
       �����ȣ, �����, �Ի���, �μ��ڵ�, �޿��� ��ȸ�Ͻÿ�
       
    SELECT EMPLOYEE_ID          AS  "�����ȣ",
           EMP_NAME             AS  "�����",
           HIRE_DATE            AS  "�Ի���",
           DEPARTMENT_ID        AS  "�λ��ڵ�",
           SALARY               AS  "�޿�"
      FROM HR.EMPLOYEES
     WHERE COMMISSION_PCT IS NOT NULL
     ORDER BY 1;
     
   -- '=' '<>' '!='�����ڷ� NULL�� ���θ� �Ǻ����� ����     
   
   2. NVL(c, val)
    - 'c'�� ���� �Ǵ��Ͽ� �� ���� NULL�̸� 'val' ���� ��ȯ�ϰ�, NULL�� �ƴϸ� 'c'�� ���� ��ȯ
    - 'c'�� 'val'�� �ڷ����� �����ؾ� ��.
    
����Ŭ������ ���ڰ� ���� ������.
c�� val���� �� ���� ���ڰ� �� ���� ������ ��� ���� �ڵ�����ȯ�� �Ұ����� ��� ������ �߻��Ѵ�.

��뿹)��ǰ���̺��� PROD_SIZE ���� NULL�̸� '��ǰũ������ ����' ���ڿ��� ����Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ũ��, ���Դܰ�
      
    SELECT PROD_ID                              AS  "��ǰ�ڵ�",
           PROD_NAME                            AS  "��ǰ��",
           NVL(PROD_SIZE,'��ǰũ������ ����')     AS  "ũ��",
           PROD_COST                            AS  "���Դܰ�"
      FROM PROD;
      
��뿹)������̺��� �����ȣ, �����, �μ��ڵ�, �����ڵ带 ����Ͻÿ�      
      ��, �μ��ڵ尡 NULL�̸� 'CEO'�� ����Ͻÿ�
      
    SELECT EMPLOYEE_ID                              AS  "�����ȣ",
           EMP_NAME                                 AS  "�����",
           NVL(TO_CHAR(DEPARTMENT_ID),'CEO')        AS  "�μ��ڵ�",
           JOB_ID                                   AS  "�����ڵ�"
      FROM HR.EMPLOYEES;
      
**��ǰ���̺��� �з��ڵ尡 P301�� ��ǰ�� �ǸŰ��� ���԰��� 90%�� UPDATE�Ͻÿ�
UPDATE  PROD
SET     PROD_PRICE = PROD_COST
WHERE   LOWER(PROD_LGU) = LOWER('P301');

SELECT * FROM PROD
WHERE PROD_LGU = 'P301';

ROLLBACK;
COMMIT;

UPDATE -> SELECT -> COMMIT�� �� �����̴�.

��뿹)2005�� 7�� ��� ��ǰ�� ���� �Ǹ������� ��ȸ�Ͻÿ�.
      Alias�� ��ǰ�ڵ�, �Ǹż����հ�, �Ǹűݾ��հ�
      
    SELECT B.PROD_ID                        AS  "��ǰ�ڵ�",
           SUM(A.CART_QTY)                  AS  "�Ǹż����հ�",
           SUM(A.CART_QTY * B.PROD_PRICE)   AS  "�Ǹűݾ��հ�"
      FROM CART A, PROD B
     WHERE A.CART_PROD(+)= B.PROD_ID
           AND SUBSTR(A.CART_NO,1,6) = '200507'
     GROUP BY B.PROD_ID
     ORDER BY 2,3;
     
     
�ܺ����ο��� �Ϲ����������� ����Ǹ� �ܺ������� �����Ű�� �ʰ� �Ϲ�����(INNER JOIN)�� ����ȴ�.
���� ������ ����Ŭ �������� + �Ϲ����� ������ ����Ǿ� �ܺ������� �ƴ϶� ���� ������ ����Ǹ鼭 ���ϴ� ���·� ��µ��� �ʾҴ�

    SELECT B.PROD_ID                        AS  "��ǰ�ڵ�",
           NVL(SUM(A.CART_QTY),0)                  AS  "�Ǹż����հ�",
           NVL(SUM(A.CART_QTY * B.PROD_PRICE),0)   AS  "�Ǹűݾ��հ�"
      FROM CART A
     RIGHT OUTER JOIN PROD B ON(A.CART_PROD= B.PROD_ID
           AND SUBSTR(A.CART_NO,1,6) = '200507')
     GROUP BY B.PROD_ID
     ORDER BY 2,3 ASC;

���� ��½����� NVL(,0)�̴�. NULL�� 0���� ����ϴ� ���̴�.

   3. NVL2(c, val1, val2)
   - 'c'���� �Ǵ��Ͽ� �� ���� NULL�̸� 'val2'�� ��ȯ�ϰ� NULL�� �ƴϸ� 'val1'�� ��ȯ ��
   - 'val1'�� 'val2'�� ������ Ÿ���� ���ƾ� ��
   - �̶� 'c'�� ������ Ÿ���� ����

��뿹)������̺��� �����ȣ, �����, �μ��ڵ�, �����ڵ带 ����Ͻÿ�.
      ��, �μ��ڵ尡 NULL�̸� 'CEO'�� ����Ͻÿ�.
      
    SELECT EMPLOYEE_ID              AS  "�����ȣ",
           EMP_NAME              AS  "�����",
           NVL2(DEPARTMENT_ID,TO_CHAR(DEPARTMENT_ID),'CEO')              AS  "�μ��ڵ�",
           JOB_ID              AS  "�����ڵ�" 
      FROM HR.EMPLOYEES;
      
��뿹)��ǰ���̺��� ��ǰ�� ��������(PROD_COLOR)�� ���� NULL�̸� '�������� ���� ��ǰ'��, NULL�� �ƴϸ� '�������� ���� ��ǰ'�� ����Ͻÿ�

SELECT PROD_ID AS  "��ǰ�ڵ�",
       PROD_NAME AS  "��ǰ��",
       NVL2(PROD_COLOR,'�������� ���� ��ǰ','�������� ���� ��ǰ') AS  "��������"
  FROM PROD;
  
   4. NULLIF(c1, c2)
    - 'c1'�� 'c2'�� ���Ͽ� ������ NULL�� ��ȯ�ϰ�, ���� ������ c1�� ��ȯ ��
    
��뿹)��ǰ���̺��� �ǸŰ��� ���԰��� ���Ͽ� ���� ������ '�����ǰ', ������ '������ǰ'�� ������ ����Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰�, �ǸŰ�, ���
      
    SELECT PROD_ID AS "��ǰ�ڵ�",
           PROD_NAME AS "��ǰ��",
           PROD_COST AS "���԰�",
           PROD_PRICE AS "�ǸŰ�",
           NVL2(NULLIF(PROD_PRICE,PROD_COST), '�����ǰ', '������ǰ') AS "���"
      FROM PROD;

��뿹)��ǰ���̺��� �ǸŰ��� ���԰��� ���Ͽ� ���� ������ �ǸŰ���, ������ '������ǰ'�� �ǸŰ����� ����Ͻÿ�
      Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰�, �ǸŰ�
      
    SELECT PROD_ID AS "��ǰ�ڵ�",
           PROD_NAME AS "��ǰ��",
           PROD_COST AS "���԰�",
           LPAD(NVL(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST)),'������ǰ'),8) AS "�ǸŰ�"
      FROM PROD;
      
    SELECT PROD_ID AS "��ǰ�ڵ�",
           PROD_NAME AS "��ǰ��",
           PROD_COST AS "���԰�",
           NVL(LPAD(TO_CHAR(NULLIF(PROD_PRICE,PROD_COST)),10),LPAD(TRIM('������ǰ'),11)) AS "�ǸŰ�"
      FROM PROD;
      
      
��������, ���־������� �ѱ��� ������ �۾��� �����ϴµ��� ���� ���� ����̴�.
