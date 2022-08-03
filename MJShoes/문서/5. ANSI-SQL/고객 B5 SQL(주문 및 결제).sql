
-->>>>>>>>>>>>>>>>>>>>> B-05 주문 및 결제하기
-->>> 1. 로그인으로 연결
-->>> 2. 주문할 상품 조회(바로결제)
select 
    rownum,
    i.name as 상품명,
    o.heel||'cm, '||
    (select name from tblColor where seq = o.colorSeq) ||', '||
    o.footSize || 'mm' as 옵션,
    1 as 수량, -- ? 
    i.price as 판매가,
    i.sellingPrice as 할인판매가
from tblOption o 
    inner join tblItem i on o.itemseq = i.seq
        where optionSeq in (?);
        
-->>> 3. 결제하기
insert into tblOrder values(seqOrder.nextVal, memberSeq, default, address, shippingFee);

insert into tblOrderItem values(orderSeq, optionSeq, 1, quantity, unitPrice, default);
insert into tblOrderItem values(orderSeq, optionSeq, 1, quantity, unitPrice, default);
...

-- 결제수단: 카드 
insert into tblPay values(seqPay, orderSeq, payerName, '카드', amount, default, '주문 결제');
-- 결제수단: 무통장 입금
insert into tblPay values(seqPay, orderSeq, payerName, '무통장 입금', amount, default, '주문 결제');


-->>> 4. 주문완료
-- 결제수단: 카드 
select 
    o.seq as 주문번호,
    o.orderdate as 주문일,
    o.address as 배송지,
from tblOrder o 
    inner join tblOrderItem t on o.seq= t.orderSeq 
    inner join tblOption p on t.optionSeq = p.seq
    inner join tblItem i on p.itemSeq = i.seq
    where o.seq = ?;
-- 결제수단: 무통장 입금