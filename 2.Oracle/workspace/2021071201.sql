2021-0712-01)데이터 타입
  - 오라클에서 사용되는 데이터 타입은  문자열, 숫자, 날짜, 2진자료형이 제공
  1. 문자열 자료
   - 오라클의 문자열은 ' ' 로 묶어 표현      -- 오라클의 모든 문자는 문자열, 자바의 한글자 타입 CHAR없음 모두 String
   - 고정길이(CHAR)와 가변길이(VARCHAR,VARCHAR2,LONG,NVARCHAR2,CLOB)타입으로 구분
   - 영문과 숫자, 특수문자는 LETER로 한글 한글자는 3BYTE로 표현
   1)CHAR
    - 정의된 크기의 기억공간에 자료를 저장하고 남는 공간은 공백으로 채움
    - 데이터는 MSB에서 LSB쪽으로 저장
   (사용형식)
   컬럼명 CHAR(크기 [BYTE|CHAR]):
   - 최대 2000BYTE 까지 저장가능
   - 'BYTE|CHAR' : 생략하면 BYTE로 취급되며 'CHAR'이 사용되면 '크기'는 글자수를 나타냄.
                   다만,  CHAR을 사용해도 2000BYTE를 초과할 수 없음
   - 길이가 고정된 컬럼인 기본키 커럼의 테이터 타입으로 주로 사용

사용예)
        CREATE TABLE T_CHAR(
            COL1    CHAR(20),
            COL2    CHAR(20 CHAR),
            COL3    CHAR(20 BYTE)
        );
        
        INSERT INTO T_CHAR(COL1,COL2,COL3)
            VALUES('무궁화 꽃이 피','무궁화 꽃이 피','무궁화');
            
        SELECT  *        FROM    T_CHAR;
        SELECT  LENGTHB(COL1),
                LENGTHB(COL2),
                LENGTHB(COL3)
        FROM    T_CHAR;
        
        
        ALTER TABLE T_CHAR  MODIFY(COL2 CHAR(20 CHAR));
        UPDATE  T_CHAR  SET COL2 = '무궁화 꽃이 피었습니다';

   2)VARCHAR2
    - 가변길이 자료저장에 사용
    (사용형식)
     컬럼명 VARCHAR2 (크기[BYTE|CHAR])
      - 최대 4000BYTE까지 저장가능
      - 사용자가 정의한 데이터 만큼 사용하고 남는 공간은 system에 반환

사용예)
    create table t_varchar2(
        col1 varchar2(500),
        col2 varchar2(50 char),
        col3 varchar2(50 byte)
    );
    
    insert into t_varchar2
            values('IL POSTONO', '필립 느와레', '마시모 트로이시');
    insert into t_varchar2
            values('IL', '필립 느와', '마시');
    select * from t_varchar2;
    select lengthb(col1), lengthb(SUBSTR(col2,1,3)), lengthb(col3)
    from t_varchar2;

   3)VARCHAR, NVARCHAR, NVARCHAR2
    - 기본적으로 NVARCHAR2와 저장 방법은 동일 함
    - NVARCHAR, NVARCHAR2는 UTF-8(가변길이), UTF-16(고정길이)방식의 코드로 변환하여 자료 저장(국제표준코드 적용)
    
   4)LONG
    - 가변길이 자료를 저장
   (사용형식)
   컬럼명 LONG
    - 최대 2GB까지 저장 가능 ( = 2 * 2^10 m byte = 2 * 2^10 * 2^10 k byte = 2 * 2^10 * 2^10 * 2^10 byte, 2^31바이트 사용)
    ㄴ 하나밖에 지정 못하는 이유 : LONG 타입 컬럼 하나에 거의 모든 저장공간(주소)를 다 써야했음 <- 예전 컴퓨터 기준
    - 한 테이블에 하나의 컬럼만 사용가능(제약사항)
    - CLOB로 대체됨S
    - 문자열 함수 (LENGTH, LENGTHB, SUBSTR 등)
    ㄴ LENGTH, LENGTHB로 저장공간 크기 조회 불가, SUBSTR의 INPUT TYPE ERROR

사용예)
    CREATE TABLE T_LONG(
        COL1    VARCHAR2(100),
        COL2    LONG,
        COL3    CHAR(100)
    );

    INSERT  INTO T_LONG(COL1,COL2,COL3)
            VALUES('PERSIMON BANNA APPLE', 'PERSIMON BANNA', 'PERSIMON');
    
    select lengthb(col1), col2, lengthb(col3) FROM T_LONG;
    
    SELECT COL3
    FROM T_LONG
    WHERE SUBSTR(COL3,90,1) = ' ';
    
   5)CLOB(Char Large Object)
    - 가변길이 자료를 저장
   (사용형식)
   컬럼명 CLOB
    - 최대 4GB까지 저장 가능(2^32 바이트 사용)
    - 여러 컬럼을 하나을 테이블에 선언 가능
    - 일부 기능은 DBMS_LOB APT의 지원을 받아야 사용 가능(LENGTH, SUBSTR 등) <-대용량자료를 처리할 수 있는 일련의 함수로 구성
    ㄴ 워낙 큰 저장공간을 사용하기 때문에 특정 함수 기능 사용 불가, 그래서 따로 다루는 함수 사용(EX BIGINTEGER IN JAVA)
    ㄴ 현재는 기능개선 중: SUBSTR(CLOB 타입)은 문법적으로 오류가 아니라 내부 데이터에 따라 오류를 반환하거나 제대로 돌아감
    ㄴ 주로 문서 전체를 하나의 컬럼에 저장하기 위해서 사용함, 그림은 데이터베이스에 따로 저장함
    
사용예)
    CREATE TABLE T_CLOB(
        COL1 CLOB,
        COL2 CLOB,
        COL3 VARCHAR2(4000),
        COL4 LONG
    );
    
    INSERT  INTO T_CLOB(COL1,COL2,COL4)
            VALUES('대전시 중구 대홍동 영민빌딩','대전시 중구 대홍동 영민빌딩','대전시 중구 대홍동 영민빌딩');
            
    SELECT * FROM T_CLOB;
    
    SELECT  DBMS_LOB.GETLENGTH(COL1),
            SUBSTR(COL1,5,6),
            DBMS_LOB.SUBSTR(COL1,5,6)
    FROM T_CLOB;

   따옴표 안의 문자열은 ASCII CODE로 변환되어 저장됨, 따라서 문자열 내부는 대소문자 구별
   고정길이든 가변길이든 저장공간보다 큰 데이터를 저장시 오류, 
   오라클의 LONG : 문자열, 더이상 기능향상은 없음
   정의된 크기의 기억공간에 자료를 저장하고 남는 공간은 공백으로 채움 <- 확인결과 진짜 ' '<- 스페이스 바 에 해당하는 글자임!
   NVARCHAR2 : N은 (national 의 약자), 국제표준인 UTR-8/16 방식으로 저장할 때 사용, NVARCHAR, NVARCHAR2, NCLOB 등
   LOB(Large Object), C: character, B: binary.
   영숫자 및 특수문자는 모두 1바이트로 처리, 한글은 3바이트로 처리 요즘은 완성형을 사용하고 있는데 이것도 3바이트 처리됨
   주소는 관습적으로 80바이트를 사용 <- 예전에는 고정길이(char)만 사용했음, varchar2 사용으로 이렇게 선언할 필요 없지만
   관습을 바꾸기 싫어서 그냥 사용 / iterater(앞으로만 가능), random(0~1의 double 타입)같은 것은 불편사항 접수로 편한 기능을
   설정했지만 사람들이 안씀.
   =================================================================
   MSB(MOST SIGNIFICANT BIT)                LSB(LEAST SIGNIFIANT BIT)
   ㄴ 가장 의미가 큰 비트(SIGN BIT)                 가장 의미가 작은 비트
   SIGN BIT 이후 모든 것은 DATA BIT
   CHAR은 데이터의 크기가 확정되어 있는 경우, 데이터의 변경이 없는 경우, 기본키를 설정할 때 사용
   기본키는 자동으로 INDEX가 설정됨, INDEX는 조회시 사용
   
   SELECT   LENGTH(문자열): 글자수를 가져옴 / LENGTHB : 바이트수를 가져옴, LONG TYPE에 적용 불가
   SELECT  LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
   FROM    T_CHAR;
   COL2의 '무궁화 꽃이 피' 는 8글자사용, 20바이트 사용, 나머지 12글자 공간에 각각 1바이트 할당하여 32바이트
   '무궁화 꽃이 피었습니다' 는 12글자사용, 32바이트 사용, 나머지 8글자 공간에 각각 1바이트 할당하여 40바이트
   이렇게 입력에 따라 할당되는 기억공간의 크기가 유동적이라서 잘 사용되지 않음
   왼쪽으로부터 오른쪽으로 저장되는 타입 : CHAR
   오른쪽으로부터 왼쪽으로 저장되는 타입 : 
   
   실명인증은 본인확인이 필요한 경우에만 사용, 행정안전처 데이터 베이스에서 조회, 접근권한은 꽤 강력하게 제한됨
   
   데이터 베이스 설계시 컬럼은 다른 컬럼과 INDENPENDENT해야 함, 다른 COLUMN들로 계산되지 않아야 함.
   -그렇다면 컬럼 설계에서 여러 정보를 가진 컬럼을 하나로 저장시키는게 나을까, 아니면
    각각 구분해서 저장하는게 나은가? -> 사용 목적에 따라 다르다
    
    자바는 0번부터, 오라클은 1번부터 시작
    SUBSTR의 자바와 오라클 문법이 다르다.
    오라클의 경우는 글자의 개수를, 자바는 마지막 글자 기준으로 어떻게 한다네.
    DBMS_LOB.SUBSTR(COL1,5,6) 이건 6번째 글자부터 5개의 글자를 가져온다는 뜻이다.
   
   64비트 운영체제: 한 데이터를 위한 주소의 크기가 64비트. 
   
  2. 숫자 자료
   - NUMBER 타입이 제공
  (사용형식)
   컬럼명 NUMBER[((정밀도)*[, 스케일: DEFAULT 0])]
    - 저장범위 : 1.0 * 10^-130 ~ 9.999..9[35자리] * 10^125
    - 정밀도 : 전체자리수(1 ~ 30)       <- 유효숫자인가?  ㅇㅇ, *는 최대인 38로 지정
    - 스케일(양수) : 소숫점 이하의 자리수 <- 소수점 아래 소수점 자리까지 반올림하여 나타내어라
      스케일(음수) : 정수부분의 자리수    <- -1: 일의 자리에서 반올림하라, -3: 백의 자리에서 반올림하라
    - 20 BYTE로 표현       <-NUMBER의 기억공간 사용크기
    ㄴ 정밀도가 스케일보다 큰 경우
    ㄴ 정밀도보다 스케일이 큰 경우는 소수점 아래 스케일 자리수의 데이터에 대하여 소수점 아래 정밀도 자리까지만 유효숫자로 지정함
    
    EX) NUMBER, NUMBER(10), NUMBER(10,2), NUMBER(*,2),...
    -----------------------------------------------------------------
    입력값          선언             기억되는 값
    -----------------------------------------------------------------
    123456.6789    NUMBER           123456.6789
    123456.6789    NUMBER(10)       123457
    123456.6789    NUMBER(7,2)      오류
    123456.6789    NUMBER(*,2)      123456.68
    123456.6789    NUMBER(10,-2)    123500
    
    123456.6789    NUMBER(7,2) : NUMBER(_,2)가 요구하는 유효숫자는 8자리임.(정수부분이 6자리니까), 근데 7개의 유효숫자로 표현불가 에러
    
    NUMBER: 입력값이 NUMBER의 도메인에 있는 경우 그대로 저장
    
    CREATE TABLE T_NUMBER(
        COL1 NUMBER,
        COL2 NUMBER(10),
        COL3 NUMBER(7,2),
        COL4 NUMBER(*,2),
        COL5 NUMBER(10,-2)
    );
    INSERT INTO T_NUMBER VALUES(123456.6789,123456.6789,123456.6789,123456.6789,123456.6789);
    INSERT INTO T_NUMBER(COL1) VALUES(123456.6789);
    INSERT INTO T_NUMBER(COL2) VALUES(123456.6789);
    INSERT INTO T_NUMBER(COL3) VALUES(12345.6789);
    INSERT INTO T_NUMBER(COL4) VALUES(12345.6789);
    INSERT INTO T_NUMBER(COL4) VALUES(1234567.6789);
    INSERT INTO T_NUMBER(COL4) VALUES(1234567.11234564);
    INSERT INTO T_NUMBER(COL5) VALUES(123456.6789);
    
    INSERT INTO T_NUMBER(COL1) VALUES('');
    
    SELECT * FROM T_NUMBER;
   
**스케일 > 정밀도
  - 스케일 : 소수점이하의 데이터 수
  - 스케일 - 정밀도 : 소수점이하에 존재해야할 0의 개수
  - 정밀도 : 소수점이하에 0이아닌 자료수
   
    -----------------------------------------------------------------
    입력값          선언             기억되는 값
    -----------------------------------------------------------------
    1.234          NUMBER(4,5)      오류(정수부분에 0이 아닌 값 존재)
    0.234          NUMBER(4,5)      0.234
    0.23           NUMBER(3,5)      오류(0.00으로 시작해야 함)
    0.0023         NUMBER(3,5)      오류(유효숫자가 부족)
    0.0023         NUMBER(2,4)      0.0023
    0.012345       NUMBER(3,4)      0.0123
    0.012355       NUMBER(3,4)      0.0124
    
    ALTER TABLE T_NUMBER ADD COLUMN COL6 NUMBER(3,5);
    ALTER TABLE T_NUMBER ADD COLUMN COL7 NUMBER(2,4);
    
   JAVA 에서 CHAR 형이 숫자로 변환되어서 저장. 그래서 JAVA의 PRIMITIVE TYPE중 숫자를 나타내는 자료형이 7가지
   (BYTE, SHORT, CHAR, INT, LONG, FLOAT, DOUBLE)(ECT: BOOLEAN) AUTOCAST는 연산시 INT이하를 모두 INT로 바꿈
   BOOLEAN은 다른 형으로 변환불가 및 다른 형에서 BOOLEAN으로 변환불가.
