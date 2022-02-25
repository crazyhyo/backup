2021-0730-02)
 4. INDEX 객체
  - 데이터의 검색 효율성을 개선하기 위한 객체
  - WHERE 조건절에 사용되는 컬럼, SORT나 GROUP의 기준컬럼 등의 컬럼을 기준으로 INDEX를 구성하면
    DBMS의 부하를 줄여 전체 성능 향상
  - 별도의 공간이 소요(INDEX FILE), 인텍스 파일의 유지보수에 많은 시스템 지원 필요,
    데이터 수정 등에 많은 시간이 소요
  - 인덱스 종류
   - Unique Index : 중복 값을 허용하지 않는 인덱스(기본키 인덱스 등)
   - Non-Unique : 중복 값을 허용하는 인덱스로 Null값을 허용하나 하나만 허용
   - Single Index : 인덱스 구성에 하나의 컬럼이 사용
   - Composite Index : 인덱스 구성에 복수개의 컬럼이 사용되며, where절에 사용시 모든 항목(인덱스 구성항목)의 참여가 효율성을 증대시킴
   - Normal Index : 기본 인덱스(트리구조 사용-모든 노드의 평균검색횟수가 동일)으로 
     ROWID와 컬럼 값으로 주소 산출
   - Function-Based Normal Index : 인덱스 구성 컬럼에 함수가 사용된 경우로
     where 조건절 사용시 동일 함수 적용시 효율이 가장 우수
   - Bitmap Index : ROWID와 컬럼 값의 이진(binary)값의 조합으로 주소 산출,
     Cardinality가 적은 경우 효율적이며, 추가, 변경, 삭제가 많은 경우 비효율적
 
 (사용형식)
   CREATE [UNIQUE|BITMAP] INDEX 인덱스명
       ON 테이블명(컬럼명1[, 컬럼명2,...][ASC|DESC]);
       
사용예)회원테이블에서 주민번호조합으로 인덱스를 생성하시오
CREATE INDEX IDX_MEM_REGNO
    ON MEMBER(MEM_REGNO1,MEM_REGNO2);

CREATE INDEX IDX_MEM_NAME
    ON MEMBER(MEM_NAME);

SELECT * FROM MEMBER WHERE SUBSTR(MEM_ADD1,1,2) = '대전';

DROP INDEX IDX_MEM_NAME;


  ** 인덱스의 재구성
    - 해당 테이블의 자료가 많이 삭제된 경우
    - 인덱스를 다른 테이블스페이스로 이동시킨 후
  
  ALTER INDEX 인덱스명 REBUILD;
  
사용예)회원테이블의 MEM_REGNO2의 주민등록번호 중 2~5번째 글자로 구성된 인덱스를 생성하시오

CREATE INDEX IDX_MEM_REGNO_SUBSTR
    ON MEMBER(SUBSTR(MEM_REGNO2,2,4));
--함수기반 인덱스

SELECT * FROM MEMBER
 WHERE SUBSTR(MEM_REGNO2,2,4) = '4489';

  ALTER INDEX IDX_MEM_REGNO REBUILD;
  
비교법 : 
비비교법 : 자료가 저장된 주소에 한번에 도달, 예로 해시맵이 잇음

kim으로 주소계산 알파벳 순번으로 11,9,13 -> 제곱하여 121,81,169
holding shilft방법
12|1811|69
  |2196|
-> 4007
kim->4007 버켓 slot key(kim) address1(4007), address2, address3 <- 여분의 주소(슬롯)는 collision에 대비하기 위함
서로 다른 데이터가 똑같은 주소를 산출하는 경우
collision이 일어난다.
collision의 회수가 최소한이 되어야 한다 : hashing map의 기본조건

자바의 오브젝트 클래스에도 hashcode라는 메소드가 있어서 각각의 클래스가 저장될 주소값을 계산해줌

이런 방법으로 키와 주소를 링크드리스트(linked list)로 관리
키와 주소가 저장되어 있는 파일이 인덱스파일, 저장위치/저장방법은 오라클에서 알아서 해줌
이진검색트리 형태로 자료((키1,주소1),(키2,주소2),(키3,주소3),...)가 저장됨
트리는 계층성을 가진 자료를 저장하는 것에 최적화됨
트리의 하나하나 자료는 노드라고 함, 노드는 키 값 1개, 테이블의 한 행, 테이블 하나 등 원하는 것이 될 수 있음
한 노드가 가질 수 있는 자식 노드의 수에 따라 이진트리(바이너리 트리)와 일반트리로 구분됨
모든 일반트리(제네럴 트리)는 바이너리 트리로 변환이 가능함
한쪽으로만 기울어진 트리(사향트리)

부모가 없는 노드 : root
부모도 자식도 있는 노드 : intermediate node
자식이 없는 노드 : leaf / terminal node

자바의 collection framework중 tree set 검색트리 : 왼쪽은 부모보다 작은 노드, 오른쪽은 부모보다 큰 노드로 구성된 트리
이 중에서 이진트리를 이진 검색트리라 함

i++ prefixed방식
++i postfixed방식

컴퓨터에서는 stack이라는 기억장소 2개로 모든 것을 처리하여 전자계산기 구현

컴퓨터는 포스트픽스는 연산자를 오른쪽으로 다 뺌
        pre픽스는 연산자를 왼쪽으로 다 뺌
이렇게 해서 계산함
왼쪽 부모 자식이 
검사방법이 left-root-right 라면 결과는 sort되어서 나옴
tree는 구간설정이 가능하다
set은 거의 사용되지 않고 map을 list로 바꿀 때만 사용됨
이런 검색트리를 이용해서 자료를 저장하는데 트리의 구조를 유지하기 위하여 데이터의 삽입과 삭제가 빈번하게 일어나는 경우
시간이 오래 걸린다. 

index file을 필요할 때 만들면 검색은 매우 빠르지만 유지보수는 비용이 많이 소요된다.

19개 컬럼을 가지고 있을 때 모든 컬럼을 index로 구성하게 되면 인덱스 관리하는데 많은 자원 비용이 소요되어(cpu사용) 시간이 오래걸림
-> 속도저하

트리구조를 사용한 인덱스 : normal index

과도한 인덱스는 지양해야 함

유니크 인덱스에서 null값이 가능하다 - 기본키 제약조건과 다른 점, 단 유니크이므로 유니크 인덱스에서 관리하는 null값은 하나만 존재할수 있다.
컴포짓 인덱스를 구성했으면 where절에서 모두 기술하는 것이 효율적이다.(기본키는 자동으로 인덱스를 생성하므로)
예) 재고수불 테이블을 조인하는 경우 컴포짓 키를 모두 비교해 주자.
rowid : 각 행의 물리적 주소값

normal index와 bitmap index는 자료가 저장되는 주소값 산출방법이 다르다(노말 인덱스 방식에서는
같은 주소를 가리키는 collision이 일어나는 경우가 많다) 이를 보완하려는 방법의 일환이 비트맵 인덱스로
자신의 주소와 키값을 이진수로 변환후 작업하여 주소를 반환한다 