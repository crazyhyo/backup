2021-0707-01)
1)�ڷ� ���� ���(INSERT)
 - ������ ���̺� ���ο� �ڷḦ ������
 (�������)
 INSERT INTO ���̺��[(�÷���1[,�÷���2,...])]
    VALUES(��1[,��2,,,]);
    - '���̺��' : �ڷ� ���� ��� ���̺��
    - '�÷���1,..' : �� �ɼ��� �����ϸ� ���̺� ����� ��� �÷��� ����� ������ �µ��� VALUES���� ���� ����ؾ� ��
    - '�÷���1,..' : �� �ɼ��� ���Ǹ� �ʿ��� �÷����� ��(������)�� �����Ͽ� �ڷḣ�� ������ �� ����.
                    ����� '�÷���'�� ���� �� ������ VALUES���� ���� ���� �� ������ ��ġ�ؾ��ϰ�, NOT NULL�׸��� �ݵ�� ���(����X)
                    
    ����) Ư�� �÷����� ���� �ְ� ���� �� � �÷��� � ���� ������ ������ָ� �ȴ�. �翬�� ��ġ���Ѿ���.
    ����Ŭ�� ��� ����Ʈ���� NULL����. NULL�� ������� �׻� NULL�� ��, �׷��� ����Ŭ������ ��ó�� �Լ��� ����
    INSERT�� ö��: �Է��� ���� �ְڴ�. �ƴ� �͵��� ��� NULL
    NULL IF, IS NOT NULL ��
    ���� �̹� ������ ���̸� �����ų� �⺻Ű�� ������ ���� CHAR Ÿ���� ����

��뿹) ������̺� (EMPLOYEE)�� ���� �ڷḦ �Է��Ͻÿ�.
    -------------------------------------------------------------------------------
    �����ȣ    �̸�     �ּ�                   ��ȭ��ȣ           ����      �μ�
    -------------------------------------------------------------------------------
    a101       ȫ�浿   ������ �߱� ��ȫ��       042-222-8202      ���      ���� ���ߺ�
    a104       ������                                            �븮      ���������
    a105       �̼���                                            ����
    -------------------------------------------------------------------------------
    
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_ADDR,E_TEL,E_DEPT,E_POSITION)
        VALUES('a101','ȫ�浿','������ �߱� ��ȫ��','042-222-8202','���� ���ߺ�','���');
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_DEPT,E_POSITION)
        VALUES('a104','������','���������','�븮');
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_POSITION,E_TEL)
        VALUES('a105','�̼���','����','010-1111-2222');
    
    INSERT INTO EMPLOYEE
        VALUES('a104','������','','','�븮','���������');
    
    UPDATE EMPLOYEE SET E_TEL = '' WHERE EMP_ID = 'a104';
    
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_POSITION)
        VALUES('a105','�̼���','����');
    
    SELECT * FROM EMPLOYEE;
    
    
��뿹) ����� ���̺�(SITE)�� ���� �ڷḦ �Է��Ͻÿ�.
    -------------------------------------------------------------------------------
    ������ȣ       ������                �ּ�                   ���
    -------------------------------------------------------------------------------
    S101           ��ȫ�ʵ��б���������      ������ �߱� ��ȫ��
    S200           �ǹ�����                
    -------------------------------------------------------------------------------
    INSERT INTO SITE(SITE_ID,SITE_NAME,SITE_ADDR)
        VALUES('S101','��ȫ�ʵ��б���������','������ �߱� ��ȫ��');
    INSERT INTO SITE(SITE_ID,SITE_NAME)
        VALUES('S200','�ǹ�����');
    
    INSERT INTO SITE
        VALUES('S200','�ǹ�����',NULL,'');

��뿹) �ٹ� ���̺�(WORK)�� ���� �ڷḦ �Է��Ͻÿ�.
    (1)ȫ�浿����� ���ú��� 'S200'����忡�� �ٹ�
    (2)�̼��ź����� 2020�� 10�� 1�Ϻ��� 'S200'����忡�� �ٹ�
    (3)�������븮�� S100����忡 �ٹ�
    INSERT INTO WORK(EMP_ID,SITE_ID,DEPART)
        VALUES('a101','S200','2021/07/07');
    INSERT INTO WORK(EMP_ID,SITE_ID,DEPART)
        VALUES('a105','S200','2020/10/01');
    INSERT INTO WORK(EMP_ID,SITE_ID,DEPART)
        VALUES('a104','S200','2021/01/01');
        
    INSERT INTO WORK VALUES('a105','S200',TO_DATE('20201001'));
    
    SELECT MOD((TRUNC(SYSDATE)-TO_DATE('00010101'))-1,7) FROM DUAL;
    
    INSERT INTO WORK VALUES('a101','S200',SYSDATE);
    INSERT INTO WORK(EMP_ID,SITE_ID) VALUES('a104','S101');
    
    SELECT * FROM EMPLOYEE;
    SELECT * FROM SITE;
    SELECT * FROM WORK;
    
    **S200�� �ٹ��ϴ� ��������� ��ȸ�Ͻÿ�
      Alias�� ������, �����ȣ, �����, ����, ��ȭ��ȣ�̴�.
      
    SELECT  SITE.SITE_NAME AS ������,
            EMPLOYEE.EMP_ID AS �����ȣ,
            EMPLOYEE.EMP_NAME AS �����,
            EMPLOYEE.E_POSITION AS ����,
            EMPLOYEE.E_TEL AS ��ȭ��ȣ
    FROM SITE, EMPLOYEE, WORK
    WHERE SITE.SITE_ID = WORK.SITE_ID
        AND EMPLOYEE.EMP_ID = WORK.EMP_ID
        AND SITE.SITE_ID = UPPER('S200');

1)�ڷ� ���� ���(DELETE)
 - �����ϴ� �ڷḦ ����
 
 (�������)
 DELETE ���̺��
    [WHERE ����];
 - '���̺��' : ������ �ڷᰡ ����� ���̺�
 - 'WHERE ����' : ������ ������ ����ϸ� �����ϸ� ����ڷ� ����
 - ROLLBACK�� ���
 - ���谡 ������ �ڷ�� ������ �� ����.
 
 SELECT (A) FROM (B) WHERE (C)
    A: ���� ����    B:�� ���̺���   C:�࿡ ����
 
    DELETE EMPLOYEE;
    
��뿹) ������̺��� 'a101'��������� �����Ͻÿ�.

DELETE WORK;
DELETE EMPLOYEE;
DELETE SITE;

COMMIT;

*** ��ü����
    DROP ��üŸ�� ��ü��;
    �ܷ�Ű�� �����ϰ� �ִ� ��ü�� ������ �� ���� -> �ڽ� ��ü���� �����ؾ� �Ѵ�.
    -ROLLBACK�� ����� �ȵ�
    
EMPLOYEE���̺� ����
    
    DROP TABLE WORK;
    DROP TABLE EMPLOYEE;
    DROP TABLE SITE;
    
    
    Q) �޸𸮿��� ����°��� �ϵ��ũ���� ����°���
    