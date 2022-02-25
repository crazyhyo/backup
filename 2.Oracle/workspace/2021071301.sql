2021-0713-01)
  3. 날짜 자료
   - DATE, TIMESTAMP 타입제공
   - 덧셈과 뺄셈의 대상
   1)DATE
    - 기본 날짜형
   (사용형식)
    컬럼명 DATE
     - 년월일시분초 정보를 저장관리
     - 날짜형 자료의 뺄셈 : 두 날짜사이의 일수 반환                   -- 시분초까지 나옴, 날짜만 지정시 0시 0분 0초부터 지금 9시 26분을 빼면 1/4보다 조금 큰 수 반환 // NUMBER TYPE
     - 날짜형 + 정수 : '날짜'에서 '정수' 만큼 경과된 후의 날짜 반환
     - 날짜형 - 정수 : '날짜'에서 '정수' 만큼 과거의 날짜 반환

   2)TIMESTAMP
    - 시간대 정보와 정교한 시간(10억분의 1초) 제공
   (사용형식)
    컬럼명 TIMESTAMP;                          - 시간대 정보 없는 날짜 정보
    컬럼명 TIMESTAMP WITH TIME ZONE;           - 시간대 정보(도시명/대륙명)와 날짜 정보
    컬럼명 TIMESTAMP WITH LOCAL TIME ZONE;     - 서버가 설치된 지역의 시간대 정보(도시명/대륙명)와 날짜 정보

사용예)    CREATE  TABLE   T_DATE(
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

  4. 기타 자료
   - 2진 자료를 저장
   - RAW, LONG RAW, BLOB, BFILE
   
  1) BFILE
   - 2진 자료 저장
   - 원본자료를 데이터베이스 외부에 저장하고 데이터베이스에는 경로정보만 보관
   - 4GB 까지 저장
  (사용형식)
   컬럼명 BFILE;
    - 오라클에서는 원본자료(2진자료)에 대하여 해석하거나 변환하지 않음.
    - 2진자료 저장을 위해 DIRECTORY 객체가 필요
사용예)
    CREATE TABLE    T_BFILE(
        COL1 BFILE
    );
   
   1.디렉토리 객체 생성
    CREATE DIRECTORY 디렉토리명 AS 절대경로명;
    
    CREATE DIRECTORY TEMP_DIR AS 'D:\A_TeachingMaterial\2.Oracle';
    
    2.이미지 자료 저장
     INSERT INTO 테이블명
        VALUES(BFILENAME(디렉토리 별칭, '파일명'));
        
    INSERT INTO T_BFILE
        VALUES(BFILENAME('TEMP_DIR', 'sample.jpeg'));
        
    SELECT * FROM T_BFILE;

  1) BLOB
   - 2진 자료저장
   - 4GB 까지 저장 가능
   - 원본자료를 데이터베이스 내부에 저장
  (사용형식)
   ** BLOB 사용순서
     (1)테이블 생성
     (2)디렉토리객체 생성
     (3)익명블록 생성

사용예)
    a)테이블 생성
    1)CREATE TABLE T_BLOB(
        COL1 BLOB);
        
    b)디렉토리 생성
        TEMP_DIR 사용
        
    c)익명블록 생성
    
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
    
    

자바/jsp 등에서 연동하여 처리하기 위하여 데이터베이스 배움   
자바에서 취급하는 날짜자료 타입과 오라클에서 취급하는 날짜자료 타입이 다름       <-  이게 핵심문제
그래서 오라클에서 날짜를 문자열로 저장하고 자바에서 그 문자열을 날짜로 변환하여 사용하는 경우 많음.
일정한 형식에 맞추어 날짜 표현 위해서는 그레고리안 캘린더, 심플
날짜를 표시해주는 경우는 CSS나 HTML, JAVA SCRIPT 등에서 지원되는 api 사용.
순수자바의 날짜처리 클래스 보다 다른 좋은 API를 많이 쓴다.
DATE 타입은 DATE 타입끼리 뺄 수 있음, DATE 타입을 정수와 더하고 뺄 수 있음
날짜: 년, 월, 일, 시, 분, 초로 구성.   날짜를 문자열로 바꾸어 format으로 출력하여 시, 분, 초 접근. (일반적 방법으론 시분초 접근 어려움)
TIMESTAMP는 TIME ZONE 정보를 가지고 있음(지구 지역에 따라 시간이 다름, 타임존 정보 필요) WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE
날짜형 + 정수의 경우 그냥 30만 더하면 윤년, 평년까지 계산해줌 -> 회원권 마지막 날은 그냥 그 날짜에 회원권 기간 날짜만큼 더하면 된다는 얘기
가산세, 벌금 등에 날짜형
TIMESTAMP도 차이계산 가능, 이것을 이용하여 시차 계산 가능

범위가 지정된 날짜는 BETWEEN을 사용하고 그렇지 않은 경우도 문자열로 사용하지 마라. 에러가 안떠서 더 문제인거다.
D가 하나면 주차(N주차), DD는 그 월의 경과된 일수, DDD는 그 년도의 경과된 일수
AM을 썼다고 해서 오전이 나오고 PM을 썼다고 해서 오후가 나오지 않음. 둘 모두 같은 기능으로 오전 오후를 구분해 주겠다는 이야기.
RAW, LONG RAW는 너무 사이즈가 작아서 요즘 안씀.
BLOB(Binary Large Object)
BLOB, BFILE은 모두 4GB까지
BLOB는 테이블의 컬럼 안에 2진자료를 저장, BFILE은 데이터베이스 외부에 저장
저장된 2진자료를 사진으로 보고 싶다면 데이터베이스 영역은 아님. 보려면 고급언어에서 처리해야 함.
2진 자료 뿐 아니라 16진수 자료도 저장가능
경로 : 드라이브명부터 자료가 저장되어 있는 폴더까지의 경로를 절대경로라고 함
윈도우의 폴더를 도스/리눅스/유닉스에서는 디렉토리라고 함.
DIR(cmd) = LS(unix/linux)  -A(all)
DOS = DISK OPERATOR SYSTEM
객체는 CREATE로 생성, DROP으로 제거
다른 응용프로그램에서도 많이 사용하고 자주 사용하는 파일은 따로 저장하는것이 좋음

DECLARE
    (선언영역)
        변수  /   상수  /   커서가 나옴
        할당연산자가 := 임
        디렉토리 명은 20바이트까지 사용가능
        파일명은 30바이트까지 사용가능
BEGIN

        INSERT INTO T_BLOB(COL1) VALUES(EMPTY_BLOB())       --초기화, 빈 BLOB를 넣음
            RETURN COL1 INTO L_BLOB;
            
        SELECT INTO FROM WHERE  PL/SQL의 실행순서
            RETURN COL1 INTO L_BLOB;    --COL1을 L_BLOB에다가 넣어준다, BLOB는 COL1으로 배정되었음
        파일에서 데이터 읽는 법:
            파일을 연다                                    여는 권한 선택   
            얼마나 읽을지 크기를 지정하여 그 크기만큼 읽는다    <- 2진자료를 BFILE의 길이만큼 잘라서 그만큼을 읽어서 L_BLOB에다가 가져다둔다.
            파일을 닫는다                                   

END;