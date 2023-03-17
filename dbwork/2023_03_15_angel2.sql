--����
--������ ����(student) : num ����(5), name ���ڿ�(10), height ����(5,1),
-- java ����(3) �⺻�� 10, spring ���� (3) �⺻�� 10 , ban ���ڿ�(20)


create table student (
    num number(5),
    name varchar2(10),
    height number(5,1),
    java number(3) DEFAULT 10,
    spring number(3) DEFAULT 10,
    ban varchar2(20)
);

--������ ���� seq_stu �⺻(1���� 1�� ����), nocache �߰� 
create SEQUENCE seq_stu nocache; 


--�������ǵ� �߰� 
--num�� primary key �߰� 
alter table student ADD CONSTRAINT STUDENT_PK_NUM PRIMARY KEY(NUM);


--java,spring�� 1~100�� �����ϵ��� check �������� �߰� 
alter table student ADD CONSTRAINT STUDEMT_CK_JAVA CHECK (JAVA>=1 AND JAVA<=100);
alter table student ADD CONSTRAINT STUDEMT_CK_SPRING CHECK (SPRING>=1 AND SPRING<=100);

--ban�� '�޴Թ�', '�޴Թ�', '���Թ�'�� �߰��� �� �ֵ��� check �߰� 
alter table student ADD CONSTRAINT STUDENT_CK_BAN CHECK (BAN IN ('�޴Թ�','�޴Թ�','���Թ�'));

--5�� ������ ����Ÿ�� �߰��غ��� 
insert into student (num,name,java,height,ban) values (seq_stu.nextval, '������', 89, 167.5, '�޴Թ�');
insert into student values (seq_stu.nextval,'��ȿ��',178.6,67,88,'�޴Թ�');
insert into student values (seq_stu.nextval,'�踻��',15.6,100,90,'���Թ�');
insert into student values (seq_stu.nextval,'����',165.6,55,67,'�޴Թ�');
insert into student values (seq_stu.nextval,'��ö��',179.1,90,86,'�޴Թ�');
commit;

--num�� 3�� ����� java ������ 99��, ban�� '�޴Թ�'���� ���� 
update student set java=99 where num=3;
update student set ban='�޴Թ�' where num=3;
--update student set java=99,ban='�޴Թ�' where num=3;


--num=5�� ����� Ű�� 189.9�� ���� 
update student set height=189.9 where num=5;

--num=2�� ����Ÿ ���� 
delete from student where num=2;

--��ȸ  �̸�  ��  �ڹ�  ������  ����  ��� - ������ ���� ������� ��� 
select name �̸�, ban ��, java �ڹ�, spring ������, java+spring ����, (java+spring)/2 ��� from student order by ���� desc;

commit;

----DB ����ȭ (Normalization)
--����ȭ��? �Ѹ���� db ������ �޸𸮸� �������� �ʱ� ���ؼ� 
--� ���̺��� �ĺ��ڸ� ������ �������� ���̺�� ������ ������ ����ȭ�� �Ѵ� 
--����ȭ�� ����Ÿ���̽��� �ߺ��� �ּ�ȭ�ǵ��� ����� ����Ÿ���̽��̴� 
--���� : �޸𸮸� ������ �� �ִ�.
--    ����ȭ�� �ý������� ���ؼ� ������ ���ϴ� 
--���� : ��ȸ������ �ſ� ���� �ý����� ��쿡�� ���̺��� join ������ �ݺ������� �̷����� ������ ���� ���� �ӵ��� ��¦ �ʾ��� �� �ִ� 


--student�� num�� �ܺ�Ű�� ���� ���ο� ���̺� stuinfo�� ������ 
--�ܺ�Ű�� ���̺� ������ �����ص� �ǰ� �ϴ� ������ ���̺� �������� �߰��ص� �ȴ� 
--ppt 29page 
create table stuinfo (
    idx number(5) constraint info_pk_idx primary key,
    num number(5),
    addr varchar2(20),
    hp varchar2(15)
);

--�ܺ�Ű �������� �߰� 
--stuinfo�� num�� student�� num���� ���� �� �ֵ��� ���� 
alter table stuinfo add constraint info_fk_num foreign key(num) references student(num); 

--stuinfo�� num�� ���� 3�� �߰��ߴٸ� student ���̺��� num=3�� ����Ÿ�� ������ �� ���� 
--�� �������� �߰��� on delete cascade �� �߰��������� �θ����̺��� num=3�� ����Ÿ ������ 
--stuinfo�� num=3�� ��� ����Ÿ�� �ڵ� �����ȴ� 

--stuinfo�� ����Ÿ �߰��ϱ� 
insert into stuinfo values (seq_stu.nextval,3,'����� ������','010-2222-3333');
--student�� ���� 2���� �߰��غ��� 
insert into stuinfo values (seq_stu.nextval,2,'����� ������','010-5454-1212'); --�����߻� 
--�ٽ� 4������ �߰� - ���� 
insert into stuinfo values (seq_stu.nextval,4,'����� ������','010-5454-1212');  
insert into stuinfo values (seq_stu.nextval,1,'���ֵ� �ֿ���','010-7777-8888'); 

--��ȸ
--���� ��ȸ�� �Ұ�� ��� ������ �˼�����
select * from stuinfo;

--join���� �� ���̺��� ���ؼ� �ʿ��� ������ �����ͺ��� 
--ppt 43������ 
--inner join �Ǵ� equi join�̶�� �Ѵ�. ���� num���� ���� ��쿡�� �����´�. 
select sd.num ������, sd.name �л���, sd.height Ű, sd.ban ��, si.addr �ּ�, si.hp �ڵ���, 
sd.java �ڹ�, sd.spring ������
from student sd, stuinfo si
where sd.num=si.num; 

--�̶� ���� ���̺� ���������� ���� �ִ� �÷��� �����ϰ�� �տ� ���̺�� ���� ���� 
select sd.num ������, name �л���, height Ű, ban ��, addr �ּ�, hp �ڵ���, 
java �ڹ�, spring ������
from student sd, stuinfo si
where sd.num=si.num; 


--outer join���� �߰����� ���� ����Ÿ�� ã�ƺ��� 
select sd.num ������, name �л���, height Ű, ban ��, addr �ּ�, hp �ڵ���, 
java �ڹ�, spring ������
from student sd, stuinfo si
where sd.num=si.num(+) and addr is null; 

--student ���̺��� num=1�� ����Ÿ �����غ��� 
--ORA-02292: ���Ἲ ��������(ANGEL.INFO_FK_NUM)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
--�̰�� ���� ������ �ϰ� ������ stuinfo�� ����Ÿ�� ���� ���� �� student�� ����Ÿ�� ������ �� �ִ� 
delete from student where num=1;

--sub ���̺��� num=1 ���� ���� �� �θ����̺� num1�� �����غ��� 
delete from stuinfo where num=1;
delete from student where num=1;

--���̺� ���Ž� �������̺��� ���� ���� �� �θ� ���̺� ����
drop table stuinfo;
drop table student;
------------------------------------------------------------------------

--�̹����� �θ����̺��� ����Ÿ ������ �������̺��� ����Ÿ�� �ڵ����� �����ǵ���
--�ܺ�Ű�� �����غ��� 
--������ ����
create SEQUENCE seq_shop;
--shop,cart
create table shop(
    sang_no number(3) CONSTRAINT shop_pk_no primary key,
    sang_name varchar2(30),
    sang_price number(10)
);
--�ܺ�Ű ������ on delete cascade�� ���̸� �θ����̺� ������ �ڽ����̺� �߰��� 
--����Ÿ�� ���� ������ 
create table cart(
    cart_no number(3) CONSTRAINT cart_pk_no PRIMARY key,
    sang_no number(3),
    cnt number(3),
    cartday date,
    CONSTRAINT cart_fk_no foreign key(sang_no) references shop(sang_no) on delete cascade
);

--5���� ��ǰ�� ����غ���
insert into shop values (seq_shop.nextval, '���콺', 12000);
insert into shop values (seq_shop.nextval, '����', 19000);
insert into shop values (seq_shop.nextval, 'û����', 25000);
insert into shop values (seq_shop.nextval, 'üũ��Ʈ', 99000);
insert into shop values (seq_shop.nextval, 'Ƽ����', 11000);
commit;

--3���� ��ǰ�� īƮ�� ��ƺ��� 
insert into cart values (seq_shop.nextval,2,3,sysdate);
insert into cart values (seq_shop.nextval,3,1,'2023-01-13');
insert into cart values (seq_shop.nextval,5,3,sysdate);
commit;


--��ȸ
--sang_no ��ǰ��ȣ, ��ǰ��, �ܰ�, ����, ������(��4-��2-��2 �������� ���)

select s.sang_no ��ǰ��ȣ,sang_name ��ǰ��, to_char(sang_price,'L999,999') �ܰ�, cnt ����, to_char(cartday,'yyyy-mm-dd') ������
from shop s,cart c
where s.sang_no=c.sang_no;


--cart�� ����� ���� ��ǰ�� ��ǰ��ȣ�� ��ǰ�� ���

select s.sang_no ��ǰ��ȣ,sang_name ��ǰ��, to_char(sang_price,'L999,999') �ܰ�, cnt ����, to_char(cartday,'yyyy-mm-dd') ������
from shop s,cart c
where s.sang_no=c.sang_no (+) and cnt is null;

--���� Ȯ��(2,3,5 ��ǰ�� cart�� �������) 
--shop�� 2��, 3�� ��ǰ�� ���� �� cart ���̺��� Ȯ���غ����� 
delete from shop where sang_no=2;
delete from shop where sang_no=3;

--���� ������ ��� ���̺�� �������� �������ּ��� 
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


insert into restaurant values (seq_food.nextval, '���İ�Ƽ', 23000);
insert into restaurant values (seq_food.nextval, '���캺����', 11000);
insert into restaurant values (seq_food.nextval, '������', 19000);
insert into restaurant values (seq_food.nextval, '����Ƣ��', 10000);
insert into restaurant values (seq_food.nextval, '¥���', 5000);

insert into resorder values (seq_food.nextval, '�̻��', 1   , '2023-12-25', sysdate, 4);
insert into resorder values (seq_food.nextval, '��ȣ��', 2   , '2023-11-20', sysdate, 3);
insert into resorder values (seq_food.nextval, '��ȣ��', 3   , '2023-12-20', sysdate, 3);
insert into resorder values (seq_food.nextval, '�̿���', 1   , '2023-05-11', sysdate, 2);

select order_name �ֹ���, to_char(order_day,'yyyy-mm-dd') ������, food_name ���ĸ�, food_price ���İ���, to_char(jumun_day,'yyyy-mm-dd hh24:mm:ss') �ֹ���, inwon �ο���
from restaurant r,resorder o
where r.food_num=o.food_num;

delete from restaurant where food_num=3;
commit;
