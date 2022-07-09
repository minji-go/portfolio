--C3
--고객의 주문 및 결제내역을 조회하고 배송 정보를 조회, 등록, 수정, 삭제할 수 있다. 
--주문내역은 기간, 회원, 카테고리, 주문처리상태별로 조회할 수 있다.
--.주문내역의 조회는 주문번호, 상품명, 컬러, 사이즈, 수량, 주문일, 회원번호, 배송지, 주문처리상태를 확인할 수 있다.
--결제내역의 조회는 결제번호, 회원번호, 주문번호, 결제수단, 결제금액, 결제일을 확인할 수 있다.
--주문내역 결제수단으로 무통장입금을 선택했을 경우 가상계좌로 입금가능하고, 입금금액은 정해진 금액만 가능하다.
--주문내역의 주문처리 상태중 배송준비중, 배송중, 배송 완료의 표시는 배송관리에서 등록된 정보에 따라 표시되어야 한다.


-- C3-01. 관리자의 고객별 주문내역 조회 (주문번호, 상품명, 컬러, 사이즈, 수량, 주문일, 회원번호, 배송지, 주문처리상태)
select
    o.seq as "주문번호",
    i.name as "상품명",
    c.name as "컬러",
    op.footsize as "사이즈",
    oi.quantity as "수량",
    o.orderdate as "주문일",
    o.memberseq as "회원번호",
    o.address as "배송지",
    ore.name as "주문처리상태"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderseq
    inner join tblOption op on oi.optionseq = op.seq
    inner join tblItem i on op.itemseq = i.seq
    inner join tblColor c on op.colorseq = c.seq
    inner join tblOrderResult ore on oi.resultSeq = ore.seq
        where o.memberseq = 1 -- 조회할 고객 번호
            order by o.orderdate asc ;


-- C3-02. 관리자의 고객별 결제내역 조회 (결제번호, 회원번호, 주문번호, 결제수단, 결제금액, 결제일)
select 
    p.seq as "결제번호",
    o.memberseq as "회원번호",
    o.seq as "주문번호",
    p.method as "결제수단",
    p.amount as "결제금액",
    p.paydate as "결제일"
from tblPay p
    inner join tblOrder o on p.orderseq = o.seq
        where o.memberseq = 1 -- 조회할 고객 번호
        order by p.paydate asc, p.seq asc;
        
        
-- C3-03. 관리자의 기간별 주문내역 조회 (주문번호, 상품명, 컬러, 사이즈, 수량, 주문일, 회원번호, 배송지, 주문처리상태)
select
    o.seq as "주문번호",
    i.name as "상품명",
    c.name as "컬러",
    op.footsize as "사이즈",
    oi.quantity as "수량",
    o.orderdate as "주문일",
    o.memberseq as "회원번호",
    o.address as "배송지",
    ore.name as "주문처리상태"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderseq
    inner join tblOption op on oi.optionseq = op.seq
    inner join tblItem i on op.itemseq = i.seq
    inner join tblColor c on op.colorseq = c.seq
    inner join tblOrderResult ore on oi.resultSeq = ore.seq
        where o.orderdate between '2022-01-01' and '2022-12-31' -- 조회할 기간
            order by o.orderdate asc ;


-- C3-04. 관리자의 카테고리별 주문내역 조회 (주문번호, 상품명, 컬러, 사이즈, 수량, 주문일, 회원번호, 배송지, 주문처리상태)
select
    o.seq as "주문번호",
    i.name as "상품명",
    c.name as "컬러",
    op.footsize as "사이즈",
    oi.quantity as "수량",
    o.orderdate as "주문일",
    o.memberseq as "회원번호",
    o.address as "배송지",
    ore.name as "주문처리상태"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderseq
    inner join tblOption op on oi.optionseq = op.seq
    inner join tblItem i on op.itemseq = i.seq
    inner join tblColor c on op.colorseq = c.seq
    inner join tblOrderResult ore on oi.resultSeq = ore.seq
    inner join tblCategory cate on i.categorySeq = cate.seq
        where cate.name = '스니커즈' -- 조회할 카테고리
            order by o.orderdate asc;


-- C3-05. 관리자의 주문처리상태별 주문내역 조회 (주문번호, 상품명, 컬러, 사이즈, 수량, 주문일, 회원번호, 배송지, 주문처리상태)
select
    o.seq as "주문번호",
    i.name as "상품명",
    c.name as "컬러",
    op.footsize as "사이즈",
    oi.quantity as "수량",
    o.orderdate as "주문일",
    o.memberseq as "회원번호",
    o.address as "배송지",
    ore.name as "주문처리상태"
    
from tblOrder o
    inner join tblOrderItem oi on o.seq = oi.orderseq
    inner join tblOption op on oi.optionseq = op.seq
    inner join tblItem i on op.itemseq = i.seq
    inner join tblColor c on op.colorseq = c.seq
    inner join tblOrderResult ore on oi.resultSeq = ore.seq
        where ore.name = '취소' -- 조회할 주문처리상태
            order by o.orderdate asc;

