2021-0706-02)서브쿼리
  - SQL구문안에 또 다른 SQL구문이 포함된 형태
  - 밖의 쿼리를 메인쿼리, 안쪽쿼리를 서브쿼리라 함
  - 서브쿼리는 메인쿼리의 결과를 반환하기 위해 중간 결과로 사용
  - 서브쿼리는 ()로 묶어 사용함(예외 INSERT문에 사용되는 서브쿼리는 '()'를 사용하지 않음)
  - 서브쿼리는 사용되는 위치에 따라 일반서브쿼리(SELECT 절), 인라인서브쿼리(FROM 절), 중첩서브쿼리(WHERE 절)로 구분
  - 변환하는 결과의 행/열의 개수에 따라 단일행/단일열, 단일행/다중열, 다중행/단일열, 다중행/다중열로 구분
  - 메인쿼리와 서브쿼리에 사용되는 테이블 간의 조인 여부에 따라 관련성없는 서브쿼리/연관서브쿼리로 구분
  - 알려지지 않은 조건에 근거하여 데이터를 검색하는 경우 유용

인라인서브쿼리는 반드시 독립적으로 하나의 쿼리를 이루어야 함.
중첩서브쿼리는 WHERE절에서 반드시 관계연산자 오른편에 와야 한다. EX: SALARY > (SELECT AVG(SALARY) FROM HR.EMPLOYEES)

SELECT EMPLOYEE_ID, EMP_NAME
  FROM HR.EMPLOYEES
 WHERE (DEPARTMENT_ID, MANAGER_ID) = (SELECT DEPARTMENT_ID, MANAGER_ID
                                        FROM HR.DEPARTMENTS
                                        WHERE MANAGER_ID = 121);

   - 하나의 행만 결과로 반환
   - 단일행 연산자는 관계연산자(=,<=,>=,<,>,<>,!=) 임

사용예)
SELECT EMPLOYEE_ID, EMP_NAME
  FROM HR.EMPLOYEES
 WHERE (DEPARTMENT_ID, MANAGER_ID) = (SELECT DEPARTMENT_ID, MANAGER_ID
                                        FROM HR.DEPARTMENTS
                                        WHERE MANAGER_ID = 121);

만약 중첩서브쿼리의 결과가 다중행 서브쿼리인 경우 IN을 사용한다
비교연산시 비교대상이 되는 두 항의 개수는 반드시 같아야 한다.(아닐 시 in을 사용할 수 있음)
위의 예에서 WHERE절의 왼편은 한 테이블을 따라가며 한번에 한 튜플의 정보를 읽어온다. / 오른편의 서브쿼리는 단 한번 실행된다.

  2)다중행 서브쿼리
   - 하나 이상의 행을 반환하는 서브쿼리
   - 복수행 연산자 : IN, ANY, SOME, EXISTS

사용예)사원테이블에서 직원의 수가 10명 이상이 되는 부서의 부서코드, 부서명을 출력
     (메인쿼리 : 부서코드, 부서명을 출력)
(결합: IN)     
SELECT DEPARTMENT_ID AS "부서코드",
       DEPARTMENT_NAME AS "부서명"
  FROM HR.DEPARTMENTS
 WHERE DEPARTMENT_ID IN (SELECT B.DID
                           FROM (SELECT DEPARTMENT_ID AS DID,
                                        COUNT(*)
                                   FROM HR.EMPLOYEES
                                  GROUP BY DEPARTMENT_ID
                                 HAVING COUNT(*) >= 10) B);
(결합: =ANY(=SOME))
SELECT DEPARTMENT_ID AS "부서코드",
       DEPARTMENT_NAME AS "부서명"
  FROM HR.DEPARTMENTS
 WHERE DEPARTMENT_ID = ANY(SELECT B.DID
                             FROM (SELECT DEPARTMENT_ID AS DID,
                                          COUNT(*)
                                     FROM HR.EMPLOYEES
                                    GROUP BY DEPARTMENT_ID
                                   HAVING COUNT(*) >= 10) B);
                                   
(결합: EXISTS - 반드시 뒤에 서브쿼리가 온다)
  - EXISTS 연산자 왼쪽의 표현식(식 OR 컬럼명)이 없음
  - EXISTS 연산자 오른쪽은 반드시 서브쿼리
  
SELECT DEPARTMENT_ID AS "부서코드",
       DEPARTMENT_NAME AS "부서명"
  FROM HR.DEPARTMENTS A
 WHERE EXISTS (SELECT C.DID
--             SELECT 1
                 FROM (SELECT DEPARTMENT_ID AS DID,
                              COUNT(*)
                         FROM HR.EMPLOYEES B
                        GROUP BY DEPARTMENT_ID
                       HAVING COUNT(*) >= 10) C
                WHERE C.DID = A.DEPARTMENT_ID);

  3)다중열
   - 하나 이상의 열이 반환되는 서브쿼리
   - PAIRWISE(쌍비교) 서브쿼리 또는 Nonpairwise (비쌍비교) 서브쿼리로 구현
   
사용예)80번 부서에 급여가 부서 평균 이상인 사원을 조회하시오
      ALIAS는 사원번호, 급여, 부서코드

SELECT EMPLOYEE_ID AS "사원번호",
       SALARY AS "급여",
       DEPARTMENT_ID AS "부서코드"
  FROM HR.EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY)
                    FROM HR.EMPLOYEES
                   WHERE DEPARTMENT_ID = 80)
       AND DEPARTMENT_ID = 80;
       
SELECT A.EMPLOYEE_ID AS "사원번호",
       A.SALARY AS "급여",
       A.DEPARTMENT_ID AS "부서코드"
  FROM HR.EMPLOYEES A
 WHERE (A.EMPLOYEE_ID, A.DEPARTMENT_ID) IN (SELECT B.EMPLOYEE_ID, DEPARTMENT_ID
                                              FROM HR.EMPLOYEES B
                                             WHERE B.SALARY > (SELECT AVG(C.SALARY)
                                                                 FROM HR.EMPLOYEES C
                                                                WHERE C.DEPARTMENT_ID = B.DEPARTMENT_ID)
                                                   AND B.DEPARTMENT_ID = 80)
 ORDER BY 3;

