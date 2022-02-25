2021-0706-02)��������
  - SQL�����ȿ� �� �ٸ� SQL������ ���Ե� ����
  - ���� ������ ��������, ���������� ���������� ��
  - ���������� ���������� ����� ��ȯ�ϱ� ���� �߰� ����� ���
  - ���������� ()�� ���� �����(���� INSERT���� ���Ǵ� ���������� '()'�� ������� ����)
  - ���������� ���Ǵ� ��ġ�� ���� �Ϲݼ�������(SELECT ��), �ζ��μ�������(FROM ��), ��ø��������(WHERE ��)�� ����
  - ��ȯ�ϴ� ����� ��/���� ������ ���� ������/���Ͽ�, ������/���߿�, ������/���Ͽ�, ������/���߿��� ����
  - ���������� ���������� ���Ǵ� ���̺� ���� ���� ���ο� ���� ���ü����� ��������/�������������� ����
  - �˷����� ���� ���ǿ� �ٰ��Ͽ� �����͸� �˻��ϴ� ��� ����

�ζ��μ��������� �ݵ�� ���������� �ϳ��� ������ �̷��� ��.
��ø���������� WHERE������ �ݵ�� ���迬���� ������ �;� �Ѵ�. EX: SALARY > (SELECT AVG(SALARY) FROM HR.EMPLOYEES)

SELECT EMPLOYEE_ID, EMP_NAME
  FROM HR.EMPLOYEES
 WHERE (DEPARTMENT_ID, MANAGER_ID) = (SELECT DEPARTMENT_ID, MANAGER_ID
                                        FROM HR.DEPARTMENTS
                                        WHERE MANAGER_ID = 121);

   - �ϳ��� �ุ ����� ��ȯ
   - ������ �����ڴ� ���迬����(=,<=,>=,<,>,<>,!=) ��

��뿹)
SELECT EMPLOYEE_ID, EMP_NAME
  FROM HR.EMPLOYEES
 WHERE (DEPARTMENT_ID, MANAGER_ID) = (SELECT DEPARTMENT_ID, MANAGER_ID
                                        FROM HR.DEPARTMENTS
                                        WHERE MANAGER_ID = 121);

���� ��ø���������� ����� ������ ���������� ��� IN�� ����Ѵ�
�񱳿���� �񱳴���� �Ǵ� �� ���� ������ �ݵ�� ���ƾ� �Ѵ�.(�ƴ� �� in�� ����� �� ����)
���� ������ WHERE���� ������ �� ���̺��� ���󰡸� �ѹ��� �� Ʃ���� ������ �о�´�. / �������� ���������� �� �ѹ� ����ȴ�.

  2)������ ��������
   - �ϳ� �̻��� ���� ��ȯ�ϴ� ��������
   - ������ ������ : IN, ANY, SOME, EXISTS

��뿹)������̺��� ������ ���� 10�� �̻��� �Ǵ� �μ��� �μ��ڵ�, �μ����� ���
     (�������� : �μ��ڵ�, �μ����� ���)
(����: IN)     
SELECT DEPARTMENT_ID AS "�μ��ڵ�",
       DEPARTMENT_NAME AS "�μ���"
  FROM HR.DEPARTMENTS
 WHERE DEPARTMENT_ID IN (SELECT B.DID
                           FROM (SELECT DEPARTMENT_ID AS DID,
                                        COUNT(*)
                                   FROM HR.EMPLOYEES
                                  GROUP BY DEPARTMENT_ID
                                 HAVING COUNT(*) >= 10) B);
(����: =ANY(=SOME))
SELECT DEPARTMENT_ID AS "�μ��ڵ�",
       DEPARTMENT_NAME AS "�μ���"
  FROM HR.DEPARTMENTS
 WHERE DEPARTMENT_ID = ANY(SELECT B.DID
                             FROM (SELECT DEPARTMENT_ID AS DID,
                                          COUNT(*)
                                     FROM HR.EMPLOYEES
                                    GROUP BY DEPARTMENT_ID
                                   HAVING COUNT(*) >= 10) B);
                                   
(����: EXISTS - �ݵ�� �ڿ� ���������� �´�)
  - EXISTS ������ ������ ǥ����(�� OR �÷���)�� ����
  - EXISTS ������ �������� �ݵ�� ��������
  
SELECT DEPARTMENT_ID AS "�μ��ڵ�",
       DEPARTMENT_NAME AS "�μ���"
  FROM HR.DEPARTMENTS A
 WHERE EXISTS (SELECT C.DID
--             SELECT 1
                 FROM (SELECT DEPARTMENT_ID AS DID,
                              COUNT(*)
                         FROM HR.EMPLOYEES B
                        GROUP BY DEPARTMENT_ID
                       HAVING COUNT(*) >= 10) C
                WHERE C.DID = A.DEPARTMENT_ID);

  3)���߿�
   - �ϳ� �̻��� ���� ��ȯ�Ǵ� ��������
   - PAIRWISE(�ֺ�) �������� �Ǵ� Nonpairwise (��ֺ�) ���������� ����
   
��뿹)80�� �μ��� �޿��� �μ� ��� �̻��� ����� ��ȸ�Ͻÿ�
      ALIAS�� �����ȣ, �޿�, �μ��ڵ�

SELECT EMPLOYEE_ID AS "�����ȣ",
       SALARY AS "�޿�",
       DEPARTMENT_ID AS "�μ��ڵ�"
  FROM HR.EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM HR.EMPLOYEES
                   WHERE DEPARTMENT_ID = 80)
       AND DEPARTMENT_ID = 80;
       
SELECT A.EMPLOYEE_ID AS "�����ȣ",
       A.SALARY AS "�޿�",
       A.DEPARTMENT_ID AS "�μ��ڵ�"
  FROM HR.EMPLOYEES A
 WHERE (A.EMPLOYEE_ID, A.DEPARTMENT_ID) IN (SELECT B.EMPLOYEE_ID, DEPARTMENT_ID
                                              FROM HR.EMPLOYEES B
                                             WHERE B.SALARY > (SELECT AVG(C.SALARY)
                                                                 FROM HR.EMPLOYEES C
                                                                WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID)
                                                   AND B.DEPARTMENT_ID = 80)
 ORDER BY 3;

