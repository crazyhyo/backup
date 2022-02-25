2021-0730-01)

2. SEQUENCE 객체
  - 순차적으로 증감하는 값을 반환하는 객체.
  - 테이블과 독립적
  - 임의의 테이블에서 기본키로 설정할 마땅한 컬럼이 없는 경우,
    자동으로 부여되는 순차적인 숫자 값이 필요한 경우 사용

 (사용형식)
   CREATE SEQUENCE 시퀀스명
     [START WITH N] -- 시작 값, 생략하면 최소값(MINVALUE)
     [INCREMENT BY N] -- 증감값, 생략하면 1
     [MAXVALUE N|NOMAXVALUE] -- 최대값, 기본은 NOMAXVALUE이며 10^27
     [MINVALUE N|NOMINVALUE] -- 최소값, 기본은 NOMINVALUE이며 1
     [CYCLE | NOCYCLE] -- 최소[최대]값 도달 후 시퀀스값을 다시 생성할지 여부 기본은 NOCYCLE
     [CACHE N | NOCACHE] -- 시퀀스 값을 캐쉬에 따라 생성하고 사용할지 여부, 기본은 CACHE 20
     [ORDER | NOORDER] -- 제시한 조건대로 시퀀스 생성을 보증, 기본은 NOORDER
     
  ** 의사컬럼(PSEUDO COLUMN)
    시퀀스명.CURRVAL : '시퀀스'가 가지고 있는 현재값 반환
    시퀀스명.NEXTVAL : '시퀀스'의 다음값 반환
    ** 시퀀스 객체가 생성된 후 맨 처음 명령은 반드시 '시퀀스명.NEXTVAL'이어야 함
    ** 시퀀스명.NEXTVAL을 사용하여 생성된 값은 다시 재생성할 수 없음
    
    여러 테이블이 동시에 참조하기 때문에 한 테이블에서 NEXTVAL을 두번 사용하면 다른 테이블에서는 자신의 현재 값의 다음 값을
    참조할 수 없다.
    
사용예)테이블 LPROD의 LPROD_ID에 사용할 시퀀스를 생성하시오
DECLARE
  V_ID LPROD.LPROD_ID%TYPE:=0
BEGIN
  V_ID
  SELECT MAC(LPROD_ID) INTO V_ID FROM LPROD;
  CREATE SEQUENCE SEQ_LPROD
    START WITH V_ID;
END;

CREATE SEQUENCE SEQ_LPROD
  START WITH 10;
SELECT SEQ_LPROD.CURRVAL FROM DUAL;

INSERT INTO LPROD
  VALUES(SEQ_LPROD.NEXTVAL, 'P501','농산물');
SELECT * FROM LPROD;

내 권한에서는 LPROD의 시퀀스 값을 볼 수 없고 쿼리만 날릴 수 있다면 MAX로 최대값을 확인해야 함

사용예)오늘이 2005년 4월 18일이라 가정하고 CART_NO를 생성하시오

SELECT MAX(CART_NO) + 1 FROM CART WHERE SUBSTR(CART_NO,1,8) = '20050418';
SELECT SUBSTR(MAX(CART_NO),9) FROM CART WHERE SUBSTR(CART_NO,1,8) = '20050418';
SELECT TO_CHAR(TO_DATE('2005/04/18'),'YYYYMMDD')||
       TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9)) + 1, '00000'))
  FROM CART
 WHERE SUBSTR(CART_NO,1,8) = '20050418';

SELECT COUNT(*) FROM HR.JOBS;

시퀀스를 여러 테이블에서 사용하면 시퀀스를 제대로 사용하기 위한 알고리즘을 따로 작성해 줘야 한다.

  ** 시퀀스의 사용이 제한되는 경우
   - SELECT,DELETE,UPDATE문에 사용되는 서브쿼리(INSERT문은 예외)
   - VIEW를 대상으로 하는 QUERY
   - DISTINCT가 사용되는 SELECT문
   - GROUP BY, ORDER BY절이 사용되는 SELECT문
   - 집합연산(UNION, UNION ALL, INTERSECT, MINUS)에 사용되는 SELECT문
   - WHERE 절

주로 사용되는 곳 : INSERT문, 자료삽입을 위하여 주로 사용되며 조회를 위해 사용되지 않음

3. SYNONYM 객체
 - 동의어(별칭)을 의미
 - 오라클에서 사용되는 객체에 별도의 이름을 부여하여 참조 가능
 - 주로 긴 이름의 객체명을 사용하기 쉬운 객체명으로 대체 할 때 사용
 (사용형식)
   CREATE [OR REPLACE] SYSNONYM 시노늄명 FOR 객체명
    - '객체명'에 별도의 이름인 '시노늄명'을 부여
    - 컬럼의 별칭과 테이블의 별칭과의 차이점
      - '시노늄명'은 해당 테이블 스페이스 전체에서 사용
      - '컬럼의 별칭과 테이블의 별칭'은 해당 쿼리에서만 사용가능
      
긴 계정명을 가지고 있는 경우 사용, 테이블 

사용예)HR의 테이블 EMPLOYEES, DEPARTMENTS, JOB_HISTORY에 EMP, DEPT, JOBH별칭을 부여하시오
CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
CREATE OR REPLACE SYNONYM JOBH FOR HR.JOB_HISTORY;

SELECT * FROM DEPT;
SELECT * FROM JOBH ORDER BY 1;
