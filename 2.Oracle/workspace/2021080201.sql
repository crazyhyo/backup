2021-0802-01)PL/SQL(Procedual Language SQL)

  - 표준 SQL의 기증을 확장한 SQL
  - 서버에 실행가능한 형태의 모듈화 된 서브프로그램
  - block 구조로 구성
  - 모듈화, 캡슐화
  - Anonymous Block, User Defined Function(Function), Stored Procedure(Procedure),
    Package, Trigger 등이 제공됨

1.익명블록(Anonymous Block)
 - PL/SQL의 기본구조
 - 단순 스크립트에서 실행되는 블록
 (기술형식)
 DECLARE
    선언부(변수, 상수, 커서 선언);
 BEGIN
    실행부(비지니스 로직 처리를 위한 sql문)
    [EXCEPTION 
        예외처리부;]
 END;

사용예)키보드로 10~110사이의 부서번호를 입력받아 해당부서직원중 가장 입사일이 빠른 사원 정보를 출력하시오
      ALIAS는 사원번호, 사원명, 입사일, 직책코드이다
      
    ACCEPT P_DID PROMPT '부서코드(10~110)'
    DECLARE
        V_EID       HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
        V_NAME      HR.EMPLOYEES.EMP_NAME   %TYPE;
        V_HIRE      HR.EMPLOYEES.HIRE_DATE  %TYPE;
        V_JOBID     HR.EMPLOYEES.JOB_ID     %TYPE;
    BEGIN
        SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.HIRE_DATE, A.JOB_ID
          INTO V_EID, V_NAME, V_HIRE, V_JOBID
          FROM (SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
                FROM HR.EMPLOYEES
                WHERE DEPARTMENT_ID = TO_NUMBER('&P_DID')
                ORDER BY 3) A;
         WHERE ROWNUM = 1;
         
        DBMS_OUTPUT.PUT_LINE('사원번호 : ' || V_EID);
        DBMS_OUTPUT.PUT_LINE('사원명 : ' || V_NAME);
        DBMS_OUTPUT.PUT_LINE('입사일 : ' || V_HIRE);
        DBMS_OUTPUT.PUT_LINE('직책코드 : ' || V_JOBID);
        
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외발생 : ' || SQLERRM);
    END;
 
PL/SQL은 SQL의 ANSI와 같은 문법적인 표준안이 없다(오라클, MYSQL 등마다 다름)
모듈화 - 하나의 모듈에 하나의 기능만을 담아야 한다.
캡슐화/은닉화 - 각 모듈간의 실행결과가 서로 간섭해서는 안됨
함수와 프로시저는 반환값의 유무로 구분됨
PL/SQL의 객체들을 묶음으로 묶어서 전체로도, 부분으로도 실행 할 수 있는 모임

패키지의 선언부는 프로토타입(추상메소드)의 모임
실행부에서 구체적으로 정의한다

익명블록의 특징 : 저장되어지지 않는다 = 다시 불러들여서 쓸 수 없다.

객체지향의 목적 재사용

변수는 V_로 시작, 매개변수는 P_로 시작
WHEN OTHERS THEN (EXCEPTION 클래스와 같이 모든 예외를 처리하고자 할 때 사용)

PLSQL은 DBMS창이 열려있어야 사용 가능

보기->DBMS창으로 열기, 자동으로 지워지지 않음, 지우개버튼으로 지움

PL/SQL의 가장 바깥쪽에 있는 SELECT 절은 반드시 INTO를 사용해야 함
쿼리가 여려 행 자료를 출력하는 경우 INTO에 들어올 수 없음(오류발생) 이를 해결하기 위한 것이 커서

DBMS_OUTPUT.PUT_LINE = SYSOUT
WHEN OTHERS THEN = EXCEPTION e
DBMS_OUTPUT.PUT_LINE(SQLERRM) = e.printStackTrace()

ACCEPT로 입력받는 자료형은 문자열(VARCHAR2)

  1) 변수와 상수
   - 실행부에서 사용할 변수와 상수
   - SCALA 변수 : 하나의 데이터를 저장하는 변수
    - REFERENCE 변수 : 임의의 테이블에 존재하는 컬럼의 타입과 크기를 참조하는 변수
    - COMPOSITE 변수 : PL/SQL에서 사용하는 배열 변수 - RECORD TYPE, TABLE TYPE
    - BIND 변수 : 파라미터로 넘겨지는 IN, OUT에서 사용되는 변수, 리턴값을 전달하기 위해 사용되는 변수
  (사용형식)
   변수명[CONSTANT] 데이터타입[(크기)]|[테이블명.컬럼명%TYPE|테이블명%ROWTYPE[:=초기값]];
     - 'CONSTANT' : 상수 선언
     - '테이블명.컬럼명%TYPE|테이블명%ROWTYPE' : 참조타입
     - 숫자형 변수인 경우 반드시 초기화 해야함
     - 데이터타입 : SQL에서 사용하는 데이터 타입,
        - BINARY_INTEGER, PLS_INTEGER : -2147483648 ~ 2147483647 사이의 정수 취급
        - BOOLEAN : true, false, null을 취급하는 논리형 변수

(LEFT VALUE) := (RIGHT VALUE)
':=' : ASSIGNMENT OPERATOR
LEFT VALUE : 변수만 올 수 있음
RIGHT VALUE : 값을 가지는 어떤 것이든 올 수 있음

전산의 SCALA 변수 : 한 순간의 하나의 값만 저장할 수 있는 변수
COMPOSITE 변수 : 한 행 전체(RECORD TYPE)를 받거나 한 테이블 전체(TABLE TYPE)를 받을 수 있는 변수
BINDING TIME : 값을 배정하는 시점
컴파일 언어 BINDING TIME이 프로그램 시작 이전, 컴파일 시점
인터프리터 언어 BINDING TIME이 프로그램 실행 중(런타임)
테이블명%ROWTYPE : 한 줄 전체를 참조할 때, 변수를 RECORD TYPE으로 지정
:=은 %TYPE이후에 띄어쓰기 없이 사용한다

CREATE안에서 CREATE는 사용할 수 없다.
따라서 CREATE로 시작하는 PROCEDURE, FUNCTION, TRIGGER안에서는 CREATE문을 사용한 테이블 생성이 불가능하다
(한 클래스 안에 MAIN메서드를 두개 이상 정의하는 꼴, 컴파일에러)
PL/SQL안에서 테이블을 생성하더라도 BOOLEAN TYPE으로 행의 데이터 타입을 정하는 것은 불가하다
PL/SQL안에서만 허용되는 데이터 타입은 변수에만 적용된다고 생각하자

  2) 분기명령
  - 프로그램의 실행 순서를 변경하는 명령
  - IF, CASE WHEN 등이 제공
  (1) IF문
    - 개발언어의 IF문과 동일한 기능 제공
    (사용형식 - 1)
    IF 조건 THEN
        명령1;
    [ELSE
        명령2;]
    END IF;
    
    (사용형식 - 2)
    IF 조건 THEN
        명령1;
    ELSIF 조건 THEN
        명령2;
        :
    [ELSE
        명령n;]
    END IF;
    
    (사용형식 - 3)
    IF 조건 THEN
        명령1;
        IF 조건 THEN
            명령2;
        ELSE
            명령3;
        END IF;
    ELSE
        명령n;
    END IF;
    
오라클은 중괄호{}를 쓰지 못하기 때문에 IF ~ END IF;, CASE WHEN ~ END;, LOOP ~ END LOOP; BEGIN ~ END;
오라클에서 FOR문 안에 FOR문을 작성은 할 수 있으나 잘 쓰지 않음

사용예)임의의 수를 입력 받아 짝수인지 홀수인지 판별하시오
ACCEPT P_NUM PROMPT '수 입력 : '
DECLARE
--    V_NUM NUMBER := 0;
    V_NUM NUMBER := TO_NUMBER('&P_NUM');
    V_RES VARCHAR2(100);
--    V_FLAG BOOLEAN := FALSE;
BEGIN
--    IF V_FLAG THEN
--        V_RES := 'TRUE';
--    ELSIF V_FLAG IS NULL THEN
--        V_RES := 'NULL';
--    ELSE 
--        V_RES := 'FALSE';
--    END IF;
--    
--    DBMS_OUTPUT.PUT_LINE(V_RES);
--    V_NUM := TO_NUMBER('&P_NUM');
    IF MOD(V_NUM,2) = 0 THEN
        V_RES := TO_CHAR(V_NUM)||'은 짝수 입니다.';
--        DBMS_OUTPUT.PUT_LINE('짝수 입니다.');
    ELSE
        V_RES := TO_CHAR(V_NUM)||'은 홀수 입니다.';
--        DBMS_OUTPUT.PUT_LINE('홀수 입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
--    EXCEPTION WHEN OTHERS THEN
--        DBMS_OUTPUT.PUT_LINE('예외! : ' || SQLERRM);
END;
    
IF(A == 3)
    3;

IF ~ THEN 사이에 나오는 조건에는 BOOLEAN이 될 수 있으며, ELSE 는 BOOLEAN의 참이 아닐 때인 NULL과 FALSE를 모두 받는다

사용예)회원테이블에서 회원들의 마일리지를 조회하여 그 값이 5000이상이면 'VIP 회원'을 
      3000 이상이면 '정회원'을, 그 이하이면 '준회원'을 회원번호, 회원명, 마일리지와 함께 출력하시오.
      
SELECT MEM_ID AS "회원번호",
       MEM_NAME AS "회원명",
       MEM_MILEAGE AS "마일리지",
       CASE WHEN MEM_MILEAGE >= 5000 THEN 'VIP 회원'
            WHEN MEM_MILEAGE >= 3000 THEN '정회원'
            ELSE '준회원'
       END AS "비고"
  FROM MEMBER;
  
DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_NAME  MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_RES   VARCHAR2(100);
    
    CURSOR CUR_MEM01 IS
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
      FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_NAME, V_MILE;
        EXIT WHEN CUR_MEM01%NOTFOUND;
        IF      V_MILE >= 5000 THEN
            V_RES := TO_CHAR(V_MID) || ', ' || TO_CHAR(V_NAME) || ', ' || TO_CHAR(V_MILE)|| ', ' || 'VIP 회원';
        ELSIF   V_MILE >= 3000 THEN
            V_RES := TO_CHAR(V_MID) || ', ' || TO_CHAR(V_NAME) || ', ' || TO_CHAR(V_MILE)|| ', ' || '정회원';
        ELSE
            V_RES := TO_CHAR(V_MID) || ', ' || TO_CHAR(V_NAME) || ', ' || TO_CHAR(V_MILE)|| ', ' || '준회원';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
END;

DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_NAME  MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_RES   VARCHAR2(100);
    
    CURSOR CUR_MEM01 IS
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE, 
           CASE WHEN MEM_MILEAGE >= 5000 THEN 'VIP 회원'
                WHEN MEM_MILEAGE >= 3000 THEN '정회원'
                ELSE '준회원'
           END
      FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_NAME, V_MILE, V_RES;
        EXIT WHEN CUR_MEM01%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_MID || ' ' || V_NAME || ' ' || V_MILE || ' ' || V_RES);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
END;


주의) PL/SQL에서는 항상 세미콜론이 붙는다고 생각해라.


사용예)사용자로부터 수도 사용량(톤 단위)을 입력 받아 수도요금을 계산하여 출력하시오.
      사용량(톤)     수도단가(톤당)
        0-10            275
       10-20            305
       20-30            350
       30-40            415
       40-              500
      
      하수도 사용요금 : 사용량 * 120원
      EX)27톤을 사용한 경우
      처음 10톤 : 275 * 10 = 2750
      10-20톤 : 305 * 10 = 3050
      20-27톤 : 350 * 7 = 2450
      하수도 사용요금 : 120 * 27 = 3240
      
      총 11490원
;     
ACCEPT P_AMT PROMPT '수도사용량 입력(톤 단위)'
DECLARE
    REMAIN NUMBER := 0;
    AMT NUMBER := 0;
    RES NUMBER := 0;
BEGIN
    AMT := TO_NUMBER('&P_AMT');
    REMAIN := MOD(AMT,10);
    
    IF AMT <= 10 THEN
        RES := AMT * 275 + AMT * 120;
    ELSIF AMT <= 20 THEN
        RES := 10 * 275 + REMAIN * 305 + AMT * 120;
    ELSIF AMT <= 30 THEN
        RES := 10 * 275 + 10 * 305 + REMAIN * 350 + AMT * 120;
    ELSIF AMT <= 40 THEN
        RES := 10 * 275 + 10 * 305 + 10 * 350 + REMAIN * 415 + AMT * 120;
    ELSE
        RES := 10 * 275 + 10 * 305 + 10 * 350 + 10 * 415 + (AMT-40) * 500 + AMT * 120;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('수도요금은 ' || TO_CHAR(RES) || '원 입니다.');
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('입력오류 : ' || SQLERRM);
END;

ACCEPT P_AMT PROMPT '수도사용량 입력(톤 단위)'
DECLARE
    REMAIN NUMBER := 0;
    AMT NUMBER := 0;
    RES NUMBER := 0;
BEGIN
    AMT := TO_NUMBER('&P_AMT');
    REMAIN := MOD(AMT,10);
    
    IF (AMT <= 10 AND AMT >= 0) THEN
        RES := AMT * 275 + AMT * 120;
    ELSIF AMT <= 20 THEN
        RES := 10 * 275 + REMAIN * 305 + AMT * 120;
    ELSIF AMT <= 30 THEN
        RES := 10 * 275 + 10 * 305 + REMAIN * 350 + AMT * 120;
    ELSIF AMT <= 40 THEN
        RES := 10 * 275 + 10 * 305 + 10 * 350 + REMAIN * 415 + AMT * 120;
    ELSIF AMT > 40 THEN
        RES := 10 * 275 + 10 * 305 + 10 * 350 + 10 * 415 + REMAIN * 500 + AMT * 120;
    ELSIF AMT < 0 THEN
        DBMS_OUTPUT.PUT_LINE('양수를 입력해주세요');
  
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('수도요금은 ' || TO_CHAR(RES) || '원 입니다.');
    
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('입력오류 : ' || SQLERRM);
END;

주의) PL/SQL에서 변수에 값을 할당 할 때는 :=를 이용한다(위에서 =으로 하니까 오류 뜨더라