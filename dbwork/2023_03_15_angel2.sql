--문제
--데이터 생성(student) : num 숫자(5), name 문자열(10), height 숫자(5,1),
-- java 숫자(3) 기본값 10, spring 숫자 (3) 기본값 10 , ban 문자열(20)


create table student (
    num number(5),
    name varchar2(10),
    height number(5,1),
    java number(3) DEFAULT 10,
    spring number(3) DEFAULT 10,
    ban varchar2(20)
);

--시퀀스 생성 seq_stu 기본(1부터 1씩 증가), nocache 추가 
create SEQUENCE seq_stu nocache; 


--제약조건들 추가 
--num에 primary key 추가 
alter table student ADD CONSTRAINT STUDENT_PK_NUM PRIMARY KEY(NUM);


--java,spring은 1~100만 가능하도록 check 제약조건 추가 
alter table student ADD CONSTRAINT STUDEMT_CK_JAVA CHECK (JAVA>=1 AND JAVA<=100);
alter table student ADD CONSTRAINT STUDEMT_CK_SPRING CHECK (SPRING>=1 AND SPRING<=100);

--ban은 '햇님반', '달님반', '별님반'만 추가할 수 있도록 check 추가 
alter table student ADD CONSTRAINT STUDENT_CK_BAN CHECK (BAN IN ('햇님반','달님반','별님반'));

--5개 정도만 데이타를 추가해보자 
insert into student (num,name,java,height,ban) values (seq_stu.nextval, '김진아', 89, 167.5, '햇님반');
insert into student values (seq_stu.nextval,'이효리',178.6,67,88,'달님반');
insert into student values (seq_stu.nextval,'김말자',15.6,100,90,'별님반');
insert into student values (seq_stu.nextval,'이진',165.6,55,67,'달님반');
insert into student values (seq_stu.nextval,'이철수',179.1,90,86,'햇님반');
commit;

--num이 3인 사람의 java 점수를 99로, ban을 '달님반'으로 수정 
update student set java=99 where num=3;
update student set ban='달님반' where num=3;
--update student set java=99,ban='달님반' where num=3;


--num=5인 사람의 키를 189.9로 수정 
update student set height=189.9 where num=5;

--num=2인 데이타 삭제 
delete from student where num=2;

--조회  이름  반  자바  스프링  총점  평균 - 총점이 높은 사람부터 출력 
select name 이름, ban 반, java 자바, spring 스프링, java+spring 총점, (java+spring)/2 평균 from student order by 총점 desc;

commit;

----DB 정규화 (Normalization)
--정규화란? 한마디로 db 서버의 메모리를 낭비하지 않기 위해서 
--어떤 테이블을 식별자를 가지는 여러개의 테이블로 나누는 과정을 정규화라 한다 
--정규화된 데이타베이스는 중복이 최소화되도록 설계된 데이타베이스이다 
--장점 : 메모리를 절약할 수 있다.
--    구조화된 시스템으로 인해서 관리가 편하다 
--단점 : 조회비율이 매우 높은 시스템의 경우에는 테이블간의 join 연산이 반복적으로 이뤄지기 때문에 질의 응답 속도가 살짝 늦어질 수 있다 


--student의 num을 외부키로 갖는 새로운 테이블 stuinfo를 만들어보자 
--외부키는 테이블 생성시 설정해도 되고 일단 생성후 테이블 수정으로 추가해도 된다 
--ppt 29page 
create table stuinfo (
    idx number(5) constraint info_pk_idx primary key,
    num number(5),
    addr varchar2(20),
    hp varchar2(15)
);

--외부키 제약조건 추가 
--stuinfo의 num은 student의 num값만 넣을 수 있도록 설정 
alter table stuinfo add constraint info_fk_num foreign key(num) references student(num); 

--stuinfo의 num에 만약 3을 추가했다면 student 테이블에서 num=3인 데이타는 삭제할 수 없다 
--단 제약조건 추가시 on delete cascade 를 추가했을경우는 부모테이블의 num=3인 데이타 삭제시 
--stuinfo의 num=3인 모든 데이타는 자동 삭제된다 

--stuinfo에 데이타 추가하기 
insert into stuinfo values (seq_stu.nextval,3,'서울시 강남구','010-2222-3333');
--student에 없는 2번을 추가해보자 
insert into stuinfo values (seq_stu.nextval,2,'서울시 강동구','010-5454-1212'); --오류발생 
--다시 4번으로 추가 - 성공 
insert into stuinfo values (seq_stu.nextval,4,'서울시 강동구','010-5454-1212');  
insert into stuinfo values (seq_stu.nextval,1,'제주도 애월읍','010-7777-8888'); 

--조회
--각각 조회를 할경우 모든 정보를 알수없다
select * from stuinfo;

--join으로 두 테이블을 합해서 필요한 정보를 가져와보자 
--ppt 43페이지 
--inner join 또는 equi join이라고 한다. 서로 num값이 같을 경우에만 가져온다. 
select sd.num 시퀀스, sd.name 학생명, sd.height 키, sd.ban 반, si.addr 주소, si.hp 핸드폰, 
sd.java 자바, sd.spring 스프링
from student sd, stuinfo si
where sd.num=si.num; 

--이때 양쪽 테이블에 공통적으로 갖고 있는 컬럼을 제외하고는 앞에 테이블명 생략 가능 
select sd.num 시퀀스, name 학생명, height 키, ban 반, addr 주소, hp 핸드폰, 
java 자바, spring 스프링
from student sd, stuinfo si
where sd.num=si.num; 


--outer join으로 추가되지 않은 데이타를 찾아보자 
select sd.num 시퀀스, name 학생명, height 키, ban 반, addr 주소, hp 핸드폰, 
java 자바, spring 스프링
from student sd, stuinfo si
where sd.num=si.num(+) and addr is null; 

--student 테이블의 num=1인 데이타 삭제해보자 
--ORA-02292: 무결성 제약조건(ANGEL.INFO_FK_NUM)이 위배되었습니다- 자식 레코드가 발견되었습니다
--이경우 만약 삭제를 하고 싶으면 stuinfo의 데이타를 먼저 삭제 후 student의 데이타를 삭제할 수 있다 
delete from student where num=1;

--sub 테이블의 num=1 먼저 삭제 후 부모테이블 num1을 삭제해보자 
delete from stuinfo where num=1;
delete from student where num=1;

--테이블 제거시 서브테이블을 먼저 제거 후 부모 테이블 제거
drop table stuinfo;
drop table student;
------------------------------------------------------------------------

--이번에는 부모테이블의 데이타 삭제시 서브테이블의 데이타도 자동으로 삭제되도록
--외부키를 설정해보자 
--시퀀스 생성
create SEQUENCE seq_shop;
--shop,cart
create table shop(
    sang_no number(3) CONSTRAINT shop_pk_no primary key,
    sang_name varchar2(30),
    sang_price number(10)
);
--외부키 설정시 on delete cascade를 붙이면 부모테이블 삭제시 자식테이블에 추가된 
--데이타도 같이 삭제됨 
create table cart(
    cart_no number(3) CONSTRAINT cart_pk_no PRIMARY key,
    sang_no number(3),
    cnt number(3),
    cartday date,
    CONSTRAINT cart_fk_no foreign key(sang_no) references shop(sang_no) on delete cascade
);

--5개의 상품을 등록해보자
insert into shop values (seq_shop.nextval, '블라우스', 12000);
insert into shop values (seq_shop.nextval, '조끼', 19000);
insert into shop values (seq_shop.nextval, '청바지', 25000);
insert into shop values (seq_shop.nextval, '체크코트', 99000);
insert into shop values (seq_shop.nextval, '티셔츠', 11000);
commit;

--3개의 제품을 카트에 담아보자 
insert into cart values (seq_shop.nextval,2,3,sysdate);
insert into cart values (seq_shop.nextval,3,1,'2023-01-13');
insert into cart values (seq_shop.nextval,5,3,sysdate);
commit;


--조회
--sang_no 상품번호, 상품명, 단가, 수량, 구입일(년4-월2-일2 형식으로 출력)

select s.sang_no 상품번호,sang_name 상품명, to_char(sang_price,'L999,999') 단가, cnt 수량, to_char(cartday,'yyyy-mm-dd') 구입일
from shop s,cart c
where s.sang_no=c.sang_no;


--cart에 담기지 않은 상품의 상품번호와 상품명 출력

select s.sang_no 상품번호,sang_name 상품명, to_char(sang_price,'L999,999') 단가, cnt 수량, to_char(cartday,'yyyy-mm-dd') 구입일
from shop s,cart c
where s.sang_no=c.sang_no (+) and cnt is null;

--삭제 확인(2,3,5 상품이 cart에 담겨있음) 
--shop의 2번, 3번 상품을 삭제 후 cart 테이블을 확인해보세요 
delete from shop where sang_no=2;
delete from shop where sang_no=3;

--오늘 연습한 모든 테이블과 시퀀스를 제거해주세요 
drop table shop;
drop table cart;
drop table person;
drop sequence seq_shop;
drop sequence seq_stu;
drop sequence seq1;
drop sequence seq3;


------------------------------------------------------------------------


create SEQUENCE seq_food;

create table restaurant(
    food_num number(3) CONSTRAINT food_pk_no primary key,
    food_name varchar2(30),
    food_price number(7)
);

create table resorder(
    order_num number(3) CONSTRAINT resorder_pk_no PRIMARY key,
    order_name varchar2(20),
    food_num number(3),
    order_day date,
    jumun_day date,
    inwon number(3),
    CONSTRAINT resorder_fk_no foreign key(food_num) references restaurant(food_num) on delete cascade
);


insert into restaurant values (seq_food.nextval, '스파게티', 23000);
insert into restaurant values (seq_food.nextval, '새우볶음밥', 11000);
insert into restaurant values (seq_food.nextval, '전복죽', 19000);
insert into restaurant values (seq_food.nextval, '새우튀김', 10000);
insert into restaurant values (seq_food.nextval, '짜장면', 5000);

insert into resorder values (seq_food.nextval, '이상아', 1   , '2023-12-25', sysdate, 4);
insert into resorder values (seq_food.nextval, '강호동', 2   , '2023-11-20', sysdate, 3);
insert into resorder values (seq_food.nextval, '강호동', 3   , '2023-12-20', sysdate, 3);
insert into resorder values (seq_food.nextval, '이영자', 1   , '2023-05-11', sysdate, 2);

select order_name 주문자, to_char(order_day,'yyyy-mm-dd') 예약일, food_name 음식명, food_price 음식가격, to_char(jumun_day,'yyyy-mm-dd hh24:mm:ss') 주문일, inwon 인원수
from restaurant r,resorder o
where r.food_num=o.food_num;

delete from restaurant where food_num=3;
commit;
