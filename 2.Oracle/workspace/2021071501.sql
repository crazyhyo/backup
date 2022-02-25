2021-0715-01)
  3. 날짜함수
   1) SYSDATE
    - 시스템에서 제공하는 날짜정보(년,월,일,시,분,초) 반환
    - '+', '-'연산의 대상                //  연산 '-'는 DATE - NUMBER 와 DATE - DATE 지원하나 연산 '+'는 DATE + NUMBER 만 지원한다
    - 날짜 - 날짜 : 두 날짜 사이의 날수 (DAYS) 반환, NUMBER TYPE
    
사용예)
SELECT  SYSDATE -10,
        TO_CHAR(SYSDATE, 'YYYY MM DD HH24:MI:SS'),
        TRUNC(SYSDATE-TO_DATE('19900715','YYYY-MM-DD'))
FROM    DUAL;

년월일시분초를 사용자 정의 형태로 다루고 싶다면 년월일 / 시분초 중 누락된 것이 있으면 형 변환이 되지 않아 오류 발생
날짜 포맷에 정확하게 맞추어서 입력해야 함. 기본 포맷은 년||'/'||월||'/'||일 의 형태로 사용 혹은 '-'로 슬래쉬나 대쉬기호만 취급
날짜정보를 사용자가 지정해서 날짜로 변환하고자 한다면   -> 그래서 보통 문자열을 매개로 날짜 정보를 다룸. 날짜가 필요할 때 TO_DATE(C)
저장할 때 문자열로 저장, 날짜타입이 필요하면 해석해서 사용
TO_CHAR(D) <- 출력을 위한 형변환, 사용자 지정 날짜지원형식 지원      TO_DATE는 사용자지정 날짜지원 형식 지원안함

   2) ADD_MONTHS(d, n)
    - 날짜형식의 자료 d에 n만큼의 월을 더한 날짜 변환
사용예)사원의 정식 입사일은 수습 3개월이 지난 날짜이다. 각 사원이 이 회사ㅏ에 처음 수습으로 입사한 날짜를 구하시오
      Alias는 사원번호, 사원명, 입사일, 수습입사일, 소속부서명

SELECT      A.EMPLOYEE_ID                                           AS  사원번호,
            A.EMP_NAME                                              AS  사원명,
            A.HIRE_DATE                                             AS  입사일,
            ADD_MONTHS(A.HIRE_DATE, -3)                             AS  수습입사일,
            B.DEPARTMENT_NAME                                       AS  소속부서명
FROM        HR.EMPLOYEES A, HR.DEPARTMENTS B
WHERE       A.DEPARTMENT_ID = B.DEPARTMENT_ID
ORDER BY    5;

조인시 생각할 점
1. 관계가 맺어져있는가
2. 어떤 테이블이 부모이고 어떤 테이블이 자식인가(부모자식관계)
3. 중매 테이블이 있는가
실무에서 테이블만 주어진다. 내가 필요한 것은 논리 ERD임. 그렇다면 테이블에서 논리 ERD를 그려낼 수 있는 기능이 있음.(역공학)     <-  이것을 통해 작업시작
논리 ERD로 테이블을 만들수도 있다(순공학)
ADD_MONTHS      S가 들어간게 정확한 함수명이다
그냥 = 을 사용하는 경우는 내부조인, 조건에 맞는 데이터만 출력, 더 작은 테이블 기준으로 출력한다고 생각할 수 있음
외부조인    조건에 맞지 않는 데이터도 더 큰 테이블에서 데이터를 모두 찾아서 출력


테이블을 2개 이상 조회하는 경우에는 반드시 WHERE 절이 필요함   <-  반드시 조인이 발생되고 WHERE없이는 카르테시안 곱으로 데이터를 가져온다
                                                            이거 하지마라. 그리고 똑같은 컬럼명을 쓰는 경우가 대부분이기 때문에
                                                            별칭부여도 반드시 해야한다. 또한 SELECT에서 컬럼명을 사용하는 경우에도
                                                            반드시 별칭을 부여하는 습관을 들이자
조회문의 가장 대표적인 형식은 SELECT FROM    WHERE;

   3) NEXT_DAY(d, expr)
    - 주어진 날자 d에서 다가올 가장 빠른 'expr'요일의 날짜 반환
    - expr : 월,화,...,일, 월요일,화요일,...,일요일

사용예)
    SELECT  NEXT_DAY(SYSDATE, '월'),
            NEXT_DAY(SYSDATE, '목'),
            NEXT_DAY(SYSDATE, '화요일'),
            NEXT_DAY(SYSDATE, '일요일'),
            NEXT_DAY(SYSDATE, '금')
    FROM    DUAL;

여기서는 expr을 문자열로 '월', '화요일', ... 등으로 써줘야 함 <- NLS설정에서 한글로 설정했기 때문에
오늘은 반환하지 않음     /       자주 사용하지는 않음

   4) LAST_DAY(d)
    - 날짜자료 d가 포함된 달의 마지막 일을 반환          -- 주로 2월 조회에 사용 / 반환 형식은 날짜형식

사용예)매입테이블(BUY_PROD)에서 2월에 매입된 매입건수를 조회하시오.
    SELECT  COUNT(*)    AS  매입건수
    FROM    BUYPROD
    WHERE   BUY_DATE    BETWEEN TO_DATE('20050201') AND     LAST_DAY(TO_DATE('20050201'));
    
테이블에 있는 데이터의 개수를 세는 함수 : COUNT
COUNT(*)를 사용하지 못하는 경우 : 외부 조인을 사용할 때

   5) MONTHS_BETWEEN(d1, d2)
    - 두 날짜 자료 사이의 개월 수 반환                   --  리턴값은 NUMBER

사용예)
    SELECT      TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))  AS  근속개월수
    FROM        HR.EMPLOYEES;
    
    SELECT      EMP_NAME,
                HIRE_DATE,
                TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12)||'년'||
                MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)),12) ||'개월'   AS  근속기간
    FROM        HR.EMPLOYEES;

   6) EXTRACT(fmt FROM d)
    - 날짜자료 d에서 'fmt'로 기술된 자료를 추출함
    - 반환값의 형식은 숫자형식임
    - 'fmt' : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
    
사용예)
    SELECT  EMP_NAME,
            TO_CHAR(HIRE_DATE,'YYYY-MM-DD HH:MM:SS'),
--            EXTRACT(YEAR FROM HIRE_DATE),
--            EXTRACT(MONTH FROM HIRE_DATE),
--            EXTRACT(DAY FROM HIRE_DATE),
--            EXTRACT(HOUR FROM TO_TIMESTAMP(HIRE_DATE)),
            HIRE_DATE,
            TO_TIMESTAMP(HIRE_DATE)
    FROM    HR.EMPLOYEES;
사용예)
    SELECT  EXTRACT(HOUR FROM SYSDATE),
            EXTRACT(MINUTE FROM SYSDATE),
            EXTRACT(SECOND FROM SYSDATE)
    FROM    DUAL;
    
사용빈도 : SYSDATE > EXTRACT > LAST_DAY    

사용예)이번 달에 생일이 있는 회원정보를 조회하시오
      Alias는 회원번호, 회원명, 생년월일이다.

    SELECT  MEM_ID  AS  회원번호,
            MEM_NAME    AS  회원명,
            MEM_BIR     AS  생년월일
    FROM    MEMBER
    WHERE   EXTRACT(MONTH FROM  SYSDATE) = EXTRACT(MONTH FROM  MEM_BIR);

HOUR, MINUTE, SECOND는 

데이터 변환함수
TO_CHAR / TO_DATE   / TO_NUMBER
데이터 타입에 따라서 초기값 설정이 다름.
숫자는 0 / 0.0 문자는 ' ' 논리는 FALSE로 초기화 (IN JAVA)
오라클은 어떤 타입이든 NULL로 초기화함 /   NULL과의 모든 연산결과는 NULL.   ->  오라클에서는 NULL처리 함수 사용
(NULLIF,  NVL, NVL2,    ISNULL,  ISNOTNULL)

집계함수의 90% 이상은 반드시 GROUP BY 필요
이제 집계함수->JOIN 순으로 배울 것임
