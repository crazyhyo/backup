2021-0714-01)

2. 숫자함수
 1) GREATEST(n1, n2[, n3,...]), LEAST(n1, n2[, n3,...])
  - GREATEST : 주어진 수 중 가장 큰 값을 반환
  - LEAST : 주어진 수 중 가장 큰 값을 반환
사용예)
SELECT  GREATEST(50, 70, 90),
        LEAST(50, 70, 90)
FROM    DUAL;

사용예)  회원테이블에서 마일리지가 1000미만인 모든 회원의 마일리지를 1000으로 수정 출력하시오.
        Alias는 회원번호, 회원명, 원본 마일리지, 수정 마일리지
        
SELECT      MEM_ID                              AS  회원번호,
            MEM_NAME                            AS  회원명,
            GREATEST(MEM_MILEAGE, 1000)         AS  "수정 마일리지"
FROM        MEMBER;

SELECT      GREATEST(MEM_MILEAGE)
FROM        MEMBER;

SELECT      MAX(MEM_MILEAGE)
FROM        MEMBER;

주의>  ALIAS에 띄어쓰기가 있으면 쌍따옴표를 사용해야 한다.
      GREATEST도 COLUMN 참조가 된다

 2) ROUND(n[, i]), TRUNC(n[, i])
  - ROUND : 주어진 수 n의 소수점 이하 i+1번째 자리에서 반올림하여 i번
            MEM_MILEAGE                         AS  "원본 마일리지",째 까지 출력
            i가 음수이면 정수부분 i번째에서 반올림
            i가 생략되면 0으로 간주(소수점 첫 번째 자리에서 반올림)
  - TRUNC : ROUND와 같이 수행되나 반올림이 아니라 절삭처리한다.
  
사용예)  사원테이블에서 급여의 지급액을 계산하여 출력하시오
        Alias는 사원번호, 사원명, 급여, 세금, 지급액
        세금 = 급여액의 17%
        지급액 = 급여액 - 세금
        소수점 1자리까지 출력

SELECT  EMPLOYEE_ID                     AS  사원번호,
        EMP_NAME                        AS  사원명,
        SALARY                          AS  급여,
        TRUNC(SALARY * 0.17,1)          AS  세금,
        SALARY - TRUNC(SALARY * 0.17,1) AS  지급액
FROM    HR.EMPLOYEES;

-- 세금은 요금납부의 개념이니까 깎아줄 수 있도록 TRUNC 사용

사용예)  2005년 1월~3월 제품분류별 평균매입액을 조회하시오.
        Alias 분류코드, 분류명, 평균매입금액
        평균매입금액 정수로 표현
        
        SELECT  분류코드, 분류명, 평균매입금액
        FROM    BUYPROD A, PROD B, LPROD C
        WHERE   A.BUY_PROD = B.PROD_ID
                AND B.PROD_LGU = C.LPROD_GU
                AND     A.BUY_DATE >= TO_DATE('20050101')
                AND     A.BUY_DATE <= (TO_DATE('20050331'));

        SELECT      C.PROD_LGU                              AS  분류코드,
                    B.LPROD_NM                              AS  분류명,
                    ROUND(AVG(A.BUY_QTY * C.PROD_COST),-1)  AS  평균매입금액
        FROM        BUYPROD A, LPROD B, PROD C
        WHERE       A.BUY_PROD = C.PROD_ID
                    AND     C.PROD_LGU = B.LPROD_GU
                    AND     A.BUY_DATE BETWEEN '20050101' AND '20050331'
        GROUP BY    C.PROD_LGU, B.LPROD_NM;

OO별 : 해당하는 것을 기준으로 묶어야 함 / GROUP BY 필요
매입액 = 단가 * 수량
집계함수 사용시 반드시 GROUP BY 필요, 뒤에 오는 것은 SELECT에서 선택하지 않은 모든 컬럼을 써주면 된다

GREATEST와 MAX의 차이: GREATEST는 값을 나열해야 함, MAX를 컬럼과 같이 쓰면 반드시 GROUP BY를 써야 하지만 GREATEST는 아님.
EX) GREATEST(MEM_MILEAGE) <- 문법오류는 아니네... 그냥 컬럼이 다 나오는데?

연말정산시 ROUND사용(돈을 받을 때는 반올림), 요금을 낼 때는 TRUNC 사용
돈을 줄 때는 ROUND, 돈을 받을 때는 TRUNC
데이터베이스는 정확한 자료를 제공할 의무가 있음.
데이터베이스 차원에서는 어지간하면 반올림 하지 말자. 데이터의 처리는 고급 언어에서


테이블 별칭이 반드시 쓰여져야 하는 경우 : 두 테이블에서 같은 컬럼명을 가지고 있는 경우, 소속 테이블명을 확실하게 밝혀줘야 함.
                                     그러나 그 테이블명이 너무 긴 경우 별칭을 사용하여 접근한다.
별칭부여하기 싫어서 테이블 컬럼명을 다른 이름을 썼네   <-  정신 나갔네
외래키, 관계가 있는 테이블의 관계를 구성하는 컬럼은 이름이 같아야 한다.

별칭부여방법 1. 객체를 만들어서 부여하는 방법, 동의어객체 생성, SYNONYM (CREATE SYNONYM)

테이블이 2개 이상 사용되면 JOIN이 사용되어야 함. 테이블이 N개가 사용되면 조인조건은 적어도 N-1개 이상 사용한다.

 3) FLOOR(n), CEIL(n)
  - n에 가까운 정수를 반환
  - FLOOR : n과 같거나 작은 정수 중 가장 큰 정수
  - CEIL : n과 같거나 큰 정수 중 가장 작은 정수
  - 세금, 급여처럼 금액과 관련된 수식에 주로 사용
사용예)
    SELECT  FLOOR(12.5), CEIL(12.5), FLOOR(12), CEIL(12), FLOOR(-12.5), CEIL(-12.5)    FROM    DUAL;
  
FLOOR(-1.2) = -2, CEIL(-1.2) = -1
오라클에서는 %연산자가 나머지를 구하는데 쓰이는 것이 아니라 문자열의 와일드카드로 사용됨. -> 나머지 구하는 연산자 없음
-> MOD나 REMAINDER 함수를 이용하여 나머지 구함        /           자주 사용하지는 않음

 4) MOD(n, i), REMAINDER(n, i)
  - 나머지를 반환
  - MOD : n을 i로 나눈 나머지 반환
            나머지 = 피제수 - 제수 * FLOOR(피제수 / 제수)
            MOD(15,6) = 3
                      = 15 - 6 * FLOOR(15/6)
                      = 15 - 6 * 2
  - REMAINDER : n을 i로 나눈 나머지가 i의 절반 이하의 값이면 MOD와 같음.
                나머지가 초과하면 다음 몫이 되기 위해 더해져야 할 수 반환
            나머지 = 피제수 - 제수 * ROUND(피제수 / 제수)
            REMAINDER(15,6) = -3
                            = 15 - 6 * ROUND(15/6)
                            = 15 - 6 * 3
                            = -3
사용예)
    SELECT  MOD(15,6), REMAINDER(16,6), MOD(15,7), REMAINDER(15,7), MOD(15,4), REMAINDER(15,4) FROM DUAL;
사용예)임의의 년도를 입력 받아 윤년과 평년을 구별하시오.
        윤년 : 4의 배수이면서 100의 배수가 아니거나 400의 배수인 년도
        
        
        ACCEPT P_YEAR   PROMPT  '년도 입력'
        DECLARE
            V_YEAR NUMBER(4):= &P_YEAR;               --      입력받은 P_YEAR을 참조하기 위해 &사용, ''안에 묶어서 문자열로 변환
                                                        --      이것을 NUMBER로 대입하면서 형변환 일어남(??)
            V_RES VARCHAR2(100);
        BEGIN
            IF(MOD(V_YEAR,4) = 0 AND MOD(V_YEAR,100) != 0) OR (MOD(V_YEAR,400) = 0) THEN
                V_RES:= V_YEAR || '년은 윤년입니다.';
            ELSE
                V_RES:= V_YEAR || '년은 평년입니다.';
            END IF;     
            DBMS_OUTPUT.PUT_LINE(V_RES);
        END;
        
        SELECT  
        (MOD(,4) = 0 AND MOD(,100) != 0)
        OR      MOD(,400) = 0

주의) ACCEPT 다음에는 세미콜론, 콜론, 콤마 모두 안들어감
ACCEPT  변수명     PROMPT  '출력메시지'
DECLARE
    변수명 데이터형    :=  &변수명 <- 입력받은 변수로 받아오겠다
BEGIN
    IF  조건  THEN
    ELSE
    END IF;
END;
    
컴퓨터 그래픽스에서 삼각함수/선형대수학 매우 많이 씀 (회전, 원근, 비례, 확대, 축소) 

 5) WIDTH_BUCKET(n, min, max, b)
  - min에서 max까지를 b개의 구간으로 나누고 주어진 수 n이 그 구간 중 어느 구간에 속하는지 판별하여 구간의 인덱스를 반환
  - n이 max이상이면 b + 1, min미만이면 0 반환[기본 로직은 이상-미만으로 구간을 나누기 때문]
사용예)
    SELECT  WIDTH_BUCKET(120, -1, 120, 20) FROM DUAL;
사용예)회원테이블에서 회원들의 마일리지를 3개의 그룹으로 나누고 각 회원들의 마일리지가 속한 그룹을 조회하여
      1그룹에 속한 회원은 '새싹회원', 2그룹에 속한 회원은 '정규 회원', 3그룹에 속한 회원은 'VIP 회원'으로 비고란에 출력하시오.
      Alias는 회원번호, 회원명, 직업, 마일리지, 비고
      
      SELECT    MEM_ID                                                              AS  회원번호,
                MEM_NAME                                                            AS  회원명,
                MEM_JOB                                                             AS  직업,
                MEM_MILEAGE                                                         AS  마일리지,
                CASE    WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 3) = 1 THEN
                                '새싹 회원'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 3) = 2 THEN
                                '정규 회원'
                        ELSE    
                                'VIP 회원'
                END
                                                                                    AS  비고
      FROM      MEMBER;

SELECT    MEM_ID                                                              AS  회원번호,
                MEM_NAME                                                            AS  회원명,
                MEM_JOB                                                             AS  직업,
                MEM_MILEAGE                                                         AS  마일리지,
                CASE    WHEN    WIDTH_BUCKET(MEM_MILEAGE,   (SELECT  MIN(MEM_MILEAGE)
                                                            FROM    MEMBER),
                                                            (SELECT  MAX(MEM_MILEAGE)
                                                            FROM    MEMBER), 3) = 1 THEN
                                '새싹 회원'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE,   (SELECT  MIN(MEM_MILEAGE)
                                                            FROM    MEMBER),
                                                            (SELECT  MAX(MEM_MILEAGE)
                                                            FROM    MEMBER), 3) = 2 THEN
                                '정규 회원'
                        ELSE    
                                'VIP 회원'
                END
                                                                                    AS  비고
      FROM      MEMBER;

사용예)회원테이블에서 회원들의 마일리지를 5개의 그룹으로 나누고 등급을 비고란에 출력
      Alias는 회원번호, 회원명, 직업, 마일리지, 비고이며, 등급은 마일리지가 많은 회원이 1등급이고,
      제일 작은 회원이 5등급이다.
      
      SELECT    MEM_ID                                                                  AS  회원번호,
                MEM_NAME                                                                AS  회원명,
                MEM_JOB                                                                 AS  직업,
                MEM_MILEAGE                                                             AS  마일리지,
                WIDTH_BUCKET(-MEM_MILEAGE, -9000, -500, 5)                              AS  비고
      FROM      MEMBER;

      SELECT    MEM_ID                                                                  AS  회원번호,
                MEM_NAME                                                                AS  회원명,
                MEM_JOB                                                                 AS  직업,
                MEM_MILEAGE                                                             AS  마일리지,
                6 - WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5)                             AS  비고
      FROM      MEMBER;

      SELECT    MEM_ID                                                                  AS  회원번호,
                MEM_NAME                                                                AS  회원명,
                MEM_JOB                                                                 AS  직업,
                MEM_MILEAGE                                                             AS  마일리지,
                CASE    WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 1 THEN
                                '5등급'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 2 THEN
                                '4등급'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 3 THEN
                                '3등급'
                        WHEN    WIDTH_BUCKET(MEM_MILEAGE, 500, 9000, 5) = 4 THEN
                                '2등급'
                        ELSE    
                                '1등급'
                END
                                                                                        AS  비고
      FROM      MEMBER;

CASE WHEN은 SELECT 절에서만 사용 가능      

[디코드라는 표현식]
CASE 조건 WHEN 값 THEN
CASE WHEN 
PL/SQL