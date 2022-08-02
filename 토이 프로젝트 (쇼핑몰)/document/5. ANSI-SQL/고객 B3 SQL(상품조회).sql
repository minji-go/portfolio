
-->>>>>>>>>>>>>>>>>>>>> B-03 상품조회
-->>> 1. 상품조회
-- 상품 목록 조회(PLSQL제작시 모든옵션의 판매여부가 N일 때 품절띄우기)
select  
    i.seq as 번호,
    i.name as 상품명,
    i.price as 판매가,
    i.sellingPrice as 할인판매가
from tblItem i
    inner join tblOption o on i.seq = o.itemSeq
    left outer join tblReview r on o.seq = r.optionseq
    where display = 'Y' and categorySeq = 1
        group by i.seq, i.name, i.price, i.sellingPrice
            --order by regdate desc -- 신상품순
            --order by sellingPrice asc -- 낮은 가격순
            --order by sellingPrice desc -- 높은 가격순
            --order by count(r.seq) desc --후기 많은순
            order by avg(r.rating) desc; -- 평점순
        
-- 상품 목록 조회(색상)
select (select name from tblColor where seq = o.colorseq) 
from tblOption o
    where o.sale ='Y' and o.itemseq = ?;
    
    
-- 상품 상세 조회(옵션)
select  
    decode(sale, 'Y', 'O', 'N', 'soldout') as 판매여부,
    heel||'cm' as 굽높이,
    (select name from tblColor where seq = o.colorSeq) as 색상,
    footSize as 사이즈
from tblOption o 
    where itemSeq = 1
        order by sale, heel, colorSeq, footSize;

-- 상품 상세 조회(상품설명)    
select  
    i.seq as 번호,
    i.name as 상품명,
    i.price as 판매가,
    i.sellingPrice as 할인판매가,
    i.content as 상품설명,
    (select name from tblMaterial where seq = i.materialSeq) as 소재,
    (select name from tblManufacturer where seq = i.manufacturerSeq) as 제조사,
    (select name from tblOrigin where seq = i.originSeq) as 원산지
from tblItem i
    where seq= ?;


-->>> 2. 관심상품 등록
insert into tblLike values(seqLike.nextVal, memberseq?, itemseq?);

-->>> 3. 장바구니 담기
select seq 
from tblCart
    where optionseq = ?
    
-- 장바구니에 같은 상품이 있으면 
update tblCart set quantity = quantity+1 where seq = ?;

-- 장바구니에 같은 상품이 없으면
insert into tblCart values(seqCart.nextVal, memberseq?, optionseq?, default);




