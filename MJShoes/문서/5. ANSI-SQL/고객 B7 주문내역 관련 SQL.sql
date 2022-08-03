--B7-마이페이지
--B7-01. 주문 (진행중)처리 현황
--      : 진행중인 주문이 있을 경우 간략한 정보 출력 (상품정보, 주문일, 결제일, 수령인 이름, 수령인 전화번호, 배송지, 현재 처리 현황)
--B7-02. 주문 내역 조회
--      : 로그인한 아이디로 조회할 수 있는 모든 주문 내역을 주문일자와 함께 출력
--      : 주문번호로 하나를 선택하면 상세 정보 출력(상품 정보 및 옵션, 수량, 결제 금액, 처리 상태(구매확정/취소/교환/반품))  
--B7-03. 주문 내역 삭제


-- 테스트용 데이터 입력
insert into tblOrder values (81, 37, '2022-06-09', '테스트용 주소지', 0);
insert into tblOrderItem values (81, 270, 1, 1, 33500, 'N');
insert into tblOrderItem values (81, 856, 1, 1, 18100, 'N');
insert into tblOrderItem values (81, 1127, 1, 1, 47500, 'N');
insert into tblPay values(82, 81, '홍정빈', '카드', 51600, '2022-06-09', '주문 결제');

------------- 결제완료 상태

update tblOrderItem set processed = 'Y' where orderSeq = 81;

------------- 주문확인 후 배송준비중 상태

select * from tblShipping;
insert into tblShipping values(76, 'CJ대한통운', '202206103522', '2022-06-10', null);
insert into tblShippingItem values(218, 76, 81, 270);
insert into tblShippingItem values(219, 76, 81, 856);
insert into tblShippingItem values(220, 76, 81, 1127);

------------- 배송중 상태 

update tblShipping set enddate = '2022-06-11' where seq = 76;

------------- 배송완료 상태




-- B7-01. 진행중인 주문 정보 확인 (상품정보, 주문일, 결제일, 수령인 이름, 수령인 전화번호, 배송지, 현재 처리 현황)
select
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
    inner join tblMember m on m.seq = o.memberSeq
where oi.resultSeq = 1 and o.memberSeq = 37;


--B7-02. 주문 내역 조회
--      : 로그인한 아이디로 조회할 수 있는 모든 주문 내역을 주문일자와 함께 출력
select
    o.seq as "주문번호",
    o.memberSeq as "회원번호",
    o.orderDate as "주문일",
    o.address as "배송지",
    o.shippingFee as "배송비"
from tblOrder o inner join tblMember m on o.memberseq = m.seq where m.id = ' sineob7' and m.pw = 'CkwPPWmoME%' order by o.seq;

select * from tblMember;




--      : 주문번호로 하나를 선택하면 상세 정보 출력(상품 정보 및 옵션, 수량, 결제 금액, 처리 상태(구매확정/취소/교환/반품))  

select
    o.seq as "주문번호",
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
    inner join tblOrderResult ore on oi.resultSeq = ore.seq
        where o.seq = 조회할 주문번호;
        


--B7-03. 주문 내역 삭제

delete from tblShippingItem where orderSeq = '삭제할 주문번호';
delete from tblOrderItem where orderSeq = '삭제할 주문번호';
delete from tblPay where orderSeq = '삭제할 주문번호';
delete from tblOrder where seq = '삭제할 주문번호';

