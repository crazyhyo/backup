2021-0730-01)

2. SEQUENCE ��ü
  - ���������� �����ϴ� ���� ��ȯ�ϴ� ��ü.
  - ���̺�� ������
  - ������ ���̺��� �⺻Ű�� ������ ������ �÷��� ���� ���,
    �ڵ����� �ο��Ǵ� �������� ���� ���� �ʿ��� ��� ���

 (�������)
   CREATE SEQUENCE ��������
     [START WITH N] -- ���� ��, �����ϸ� �ּҰ�(MINVALUE)
     [INCREMENT BY N] -- ������, �����ϸ� 1
     [MAXVALUE N|NOMAXVALUE] -- �ִ밪, �⺻�� NOMAXVALUE�̸� 10^27
     [MINVALUE N|NOMINVALUE] -- �ּҰ�, �⺻�� NOMINVALUE�̸� 1
     [CYCLE | NOCYCLE] -- �ּ�[�ִ�]�� ���� �� ���������� �ٽ� �������� ���� �⺻�� NOCYCLE
     [CACHE N | NOCACHE] -- ������ ���� ĳ���� ���� �����ϰ� ������� ����, �⺻�� CACHE 20
     [ORDER | NOORDER] -- ������ ���Ǵ�� ������ ������ ����, �⺻�� NOORDER
     
  ** �ǻ��÷�(PSEUDO COLUMN)
    ��������.CURRVAL : '������'�� ������ �ִ� ���簪 ��ȯ
    ��������.NEXTVAL : '������'�� ������ ��ȯ
    ** ������ ��ü�� ������ �� �� ó�� ����� �ݵ�� '��������.NEXTVAL'�̾�� ��
    ** ��������.NEXTVAL�� ����Ͽ� ������ ���� �ٽ� ������� �� ����
    
    ���� ���̺��� ���ÿ� �����ϱ� ������ �� ���̺��� NEXTVAL�� �ι� ����ϸ� �ٸ� ���̺����� �ڽ��� ���� ���� ���� ����
    ������ �� ����.
    
��뿹)���̺� LPROD�� LPROD_ID�� ����� �������� �����Ͻÿ�
DECLARE
  V_ID LPROD.LPROD_ID%TYPE:=0
BEGIN
  V_ID
  SELECT MAC(LPROD_ID) INTO V_ID FROM LPROD;
  CREATE SEQUENCE SEQ_LPROD
    START WITH V_ID;
END;

CREATE SEQUENCE SEQ_LPROD
  START WITH 10;
SELECT SEQ_LPROD.CURRVAL FROM DUAL;

INSERT INTO LPROD
  VALUES(SEQ_LPROD.NEXTVAL, 'P501','��깰');
SELECT * FROM LPROD;

�� ���ѿ����� LPROD�� ������ ���� �� �� ���� ������ ���� �� �ִٸ� MAX�� �ִ밪�� Ȯ���ؾ� ��

��뿹)������ 2005�� 4�� 18���̶� �����ϰ� CART_NO�� �����Ͻÿ�

SELECT MAX(CART_NO) + 1 FROM CART WHERE SUBSTR(CART_NO,1,8) = '20050418';
SELECT SUBSTR(MAX(CART_NO),9) FROM CART WHERE SUBSTR(CART_NO,1,8) = '20050418';
SELECT TO_CHAR(TO_DATE('2005/04/18'),'YYYYMMDD')||
       TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9)) + 1, '00000'))
  FROM CART
 WHERE SUBSTR(CART_NO,1,8) = '20050418';

SELECT COUNT(*) FROM HR.JOBS;

�������� ���� ���̺��� ����ϸ� �������� ����� ����ϱ� ���� �˰����� ���� �ۼ��� ��� �Ѵ�.

  ** �������� ����� ���ѵǴ� ���
   - SELECT,DELETE,UPDATE���� ���Ǵ� ��������(INSERT���� ����)
   - VIEW�� ������� �ϴ� QUERY
   - DISTINCT�� ���Ǵ� SELECT��
   - GROUP BY, ORDER BY���� ���Ǵ� SELECT��
   - ���տ���(UNION, UNION ALL, INTERSECT, MINUS)�� ���Ǵ� SELECT��
   - WHERE ��

�ַ� ���Ǵ� �� : INSERT��, �ڷ������ ���Ͽ� �ַ� ���Ǹ� ��ȸ�� ���� ������ ����

3. SYNONYM ��ü
 - ���Ǿ�(��Ī)�� �ǹ�
 - ����Ŭ���� ���Ǵ� ��ü�� ������ �̸��� �ο��Ͽ� ���� ����
 - �ַ� �� �̸��� ��ü���� ����ϱ� ���� ��ü������ ��ü �� �� ���
 (�������)
   CREATE [OR REPLACE] SYSNONYM �ó봽�� FOR ��ü��
    - '��ü��'�� ������ �̸��� '�ó봽��'�� �ο�
    - �÷��� ��Ī�� ���̺��� ��Ī���� ������
      - '�ó봽��'�� �ش� ���̺� �����̽� ��ü���� ���
      - '�÷��� ��Ī�� ���̺��� ��Ī'�� �ش� ���������� ��밡��
      
�� �������� ������ �ִ� ��� ���, ���̺� 

��뿹)HR�� ���̺� EMPLOYEES, DEPARTMENTS, JOB_HISTORY�� EMP, DEPT, JOBH��Ī�� �ο��Ͻÿ�
CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
CREATE OR REPLACE SYNONYM JOBH FOR HR.JOB_HISTORY;

SELECT * FROM DEPT;
SELECT * FROM JOBH ORDER BY 1;
