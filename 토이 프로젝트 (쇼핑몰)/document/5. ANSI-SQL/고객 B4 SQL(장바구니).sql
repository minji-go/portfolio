
-->>>>>>>>>>>>>>>>>>>>> B-04 장바구니
-->>> 1. 목록조회
select 
    rownum,
    i.name as 상품명,
    o.heel||'cm, '||
    (select name from tblColor where seq = o.colorSeq) ||', '||
    o.footSize || 'mm' as 옵션,
    c.quantity as 수량, 
    i.price as 판매가,
    i.sellingPrice as 할인판매가
from tblCart c
    inner join tblOption o on c.optionseq = o.seq
    inner join tblItem i on o.itemseq = i.seq
        where memberseq = ?;
        
-- 총 금액
select 
    sum(c.quantity * i.sellingPrice) as 상품가격,
    case
        when sum(c.quantity * i.sellingPrice) >= 50000 then 0 
        else 2500
    end as 배송비
from tblCart c
    inner join tblOption o on c.optionseq = o.seq
    inner join tblItem i on o.itemseq = i.seq
        where memberseq = ?;
    

-->>> 2. 목록 수정
update tblCart set (optionSeq, quantity) = (select..from dual) where seq = ?;

-->>> 3. 목록 삭제
delete from tblCart where seq = ?;