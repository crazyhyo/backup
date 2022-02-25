2021-0713-01)
  3. ��¥ �ڷ�
   - DATE, TIMESTAMP Ÿ������
   - ������ ������ ���
   1)DATE
    - �⺻ ��¥��
   (�������)
    �÷��� DATE
     - ����Ͻú��� ������ �������
     - ��¥�� �ڷ��� ���� : �� ��¥������ �ϼ� ��ȯ                   -- �ú��ʱ��� ����, ��¥�� ������ 0�� 0�� 0�ʺ��� ���� 9�� 26���� ���� 1/4���� ���� ū �� ��ȯ // NUMBER TYPE
     - ��¥�� + ���� : '��¥'���� '����' ��ŭ ����� ���� ��¥ ��ȯ
     - ��¥�� - ���� : '��¥'���� '����' ��ŭ ������ ��¥ ��ȯ

   2)TIMESTAMP
    - �ð��� ������ ������ �ð�(10����� 1��) ����
   (�������)
    �÷��� TIMESTAMP;                          - �ð��� ���� ���� ��¥ ����
    �÷��� TIMESTAMP WITH TIME ZONE;           - �ð��� ����(���ø�/�����)�� ��¥ ����
    �÷��� TIMESTAMP WITH LOCAL TIME ZONE;     - ������ ��ġ�� ������ �ð��� ����(���ø�/�����)�� ��¥ ����

��뿹)    CREATE  TABLE   T_DATE(
            COL1    DATE,
            COL2    DATE,
            COL3    TIMESTAMP,
            COL4    TIMESTAMP WITH TIME ZONE,
            COL5    TIMESTAMP WITH LOCAL TIME ZONE
            );

INSERT INTO T_DATE    VALUES(SYSDATE, TO_DATE('20201015')+30,SYSDATE,SYSDATE,SYSDATE);
SELECT * FROM T_DATE;

SELECT  TO_CHAR(COL1, 'YYYY-MM-DD PM HH24:MI:SS'),
        TRUNC(COL1-COL2)
FROM    T_DATE;

  4. ��Ÿ �ڷ�
   - 2�� �ڷḦ ����
   - RAW, LONG RAW, BLOB, BFILE
   
  1) BFILE
   - 2�� �ڷ� ����
   - �����ڷḦ �����ͺ��̽� �ܺο� �����ϰ� �����ͺ��̽����� ��������� ����
   - 4GB ���� ����
  (�������)
   �÷��� BFILE;
    - ����Ŭ������ �����ڷ�(2���ڷ�)�� ���Ͽ� �ؼ��ϰų� ��ȯ���� ����.
    - 2���ڷ� ������ ���� DIRECTORY ��ü�� �ʿ�
��뿹)
    CREATE TABLE    T_BFILE(
        COL1 BFILE
    );
   
   1.���丮 ��ü ����
    CREATE DIRECTORY ���丮�� AS �����θ�;
    
    CREATE DIRECTORY TEMP_DIR AS 'D:\A_TeachingMaterial\2.Oracle';
    
    2.�̹��� �ڷ� ����
     INSERT INTO ���̺��
        VALUES(BFILENAME(���丮 ��Ī, '���ϸ�'));
        
    INSERT INTO T_BFILE
        VALUES(BFILENAME('TEMP_DIR', 'sample.jpeg'));
        
    SELECT * FROM T_BFILE;

  1) BLOB
   - 2�� �ڷ�����
   - 4GB ���� ���� ����
   - �����ڷḦ �����ͺ��̽� ���ο� ����
  (�������)
   ** BLOB ������
     (1)���̺� ����
     (2)���丮��ü ����
     (3)�͸��� ����

��뿹)
    a)���̺� ����
    1)CREATE TABLE T_BLOB(
        COL1 BLOB);
        
    b)���丮 ����
        TEMP_DIR ���
        
    c)�͸��� ����
    
    DECLARE
        L_DIR VARCHAR2(20) := 'TEMP_DIR';
        L_FILE VARCHAR2(30) := 'sample.jpeg';
        L_BFILE BFILE;
        L_BLOB BLOB;
    BEGIN
        INSERT INTO T_BLOB(COL1) VALUES(EMPTY_BLOB())
            RETURN COL1 INTO L_BLOB;
        L_BFILE := BFILENAME(L_DIR, L_FILE);
        DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
        DBMS_LOB.LOADFROMFILE(L_BLOB,L_BFILE,DBMS_LOB.GETLENGTH(L_BFILE));
        DBMS_LOB.FILECLOSE(L_BFILE);
        
        COMMIT;
    END;
    
    SELECT  *   FROM    T_BLOB;
    
    

�ڹ�/jsp ��� �����Ͽ� ó���ϱ� ���Ͽ� �����ͺ��̽� ���   
�ڹٿ��� ����ϴ� ��¥�ڷ� Ÿ�԰� ����Ŭ���� ����ϴ� ��¥�ڷ� Ÿ���� �ٸ�       <-  �̰� �ٽɹ���
�׷��� ����Ŭ���� ��¥�� ���ڿ��� �����ϰ� �ڹٿ��� �� ���ڿ��� ��¥�� ��ȯ�Ͽ� ����ϴ� ��� ����.
������ ���Ŀ� ���߾� ��¥ ǥ�� ���ؼ��� �׷����� Ķ����, ����
��¥�� ǥ�����ִ� ���� CSS�� HTML, JAVA SCRIPT ��� �����Ǵ� api ���.
�����ڹ��� ��¥ó�� Ŭ���� ���� �ٸ� ���� API�� ���� ����.
DATE Ÿ���� DATE Ÿ�Գ��� �� �� ����, DATE Ÿ���� ������ ���ϰ� �� �� ����
��¥: ��, ��, ��, ��, ��, �ʷ� ����.   ��¥�� ���ڿ��� �ٲپ� format���� ����Ͽ� ��, ��, �� ����. (�Ϲ��� ������� �ú��� ���� �����)
TIMESTAMP�� TIME ZONE ������ ������ ����(���� ������ ���� �ð��� �ٸ�, Ÿ���� ���� �ʿ�) WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE
��¥�� + ������ ��� �׳� 30�� ���ϸ� ����, ������ ������� -> ȸ���� ������ ���� �׳� �� ��¥�� ȸ���� �Ⱓ ��¥��ŭ ���ϸ� �ȴٴ� ���
���꼼, ���� � ��¥��
TIMESTAMP�� ���̰�� ����, �̰��� �̿��Ͽ� ���� ��� ����

������ ������ ��¥�� BETWEEN�� ����ϰ� �׷��� ���� ��쵵 ���ڿ��� ������� ����. ������ �ȶ��� �� �����ΰŴ�.
D�� �ϳ��� ����(N����), DD�� �� ���� ����� �ϼ�, DDD�� �� �⵵�� ����� �ϼ�
AM�� ��ٰ� �ؼ� ������ ������ PM�� ��ٰ� �ؼ� ���İ� ������ ����. �� ��� ���� ������� ���� ���ĸ� ������ �ְڴٴ� �̾߱�.
RAW, LONG RAW�� �ʹ� ����� �۾Ƽ� ���� �Ⱦ�.
BLOB(Binary Large Object)
BLOB, BFILE�� ��� 4GB����
BLOB�� ���̺��� �÷� �ȿ� 2���ڷḦ ����, BFILE�� �����ͺ��̽� �ܺο� ����
����� 2���ڷḦ �������� ���� �ʹٸ� �����ͺ��̽� ������ �ƴ�. ������ ��޾��� ó���ؾ� ��.
2�� �ڷ� �� �ƴ϶� 16���� �ڷᵵ ���尡��
��� : ����̺����� �ڷᰡ ����Ǿ� �ִ� ���������� ��θ� �����ζ�� ��
�������� ������ ����/������/���н������� ���丮��� ��.
DIR(cmd) = LS(unix/linux)  -A(all)
DOS = DISK OPERATOR SYSTEM
��ü�� CREATE�� ����, DROP���� ����
�ٸ� �������α׷������� ���� ����ϰ� ���� ����ϴ� ������ ���� �����ϴ°��� ����

DECLARE
    (���𿵿�)
        ����  /   ���  /   Ŀ���� ����
        �Ҵ翬���ڰ� := ��
        ���丮 ���� 20����Ʈ���� ��밡��
        ���ϸ��� 30����Ʈ���� ��밡��
BEGIN

        INSERT INTO T_BLOB(COL1) VALUES(EMPTY_BLOB())       --�ʱ�ȭ, �� BLOB�� ����
            RETURN COL1 INTO L_BLOB;
            
        SELECT INTO FROM WHERE  PL/SQL�� �������
            RETURN COL1 INTO L_BLOB;    --COL1�� L_BLOB���ٰ� �־��ش�, BLOB�� COL1���� �����Ǿ���
        ���Ͽ��� ������ �д� ��:
            ������ ����                                    ���� ���� ����   
            �󸶳� ������ ũ�⸦ �����Ͽ� �� ũ�⸸ŭ �д´�    <- 2���ڷḦ BFILE�� ���̸�ŭ �߶� �׸�ŭ�� �о L_BLOB���ٰ� �����ٵд�.
            ������ �ݴ´�                                   

END;