2021-0708-01)
1)SELECT 절 구성
  SELECT [DISTINCT] 컬럼명(수식|데이터) [AS] ["][별칭]["]
    - 'DISTINCT' : 중복된 값 배제
    - '[AS]["][별칭]["]' : 컬럼에 부여된 또다른 이름으로 특수문자 사용시 " "로 묶어 사용
        -출력시 컬럼의 제목
사용예)  회원테이블(MEMBER)의 주민번호(MEM_REGNO1)을 사용하여 회원의 나이를 조회하시오.
        단, Alias는 회원번호, 회원명, 주민번호, 나이이다.
    
    SELECT  MEM_ID                                                                  AS  "회원번호",
            MEM_NAME                                                                AS  "회원명",
            MEM_REGNO1 || '-' || MEM_REGNO2                                         AS  "주민 번호",
            EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2)) + 1900) AS  "나이"
    FROM    MEMBER;
    
    (1)연산자(operator)
    - 산술연산자 : +, -, *, /
사용예) HR계정의 사원테이블(EMPLOYEES)에서 보너스를 계산하여 급여의 지급액을 조회하시오
       보너스 = 급여 * 영업실적코드(COMMISION_PCT)의 35%
       지급액 = 급여 + 보너스
       출력 : 사원번호, 사원명, 급여, 보너스, 지급액

       SELECT   A.EMPLOYEE_ID                                                   AS      "사원번호",
                A.FIRST_NAME || ' ' || A.LAST_NAME                              AS      "사원명",
                A.SALARY                                                        AS      "급여",
                A.SALARY * NVL(A.COMMISSION_PCT,0) * 0.35                       AS      "보너스",
                A.SALARY + A.SALARY * NVL(A.COMMISSION_PCT,0) * 0.35            AS      "지급액"
       FROM HR.EMPLOYEES A;

       SELECT   EMPLOYEE_ID                                     AS  사원번호,
                FIRST_NAME || ' ' || LAST_NAME                  AS  사원명,
                SALARY                                          AS  급여,
                SALARY * NVL(COMMISSION_PCT,0) * 0.35           AS  보너스,
                SALARY + SALARY * NVL(COMMISSION_PCT,0) * 0.35  AS  지급액
       FROM     HR.EMPLOYEES;
                
    - 관계연산자 : 대소비교, TRUE/FALSE 를 결과로 반환, <, >, <=, >=, =, !=, <>
                조건문 구성에 주로 사용 (WHERE 절)
사용예) 회원테이블에서 마일리지가 4000이상인 회원의 회원번호, 회원명, 직업, 마일리지를 조회하시오.
       마일리지가 많은 회원부터 조회
    SELECT      MEM_ID      AS  회원번호,
                MEM_NAME    AS  회원명,
                MEM_JOB     AS  직업,
                MEM_MILEAGE AS  마일리지
    FROM        MEMBER
    WHERE       MEM_MILEAGE >= 200
    ORDER BY    MEM_MILEAGE DESC, MEM_ID DESC;


**회원테이블 정보 변경
    1) d001회원의 주민등록번호 460409-2000000, 생년월일이 1946/04/09
       ->        주민등록번호 010409-4000000, 생년월일이 2001/04/09
    2) n001회원의 주민등록번호 750323-1011014, 생년월일이 1975/03/23
       ->        주민등록번호 000323-3011014, 생년월일이 2000/03/23
    2) v001회원의 주민등록번호 520131-2402712, 생년월일이 1952/01/31
       ->        주민등록번호 020131-4402712, 생년월일이 2002/01/31

**정보변경 : UPDATE문
    UPDATE  테이블명
    SET     컬럼명 = 값[,
            컬럼명 = 값 ,
                :
    [WHERE 조건]; 
       
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '010409',
                MEM_REGNO2 = '4000000',
                MEM_BIR = TO_DATE('20010409')
       WHERE    MEM_ID = 'd001';
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '000323',
                MEM_REGNO2 = '3011014',
                MEM_BIR = TO_DATE('20000323')
       WHERE    MEM_ID = 'n001';
       UPDATE   MEMBER
       SET      MEM_REGNO1 = '020131',
                MEM_REGNO2 = '4402712',
                MEM_BIR = TO_DATE('20020131')
       WHERE    MEM_ID = 'v001';
       
    SELECT      MEM_ID,  MEM_REGNO1, MEM_REGNO2, MEM_BIR
    FROM        MEMBER
    WHERE       MEM_ID IN('d001','v001','n001');

사용예) 회원테이블에서 여성회원정보를 조회하시오.
       Alias 회원번호, 학원명, 생년월일, 마일리지, 비고    
    
       SELECT       MEM_ID      AS  회원번호,
                    MEM_NAME    AS  회원명,
                    MEM_BIR     AS  생년월일,
                    MEM_MILEAGE AS  마일리지,
                    CASE WHEN   SUBSTR(MEM_REGNO2,1,1) = ANY('2','4')   THEN
                                '여성회원'
                    ELSE
                                '남성회원'
                    END
                                AS  비고
--                  '여성회원'  AS  비고
       FROM         MEMBER
       WHERE        SUBSTR(MEM_REGNO2,1,1) = ANY('2','4');

    - 논리연산자 : NOT, AND, OR
        NOT : 논리부정
        AND OR 은 진리표대로
        ----------------------------
        입력1 입력2 출력
                   OR   AND (EX-OR)
        ----------------------------
        0     0    0    0   0
        0     1    1    0   1
        1     0    1    0   1
        1     1    1    1   0
        ----------------------------
        MEM_MILEAGE >= 2000 OR  EXTRACT(YEAR FROM MEM_BIR) <= 2000
사용예)  사원테이블에서 평균급여 이상 급여를 받는 사원을 조회하시오.
        Alias는 사원번호, 사원명, 급여, 부서번호
        
        SELECT      EMPLOYEE_ID     AS  사원번호,
                    FIRST_NAME      AS  사원명,
                    SALARY          AS  급여,
                    DEPARTMENT_ID   AS  부서번호,
                    ROUND((SELECT AVG(SALARY)
                    FROM    HR.EMPLOYEES),0)    AS  평균급여
        FROM        HR.EMPLOYEES
        WHERE       NOT SALARY  < (SELECT    AVG(SALARY)
                                  FROM  HR.EMPLOYEES);
                                  
    - 기타연산자 : IN, ANY, SOME, ALL, EXISTS, BETWEEN, LIKE 등 제공
                IN은 OR로 연결된 것과 똑같음


        
    SELECT * FROM HR.EMPLOYEES;

