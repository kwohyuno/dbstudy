--PLSQL ������ ���̺�� ������ ������ ���� 
create SEQUENCE seq_test nocache; --1���� 1�� �����ϴ� ������ (cache size : 0 ) 
create table shop(
    num number(3) CONSTRAINT shop_pk_num PRIMARY key,
    sangpum varchar2(30),
    su number(7),
    dan number(7),
    today date
);

--�⺻ ����Ÿ 5�� ������ �߰�
insert into shop values (seq_test.nextval, 'û����', 2, 19000, sysdate);
insert into shop values (seq_test.nextval, '������', 1, 19000, sysdate);
insert into shop values (seq_test.nextval, '�����', 1, 23000, sysdate);
insert into shop values (seq_test.nextval, 'Ƽ����', 3, 27000, sysdate);
insert into shop values (seq_test.nextval, '���콺', 2, 32000, sysdate);
commit;

--PL-SQL : SQL �� ������ ��Ҹ� �߰��ؼ� ���α׷��� �� ���� PLSQ�̶�� �Ѵ� 
--����
--DECLARE
--��������
--BEGIN
--���� ��� �Ǵ� ������
--DBMS_OUTPUT.PUT_LINE();    --������� ��ɾ�(�ڹ� println������) 
--END;

--set serveroutput off -- �ܼ�â���� ����� ������ �ϱ� (�⺻�� off)
--set serveroutput on

DECLARE
	v_no number(4,1); --4�ڸ�����, �Ҽ����ڸ� 1�ڸ�
BEGIN
    v_no:=10; --�� ����         
	DBMS_OUTPUT.PUT_LINE('���ڴ� '||v_no||'�Դϴ�');  --���     
END;
/

--shop ���̺��� Ư�� ��ǰ ���� ������ 
DECLARE
    v_sangpum varchar2(30);
    v_su number(3);
    v_dan number(7);
    v_num number(3):=1; --�˻��ؼ� ������ num�� 
BEGIN
    select sangpum,su,dan
    into v_sangpum,v_su,v_dan
    from shop where num=3;
    
	DBMS_OUTPUT.PUT_LINE(v_num||'�� ��ǰ����'); 
    DBMS_OUTPUT.PUT_LINE('��ǰ��: '||v_sangpum); 
    DBMS_OUTPUT.PUT_LINE('����: '||v_su); 
    DBMS_OUTPUT.PUT_LINE('�ܰ�: '||v_dan); 
    DBMS_OUTPUT.PUT_LINE('�ѱݾ�: '||v_su*v_dan); 
END;
/


--���� �ڵ带 �����ؼ� ��ǰ������ �˻��ؼ� ����Ÿ�� ����Ͻÿ� 
DECLARE
    v_sangpum varchar2(30):='û����'; --�˻��ؼ� ������ ��ǰ�� 
    v_su number(3);
    v_dan number(7);
    v_num number(3); 
BEGIN
    select num,su,dan
    into v_num,v_su,v_dan
    from shop where sangpum=v_sangpum;
	
    DBMS_OUTPUT.PUT_LINE(v_sangpum||'��ǰ����'); 
    DBMS_OUTPUT.PUT_LINE('�������� :'||v_num); 
    DBMS_OUTPUT.PUT_LINE('����: '||v_su); 
    DBMS_OUTPUT.PUT_LINE('�ܰ�: '||v_dan); 
    DBMS_OUTPUT.PUT_LINE('�ѱݾ�: '||v_su*v_dan); 
END;
/

--���ǹ�
/*
���� ���ǹ� 
    if ���ǽ� then 
        ����1;
    else
        ����2;
    end if; 

���� ���ǹ�
    if ���ǽ�1 then 
        ����1; 
    elsif ���ǽ�2 then
        ����2; 
    ......
    end if; 
*/


accept k_year prompt '�⵵ 4�ڸ��� �Է����ּ���';
DECLARE
    v_year number(4):=2023;
    v_mod number(2):=mod(v_year,12); --�⵵�� 12�� ���� ������ 
    v_ddi varchar2(10); --�츦 ���ؼ� ���� 
BEGIN
    if v_mod=0 then v_ddi:='������';
    elsif v_mod=1 then v_ddi:='��';
    elsif v_mod=2 then v_ddi:='��';
    elsif v_mod=3 then v_ddi:='����';
    elsif v_mod=4 then v_ddi:='��';
    elsif v_mod=5 then v_ddi:='��';
    elsif v_mod=6 then v_ddi:='ȣ����';
    elsif v_mod=7 then v_ddi:='�䳢';
    elsif v_mod=8 then v_ddi:='��';
    elsif v_mod=9 then v_ddi:='��';
    elsif v_mod=10 then v_ddi:='��';
    else v_ddi:='��';
	DBMS_OUTPUT.PUT_LINE(v_year||'����� '||v_ddi||'���Դϴ�'); 
END;
/


--Ư���⵵�� ���������� ���ϱ�
--�⵵�� Ű����� �Է¹޾Ƽ� �츦 �˾ƺ� �� �ֵ��� �����ϱ� 
DECLARE
    v_year number(4):='&k_year';--Ű����� �Է¹��� accept ������ ��������� ���� 
    v_mod number(2):=mod(v_year,12); --�⵵�� 12�� ���� ������ 
    v_ddi varchar2(10); --�츦 ���ؼ� ���� 
BEGIN
    if v_mod=0 then v_ddi:='������';
    elsif v_mod=1 then v_ddi:='��';
    elsif v_mod=2 then v_ddi:='��';
    elsif v_mod=3 then v_ddi:='����';
    elsif v_mod=4 then v_ddi:='��';
    elsif v_mod=5 then v_ddi:='��';
    elsif v_mod=6 then v_ddi:='ȣ����';
    elsif v_mod=7 then v_ddi:='�䳢';
    elsif v_mod=8 then v_ddi:='��';
    elsif v_mod=9 then v_ddi:='��';
    elsif v_mod=10 then v_ddi:='��';
    else v_ddi:='��';
	DBMS_OUTPUT.PUT_LINE(v_year||'����� '||v_ddi||'���Դϴ�'); 
END;
/

--���ڸ� �Է¹޾� 12�Է½� 12�� ¦���Դϴ�. 11 �Է½� 11�� Ȧ���Դϴ� ��� ��� 
accept k_su prompt '���ڸ� �Է����ּ���';
DECLARE
    v_su number(5):='&k_su';--Ű����� �Է¹��� accept ������ ��������� ���� 
BEGIN
     if mod(v_su,2)=0 then 
       DBMS_OUTPUT.PUT_LINE(v_su||'�� ¦���Դϴ�');
     else 
      DBMS_OUTPUT.PUT_LINE(v_su||'�� Ȧ���Դϴ�');
     end if; 
END;
/


accept k_dan prompt '������ ���ڸ� �Է����ּ���';
DECLARE
    v_dan number(3):='&k_dan';
    v_idx number(1):=1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('** [*||v_dan||'��]**');
    
    loop
        DBMS_OUTPUT.PUT_LINE(v_dan||'x'||v_idx||'='||v_dan*v_idx);
        v_idx:v_idx+1;
        exit when v_idx>9;
    end loop;
END;
/




/*
    �� �ٸ� ���ǹ� case
    
    ����:=
        case ǥ����
            when ��1 then ���1
            when ��2 ten ���2
            wehn ��3 then ���3 
            else ���4
        end;
*/

DECLARE
	v_grade char(1) := 'B';
    v_msg varchar2(15);
BEGIN
    v_msg :=
        case v_grade
            when 'A' then 'Excellent!!'
            when 'B' then 'Very Good!!'
            when 'C' then 'Good!!'
            else 'Try!'
        end;
        DBMS_OUTPUT.PUT_LINE(v_grade||'������ '||v_msg); 
END;
/



--exception ó��
DECLARE
    v_sangpum varchar2(30):='&k_sang'; --Ű����� �Է½� ������ ��ǰ��
    v_su number(3);
    v_dan number(7);
    v_num number(3); 
BEGIN
    select num,su,dan
    into v_num,v_su,v_dan
    from shop where sangpum=v_sangpum;
	
    DBMS_OUTPUT.PUT_LINE(v_sangpum||'��ǰ����'); 
    DBMS_OUTPUT.PUT_LINE('�������� :'||v_num); 
    DBMS_OUTPUT.PUT_LINE('����: '||v_su); 
    DBMS_OUTPUT.PUT_LINE('�ܰ�: '||v_dan); 
    DBMS_OUTPUT.PUT_LINE('�ѱݾ�: '||v_su*v_dan); 

    --����Ŭ���� ���� ó���ϴ� ��� 
    exception
     when NO_DATA_FOUND then 
       DBMS_OUTPUT.PUT_LINE(v_sangpum||' ��ǰ�� DB�� �����!!');
     when TOO_MANY_ROWS then
       DBMS_OUTPUT.PUT_LINE(v_sangpum||'��ǰ�� ������ �־��!!');
     when OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('��·�� ���� �߻���!!!');
END;
/

--shop ���̺� ���� 
--shop ���̺� color �÷��� �߰��ϰ� �⺻���� 'GREEN'
ALTER TABLE SHOP ADD COLOR VARCHAR2(20) DEFAULT 'GREEN';
--3���� PINK�� ����, 5���� YELLOW�� ���� 
UPDATE SHOP SET COLOR='PINK' WHERE NUM=3;
UPDATE SHOP SET COLOR='YELLOW' WHERE NUM=5;
--����Ÿ �߰�: �ߺ��� ��ǰ�� �־����
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'���콺',1,19000,SYSDATE,'ORANGE');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'�ݹ���',3,34000,SYSDATE,'BLUE');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'���̽�Ƽ����',4,7000,SYSDATE,'GRAY');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'������û����',2,99000,SYSDATE,'DARKBLUE');
COMMIT;


/*
    FOR �ݺ���
    for ������ in [reverse] ���۰�..������ loop
        �����; 
    end loop;
*/ 



--�̰Ŵ� ��Ÿ�� ������ �� �۵��˴ϴ� (����) 
DECLARE
    v_bdan number(5) := '&k_dan';
    v_num number(2);
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_bdan||'��');
    for v_num in 1..9 loop
        DBMS_OUTPUT.PUT_LINE(v_bdan||'x'||v_num||'='||v_bdan*v_num);
    end loop;
END;
/
    

--db�� Ÿ���� �����ϴ� ���
--db�� ����Ÿ�� ���ڵ� ������ �������� ���
DECLARE
	v_sang shop.sangpum%type :='Ƽ����'; --db�� sangpum Ÿ���� ���� 
    v_shop angel.shop%rowtype; --���ڵ������ ����Ÿ �б����� ���� 
BEGIN
    select *
    into v_shop
    from shop
    where sangpum=v_sang;
    
	DBMS_OUTPUT.PUT_LINE('��ǰ��:'||v_shop.sangpum); 
    DBMS_OUTPUT.PUT_LINE('����:'||v_shop.color); 
    DBMS_OUTPUT.PUT_LINE('����:'||v_shop.su); 
    DBMS_OUTPUT.PUT_LINE('�ܰ�:'||v_shop.dan); 
    DBMS_OUTPUT.PUT_LINE('������:'||v_shop.today); 
END;




/*
    ���� ���ڵ� ��ȸ��
    Cursor Ŀ���� 
    is
    select ����; --select ��ȸ�� ����� Cursor�� ���� 
    
    for ���ڵ�� in Ŀ���� loop
      ���;
    end loop;

    
*/


--shop ��ü ����Ÿ ���    // �̰͵� ������ ������ �� ���ư� 
DECLARE
	CURSOR s1
    is
    select * from shop order by dan desc; 
    
    v_cnt number(5);
    
BEGIN
	DBMS_OUTPUT.PUT_LINE('��ȣ    ��ǰ��    ����    ����    �ܰ�  ������');
     for s in s1 loop
        DBMS_OUTPUT.PUT_LINE(s.num||'   '||s.sangpum||'   '
           ||s.color||'    '||s.su||'   '||s.dan||'   '||s.today);
     end loop;
     
     select count(*) into v_cnt from shop;
     DBMS_OUTPUT.PUT_LINE('�� '||v_cnt||'���� ��ǰ�� �ֽ��ϴ�');
END;
/

/*
    Ű����� ��ǰ�� �Ϻθ� �Է¹޾� �ش� ��ǰ���� ����Ͻÿ�
    
    ���� ��ǰ���� '����'��� �Է½� 
    �� 4���� ��ǰ�� �ֽ��ϴ� 
    
    ��ǰ��: û����
    ���� : yellow
    �ܰ� : 23000
    
    ��ǰ�� : �ݹ���
    ���� : green
    �ܰ� : 37000
    .
    .
    .
    ���� �������
    ���� ��ǰ�� ��Ͽ� �����ϴ� 

*/



DECLARE
    v_search shop.sangpum%type := '&sang';
    CURSOR s1
    is
    select * from shop where sangpum like '%'||v_search||'%';
    v_cnt number(5);
BEGIN
    --�ϴ� �˻�� ���Ե� ��ǰ �������� ���ϱ�
    select count(*) into v_cnt from shop where sangpum like '%'||V_search||'%';
    
    if v_cnt=0 then
        DBMS_OUTPUT.PUT_LINE(v_search||' ��ǰ�� ��Ͽ� �����ϴ�');
    else
        DBMS_OUTPUT.PUT_LINE('�� '||v_cnt||'���� ��ǰ�� �ֽ��ϴ�');
        
        for s in s1 loop
            DBMS_OUTPUT.PUT_LINE('��ǰ�� :'||s.sangpum);
            DBMS_OUTPUT.PUT_LINE('���� :'||s.color);
            DBMS_OUTPUT.PUT_LINE('�ܰ� :'||TRIM(to_char(s.dan,'L999,999')));
            DBMS_OUTPUT.PUT_LINE('-----------------');
        end loop;
    end if;
END;
/

