--ppt 23������ table
--table ���� (person) : ��ȣ, �̸�, ����, ����, ����, ���糯¥ 
create table person (
    num number(3)  PRIMARY key,
    name varchar2(15) not null,
    age number(3),
    gender varchar2(10) DEFAULT '����',
    city varchar2(15) DEFAULT '����', 
    today date
);

--����Ÿ ��ȸ
select * from person;


--insert �÷�����Ÿ �Ϻθ� �߰��� ���
insert into person (num,name,today) values (1,'ȫ�浿',sysdate);
--pk(primary key),nn(not null)�� ��� ���� �ȳ־��ָ� ���� �߻� - Ȯ�� 
--ORA-01400: NULL�� ("ANGEL"."PERSON"."NUM") �ȿ� ������ �� �����ϴ�
insert into person (name, age, today) values ('��ö��',23,'2022-10-10');--����
--nn �Ӽ��� �� �÷��� ������ �־���� �Ѵ� 
--ORA-00001: ���Ἲ ���� ����(ANGEL.SYS_C008321)�� ����˴ϴ�
insert into person (num,name,age,today) values (1,'��ö��',23,'2022-10-10');
--���� ���� �������� ����� �־�� 
insert into person (num,name,age,today) values (2,'��ö��',23,'2022-10-10');
--�Ϻ� �÷��� �ƴ϶� ������� ��� �÷����� ������� �÷��� ���� ���� 
insert into person values (3, '��ȣ��', 34, '����', '���ֵ�', '2021-12-25');
--���� 7������ �߰��غ��� 
insert into person values (4, '��ȿ��', 27, '����', '�λ�', '2023-01-25');
insert into person values (5, '������', 45, '����', '�ϻ�', sysdate);
insert into person values (6, '����', 39, '����', '����', '2022-05-10');
insert into person values (7, '������', 19, '����', '����', '2020-11-22');
insert into person values (8, '��ȣ��', 41, '����', '�뱸', sysdate);
insert into person values (9, '������', 32, '����', '�λ�', '2019-09-25');
insert into person values (10, '��ȿ��', 28, '����', '���ֵ�', '2021-12-11');
commit;
--�������� age,city ����
update person set age=26,city='���ֵ�' where name='������';
--ȫ�浿�� ���� ���� 
update person set age=29 where name='ȫ�浿';
--������ today�� ���糯¥�� ���� 
update person set today=sysdate where name='����'; 
commit;
--delete : where ������ �Ⱦ��� ��ü ��� ������ 
delete from person; 
--�ٽ� �츮��
rollback; --������ commit ���ı����� �ѹ� 
--������ �̿��ؼ� ���� 
delete from person where name='ȫ�浿';
--���̰� 30�� �̸��� ��� ��� ���� 
delete from person where age<30;
rollback;

--���ݺ��ʹ� ���̺� ������ �����ϴ� ���� 
--���̺� Į�� �߰� 
alter table person add score number(3) default 50;
--��� �߰��� score Į���� ���� 
alter table person drop column score;

--�÷� Ÿ�� ����
alter table person modify city varchar2(20); 
--�÷� �� ���� today -> ipsaday�� ���� 
alter table person rename column today to ipsaday; 

--���������� ���� : name�� not null ���������� ����ִ� (�������� �̸��� ���༭ �⺻ �̸����� ���ִ�) 
--SYS_C008320 ����
alter table person drop CONSTRAINT SYS_C008320;
--NAME�� ���ο� ���������� �߰��غ���(UNIQUE) 
alter table person ADD CONSTRAINT PERSON_UQ_NAME UNIQUE(NAME);
--�̸��� ���� �̸��� ������ ���� ������ �߻�
INSERT INTO PERSON (NUM,NAME) VALUES (11,'��ȣ��');  --���� 
--GENDER �� '����', '����' ���� ����Ÿ�� ������ ������ �߻��ǵ��� CHECK ���������� �߰��غ��� 
alter table person ADD CONSTRAINT PERSON_CK_GENDER CHECK (GENDER IN ('����','����'));
--10 ~ 50 ���� �߰� �����ϵ��� ���������� �߰��غ��� 
alter table person ADD CONSTRAINT PERSON_CK_AGE CHECK (AGE>=10 AND AGE<=50);

--�������ǿ� ����ǵ��� ���̸� �߰��غ���
INSERT INTO PERSON(NUM,NAME,AGE) VALUES(100,'�̻��',60); --���� 

--����
--PK ���������� ������ PERSON_PK_NUM �̶�� ���ο� ���������� �߰��غ���
alter table person drop CONSTRAINT SYS_C008321;
alter table person ADD CONSTRAINT PERSON_PK_NUM PRIMARY KEY(NUM);


--����2
--BUSEO��� Į���� �߰� VARCHAR2(10) �⺻���� '������'
alter table person add BUSEO VARCHAR2(10) default '������';
--BUSEO�� �������� �߰� '������', 'ȫ����', '�λ��' 3���� �߰��� �����ϵ���.. 
alter table person ADD CONSTRAINT PERSON_UQ_BUSEO CHECK(BUSEO IN ('������','ȫ����','�λ��')); 

--����3 ����,�̾����� ���� ������� ��� '�λ��'�� �����ͼ��� 
update person set BUSEO='�λ��' where name like '��%' or name like '��%';
--�ھ�, �达 ���� ���� ������� ��� 'ȫ����'�� ����
update person set BUSEO='ȫ����' where name like '��%' or name like '��%';

--����4
--���� ���� ������ �ο����� ��ճ���(����Ÿ��) ���ϱ� - �ο����� ���� �ͺ��� ��� 
select gender ����,count(*) �ο���,round(avg(age),1) ��ճ��� from person group by gender order by 2 desc;
--�μ����� �ο����� ��ճ��� ���ϱ�  - �μ����� ������������ ��� 
select count(*) �ο���,round(avg(age),1) ��ճ���, buseo �μ��� from person group by buseo order by �μ���;

--������ �����ϴ� ��� (ppt) 
--���� ���� ����ϴ� �⺻ ������ : 1���� 1�� �����ϴ� ������ 
create SEQUENCE seq1;
create SEQUENCE seq2 start with 1 increment by 1; --���� ���� 
create SEQUENCE seq3 start with 10 increment by 5 nocache; --nocache : cache�� 0���� 
create SEQUENCE seq4 maxvalue 100;  --max���� 100������ �߻��ȴ� 
--������ ��ȸ 
select * from seq;
--���̺� ��ȸ
select * from tab;

--������ ����
drop sequence seq2;
drop sequence seq4;

--������ �߻� nextval, ���簪 currval 
select seq1.nextval, seq3.nextval from dual; --�ݺ��ؼ� �����غ��� 
select seq1.currval, seq3.currval from dual;
commit;






