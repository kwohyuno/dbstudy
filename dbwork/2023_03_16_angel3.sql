--PLSQL 연습용 테이블과 연습용 시퀀스 생성 
create SEQUENCE seq_test nocache; --1부터 1씩 증가하는 시퀀스 (cache size : 0 ) 
create table shop(
    num number(3) CONSTRAINT shop_pk_num PRIMARY key,
    sangpum varchar2(30),
    su number(7),
    dan number(7),
    today date
);

--기본 데이타 5개 정도만 추가
insert into shop values (seq_test.nextval, '청바지', 2, 19000, sysdate);
insert into shop values (seq_test.nextval, '동바지', 1, 19000, sysdate);
insert into shop values (seq_test.nextval, '백바지', 1, 23000, sysdate);
insert into shop values (seq_test.nextval, '티셔츠', 3, 27000, sysdate);
insert into shop values (seq_test.nextval, '블라우스', 2, 32000, sysdate);
commit;

--PL-SQL : SQL 언어에 절차적 요소를 추가해서 프로그래밍 한 것을 PLSQ이라고 한다 
--형식
--DECLARE
--변수선언
--BEGIN
--각종 출력 또는 로직들
--DBMS_OUTPUT.PUT_LINE();    --한줄출력 명령어(자바 println같은거) 
--END;

--set serveroutput off -- 콘솔창에서 결과값 나오게 하기 (기본이 off)
--set serveroutput on

DECLARE
	v_no number(4,1); --4자리숫자, 소숫점자리 1자리
BEGIN
    v_no:=10; --값 대입         
	DBMS_OUTPUT.PUT_LINE('숫자는 '||v_no||'입니다');  --출력     
END;
/

--shop 테이블에서 특정 상품 정보 얻어오기 
DECLARE
    v_sangpum varchar2(30);
    v_su number(3);
    v_dan number(7);
    v_num number(3):=1; --검색해서 가져올 num값 
BEGIN
    select sangpum,su,dan
    into v_sangpum,v_su,v_dan
    from shop where num=3;
    
	DBMS_OUTPUT.PUT_LINE(v_num||'번 상품설명'); 
    DBMS_OUTPUT.PUT_LINE('상품명: '||v_sangpum); 
    DBMS_OUTPUT.PUT_LINE('수량: '||v_su); 
    DBMS_OUTPUT.PUT_LINE('단가: '||v_dan); 
    DBMS_OUTPUT.PUT_LINE('총금액: '||v_su*v_dan); 
END;
/


--위의 코드를 수정해서 상품명으로 검색해서 데이타를 출력하시오 
DECLARE
    v_sangpum varchar2(30):='청바지'; --검색해서 가져올 상품명 
    v_su number(3);
    v_dan number(7);
    v_num number(3); 
BEGIN
    select num,su,dan
    into v_num,v_su,v_dan
    from shop where sangpum=v_sangpum;
	
    DBMS_OUTPUT.PUT_LINE(v_sangpum||'상품설명'); 
    DBMS_OUTPUT.PUT_LINE('시퀀스값 :'||v_num); 
    DBMS_OUTPUT.PUT_LINE('수량: '||v_su); 
    DBMS_OUTPUT.PUT_LINE('단가: '||v_dan); 
    DBMS_OUTPUT.PUT_LINE('총금액: '||v_su*v_dan); 
END;
/

--조건문
/*
단일 조건문 
    if 조건식 then 
        문장1;
    else
        문장2;
    end if; 

다중 조건문
    if 조건식1 then 
        문장1; 
    elsif 조건식2 then
        문장2; 
    ......
    end if; 
*/


accept k_year prompt '년도 4자리를 입력해주세요';
DECLARE
    v_year number(4):=2023;
    v_mod number(2):=mod(v_year,12); --년도를 12로 나눈 나머지 
    v_ddi varchar2(10); --띠를 구해서 저장 
BEGIN
    if v_mod=0 then v_ddi:='원숭이';
    elsif v_mod=1 then v_ddi:='닭';
    elsif v_mod=2 then v_ddi:='개';
    elsif v_mod=3 then v_ddi:='돼지';
    elsif v_mod=4 then v_ddi:='쥐';
    elsif v_mod=5 then v_ddi:='소';
    elsif v_mod=6 then v_ddi:='호랑이';
    elsif v_mod=7 then v_ddi:='토끼';
    elsif v_mod=8 then v_ddi:='용';
    elsif v_mod=9 then v_ddi:='뱀';
    elsif v_mod=10 then v_ddi:='소';
    else v_ddi:='양';
	DBMS_OUTPUT.PUT_LINE(v_year||'년생은 '||v_ddi||'띠입니다'); 
END;
/


--특정년도가 무슨띠인지 구하기
--년도를 키보드로 입력받아서 띠를 알아볼 수 있도록 수정하기 
DECLARE
    v_year number(4):='&k_year';--키보드로 입력받은 accept 변수를 멤버변수에 대입 
    v_mod number(2):=mod(v_year,12); --년도를 12로 나눈 나머지 
    v_ddi varchar2(10); --띠를 구해서 저장 
BEGIN
    if v_mod=0 then v_ddi:='원숭이';
    elsif v_mod=1 then v_ddi:='닭';
    elsif v_mod=2 then v_ddi:='개';
    elsif v_mod=3 then v_ddi:='돼지';
    elsif v_mod=4 then v_ddi:='쥐';
    elsif v_mod=5 then v_ddi:='소';
    elsif v_mod=6 then v_ddi:='호랑이';
    elsif v_mod=7 then v_ddi:='토끼';
    elsif v_mod=8 then v_ddi:='용';
    elsif v_mod=9 then v_ddi:='뱀';
    elsif v_mod=10 then v_ddi:='소';
    else v_ddi:='양';
	DBMS_OUTPUT.PUT_LINE(v_year||'년생은 '||v_ddi||'띠입니다'); 
END;
/

--숫자를 입력받아 12입력시 12는 짝수입니다. 11 입력시 11은 홀수입니다 라고 출력 
accept k_su prompt '숫자를 입력해주세요';
DECLARE
    v_su number(5):='&k_su';--키보드로 입력받은 accept 변수를 멤버변수에 대입 
BEGIN
     if mod(v_su,2)=0 then 
       DBMS_OUTPUT.PUT_LINE(v_su||'는 짝수입니다');
     else 
      DBMS_OUTPUT.PUT_LINE(v_su||'는 홀수입니다');
     end if; 
END;
/


accept k_dan prompt '구구단 숫자를 입력해주세요';
DECLARE
    v_dan number(3):='&k_dan';
    v_idx number(1):=1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('** [*||v_dan||'단]**');
    
    loop
        DBMS_OUTPUT.PUT_LINE(v_dan||'x'||v_idx||'='||v_dan*v_idx);
        v_idx:v_idx+1;
        exit when v_idx>9;
    end loop;
END;
/




/*
    또 다른 조건문 case
    
    변수:=
        case 표현식
            when 값1 then 결과1
            when 값2 ten 결과2
            wehn 값3 then 결과3 
            else 결과4
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
        DBMS_OUTPUT.PUT_LINE(v_grade||'학점은 '||v_msg); 
END;
/



--exception 처리
DECLARE
    v_sangpum varchar2(30):='&k_sang'; --키보드로 입력시 가져올 상품명
    v_su number(3);
    v_dan number(7);
    v_num number(3); 
BEGIN
    select num,su,dan
    into v_num,v_su,v_dan
    from shop where sangpum=v_sangpum;
	
    DBMS_OUTPUT.PUT_LINE(v_sangpum||'상품설명'); 
    DBMS_OUTPUT.PUT_LINE('시퀀스값 :'||v_num); 
    DBMS_OUTPUT.PUT_LINE('수량: '||v_su); 
    DBMS_OUTPUT.PUT_LINE('단가: '||v_dan); 
    DBMS_OUTPUT.PUT_LINE('총금액: '||v_su*v_dan); 

    --오라클에서 예외 처리하는 방법 
    exception
     when NO_DATA_FOUND then 
       DBMS_OUTPUT.PUT_LINE(v_sangpum||' 상품은 DB에 없어요!!');
     when TOO_MANY_ROWS then
       DBMS_OUTPUT.PUT_LINE(v_sangpum||'상품이 여러개 있어요!!');
     when OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('어쨌든 예외 발생함!!!');
END;
/

--shop 테이블 수정 
--shop 테이블에 color 컬럼을 추가하고 기본색을 'GREEN'
ALTER TABLE SHOP ADD COLOR VARCHAR2(20) DEFAULT 'GREEN';
--3번은 PINK로 수정, 5번은 YELLOW로 수정 
UPDATE SHOP SET COLOR='PINK' WHERE NUM=3;
UPDATE SHOP SET COLOR='YELLOW' WHERE NUM=5;
--데이타 추가: 중복된 상품명도 넣어보세요
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'블라우스',1,19000,SYSDATE,'ORANGE');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'반바지',3,34000,SYSDATE,'BLUE');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'레이스티셔츠',4,7000,SYSDATE,'GRAY');
INSERT INTO SHOP VALUES (SEQ_TEST.NEXTVAL,'찢어진청바지',2,99000,SYSDATE,'DARKBLUE');
COMMIT;


/*
    FOR 반복문
    for 변수명 in [reverse] 시작값..최종값 loop
        문장들; 
    end loop;
*/ 



--이거는 오타가 없는지 잘 작동됩니다 (현오) 
DECLARE
    v_bdan number(5) := '&k_dan';
    v_num number(2);
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_bdan||'단');
    for v_num in 1..9 loop
        DBMS_OUTPUT.PUT_LINE(v_bdan||'x'||v_num||'='||v_bdan*v_num);
    end loop;
END;
/
    

--db의 타입을 적용하는 방법
--db의 데이타를 레코드 단위로 가져오는 방법
DECLARE
	v_sang shop.sangpum%type :='티셔츠'; --db의 sangpum 타입을 적용 
    v_shop angel.shop%rowtype; --레코드단위로 데이타 읽기위한 선언 
BEGIN
    select *
    into v_shop
    from shop
    where sangpum=v_sang;
    
	DBMS_OUTPUT.PUT_LINE('상품명:'||v_shop.sangpum); 
    DBMS_OUTPUT.PUT_LINE('색상:'||v_shop.color); 
    DBMS_OUTPUT.PUT_LINE('수량:'||v_shop.su); 
    DBMS_OUTPUT.PUT_LINE('단가:'||v_shop.dan); 
    DBMS_OUTPUT.PUT_LINE('구입일:'||v_shop.today); 
END;




/*
    여러 레코드 조회시
    Cursor 커서명 
    is
    select 문장; --select 조회의 결과를 Cursor에 저장 
    
    for 레코드명 in 커서명 loop
      명령;
    end loop;

    
*/


--shop 전체 데이타 출력    // 이것도 오류가 없는지 잘 돌아감 
DECLARE
	CURSOR s1
    is
    select * from shop order by dan desc; 
    
    v_cnt number(5);
    
BEGIN
	DBMS_OUTPUT.PUT_LINE('번호    상품명    색상    수량    단가  구입일');
     for s in s1 loop
        DBMS_OUTPUT.PUT_LINE(s.num||'   '||s.sangpum||'   '
           ||s.color||'    '||s.su||'   '||s.dan||'   '||s.today);
     end loop;
     
     select count(*) into v_cnt from shop;
     DBMS_OUTPUT.PUT_LINE('총 '||v_cnt||'개의 상품이 있습니다');
END;
/

/*
    키보드로 상품명 일부를 입력받아 해당 상품들을 출력하시오
    
    만약 상품명을 '바지'라고 입력시 
    총 4개의 상품이 있습니다 
    
    상품명: 청바지
    색상 : yellow
    단가 : 23000
    
    상품명 : 반바지
    색상 : green
    단가 : 37000
    .
    .
    .
    만약 없을경우
    바지 상품은 목록에 없습니다 

*/



DECLARE
    v_search shop.sangpum%type := '&sang';
    CURSOR s1
    is
    select * from shop where sangpum like '%'||v_search||'%';
    v_cnt number(5);
BEGIN
    --일단 검색어가 포함된 상품 갯수부터 구하기
    select count(*) into v_cnt from shop where sangpum like '%'||V_search||'%';
    
    if v_cnt=0 then
        DBMS_OUTPUT.PUT_LINE(v_search||' 상품은 목록에 없습니다');
    else
        DBMS_OUTPUT.PUT_LINE('총 '||v_cnt||'개의 상품이 있습니다');
        
        for s in s1 loop
            DBMS_OUTPUT.PUT_LINE('상품명 :'||s.sangpum);
            DBMS_OUTPUT.PUT_LINE('색상 :'||s.color);
            DBMS_OUTPUT.PUT_LINE('단가 :'||TRIM(to_char(s.dan,'L999,999')));
            DBMS_OUTPUT.PUT_LINE('-----------------');
        end loop;
    end if;
END;
/

