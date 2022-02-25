2021-0713-02)함수(FUNCTION)
  - 특정 결과를 반환하기 위하여 미리 작성하여 컴파일된 모듈
  - 반환값이 존재
  - 서버와 네트워크 성능 개선에 기여
  - 단일행 함수와 복수행 함수(집계함수:SUM,AVG,COUNT,MAX,MIN)로 구분
  - 문자열, 숫자, 날짜, 형변환, NULL처리, 집계함수 등이 있음
  - 중첩사용 할 수 있음
  
  1. 문자열 함수
   1) || (문자열 결합 연산자)
    - 자바의 문자열에서 사용되는 '+'와 같음            -- 같은 기능인 CONCAT, APPEND 메서드 있음, 근데 잘 안씀
    - 두 문자열을 결합하여 새로운 문자열을 반환
    
사용예)회원테이블에서 충남에 거주하는 회원정보를 조회하시오.
        Alias는 회원번호, 회원명, 주민번호, 주소이며 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력
SELECT      MEM_ID                              AS  회원번호,
            MEM_NAME                            AS  회원명,
            MEM_REGNO1  ||'-'||     MEM_REGNO2  AS  주민번호,
            MEM_ADD1    ||' '||     MEM_ADD2    AS  주소
FROM        MEMBER
WHERE       SUBSTR(MEM_ADD1,1,2) = '충남'
ORDER BY    1;
--      WHERE   MEM_ADD1    LIKE    '충남%'

   2) CONCAT(C1, C2)
    - 주어진 문자열 자료 C1과 C2를 결합하여 반환 (파라미터는 2개 뿐임)
    
사용예)회원테이블에서 충남에 거주하는 회원정보를 조회하시오.
        Alias는 회원번호, 회원명, 주민번호, 주소이며 주민번호는 'XXXXXX-XXXXXXX'형식으로 출력
SELECT      MEM_ID                                      AS  회원번호,
            MEM_NAME                                    AS  회원명,
            CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2)   AS  주민번호,
            CONCAT(CONCAT(MEM_ADD1,' '),MEM_ADD2)       AS  주소,
            CONCAT(MEM_ID,MEM_REGNO1)                   AS  TEST        --  CHAR랑 VARCHAR2도 합칠 수 있음
FROM        MEMBER
WHERE       SUBSTR(MEM_ADD1,1,2) = '충남'
ORDER BY    1;    

   3) ASCII(C1), CHR(N1)
    - ASCII(C1) : C1에 해당하는 문자를 반환
    - CHR(N1) : 숫자 N1에 해당하는 ASCII 코드값 반환

사용예)
    SELECT ASCII(PROD_ID), CHR(65) FROM PROD;
    SELECT ASCII(MEM_ID), CHR(65) FROM MEMBER;
사용예)
DECLARE

BEGIN
    FOR I IN 1..255 LOOP
        DBMS_OUTPUT.PUT_LINE(I||'='||CHR(I));               --CHR(37)은 %임!
    END LOOP;
END;


    
함수도 객체임
사용자 정의 함수는 PL/SQL의 서브루틴
함수와 프로시저 : 함수는 반환값 / 반환타입이 있고 프로시저는 반환값이 없음(자바의 VOID와 대응)
반환타입이 있으면 메서드 명 앞에 반환타입 설정
분류1 : 취급하는 데이터 타입
분류2 : 반환하는 값의 개수(집계함수, 여러 값을 반환하는 함수)
        EX) 각 반의 인원수 : 401호, 402호,... 에 몇명, 사람수가 6개가 나옴
        EX2) 남자와 여자의 인원수 - 반환값이 2개
왼편에는 컬럼명 1개 기술
오른편에는 여러 자료가 나올 수 있는 

CONCAT은 잘 안씀 <- 오류발생 위험 및 코드가독성, 코드 작성용이성

C: 문자열타입
N: 숫자타입
D: 날짜타입

함수의 종류에 따라서 사용되는 연산자도 변경되어야 한다
    =   함수의 반환값이 복수행인 경우 도메인 비교오류가 발생하기 때문에

SELECT  EMP_NAME, SALARY
FROM    HR.EMPLOYEES
WHERE   DEPARTMENT_ID    IN(SELECT A.DID
                            FROM    (SELECT         DEPARTMENT_ID   AS  DID,
                                                    COUNT(*)
                                    FROM            HR.EMPLOYEES
                                    GROUP BY        DEPARTMENT_ID
                                    HAVING          COUNT(*) >= 5) A);
                            


   4) RPAD(c1, n[, c2]), LPAD(c1, n[, c2])
    - RPAD : 지정된 길이 n에 c1을 저장하고 남는 오른쪽 공간에 c2를 삽입한다.
    - LPAD : 지정된 길이 n에 c1을 저장하고 남는 왼쪽 공간에 c2를 삽입한다.
    - c2가 생략되면 공백을 채움
    
사용예)    SELECT      LPAD('12345',7,'*')     AS  COL1,
                      RPAD('9876',6)          AS  COL2
          FROM        DUAL;

            SELECT      TO_CHAR(PROD_COST)                  AS  COL1,
                        LPAD(PROD_NAME,30)                  AS  COL2,
                        LPAD(TO_CHAR(PROD_COST),10)         AS  COL3,
                        LPAD(TO_CHAR(PROD_COST),10,'#')     AS  "COST"
            FROM        PROD;

   5) RTRIM(c1[, c2]), LTRIM(c1[, c2])
    - RTRIM : 주어진 문자열 c1 내부에 c2 문자열을 오른쪽에서 찾아 삭제
    - LTRIM : 주어진 문자열 c1 내부에 c2 문자열을 왼쪽에서 찾아 삭제
    - c2가 생략되면 공백을 제거
    
데이터베이스는 자료를 정확하게 보관하기 위한 도구,
나중에는 데이터베이스를 고급언어에서 사용할 것임, 데이터 베이스 자체에서 예쁘게 출력하는 것이 아니라
따로 예쁘게 출력하는 기능은 고급 언어에서 사용. 그래서 RAPD, LPAD는 자주 사용하지 않음
LPAD는 문자열 자료를 오른쪽 정렬하려 할 때 사용(숫자로 된 문자열을 오른쪽 정렬하고 싶을 때)
LTRIM, RTRIM은 무효의 공백을 제거(문자열의 한 쪽 끝의 연속된 공백을 제거)
문자열의 내부 공백을 제거할 때는 다른 함수 사용

   6) TRIM(c1)
    - 단어 왼쪽 또는 오른쪽에 발생된 공백을 모두 제거
    - 단어 내부 공백 제거는 불가능
    
SELECT  MEM_NAME, MEM_HP, MEM_JOB, MEM_MILEAGE
FROM    MEMBER
WHERE   MEM_NAME = TRIM('이혜나 ');

WHERE절에서는 자동적으로 TRIM해서 문자열 비교하지 않음
PL/SQL에서는 문자열을 비교할 때 자동으로 TRIM을 적용한 후 비교함

   7) SUBSTR(c, n1[, n2])
    - 주어진 문자열 c에서 n1번째 부터 n2 개의 문자를 추출하여 부분 문자열을 반환
    - 결과도 문자열임
    - n1, n2는 1부터 시작됨
    - n2가 생략되거나 문자의 수보다 큰 n2를 사용하면 n1이후 모든 문자열을 추출함
    - n1이 음수이면 오른쪽을 기준으로 처리됨, 그래도 그 시작문자부터 오른쪽으로 n2개의 문자 추출
    
사용예)    SELECT    SUBSTR('대전시 중구 대홍동', 2, 5),
                    SUBSTR('대전시 중구 대홍동', 2),
                    SUBSTR('대전시 중구 대홍동', 2, 20),
                    SUBSTR('대전시 중구 대홍동', -8, 6)
          FROM      DUAL;

자바의 SUBSTR은 N1과 N2가 모두 인덱스임

사용예) 오늘이 2005년 4월 1일인 경우 CART_NO를 자동 생성하시오.
SELECT      TO_CHAR(SYSDATE, 'YYYYMMDD')||LPAD(TO_CHAR((TO_NUMBER(SUBSTR(MAX(CART_NO),-5)) + 1)),5,'0')       AS  PROCESSING
FROM        CART
WHERE       SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE, 'YYYYMMDD');

SELECT      TO_CHAR(SYSDATE, 'YYYYMMDD')||TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9)) + 1, '00000'))
FROM        CART
WHERE       CART_NO LIKE    '20050401%';

SELECT  MAX(CART_NO) + 1
FROM    CART
WHERE   CART_NO LIKE '20050401%';

   8) REPLACE(c1, c2[,c3])
    - 주어진 문자열 c1에 포함된 c2를 찾아 c3로 치환시킴
    - c3가 생략되면 찾은 c2를 삭제시킴
    - 단어 내부의 공백 제거에 사용될 수 있음
사용예)
            SELECT  REPLACE('대전광역시 중구 대홍동', '전광역시', '전시'),
                    REPLACE('대전광역시 중구 대홍동', '광역'),
                    REPLACE('대전광역시 중구 대홍동', ' '),
                    REPLACE('대전광역시 중구 대홍동', '대')
            FROM    DUAL;
            
   9) INSTR(c1, c2[, m[, n]])                -- INDEX OF (IN?) STRING
    - 주어진 문자열 c1에서 c2문자열이 처음 나온 위치값을 반환
    - m은 검색 시작위치를 직접 지정할 때 사용
    - n은 c2문자열의 반복 횟수를 정하여 검색하는 경우 사용
    
사용예)
SELECT  INSTR('APPLE PERSIMON PEAR BEAR', 'E'),
        INSTR('APPLE PERSIMON PEAR BEAR', 'P', 5),
        INSTR('APPLE PERSIMON PEAR BEAR', 'P', 5, 2),
        INSTR('APPLE PERSIMON PEAR BEAR', 'P', 5, 3)
FROM    DUAL;

오라클의 INDEX는 1번부터 시작, 정확히 일치하는 문자열을 찾음,
검색의 대상이 되는 문자열에서 찾는 문자열의 첫 글자가 나온 위치를 반환, 찾지 못했다면 0을 반환
