--ppt 23페이지 table
--table 생성 (person) : 번호, 이름, 나이, 성별, 지역, 현재날짜 
create table person (
    num number(3)  PRIMARY key,
    name varchar2(15) not null,
    age number(3),
    gender varchar2(10) DEFAULT '남자',
    city varchar2(15) DEFAULT '서울', 
    today date
);

--데이타 조회
select * from person;


--insert 컬럼데이타 일부만 추가할 경우
insert into person (num,name,today) values (1,'홍길동',sysdate);
--pk(primary key),nn(not null)일 경우 값을 안넣어주면 오류 발생 - 확인 
--ORA-01400: NULL을 ("ANGEL"."PERSON"."NUM") 안에 삽입할 수 없습니다
insert into person (name, age, today) values ('강철수',23,'2022-10-10');--오류
--nn 속성이 들어간 컬럼은 무조건 넣어줘야 한다 
--ORA-00001: 무결성 제약 조건(ANGEL.SYS_C008321)에 위배됩니다
insert into person (num,name,age,today) values (1,'강철수',23,'2022-10-10');
--오류 없이 나오도록 제대로 넣어보자 
insert into person (num,name,age,today) values (2,'강철수',23,'2022-10-10');
--일부 컬럼이 아니라 순서대로 모든 컬럼값을 넣을경우 컬럼명 생략 가능 
insert into person values (3, '강호순', 34, '여자', '제주도', '2021-12-25');
--각각 7개정도 추가해보자 
insert into person values (4, '이효리', 27, '여자', '부산', '2023-01-25');
insert into person values (5, '김진수', 45, '남자', '일산', sysdate);
insert into person values (6, '이진', 39, '여자', '뉴욕', '2022-05-10');
insert into person values (7, '박지윤', 19, '여자', '김포', '2020-11-22');
insert into person values (8, '강호동', 41, '남자', '대구', sysdate);
insert into person values (9, '박지나', 32, '여자', '부산', '2019-09-25');
insert into person values (10, '이효진', 28, '여자', '제주도', '2021-12-11');
commit;
--박지나의 age,city 수정
update person set age=26,city='제주도' where name='박지나';
--홍길동의 나이 수정 
update person set age=29 where name='홍길동';
--이진의 today를 현재날짜로 수정 
update person set today=sysdate where name='이진'; 
commit;
--delete : where 조건을 안쓰면 전체 모두 삭제됨 
delete from person; 
--다시 살리기
rollback; --마지막 commit 이후까지만 롤백 
--조건을 이용해서 삭제 
delete from person where name='홍길동';
--나이가 30세 미만인 경우 모두 삭제 
delete from person where age<30;
rollback;

--지금부터는 테이블 구조를 수정하는 연습 
--테이블에 칼럼 추가 
alter table person add score number(3) default 50;
--방금 추가한 score 칼럼을 제거 
alter table person drop column score;

--컬럼 타입 수정
alter table person modify city varchar2(20); 
--컬럼 명 변경 today -> ipsaday로 변경 
alter table person rename column today to ipsaday; 

--제약조건을 제거 : name에 not null 제약조건이 들어있다 (제약조건 이름을 안줘서 기본 이름으로 들어가있다) 
--SYS_C008320 제거
alter table person drop CONSTRAINT SYS_C008320;
--NAME에 새로운 제약조건을 추가해보자(UNIQUE) 
alter table person ADD CONSTRAINT PERSON_UQ_NAME UNIQUE(NAME);
--이름에 같은 이름을 넣으면 이제 오류가 발생
INSERT INTO PERSON (NUM,NAME) VALUES (11,'강호동');  --오류 
--GENDER 에 '남자', '여자' 외의 데이타를 넣으면 오류가 발생되도록 CHECK 제약조건을 추가해보자 
alter table person ADD CONSTRAINT PERSON_CK_GENDER CHECK (GENDER IN ('남자','여자'));
--10 ~ 50 세만 추가 가능하도록 제약조건을 추가해보자 
alter table person ADD CONSTRAINT PERSON_CK_AGE CHECK (AGE>=10 AND AGE<=50);

--제약조건에 위배되도록 나이를 추가해보자
INSERT INTO PERSON(NUM,NAME,AGE) VALUES(100,'이상아',60); --오류 

--문제
--PK 제약조건을 제거후 PERSON_PK_NUM 이라는 새로운 제약조건을 추가해보자
alter table person drop CONSTRAINT SYS_C008321;
alter table person ADD CONSTRAINT PERSON_PK_NUM PRIMARY KEY(NUM);


--문제2
--BUSEO라는 칼럼을 추가 VARCHAR2(10) 기본값을 '교육부'
alter table person add BUSEO VARCHAR2(10) default '교육부';
--BUSEO에 제약조건 추가 '교육부', '홍보부', '인사부' 3개만 추가가 가능하도록.. 
alter table person ADD CONSTRAINT PERSON_UQ_BUSEO CHECK(BUSEO IN ('교육부','홍보부','인사부')); 

--문제3 강씨,이씨성을 가진 사람들은 모두 '인사부'로 데이터수정 
update person set BUSEO='인사부' where name like '강%' or name like '이%';
--박씨, 김씨 성을 가진 사람들은 모두 '홍보부'로 수정
update person set BUSEO='홍보부' where name like '박%' or name like '김%';

--문제4
--남자 여자 성별로 인원수와 평균나이(정수타입) 구하기 - 인원수가 많은 것부터 출력 
select gender 성별,count(*) 인원수,round(avg(age),1) 평균나이 from person group by gender order by 2 desc;
--부서별로 인원수와 평균나이 구하기  - 부서명의 오름차순으로 출력 
select count(*) 인원수,round(avg(age),1) 평균나이, buseo 부서명 from person group by buseo order by 부서명;

--시퀀스 생성하는 방법 (ppt) 
--가장 많이 사용하는 기본 시퀀스 : 1부터 1씩 증가하는 시퀀스 
create SEQUENCE seq1;
create SEQUENCE seq2 start with 1 increment by 1; --위와 같다 
create SEQUENCE seq3 start with 10 increment by 5 nocache; --nocache : cache를 0으로 
create SEQUENCE seq4 maxvalue 100;  --max값이 100까지만 발생된다 
--시퀀스 조회 
select * from seq;
--테이블 조회
select * from tab;

--시퀀스 제거
drop sequence seq2;
drop sequence seq4;

--다음값 발생 nextval, 현재값 currval 
select seq1.nextval, seq3.nextval from dual; --반복해서 실행해본다 
select seq1.currval, seq3.currval from dual;
commit;






