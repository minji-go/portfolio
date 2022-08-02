-- 관심상품
declare
    vMemberNum number;
    vItemNum number;
begin
   for i in 1..80 loop 
        select trunc(dbms_random.value(1,51)) as random_num into vMemberNum from dual;
        select trunc(dbms_random.value(1,51)) as random_num into vItemNum from dual;
        insert into tblLike values(seqLike.nextVal, vMemberNum, vItemNum );
    end loop;
end;



-- 장바구니
declare
    vMemberNum number;
    vFootSize number;
    vOptionNum number;
    vNum    number;
    vRandomNum number;
begin
    for i in 1..100 loop 
       
        begin
            select trunc(dbms_random.value(1,51)) as random_num into vMemberNum from dual;
            select footsize into vFootSize from tblMemberInfo where memberseq = vMemberNum; 
            select count(*) into vNum from (select seq from tblOption where itemseq < 41 and footsize = to_char(vFootSize));
            select trunc(dbms_random.value(1, vNum+1)) as random_num into vRandomNum from dual;
            select seq into vOptionNum from (select seq, rownum as rnum from tblOption where footsize = to_char(vFootSize)) where rnum = vRandomNum;
            insert into tblCart values(seqCart.nextVal, vMemberNum, vOptionNum);
            dbms_output.put_line('성공');
        exception 
            when NO_DATA_FOUND then DBMS_OUTPUT.PUT_LINE('Data 없음');
        end;
        
    end loop;
end;



-- 주문내역
--**** 배송비 무료배송인거 고치기!
--**** 날짜 고치기!
--**** 후에 주문결과가 생겼을 때 주문결과번호 바꾸기
create sequence seqOrder start with 72;
drop sequence seqOrder;


declare
    vMemberSeq number;
    vDate date;
    vAddress varchar2(120);
begin
    vMemberSeq := 1;

    for i in 20..50 loop  -- 반복횟수 수정하여 사용
        begin
--            select address into vAddress from tblAddress where memberseq = vMemberSeq and name = '집';
--            select address into vAddress from tblAddress where memberseq =  vMemberSeq and name = '회사';
            select address into vAddress from tblAddress where memberseq =  vMemberSeq and name = '본가';
             
            select to_date (round (dbms_random.value (1, 28))
                  || '-'
                  || round (dbms_random.value (1, 12))
                  || '-'
                  || round (dbms_random.value (2020, 2022)), 'DD-MM-YYYY') into vdate
            from dual;
            
            insert into tblOrder values(seqOrder.nextVal, vMemberSeq, vDate, vAddress, 2500);
            
            vMemberSeq := vMemberSeq + 1;  -- 회원번호 규칙 수정하여 사용
            
            exception when no_data_found then null;
        end;
        
    end loop;
end;



update tblOrder set orderdate = add_months
    ((select orderdate from tblOrder where orderdate > '2022-06-06' and rownum = 1), -6) 
        where orderdate > '2022-06-06' and rownum = 1;



-- 주문상품
declare
    vMemberSeq number;
    vRandomNum number;
    vRandomNum2 number;
    vRandomNum3 number;
    vOptionNum number;
    vOptionNum2 number;
    vOptionNum3 number;
    vPrice number;
    vPrice2 number;
    vPrice3 number;
begin

    for i in 72..77 loop  -- 주문번호로 수정하여 사용
        
        select memberSeq into vMemberSeq from tblOrder where seq = i;
        select trunc(dbms_random.value(1,60)) as random_num  into vRandomNum from dual;
        vRandomNum2 := vRandomNum + 20;
        vRandomNum3 := vRandomNum2 + 20;
        
        select seq into vOptionNum from (select seq, rownum as rnum from tblOption where footsize = (select to_char(footsize) from tblFootSize where memberseq= vMemberSeq)) where rnum = vRandomNum;
        select seq into vOptionNum2 from (select seq, rownum as rnum from tblOption where footsize = (select to_char(footsize) from tblFootSize where memberseq= vMemberSeq)) where rnum = vRandomNum2;
        select seq into vOptionNum3 from (select seq, rownum as rnum from tblOption where footsize = (select to_char(footsize) from tblFootSize where memberseq= vMemberSeq)) where rnum = vRandomNum3;
   
        select sellingPrice into vPrice from tblItem where seq = (select itemseq from tblOption where seq =  vOptionNum);
        select sellingPrice into vPrice2 from tblItem where seq = (select itemseq from tblOption where seq =  vOptionNum2);
        select sellingPrice into vPrice3 from tblItem where seq = (select itemseq from tblOption where seq =  vOptionNum3);
        
        insert into tblOrderItem values(i, vOptionNum, 1, 1, vPrice, 'N');
        insert into tblOrderItem values(i, vOptionNum2, 1, 1, vPrice2, 'N');
        insert into tblOrderItem values(i, vOptionNum3, 1, 1, vPrice3, 'N');
     
    end loop;
end;



-- 무료배송 수정
update tblOrder set shippingfee = 0 where seq in
(select orderseq from tblOrderItem
    group by orderseq
        having sum(unitprice*quantity) >= 50000);



-- 주문일을 상품 등록일 이후로 수정
select o.seq, o.orderdate, i.regdate from tblItem  i
    inner join tblOption p on i.seq = p.itemSeq
    inner join tblOrderItem t on p.seq = t.optionSeq
    inner join tblOrder o on o.seq = t.orderSeq
        where o.orderdate < i.regdate;


update tblOrder set orderdate = '21-04-26'
where seq in (
select o.seq from tblItem  i
    inner join tblOption p on i.seq = p.itemSeq
    inner join tblOrderItem t on p.seq = t.optionSeq
    inner join tblOrder o on o.seq = t.orderSeq
        where o.orderdate < i.regdate and i.regdate >= '20-04-19' and o.seq >= 0);



-- 결제내역
--(결제번호, 주문번호, 임금자명, 결제수단, 결제금액, 결제일, 비고)
//

declare
    vRandomNum number;
begin
    
    for k in 1..71 loop    
        select trunc(dbms_random.value(1,5)) as random_num into vRandomNum from dual;
        
        if vRandomNum < 4 then
         insert into tblPay
         select k, o.seq, m.name, '카드',
                (select sum(i.unitprice*i.quantity)+avg(o.shippingFee)
                    from tblOrderItem i 
                        inner join tblOrder o on i.orderseq = o.seq
                            group by o.seq
                                having o.seq = k),
                orderdate, '주문 결제' 
            from tblOrder o inner join tblMember m on o.memberseq = m.seq
                where o.seq = k;
          
        else 
            insert into tblPay
            select k, o.seq, m.name, '무통장 입금',
                (select sum(i.unitprice*i.quantity)+avg(o.shippingFee)
                    from tblOrderItem i 
                        inner join tblOrder o on i.orderseq = o.seq
                            group by o.seq
                                having o.seq = k),
                orderdate, '주문 결제' 
            from tblOrder o inner join tblMember m on o.memberseq = m.seq
                where o.seq = k;
        end if;
        
     end loop;       
end;