-->>>>>>>>>>>>>>>>>>>>> B-04 장바구니
-- 목록조회
create or replace procedure procListCart(
    pMemberSeq in number,
    pCursor out sys_refcursor,
    pTotalPrice out number,
    pShippingFee out number
)
is
begin   
    open pCursor for
    select 
        i.name as 상품명,
        (o.heel||'cm, '||
        (select name from tblColor where seq = o.colorSeq) ||', '||
        o.footSize || 'mm') as 옵션,
        c.quantity as 수량, 
        i.price as 판매가,
        i.sellingPrice as 할인판매가
    from tblCart c
        inner join tblOption o on c.optionseq = o.seq
        inner join tblItem i on o.itemseq = i.seq
            where memberseq = pMemberSeq;
            
    select 
        sum(c.quantity * i.sellingPrice) as 상품가격,
        case
            when sum(c.quantity * i.sellingPrice) >= 50000 then 0 
            else 2500
        end as 배송비
    into pTotalPrice, pShippingFee 
    from tblCart c
        inner join tblOption o on c.optionseq = o.seq
        inner join tblItem i on o.itemseq = i.seq
            where memberseq = pMemberSeq;

end;



-- 목록조회 출력문
create or replace procedure procListCart_Print(
    pMemberSeq in number
)
is
begin
    declare
        vCursor         sys_refcursor;
        vTotalPrice     number;
        vShippingFee    number;
    
        vName           tblitem.name%type;
        vOption         varchar2(100);
        vQuantity       tblCart.quantity%type; 
        vPrice          tblitem.price%type;
        vSellingPrice   tblitem.sellingprice%type;
        vNumber         number;
    begin
        vNumber := 1;
        procListCart(pMemberSeq, vCursor, vTotalPrice, vShippingFee);
        dbms_output.put_line('----------------------------------------------------------------');
        dbms_output.put_line('상품명   판매가   할인판매가');
        dbms_output.put_line('  - 옵션               (수량)');
        dbms_output.put_line('----------------------------------------------------------------');
        loop
        fetch vCursor into vName, vOption, vQuantity, vPrice, vSellingPrice;
        exit when vCursor%notfound;
      
        dbms_output.put_line(vNumber||'. '||vName||', '||vPrice||'원, '|| vSellingPrice||'원');
        dbms_output.put_line('  - '||vOption||' ('|| vQuantity||'개)');
        dbms_output.put_line('');
        vNumber := vNumber+1;
        end loop;
        
        if vNumber = 1 then dbms_output.put_line('장바구니 목록이 존재하지 않습니다.');
        else
            dbms_output.put_line('----------------------------------------------------------------');
            dbms_output.put_line('- 상품비: '|| vTotalPrice ||'원');
            dbms_output.put_line('- 배송비: '|| vShippingFee ||'원');
            dbms_output.put_line('-> 합계: '||(vTotalPrice + vShippingFee) ||'원');
        end if;
        
        dbms_output.put_line('----------------------------------------------------------------');
       close vcursor;
    
    exception
        when others then
            dbms_output.put_line('----------------------------------------------------------------');
            dbms_output.put_line(' 장바구니 목록 불러오기에 실패하였습니다.');
            dbms_output.put_line('----------------------------------------------------------------');
    end;
end;

-- 목록조회 실행문
begin
     procListCart_Print(3);
end;

