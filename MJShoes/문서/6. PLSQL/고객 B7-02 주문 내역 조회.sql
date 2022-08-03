--B7-02. 주문 내역 조회
--      : 로그인한 아이디로 조회할 수 있는 모든 주문 내역을 주문일자와 함께 출력
--          procOrderLoginID('로그인 아이디', '로그인 비밀번호');
--      : 주문번호로 하나를 선택하면 상세 정보 출력(상품 정보 및 옵션, 수량, 결제 금액, 처리 상태(구매확정/취소/교환/반품))  
--          procOrderDetail('로그인 아이디', '로그인 비밀번호', 해당 아이디로 주문한 주문번호);





--      : 로그인한 아이디로 조회할 수 있는 모든 주문 내역을 주문일자와 함께 출력
-- ansi-sql view 생성

create or replace view vwOrderLoginID
as
select
    m.id as "아이디",
    m.pw as "비밀번호",
    m.name as "이름",
    o.seq as "주문번호",
    o.memberSeq as "회원번호",
    o.orderDate as "주문일",
    o.address as "배송지",
    o.shippingFee as "배송비"
from tblOrder o inner join tblMember m on o.memberseq = m.seq order by o.seq;

-- view + 프로시저 생성

create or replace procedure procOrderLoginID (
    pid varchar2,
    ppw varchar2
)
is
    cursor vcursor
    is
    select * from vwOrderLoginID where "아이디" = pid and "비밀번호" = ppw;
    vrow vwOrderLoginID%rowtype;
    vname tblMember.name%type;
    vindex number;
    vspace varchar2(3);
begin
    
    select name into vname from tblMember where id = pid and pw = ppw;

    vindex := 0;
    
    open vcursor;
    loop 
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        vspace := '';
        
        if (vindex = 0) then     
            dbms_output.put_line('-------------- ' || vrow."이름" || '(회원번호 ' || vrow."회원번호" || ') 님의 주문 내역입니다. --------------');
            dbms_output.put_line('');
            dbms_output.put_line('[주문번호]    주문일     배송비    배송지');
            vindex := 1;
        end if;
        
        if (vrow."주문번호" < 10) then
            vspace := ' ';
        end if;
        
        dbms_output.put_line('       ' || vspace || vrow."주문번호" || '     ' || vrow."주문일" || '        ' || vrow."배송비" || '    ' || vrow."배송지");
    end loop;
    
    if (vindex = 0) then
        dbms_output.put_line('------------------------------------------------------------');
        dbms_output.put_line('');
        dbms_output.put_line('                 주문 내역이 없습니다.');
    end if;
    dbms_output.put_line('');
    dbms_output.put_line('----------------------------------------------------------------------');    
    
    close vcursor;
exception
    when others then
        dbms_output.put_line('--------------------------------');
        dbms_output.put_line(' ID 혹은 PW를 찾을 수 없습니다.');
        dbms_output.put_line('--------------------------------');
end;



-- 프로시저 실행

begin
    procOrderLoginID('sineob7', 'CkwPPWmoME%');
end;







--      : 주문번호로 하나를 선택하면 상세 정보 출력(상품 정보 및 옵션, 수량, 결제 금액, 처리 상태(구매확정/취소/교환/반품)) 
-- ansi-sql view 생성

create or replace view vwOrderDetail
as
select
    o.seq as "주문번호",
    o.memberSeq as "회원번호",
    i.name as "상품명",
    c.name as "색상",
    op.footsize as "사이즈",
    op.heel || 'cm' as "굽높이",
    oi.quantity as "수량",
    oi.unitprice as "결제 금액",
    ore.name as "처리 상태"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderSeq
    inner join tblOption op on oi.optionSeq = op.seq
    inner join tblItem i on op.itemSeq = i.seq
    inner join tblColor c on op.colorSeq = c.seq
    inner join tblOrderResult ore on oi.resultSeq = ore.seq;
    
    
-- view + 프로시저
create or replace procedure procOrderDetail (
    pid varchar2,
    ppw varchar2,
    porderSeq number
)
is
    cursor vcursor
    is
    select * from vwOrderDetail where "주문번호" = porderSeq and "회원번호" = (select seq from tblMember where id = pid and pw = ppw);
    vrow vwOrderDetail%rowtype;
    vflag number;
    vindex number;
begin

    vflag := 1;
    vindex := 1;
    
    open vcursor;
        loop
            fetch vcursor into vrow;
            exit when vcursor%notfound;
            
            if (vflag = 1) then
                dbms_output.put_line('-------------- ' || vrow."주문번호" || '번 주문 상세 내역입니다. --------------');
                dbms_output.put_line('');
            end if;
            
            dbms_output.put_line(' [' || vindex || '] ' || vrow."상품명" || ': ' || vrow."색상" || ' / ' || vrow."사이즈" || ' / 굽 ' || vrow."굽높이");
            dbms_output.put_line('                        ' || vrow."수량" || '켤레, ￦' || vrow."결제 금액" * vrow."수량" || ' ▷▷ ' || vrow."처리 상태");
            dbms_output.put_line('');
            vindex := vindex + 1;
            vflag := vflag + 1;
            
        end loop;
    close vcursor;
    if (vindex = 1) then
        dbms_output.put_line('--------------------------------------------------------');
        dbms_output.put_line('');
        dbms_output.put_line('          주문내역 조회에 실패했습니다.');
        dbms_output.put_line('');
    end if;
    dbms_output.put_line('--------------------------------------------------------');
end;



-- 프로시저 실행
--

begin
    procOrderDetail('hbtqayxe3', 'mDJsjtKohqm%', 81);
end;