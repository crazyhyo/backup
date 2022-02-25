2021-0706-02)SQL ����� ����
  1)Query
   - ���� �� ��ȸ
   - SELECT ��
  2)DML(Data Manipulation Language:������ ���۾�)
   - INSERT, UPDATE, DELETE ��
   
  3)DCL(Data Control Language:������ �����)
   - COMMIT, ROLLBACK, SAVEPOINT, GRANT
   
  4)DDL(Data Definition Language:������ ���Ǿ�)
   - CREATE, DROP, ALTER

 (1)CREATE
 - ����Ŭ ��ü�� ����
  (�������)
  CREATE ��üŸ�� ��ü��;
  - ��üŸ�� : �����Ϸ� �ϴ� ��ü�� ������ USER, VIEW, INDEX, SYNONYM, TABLE... etc
  **���̺� �������
  CREATE TABLE ���̺��(
    �÷��� ������Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��][,]
                            :
    �÷��� ������Ÿ��[(ũ��)] [NOT NULL] [DEFAULT ��][,]
    
    [CONSTRAINT �⺻Ű������ PRIMARY KEY(�÷���[,�÷���,...])[,]
    [CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���[,�÷���,...])
      REFERENCES ���̺��(�÷���)[,]
                            :
    [CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���[,�÷���,...])
      REFERENCES ���̺��(�÷���)[,]
      
    - '������Ÿ��' : CHAR, VARCHAR2, DATE, NUMBER, CLOB{�ſ� ū �ؽ�Ʈ����}, BLOB{�ſ� ū �̹�������} �� ���
    - 'DEFAULT ��': ����ڰ� ������ �Է½�(INSERT��) �����͸� ������� ���� ��� ����Ǵ� ��
    - '�⺻Ű������', '�ܷ�Ű������' : �⺻Ű �� �ܷ�Ű ������ �����ϱ� ���� �ο��� �ε��������� ������ �ĺ����̾�� ��
    -'REFERENCES ���̺��(�÷���)' : �������̺��(�θ����̺��)�� �װ����� ���� �÷���
    
    ����)
    -�������̺���� �˼� �ְ� �̸� �ۼ�, ���� ���̺��� ����´ٸ� �� ���̺�� �����ֱ�, ���̺��� �ʹ� �Ϲ��� ���ų� ������ ��Ī�� ������
    TBL_��¼���� �ϸ� �ȴ�.
    -���̺��� �ϳ� �̻��� ���� ������ �־�� �Ѵ�. ���� ��� ��
    -NOT NULL�� ���� INSERT�� �� ���̰� ����, �ݵ�� �����ؾ� ��.
    -,�� ������ �̾��� ������ �ν���, ���� ���ȣ�� ���� �� ����.
    -�⺻Ű������� �ܷ�Ű�������� �ߺ����� ����. ����? �̰� �ε����� ���Űŵ� / �⺻Ű�������� ���� pk_��¼��, �ܷ�Ű�������� ����
    ���� ���̺��_�������̺��
    -�ε����� �ʿ��� ����: ���� ��ġ, �ߺ����� �ʱ� ����
    -Ÿ���ι̽� REFERENCES S �ٴ´�!
    [CONSTRAINT �ܷ�Ű������ FOREIGN KEY(�÷���<- �ڽ����̺��� ���� ���� �ִ� �÷���[,�÷���,...])
    REFERENCES ���̺��(�÷���)<- �θ����̺��� ����ϰ� �ִ� �÷���[,]
    );
    
��뿹) ���������� �����ڷ� 97�� �� ERD�� �����Ͽ� ���, �����, ���������, �ٹ� ���̺��� �����Ͻÿ�
        [������̺�]
        1)���̺�� : EMPLOYEE
        2)�÷�
        -----------------------------------------
        �÷���          ������Ÿ��(ũ��)    N.N     PK/FK
        -----------------------------------------
        EMP_ID         CHAR(4)           N.N     PK
        EMP_NAME       VARCHAR2(30)      N.N
        E_ADDR         VARCHAR2(80)
        E_TEL          VARCHAR2(20)
        E_POSITION     VARCHAR2(30)
        E_DEPT         VARCHAR2(50)
        
CREATE TABLE EMPLOYEE(
        EMP_ID         CHAR(4)           NOT NULL,    
        EMP_NAME       VARCHAR2(30)      NOT NULL,
        E_ADDR         VARCHAR2(80),
        E_TEL          VARCHAR2(20),
        E_POSITION     VARCHAR2(30),
        E_DEPT         VARCHAR2(50),
        
        CONSTRAINT pk_employee PRIMARY KEY(EMP_ID)
);
commit;

        [����� ���̺�]
        1)���̺�� : SITE
        2)�÷�
        -------------------------------------------------
        �÷���          ������Ÿ��(ũ��)    N.N     PK/FK
        -------------------------------------------------
        SITE_ID         CHAR(4)                  PK
        SITE_NAME       VARCHAR2(30)     N.N
        SITE_ADDR       VARCHAR2(80)
        REMARKS         VARCHAR2(255)
        -------------------------------------------------
        
CREATE TABLE SITE(
        SITE_ID         CHAR(4),        
        SITE_NAME       VARCHAR2(30)     NOT NULL,
        SITE_ADDR       VARCHAR2(80),
        REMARKS         VARCHAR2(255),
        
        CONSTRAINT pk_site PRIMARY KEY(SITE_ID)
);

        [�ٹ� ���̺�]
        1)���̺�� : WORK
        2)�÷�
        -------------------------------------------------
        �÷���          ������Ÿ��(ũ��)    N.N     PK/FK
        -------------------------------------------------
        EMP_ID         CHAR(4)           N.N,    PK & FK
        SITE_ID        CHAR(4)           N.N,    PK & FK
        DEPART         DATE
        -------------------------------------------------

CREATE TABLE WORK(
        EMP_ID         CHAR(4)           NOT NULL,
        SITE_ID        CHAR(4)           NOT NULL,
        DEPART         DATE,
        
        CONSTRAINT pk_work PRIMARY KEY(EMP_ID,SITE_ID),
        CONSTRAINT fk_work_emp FOREIGN KEY(EMP_ID)
            REFERENCES EMPLOYEE(EMP_ID),
        CONSTRAINT fk_work_site FOREIGN KEY(SITE_ID)
            REFERENCES SITE(SITE_ID)
);

drop table work;
DROP TABLE WORK;
DROP TABLE SITE;
DROP TABLE EMPLOYEE;