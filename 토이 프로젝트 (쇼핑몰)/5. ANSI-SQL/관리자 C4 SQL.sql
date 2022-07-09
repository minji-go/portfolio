--C4
--배송 정보의 조회는 배송준비중, 배송중, 배송완료으로 나누어 배송번호, 주문번호, 상품번호, 배송지, 상품발송일자, 택배사, 송장번호, 배송완료일자를 확인할 수 있다. 
--배송 정보 등록은 배송 준비 등록, 배송등록, 배송완료등록으로 나누어진다.
--배송 준비 등록은 취소상태가 아닌 주문완료 내역 중 결제가 완료된 내역에서 선택하면 배송준비중으로 주문처리상태가 변경된다.  
--배송 정보의 등록은 배송한 상품을 선택하고 배송상품발송일자, 택배사, 송장번호를 입력해야한다. 
--배송 완료 등록은 배송상품 묶음  또는 송장번호 등으로 선택한 후 배송완료일자를 입력해야한다.
--배송 정보는 수정하거나 삭제할 수 있다.
--배송 정보의 수정 혹은 삭제는 배송정보, 배송 완료정보를 한번에 처리한다.
--배송 완료 등록이 처리된 후 7일이 지나면 자동으로 구매확정처리가 되고, 그 전에 고객의 요청이 있을 경우 교환, 반품 처리를 할 수 있다. 
--교환,반품 발생시 결제내역 수정이 진행되고 교환의 경우 주문상품내역 에 추가하고 새로운상품주문과 동일한 과정이 진행된다.
--배송 준비 등록시 주문번호와 상품번호는 주문내역에서 선택한다.
--배송 준비 등록을 하면 구매자는 주문을 취소 할 수 없으며, 구매를 취소하려면 판매자에게 문의해야 한다.
--결제완료 후에야 배송정보 등록이 가능하다.
--배송정보 등록시 배송완료일자는 기입하지 않아도 무방하다.
--교환,반품 발생시 무료배송의 변경이 발생할 수 있다.


-- C4-01. 관리자의 배송준비중/배송중/배송완료별 배송 정보 조회 (배송번호, 주문번호, 상품번호, 배송지, 상품발송일자, 택배사, 송장번호, 배송완료일자)

-- 배송준비중/배송중/배송완료 모든 배송 정보 조회
select
    si.shippingseq as "배송번호",
    o.seq as "주문번호",
    oi.optionseq as "상품번호",
    o.address as "배송지",
    s.begindate as "상품발송일자",
    s.company as "택배사",
    s.trackingnum as "송장번호",
    s.enddate as "배송완료일자"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderSeq 
    left outer join tblShippingItem si on o.seq = si.orderSeq and si.optionseq = oi.optionseq
    left outer join tblShipping s on si.shippingseq = s.seq
            order by o.seq, o.orderdate asc;


-- 배송준비중 배송 정보 조회 (주문확인 = 'Y', 상품발송일자(배송시작일) = null)
select
    si.shippingseq as "배송번호",
    o.seq as "주문번호",
    oi.optionseq as "상품번호",
    o.address as "배송지",
    s.begindate as "상품발송일자",
    s.company as "택배사",
    s.trackingnum as "송장번호",
    s.enddate as "배송완료일자"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderSeq 
    left outer join tblShippingItem si on o.seq = si.orderSeq and si.optionseq = oi.optionseq
    left outer join tblShipping s on si.shippingseq = s.seq
        where s.begindate is null and oi.processed = 'Y'
            order by o.seq, o.orderdate asc;
            
    
-- 배송중 배송 정보 조회 (상품발송일자(배송시작일) = not null, 배송완료일 = null)
select
    si.shippingseq as "배송번호",
    o.seq as "주문번호",
    oi.optionseq as "상품번호",
    o.address as "배송지",
    s.begindate as "상품발송일자",
    s.company as "택배사",
    s.trackingnum as "송장번호",
    s.enddate as "배송완료일자"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderSeq 
    left outer join tblShippingItem si on o.seq = si.orderSeq and si.optionseq = oi.optionseq
    left outer join tblShipping s on si.shippingseq = s.seq
        where s.begindate is not null and s.enddate is null
            order by o.seq, o.orderdate asc;


-- 배송완료 배송 정보 조회 (상품발송일자(배송시작일) = not null, 배송완료일 = not null)
select
    si.shippingseq as "배송번호",
    o.seq as "주문번호",
    oi.optionseq as "상품번호",
    o.address as "배송지",
    s.begindate as "상품발송일자",
    s.company as "택배사",
    s.trackingnum as "송장번호",
    s.enddate as "배송완료일자"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderSeq 
    left outer join tblShippingItem si on o.seq = si.orderSeq and si.optionseq = oi.optionseq
    left outer join tblShipping s on si.shippingseq = s.seq
        where s.begindate is not null and s.enddate is not null
            order by o.seq, o.orderdate asc;
            
            
-- C4-02. 관리자의 배송 준비 등록 (취소상태가 아닌 주문완료 내역 중 결제가 완료된 내역에서 선택하면 주문처리상태가 배송준비중으로 변경)
-- 결제완료 내역 중에 선택하기 -> 추후 구현
update tblOrderItem set processed = 'Y' where resultseq <> 2 and orderseq = '선택 주문번호';


-- C4-03. 관리자의 배송 등록 (배송한 상품을 선택하고 배송상품발송일자, 택배사, 송장번호를 입력)
insert into tblShipping(seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, '택배사', '송장번호', sysdate, null);
insert into tblShippingItem(seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 배송번호, 주문번호, 옵션번호);


-- C4-04. 관리자의 배송 완료 등록 (배송상품 묶음 또는 송장번호 등으로 선택한 후 배송완료일자를 입력)
update tblShipping set endDate = '배송완료일자' where trackingNum = '송장번호';


-- C4-05. 배송 정보 수정, 배송 정보 삭제
-- 배송 정보 수정 - 택배사 수정
update tblShipping set company = '변경된 택배사' where seq = 수정할 배송번호;
-- 배송 정보 수정 - 송장번호 수정
update tblShipping set trackingNum = '변경된 송장번호' where seq = 수정할 배송번호;
-- 배송 정보 수정 - 배송시작일 수정
update tblShipping set beginDate = '변경된 배송시작일' where seq = 수정할 배송번호;
-- 배송 정보 수정 - 배송완료일 수정
update tblShipping set endDate = '변경된 배송완료일' where seq = 수정할 배송번호;
-- 배송 정보 삭제
delete from tblShippingItem where shippingSeq = 삭제할 배송번호;
delete from tblShipping where seq = 삭제할 배송번호;


-- C4-06. 배송 완료 등록 처리 후 7일이 지나면 주문번호로 자동으로 구매확정 처리
update tblOrderItem set resultseq = 3
    where resultseq = 1 and orderSeq in
        (select orderSeq from tblShipping s
            inner join tblShippingItem si on s.seq = si.shippingseq
                where si.orderseq = 처리할 주문번호 and sysdate - s.enddate >= 7);
        
        
-- C4-07. 교환, 반품 처리: 결제내역 수정 진행, 주문상품내역에 추가
-- 교환 처리

-- 교환 1) 주문상품내역 업데이트 및 추가
update tblOrderItem set resultSeq = 4 where orderSeq = 교환처리할 주문번호 and optionSeq = 교환처리할 옵션번호;
insert into tblOrderItem(orderSeq, optionSeq, resultSeq, quantity, unitPrice, processed) values (교환처리할 주문번호, 교환처리할 옵션번호, 4, 교환처리할 수량, 'Y');
-- 교환 2) 결제내역 추가
insert into tblPay(seq, orderSeq, payerName, method, amount, paydate, note)
    values
        (seqPay.nextVal, 교환처리할 주문번호, 입금자명, 결제수단, (select amount from tblPay where orderSeq = 주문번호) - (select unitPrice from tblOrderItem where orderSeq = 주문번호 and optionSeq = 교환전 옵션번호) + (select unitPrice from tblOrderItem where orderSeq = 주문번호 and optionSeq = 교환후 옵션번호) + 5000, sysdate, '교환');


-- 반품 처리
select * from tblPay;
select * from tblOrderResult;
select * from tblOrderItem;

-- 반품 1) 주문상품내역 업데이트
update tblOrderItem set resultSeq = 5 where orderSeq = 반품처리할 주문번호 and optionSeq = 반품처리할 옵션번호;
-- 반품 2) 결제내역
-- 추후 pl-sql 프로시저로 구현