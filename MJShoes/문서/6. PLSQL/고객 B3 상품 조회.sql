-->>>>>>>>>>>>>>>>>>>>> B-03 상품조회
-- 상품 목록 조회
create or replace procedure procDisplayItem (
    pCategory in number,
    pOrderby  in number,
    pCursor out sys_refcursor
)
is
begin
    open pCursor for 
    select  
        i.seq as 번호,
        i.name || ' (' ||
        (select listagg(distinct heel, '/') within group(order by heel) 
         from tblOption where itemseq = i.seq) ||'cm)' as 상품명,
        i.price as 판매가,
        case
            when (select count(sale) from tblOption where itemseq = i.seq and sale='Y') > 0
                then to_char(i.sellingPrice)
            else 'soldout'
        end as 할인판매가,
        count(r.seq) as 리뷰수 
    from tblItem i
        inner join tblOption o on i.seq = o.itemSeq
        left outer join tblReview r on o.seq = r.optionseq
        where display = 'Y' and categorySeq = pCategory
            group by i.seq, i.name, i.price, i.sellingPrice, i.regdate
                order by 
                    (case when pOrderby = 1 then i.regdate end) desc,         -- 신상품순
                    (case when pOrderby = 2 then i.sellingPrice end),         -- 낮은 가격순
                    (case when pOrderby = 3 then i.sellingPrice end) desc,    -- 높은 가격순
                    (case when pOrderby = 4 then count(r.seq) end) desc,    --후기 많은순
                    (case when pOrderby = 5 then avg(r.rating) end) desc;   -- 평점순
end;


-- 상품 목록 조회 출력문
create or replace procedure procDisplayItem_Print(
    pCategory number,
    pOrderby  number
)
is
begin
    declare
        vcursor sys_refcursor;
        vseq number;
        vname varchar2(100);
        vprice tblItem.price%type;
        vsellingprice varchar2(50);
        vreview number;
    begin
        procDisplayItem (1, 1, vcursor);
        
        dbms_output.put_line('번호   상품명   할인판매가(판매가)  리뷰수 ');
        
        loop
            fetch vcursor into vseq,vname, vprice, vsellingprice,vreview;
            exit when vcursor%notfound;
            dbms_output.put_line(vseq ||', '||vname ||', '||vsellingprice||'원('||vprice ||'원), '||vreview ||'개');
        end loop;
        
        close vcursor;
    
    exception
        when others then
            dbms_output.put_line('--------------------------------');
            dbms_output.put_line(' 상품 목록을 찾을 수 없습니다.');
            dbms_output.put_line('--------------------------------');
    end;
end;


-- 상품 목록 조회 실행문
begin
    procDisplayItem_Print(1, 1);
end;
  












