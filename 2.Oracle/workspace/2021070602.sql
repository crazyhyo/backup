2021-0706-02)SQL 명령의 구분
  1)Query
   - 질의 및 조회
   - SELECT 문
  2)DML(Data Manipulation Language:데이터 조작어)
   - INSERT, UPDATE, DELETE 문
   
  3)DCL(Data Control Language:데이터 제어어)
   - COMMIT, ROLLBACK, SAVEPOINT, GRANT
   
  4)DDL(Data Definition Language:데이터 정의어)
   - CREATE, DROP, ALTER

 (1)CREATE
 - 오라클 객체를 생성
  (사용형식)
  CREATE 객체타입 객체명;
  - 객체타입 : 생성하려 하는 객체의 종류로 USER, VIEW, INDEX, SYNONYM, TABLE... etc
  **테이블 생성명령
  CREATE TABLE 테이블명(
    컬럼명 테이터타입[(크기)] [NOT NULL] [DEFAULT 값][,]
                            :
    컬럼명 테이터타입[(크기)] [NOT NULL] [DEFAULT 값][,]
    
    [CONSTRAINT 기본키설정명 PRIMARY KEY(컬럼명[,컬럼명,...])[,]
    [CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명[,컬럼명,...])
      REFERENCES 테이블명(컬럼명)[,]
                            :
    [CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명[,컬럼명,...])
      REFERENCES 테이블명(컬럼명)[,]
      
    - '데이터타입' : CHAR, VARCHAR2, DATE, NUMBER, CLOB{매우 큰 텍스트파일}, BLOB{매우 큰 이미지파일} 등 사용
    - 'DEFAULT 값': 사용자가 데이터 입력시(INSERT문) 데이터를 기술하지 않은 경우 저장되는 값
    - '기본키설정명', '외래키설정명' : 기본키 및 외래키 설정을 구별하기 위해 부여된 인덱스명으로 고유한 식별자이어야 함
    -'REFERENCES 테이블명(컬럼명)' : 원본테이블명(부모테이블명)과 그곳에서 사용된 컬럼명
    
    주의)
    -원본테이블명을 알수 있게 이름 작성, 여러 테이블을 끌어온다면 각 테이블명 적어주기, 테이블이 너무 일반적 명사거나 마땅한 명칭이 없으면
    TBL_어쩌구로 하면 된다.
    -테이블은 하나 이상의 열을 가지고 있어야 한다. 행은 없어도 됨
    -NOT NULL을 쓰면 INSERT할 때 차이가 생김, 반드시 지정해야 함.
    -,가 없으면 이어진 것으로 인식함, 오류 행번호는 믿을 게 못됨.
    -기본키설정명과 외래키설정명은 중복되지 않음. 이유? 이걸 인덱스로 쓸거거든 / 기본키설정명은 보통 pk_어쩌구, 외래키설정명은 보통
    현재 테이블명_참조테이블명
    -인덱스가 필요한 이유: 빠른 서치, 중복되지 않기 위해
    -타이핑미스 REFERENCES S 붙는다!
    [CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명<- 자식테이블인 내가 쓰고 있는 컬럼명[,컬럼명,...])
    REFERENCES 테이블명(컬럼명)<- 부모테이블에서 사용하고 있는 컬럼명[,]
    );
    
사용예) 공유폴더의 강의자료 97쪽 논리 ERD를 참조하여 사원, 사업장, 사업장자재, 근무 테이블을 생성하시오
        [사원테이블]
        1)테이블명 : EMPLOYEE
        2)컬럼
        -----------------------------------------
        컬럼명          데이터타입(크기)    N.N     PK/FK
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

        [사업장 테이블]
        1)테이블명 : SITE
        2)컬럼
        -------------------------------------------------
        컬럼명          데이터타입(크기)    N.N     PK/FK
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

        [근무 테이블]
        1)테이블명 : WORK
        2)컬럼
        -------------------------------------------------
        컬럼명          데이터타입(크기)    N.N     PK/FK
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