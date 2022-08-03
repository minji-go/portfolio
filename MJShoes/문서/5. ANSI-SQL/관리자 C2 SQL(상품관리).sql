
-->>>>>>>>>>>>>>>>>>>>> C-02 상품관리
-->>> 1. 상품조회
-- 카테고리별 상품 조회
select  
    decode(display, 'Y', 'O', 'N', 'X') as 진열여부,
    seq as 번호,
    name as 상품명,
    (select name from tblMaterial where seq = i.materialSeq) as 소재,
    (select name from tblManufacturer where seq = i.manufacturerSeq) as 제조사,
    (select name from tblOrigin where seq = i.originSeq) as 원산지,
    (select count(*) from tblOption where itemSeq = i.seq) as 옵션수,
    price as 판매가,
    sellingPrice as 할인판매가,
    regdate as 상품등록일
from tblItem i
    where categorySeq = ?
        order by display desc, regdate desc;


-- 상품 상세 조회(옵션)   
select  
    decode(sale, 'Y', 'O', 'N', 'X') as 판매여부,
    heel||'cm' as 굽높이,
    (select name from tblColor where seq = o.colorSeq) as 색상,
    footSize as 사이즈,
     stock as 재고수량
from tblOption o 
    where itemSeq = ?
        order by sale, heel, colorSeq, footSize;


-- 상품 상세 조회(상품설명)    
select content as 상품설명 from tblItem where seq= ?;


-->>> 2. 상품등록
insert into tblItem values(seqItem.nextVal, categoryseq, materialseq, manufacturerSeq, originSeq, name, content, price, sellingPrice, display, sysdate);
insert into tblOption values(seqOption.nextVal, itemSeq, colorSeq, footSize, heel, stock, sale);


-->>> 3. 상품수정
-- 주문내역이 존재할 경우
select count(*) from tblOrderItem where itemSeq = ?; --주문내역 존재 확인
update tblItem set (content, price, sellingPrice, display) = (select ..) where seq =?;
update tblOption set sale = ? where seq = ?; -- 옵션주문내역 존재
update tblOption set (colorSeq, footSize, heel, sale) = (select ..) where seq =?; -- 옵션주문내역 부존재

-- 주문내역이 존재하지 않을 경우
update tblItem set (categoryseq, materialseq, manufacturerSeq, originSeq, name, content, price, sellingPrice, display) = (select ..) where seq =?;
update tblOption set (colorSeq, footSize, heel, sale) = (select ..) where seq =?; 


-->>> 4. 상품삭제
-- 상품 특정 옵션 삭제
delete from tblOption where optionSeq = ?;

-- 상품 전체 삭제
delete from tblOption where itemSeq = ?;
delete from tblItem where seq = ?;


-- 재고수량  수정
update tblOption set stock = ? where seq = ?;






