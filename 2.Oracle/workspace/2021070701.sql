2021-0707-01)
1)자료 삽입 명령(INSERT)
 - 생성된 테이블에 새로운 자료를 삽입함
 (사용형식)
 INSERT INTO 테이블명[(컬럼명1[,컬럼명2,...])]
    VALUES(값1[,값2,,,]);
    - '테이블명' : 자료 삽입 대상 테이블명
    - '컬럼명1,..' : 이 옵션을 생략하면 테이블에 기술된 모든 컬럼에 기술된 순서에 맞도록 VALUES절에 값을 기술해야 함
    - '컬럼명1,..' : 이 옵션이 사용되면 필요한 컬럼에만 값(데이터)을 지정하여 자료르를 삽입할 수 있음.
                    기술된 '컬럼명'의 갯수 및 순서와 VALUES절의 값의 갯수 및 순서가 일치해야하고, NOT NULL항목은 반드시 기술(생략X)
                    
    주의) 특정 컬럼에만 값을 넣고 싶을 때 어떤 컬럼에 어떤 값을 넣을지 명시해주면 된다. 당연히 일치시켜야함.
    오라클은 모든 디폴트값이 NULL값임. NULL은 계산결과가 항상 NULL이 됨, 그래서 오라클에서는 널처리 함수가 있음
    INSERT의 철학: 입력할 값만 넣겠다. 아닌 것들은 모두 NULL
    NULL IF, IS NOT NULL 등
    거의 이미 고정된 길이를 가지거나 기본키를 설정할 때만 CHAR 타입을 쓴다

사용예) 사원테이블 (EMPLOYEE)에 다음 자료를 입력하시오.
    -------------------------------------------------------------------------------
    사원번호    이름     주소                   전화번호           직위      부서
    -------------------------------------------------------------------------------
    a101       홍길동   대전시 중구 대홍동       042-222-8202      사원      공공 개발부
    a104       강감찬                                            대리      기술영업부
    a105       이순신                                            부장
    -------------------------------------------------------------------------------
    
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_ADDR,E_TEL,E_DEPT,E_POSITION)
        VALUES('a101','홍길동','대전시 중구 대홍동','042-222-8202','공공 개발부','사원');
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_DEPT,E_POSITION)
        VALUES('a104','강감찬','기술영업부','대리');
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_POSITION,E_TEL)
        VALUES('a105','이순신','부장','010-1111-2222');
    
    INSERT INTO EMPLOYEE
        VALUES('a104','강감찬','','','대리','기술영업부');
    
    UPDATE EMPLOYEE SET E_TEL = '' WHERE EMP_ID = 'a104';
    
    INSERT INTO EMPLOYEE(EMP_ID,EMP_NAME,E_POSITION)
        VALUES('a105','이순신','부장');
    
    SELECT * FROM EMPLOYEE;
    
    
사용예) 사업장 테이블(SITE)에 다음 자료를 입력하시오.
    -------------------------------------------------------------------------------
    사업장번호       사업장명                주소                   비고
    -------------------------------------------------------------------------------
    S101           대홍초등학교보수공사      대전시 중구 대홍동
    S200           건물신축                
    -------------------------------------------------------------------------------
    INSERT INTO SITE(SITE_ID,SITE_NAME,SITE_ADDR)
        VALUES('S101','대홍초등학교보수공사','대전시 중구 대홍동');
    INSERT INTO SITE(SITE_ID,SITE_NAME)
        VALUES('S200','건물신축');
    
    INSERT INTO SITE
        VALUES('S200','건물신축',NULL,'');

사용예) 근무 테이블(WORK)에 다음 자료를 입력하시오.
    (1)홍길동사원이 오늘부터 'S200'사업장에서 근무
    (2)이순신부장이 2020년 10월 1일부터 'S200'사업장에서 근무
    (3)강감찬대리가 S100사업장에 근무
    INSERT INTO WORK(EMP_ID,SITE_ID,DEPART)
        VALUES('a101','S200','2021/07/07');
    INSERT INTO WORK(EMP_ID,SITE_ID,DEPART)
        VALUES('a105','S200','2020/10/01');
    INSERT INTO WORK(EMP_ID,SITE_ID,DEPART)
        VALUES('a104','S200','2021/01/01');
        
    INSERT INTO WORK VALUES('a105','S200',TO_DATE('20201001'));
    
    SELECT MOD((TRUNC(SYSDATE)-TO_DATE('00010101'))-1,7) FROM DUAL;
    
    INSERT INTO WORK VALUES('a101','S200',SYSDATE);
    INSERT INTO WORK(EMP_ID,SITE_ID) VALUES('a104','S101');
    
    SELECT * FROM EMPLOYEE;
    SELECT * FROM SITE;
    SELECT * FROM WORK;
    
    **S200에 근무하는 사원정보를 조회하시오
      Alias는 사업장명, 사원번호, 사원명, 직위, 전화번호이다.
      
    SELECT  SITE.SITE_NAME AS 사업장명,
            EMPLOYEE.EMP_ID AS 사원번호,
            EMPLOYEE.EMP_NAME AS 사원명,
            EMPLOYEE.E_POSITION AS 직위,
            EMPLOYEE.E_TEL AS 전화번호
    FROM SITE, EMPLOYEE, WORK
    WHERE SITE.SITE_ID = WORK.SITE_ID
        AND EMPLOYEE.EMP_ID = WORK.EMP_ID
        AND SITE.SITE_ID = UPPER('S200');

1)자료 삭제 명령(DELETE)
 - 존재하는 자료를 삭제
 
 (사용형식)
 DELETE 테이블명
    [WHERE 조건];
 - '테이블명' : 삭제할 자료가 저장된 테이블
 - 'WHERE 조건' : 삭제할 조건을 기술하며 생략하면 모든자료 삭제
 - ROLLBACK의 대상
 - 관계가 설정된 자료는 삭제할 수 없다.
 
 SELECT (A) FROM (B) WHERE (C)
    A: 열에 관련    B:의 테이블에서   C:행에 관련
 
    DELETE EMPLOYEE;
    
사용예) 사원테이블에서 'a101'사원정보를 삭제하시오.

DELETE WORK;
DELETE EMPLOYEE;
DELETE SITE;

COMMIT;

*** 객체삭제
    DROP 객체타입 객체명;
    외래키가 참조하고 있는 객체는 삭제할 수 없다 -> 자식 객체부터 삭제해야 한다.
    -ROLLBACK의 대상이 안됨
    
EMPLOYEE테이블 삭제
    
    DROP TABLE WORK;
    DROP TABLE EMPLOYEE;
    DROP TABLE SITE;
    
    
    Q) 메모리에서 지우는건지 하드디스크에서 지우는건지
    