사용예)키보드로 10~110사이의 부서번호를 입력받아 해당부서직원중 가장 입사일이 빠른 사원 정보를 출력하시오
      ALIAS는 사원번호, 사원명, 입사일, 직책코드이다
      
ACCEPT P_DID PROMPT '부서번호 입력'
DECLARE
    V_EID   HR.EMPLOYEES.EMPLOYEE_ID    %TYPE;
    V_ENAME HR.EMPLOYEES.EMP_NAME       %TYPE;
    V_HIRE  HR.EMPLOYEES.HIRE_DATE      %TYPE;
    V_JOBID HR.EMPLOYEES.JOB_ID         %TYPE;
BEGIN
    SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.HIRE_DATE, A.JOB_ID
      INTO V_EID, V_ENAME, V_HIRE, V_JOBID
      FROM (SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
              FROM HR.EMPLOYEES
             WHERE DEPARTMENT_ID = TO_NUMBER('&P_DID')
             ORDER BY 3) A
     WHERE ROWNUM = 1;
     
     DBMS_OUTPUT.PUT_LINE('사원번호 : ' || V_EID);
     DBMS_OUTPUT.PUT_LINE('사원명 : ' || V_ENAME);
     DBMS_OUTPUT.PUT_LINE('입사일 : ' || V_HIRE);
     DBMS_OUTPUT.PUT_LINE('직무명 : ' || V_JOBID);
     
     EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외발생 : ' || SQLERRM);
END;
      
사용예)임의의 수를 입력 받아 짝수인지 홀수인지 판별하시오

ACCEPT P_NUM PROMPT '숫자 입력'
DECLARE
BEGIN
    IF MOD(TO_NUMBER('&P_NUM'),2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EVEN');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ODD');
    END IF;
END;


사용예)회원테이블에서 회원들의 마일리지를 조회하여 그 값이 5000이상이면 'VIP 회원'을 
      3000 이상이면 '정회원'을, 그 이하이면 '준회원'을 회원번호, 회원명, 마일리지와 함께 출력하시오.
      
DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_MNAME MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_GD    VARCHAR2(30);
    
    CURSOR CUR_MEM01 IS
        SELECT MEM_ID, MEM_NAME, MEM_MILEAGE,
               CASE WHEN MEM_MILEAGE >= 5000 THEN   'VIP 회원'
                    WHEN MEM_MILEAGE >= 3000 THEN   '정회원'
                    ELSE                            '준회원'
               END
          FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_MNAME, V_MILE, V_GD;
        EXIT WHEN CUR_MEM01%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(V_MID);
        DBMS_OUTPUT.PUT_LINE(V_MNAME);
        DBMS_OUTPUT.PUT_LINE(V_MILE);
        DBMS_OUTPUT.PUT_LINE(V_GD);
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
    
END;

DECLARE
    V_MID   MEMBER.MEM_ID       %TYPE;
    V_MNAME MEMBER.MEM_NAME     %TYPE;
    V_MILE  MEMBER.MEM_MILEAGE  %TYPE;
    V_RES   VARCHAR2(100);
    
    CURSOR CUR_MEM01 IS
        SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
          FROM MEMBER;
BEGIN
    OPEN CUR_MEM01;
    
    LOOP
        FETCH CUR_MEM01 INTO V_MID, V_MNAME, V_MILE;
        EXIT WHEN CUR_MEM01 % NOTFOUND;
        
        IF      V_MILE >= 5000  THEN    V_RES := 'VIP 회원';
        ELSIF   V_MILE >= 3000  THEN    V_RES := '정회원';
        ELSE                            V_RES := '준회원';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(V_MID || ' ' || V_MNAME || ' ' || V_MILE || ' ' || V_RES);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
    
    CLOSE CUR_MEM01;
END;
      
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
      
      
ACCEPT P_INPUT PROMPT '수도 사용량 입력(톤 단위)'
DECLARE
    V_AMT   NUMBER;
    V_RES   NUMBER;
BEGIN
    V_AMT := TO_NUMBER('&P_INPUT');
    
    IF V_AMT <= 10 THEN
        V_RES := V_AMT * 275 + V_AMT * 120;
    ELSIF V_AMT <= 20 THEN
        V_RES := (V_AMT - 10) * 305 + V_AMT * 120 + 10 * 275;
    ELSIF V_AMT <= 30 THEN
        V_RES := (V_AMT - 20) * 350 + V_AMT * 120 + 10 * 275 + 10 * 305;
    ELSIF V_AMT <= 40 THEN
        V_RES := (V_AMT - 30) * 415 + V_AMT * 120 + 10 * 275 + 10 * 305 + 10 * 350;
    ELSE
        V_RES := (V_AMT - 40) * 500 + V_AMT * 120 + 10 * 275 + 10 * 305 + 10 * 350 + 10 * 415;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(V_RES);
    
END;