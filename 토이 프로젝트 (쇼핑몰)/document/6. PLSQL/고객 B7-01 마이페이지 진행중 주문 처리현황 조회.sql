--B7-마이페이지
--B7-01. 주문 (진행중)처리 현황
--      : procOrdering(진행중 주문내역을 조회할 회원번호);


-- ansi-sql view 생성
create or replace view vwOrdering
as
select
    o.seq as "주문번호",
    oi.resultSeq as "주문구분",
    m.seq as "회원번호",
    i.name as "상품명",
    c.name as "색상",
    op.footsize as "사이즈",
    op.heel || 'cm' as "굽높이",
    p.paydate as "결제일",
    m.name as "수령인 이름",
    m.tel as "수령인 전화번호",
    o.address as "배송지",
    case
        when (select processed from tblOrderItem where orderSeq = o.seq group by processed) = 'N' then '결제완료'
        when (select count(*) from tblShippingItem where orderSeq = o.seq) = 0 then '배송준비중'
        when (select count(*) from tblShippingItem where orderSeq = o.seq) <> 0
                and
             (select s.enddate from tblShippingItem si inner join tblShipping s on si.shippingSeq = s.seq where orderSeq = o.seq group by s.enddate) is null
                then '배송중'
        when (select s.enddate from tblShippingItem si inner join tblShipping s on si.shippingSeq = s.seq where orderSeq = o.seq group by s.enddate) is not null
                then '배송완료'
    end as "처리현황"

from tblOrderItem oi
    inner join tblOrder o on oi.orderSeq = o.seq
    inner join tblOption op on oi.optionSeq = op.seq
    inner join tblColor c on op.colorSeq = c.seq
    inner join tblItem i on op.itemseq = i.seq    
    inner join tblPay p on p.orderSeq = o.seq
    inner join tblMember m on m.seq = o.memberSeq;
    


--view + 프로시저
create or replace procedure procOrdering (
    pMemberSeq number
)
is
    cursor vcursor
    is
    select * from vwOrdering where "주문구분" = 1 and "회원번호" = pMemberSeq;
    vrow vwOrdering%rowtype;
    voseq tblOrder.seq%type;
    vflag number;
begin

    vflag := 1;
    open vcursor;
        loop 
            fetch vcursor into vrow;
            exit when vcursor%notfound;
            
            if (vflag = 1) then
                dbms_output.put_line('-------------' || vrow."수령인 이름" || ' 님의 진행 중 주문 -------------');
                dbms_output.put_line('');
                dbms_output.put_line('[주문 정보] ' || vrow."주문번호" || '번 주문(' || vrow."결제일" || ') ▷▷▷ ' || vrow."처리현황");
                dbms_output.put_line('');
                dbms_output.put_line('[배송 정보] ' || vrow."수령인 이름" || '(' || vrow."수령인 전화번호" || ', ' || vrow."배송지" || ')');
                dbms_output.put_line('');
                dbms_output.put_line('[상품 정보] <상품명 / 색상 / 사이즈 / 굽높이>');
                voseq := vrow."주문번호";
                vflag := 0;
            end if;
            
            if (vrow."주문번호" = voseq) then
                dbms_output.put_line('            ' || vrow."상품명" || ' / ' || vrow."색상" || ' / ' || vrow."사이즈" || ' / ' || vrow."굽높이");
            end if;
            
        end loop;
    close vcursor;
        dbms_output.put_line('');
        if (vflag = 1) then
            dbms_output.put_line('---------------------------------------------------');
            dbms_output.put_line('          진행중인 주문 내역이 없습니다.');
        end if;
        dbms_output.put_line('---------------------------------------------------');
end;



-- 프로시저 실행
-- procOrdering(진행중 주문내역을 조회할 회원번호);

begin
    procOrdering(37);
end;



-- B7-00 주문진행상태
create or replace procedure procOrderProcess (
    pmemberSeq in number,
    ppaid out number,
    pready out number,
    pdelivering out number,
    pdelivered out number,
    prefund out number
)
is
begin
    select
        count(case
        when  os.name not in ('취소', '교환', '반품') and oi.processed = 'N' and p.note = '주문 결제' then '1'
        end) as paid,
        count(case
        when  os.name not in ('취소', '교환', '반품') and  s.begindate is null and oi.processed = 'Y' then '1'
        end) as ready,
        count(case
        when  os.name not in ('취소', '교환', '반품') and s.begindate is not null and s.enddate is null then '1'
        end) as delivering,
        count(case
        when os.name not in ('취소', '교환', '반품') and s.enddate is not null then '1'
        end) as delivered,
        count(case
        when os.name in ('취소', '교환', '반품') and (p.note = '주문 결제' or p.note is null) then '1'
        end) as refund
        into ppaid, pready, pdelivering, pdelivered, prefund
    from tblOrderItem oi
        inner join tblOrder o on oi.orderSeq = o.seq
        inner join tblOrderResult os on oi.resultseq = os.seq
        left outer join tblPay p on o.seq = p.orderseq
        left outer join tblShippingItem si on oi.orderseq = si.orderseq and oi.optionseq = si.optionseq
        left outer join tblShipping s on si.shippingSeq = s.seq 
            where orderdate > add_months(sysdate, -3) and memberseq = pmemberseq;
end;

-- 프로시저 실행
declare
    ppaid number;
    pready number;
    pdelivering number;
    pdelivered number;
    prefund number;
begin
    procOrderProcess(회원번호, ppaid, pready, pdelivering, pdelivered, prefund);
    dbms_output.put_line(ppaid ||' '||pready||' '||pdelivering||' '||pdelivered||' '||prefund);
end;

