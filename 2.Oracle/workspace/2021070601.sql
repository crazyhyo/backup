2021-0706-01)사용자 생성
 - CRATE USER 명령으로 수행
 - 권한 부여 : GRANT 명령 사용
 (사용형식)
  CREATE USER 계정명 IDENTIFIED BY 암호;
  
  
  CREATE USER LKH96 IDENTIFIED BY java;
  (권한부여)
  GRANT 권한명[, 권한명,...] TO 계정명;
  - '권한명'은 주로 CONNECT, RESOURCE, DBA 등에 사용
  
  GRANT CONNECT, RESOURCE, DBA TO LKH96;