2021-0709-01)
 4) 기타연산자
    (1) IN / ANY, SOME [ANY와 SOME은 = 와 함께 사용]
     - 주어진 값 중 어느 하나와 일치하면 TRUE를 반환
     - OR 연산자로 치환 가능
     - NOT 연산자와 함께 사용가능함
  (사용형식)
   expr IN(값1[,값2,...])
   범위에 해당하는 데이터 조회는 AND 혹은 BETWEEN 연산자를 이용하여 조건 비교
   특정한 규칙이 없는(혹은 연속되지 않은) 데이터 조회는 IN, OR, EXISTS 등의 연산자 사용
   
** 사원테이블에서 EMP_NAME VARCHAR2(80) 컬럼을 추가
    (컬럼을 추가)
    ALTER TABLE 테이블명
        ADD(컬럼명    데이터타입[(크기)]  [NOT NULL]   [DEFAULT 초기값]);

    ALTER TABLE HR.EMPLOYEES
        ADD(EMP_NAME    VARCHAR2(80));
    COMMIT;

** FIRST_NAME과 LAST_NAME의 값을 EMP_NAME에 저장
    UPDATE  HR.EMPLOYEES
        SET EMP_NAME = FIRST_NAME || ' ' || LAST_NAME;
        
    SELECT  EMP_NAME
    FROM    HR.EMPLOYEES;
    
    (컬럼이름을 변경)
    ALTER TABLE 테이블명    RENAME  COLUMN  원래컬럼명   TO  새로운컬럼명;
    
    (컬럼을 삭제)
    ALTER TABLE 테이블명    DROP  COLUMN  컬럼명;
    
    (컬럼타입 변경)
    ALTER TABLE 테이블명    
        MODIFY(컬럼명    데이터타입[(크기)]  [NOT NULL]   [DEFAULT 초기값]);
    
        
사용예)사원테이블에서 10, 30, 40, 60번 부서에 속한 사원들의 사원번호, 사원명, 부서코드, 입사일을 조회하시오.
      (OR 연산자 사용)
        SELECT      EMPLOYEE_ID AS  사원번호,
                    EMP_NAME  AS  사원명,
                    DEPARTMENT_ID   AS  부서코드,
                    HIRE_DATE   AS  입사일
        FROM        HR.EMPLOYEES
        WHERE       DEPARTMENT_ID = 10
                    OR  DEPARTMENT_ID = 30
                    OR  DEPARTMENT_ID = 40
                    OR  DEPARTMENT_ID = 60
        ORDER BY    3;
      (IN 연산자 사용)              
        SELECT      EMPLOYEE_ID AS  사원번호,
                    EMP_NAME  AS  사원명,
                    DEPARTMENT_ID   AS  부서코드,
                    HIRE_DATE   AS  입사일
        FROM        HR.EMPLOYEES
        WHERE       DEPARTMENT_ID IN(10,30,40,60)
        ORDER BY    3;
      (ANY, SOME 연산자 사용)              
        SELECT      EMPLOYEE_ID AS  사원번호,
                    EMP_NAME  AS  사원명,
                    DEPARTMENT_ID   AS  부서코드,
                    HIRE_DATE   AS  입사일
        FROM        HR.EMPLOYEES
        WHERE       DEPARTMENT_ID = ANY(10,30,40,60)
        --          DEPARTMENT_ID = SOME(10,30,40,60)
        ORDER BY    3;
        
    (2) ALL
     - ( )안에 주어진 값들을 모두 만족해야 결과가 참(TRUE)이 됨
     - AND로 치환 가능, 등호와 함께 사용불가
    (사용형식)
     컬럼명 관계연산자 ALL(값1[,값2,...])
     
사용예) 사운테이블에서 20,40,70번 부서에 속한 사원들의 급여보다 급역 많은 사원의 사원번호, 사원명, 급여, 부서번호를 조회하시오.

SELECT      EMPLOYEE_ID     AS      사원번호,
            EMP_NAME        AS      사원명,
            SALARY          AS      급여,
            DEPARTMENT_ID    AS      부서번호
FROM        HR.EMPLOYEES
WHERE       SALARY  > ALL(SELECT    SALARY
                          FROM      HR.EMPLOYEES
                          WHERE     DEPARTMENT_ID IN(20,40,70));

(SELECT    MAX(SALARY)
                          FROM      HR.EMPLOYEES
                          WHERE     DEPARTMENT_ID IN(20,40,70));




    (3) BETWEEN ~ AND
     - 범위를 지정하여 값을 조회하는 조건문 구성에 사용, 대상은 숫자, 문자, 날짜 모두 가능
     - 논리 연산자 'AND'로 치환 가능

LIKE연산자는 비교대상이 문자열임. 단, LIKE는 연산 요구량이 많아서 속도가 느림
날짜비교시는 LIKE가 아니라 BETWEEN을 사용해야 함.

사용예)매입정보테이블(BUYPROD)에서 2005년 3월 매입현황을 출력하시오.        <-      제한조건, WHERE절 써야함
      Alias는 날짜, 제품코드, 매입수량, 매입금액이다.

(AND 연산자 사용)
SELECT  BUY_DATE            AS  날짜,
        BUY_PROD            AS  제품코드,
        BUY_QTY             AS  매입수량,
        BUY_QTY * BUY_COST  AS  매입금액
FROM    BUYPROD
WHERE   BUY_DATE >= TO_DATE('20050301')
        AND     BUY_DATE <= LAST_DAY(TO_DATE('20050301'));

SELECT  BUY_DATE            AS  날짜,
        BUY_PROD            AS  제품코드,
        BUY_QTY             AS  매입수량,
        BUY_QTY * BUY_COST  AS  매입금액
FROM    BUYPROD
WHERE   BUY_DATE            
        BETWEEN TO_DATE('20050301')    AND     LAST_DAY(TO_DATE('20050301'));

BUY_QTY * BUY_COST  AS  매입금액            <-      정규화 위반예시, 데이터 이상 일어남
AUTO CAST : 자동형변환(데이터 형이 큰 쪽으로 바꿔줌)
CAST(변환대상 AS 데이터형)
자바에서는 문자열이 가장 강력함
오라클에서는 숫자가 가장 강력함, 
BUY_DATE >= '20050301' : 컴퓨터는 연산자를 읽고 연산을 하겠다고 해석
제일 먼저 두 대상의 데이터 타입 비교, 전자는 DATE 타입, 후자는 문자열
문자열은 가장 데이터 형변환 우선순위가 낮기 때문에 DATE 타입으로 변환실행(성공)
BOOLEAN 형식 반환
EXTRACT 함수는 DATE 타입을 ARGUMENT로 받아 숫자를 반환한다!
날짜 차이 계산은 일(DAY)단위로 계산한다.

사용예)회원테이블에서 40대 회원의 회원번호, 회원명, 마일리지를 조회하시오.

SELECT      MEM_ID      AS  회원번호,
            MEM_NAME    AS  회원명,
            MEM_MILEAGE AS  마일리지
FROM        MEMBER
WHERE       (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)) BETWEEN 40 AND 49;

**회원의 생년월일 컬럼에서 월을 추출하시오.
    SELECT  EXTRACT(MONTH FROM MEM_BIR),
            SUBSTR(MEM_BIR,6,2)
    FROM    MEMBER;
    
**회원테이블에서 이번 달에 생일이 있는 회원번호, 회원명을 조회
    SELECT  MEM_ID      AS  회원번호,
            MEM_NAME    AS  회원명
    FROM    MEMBER
    WHERE   EXTRACT(MONTH FROM SYSDATE) = EXTRACT(MONTH FROM MEM_BIR);

사용예)분류코드가 P2로 시작하는 상품에 대하여 2005년 5월 매출실적을 조회하시오.
      상품코드, 상품명, 분류코드, 분류명, 판매수량, 금액
    
SELECT      A.PID       AS  상품코드,
            A.PNAME     AS  상품명,
            LPROD_GU    AS  분류코드,
            LPROD_NM    AS  분류명,
            A.QANT      AS  판매수량,
            A.MANT      AS  금액
FROM        LPROD, (    SELECT      CART_PROD                     AS  PID,
                                    PROD_NAME                     AS  PNAME,
                                    SUM(CART_QTY)                 AS  QANT,
                                    SUM(CART_QTY * PROD_PRICE)    AS  MANT
                        FROM        CART , PROD 
                        WHERE       CART_PROD = PROD_ID
                                    AND CART_NO LIKE '200505%'
                                    AND PROD_LGU BETWEEN 'P200' AND 'P299'
                        GROUP BY    CART_PROD, PROD_NAME)   A,
            PROD
WHERE       PROD_ID = PID
            AND PROD_LGU=LPROD_GU
ORDER BY    1;

가장 안 좋은 정렬 1. 셀렉션 소트 2. 버블 소트
자바는 COLLECTIONS라는 콜렉션에서 SORT라는 메소드가 있어서 알아서 정렬시켜줌
다양한 정렬법을 배우는 이유 : 시스템이나 프로그램에서 제공하는 정렬방법을 사용하지 못하는 경우가 반드시 발생하기 때문.
<기술면접>
1. 스택을 생성해서 입출력 (자바) 코드로 구현
2. 큐를 생성해서 입출력 (자바) 코드로 구현
3. 정렬
// 괜찮은 회사는 코딩테스트 다 함.

대기업의 좋은 점: 높은 급여/복리후생
대기업의 나쁜 점: 짧은 정년(40대 중반)/퇴직해서 할 일이 거의 없음 <- 프로그램을 안하고 주로 관리만 하기 때문에, 프로그래밍하는 사람은 극소수

대기업 입사방법   1. 신입으로 들어가기(높은 스펙, 치열한 경쟁 필요)
                2. 원하는 회사의 하청회사(마더) 혹은 그 하청회사에 개발자로 입사하여 두각을 나타내 특채로 채용
구인의뢰는 > 50, 수강생은 BETWEEN 22 AND 25  BUT 모두가 취업결정되는 건 아니다.
주의) MAX함수를 쓰지 못하는 경우 : MAX를 쓰려면 GROUP BY절을 사용해야 한다.
그런데 GROUP BY를 쓰지 못하면 MAX함수를 못 쓰니까 이 경우에 ALL연산자를 사용해야 한다.
SUM AVG MAX MIN COUNT   는 반드시 GROUP BY라는 예약어를 써야 함
위의 예시 코드 동작은 일반컬럼이 안 쓰였으므로 테이블을 디폴트 그룹으로 설정하여 동작한다.
일반컬럼이 안 쓰인 경우는 테이블을 하나의 그룹으로 놓음.
주의) 오타주의 <- 복붙의 생활화

EXTRACT(MONTH) 를 하는 경우: ELP SYSTEM에서 이번 달에 생일인 직원에게 어떤 작업을 할 때
YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
구글링해서 쓸 때 아무 코드나 갖다 쓰면 안됨
가장 좋은 코드는 자바 웹사이트 튜토리얼 안에 들어있음.
그게 최적화된 코드임

주의 SUBSTR의 대상은 문자열이다. DATE타입에게 SUBSTR을 쓰지 마라.(돌아가기 때문에 더 노답인거다.)
DATE를 STR로 해서