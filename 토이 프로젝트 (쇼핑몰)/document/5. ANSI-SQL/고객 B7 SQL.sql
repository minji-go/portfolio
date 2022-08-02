--B7-마이페이지
--B7-01. 주문 (진행중)처리 현황
--      : 진행중인 주문이 있을 경우 간략한 정보 출력 (상품정보, 주문일, 결제일, 수령인 이름, 수령인 전화번호, 배송지, 현재 처리 현황)
--B7-02. 주문 내역 조회
--      : 로그인한 아이디로 조회할 수 있는 모든 주문 내역을 주문일자와 함께 출력
--      : 주문번호로 하나를 선택하면 상세 정보 출력(상품 정보 및 옵션, 수량, 결제 금액, 처리 상태(구매확정/취소/교환/반품))  
--B7-03. 주문 내역 삭제
--B7-04. 관심 상품
--      : 관심 상품에 등록한 상품의 상세 정보(카테고리, 상품명, 가격, 옵션)를 확인
--      : 관심 상품을 장바구니에 추가
--      : 관심 상품 목록 삭제
--B7-05. 개인정보 관리
--      : 회원가입 시 입력했던 정보들을 수정
--      : 회원 탈퇴
--B7-06. 적립금 내역 조회
--      : 주문 및 리뷰 작성으로 쌓인 적립금 상세 내역을 조회 (적립 날짜, 적립 유형(주문/리뷰 작성), 적립 금액, 누적 금액)


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
where oi.resultSeq = 1 and o.memberSeq = 조회할 회원번호;


--B7-02. 주문 내역 조회
--      : 로그인한 아이디로 조회할 수 있는 모든 주문 내역을 주문일자와 함께 출력
select
    o.seq as "주문번호",
    o.memberSeq as "회원번호",
    o.orderDate as "주문일",
    o.address as "배송지",
    o.shippingFee as "배송비"
from tblOrder o inner join tblMember m on o.memberseq = m.seq where m.id = '아이디' and m.pw = '비밀번호' order by o.seq;



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

delete from tblShippingItem where orderSeq = 삭제할 주문번호;
delete from tblOrderItem where orderSeq = 삭제할 주문번호;
delete from tblPay where orderSeq = 삭제할 주문번호;
delete from tblOrder where seq = 삭제할 주문번호;



--B7-04. 관심 상품


--      : 관심 상품에 등록한 상품의 상세 정보(카테고리, 상품명, 가격, 옵션)를 확인
--        조회할 회원번호 및 회원의 사이즈를 입력하면 조회! (사이즈가 없으면 목록이 너무 길어서...)
select
    cate.name as "카테고리",
    i.name as "상품명",
    i.sellingPrice as "가격",
    c.name as "색상",
    op.footsize as "사이즈",
    op.heel || 'cm' as "굽높이"
    
from tblLike l
    inner join tblItem i on l.itemSeq = i.seq
    inner join tblCategory cate on i.categorySeq = cate.seq
    inner join tblOption op on i.seq = op.itemseq
    inner join tblColor c on op.colorSeq = c.seq
        where l.memberSeq = 회원번호 and op.footsize = '사이즈';




--      : 관심 상품을 장바구니에 추가(***)


insert into tblCart(seq, memberSeq, optionSeq, quantity)
    values (seqCart.nextVal, 회원번호,
        (select seq from tblOption where itemSeq = 아이템번호 and colorSeq = (select seq from tblColor where name = '주문하고 싶은 색상명') and heel = 굽높이 and footsize = 사이즈), 수량);
      
      
-- 장바구니 추가 테스트  
insert into tblCart(seq, memberSeq, optionSeq, quantity)
    values (seqCart.nextVal, 1,
        (select seq from tblOption where itemSeq = 9 and colorSeq = (select seq from tblColor where name = '레드') and heel = 4 and footsize = 260), 1);
        
        
        
        
--      : 관심 상품 목록 삭제
-- 일괄 삭제
delete from tblLike where memberseq = 회원번호;

-- ItemSeq 선택해 삭제하기
delete from tblLike where memberSeq = 회원번호 and itemSeq = 목록 중 아이템번호;



--B7-05. 개인정보 관리
--      : 회원가입 시 입력했던 정보들을 수정 -> 0개 행 업데이트: 실패, 1개 행 업데이트: 성공

select * from tblMember;

-- 비밀번호 수정
update tblMember set pw = '바꿀 비밀번호' where id = '로그인 아이디' and pw = '(기존)로그인 비밀번호';

-- 주소 수정
update tblMember set address = '바꿀 주소' where id = '로그인 아이디' and pw = '로그인 비밀번호';

-- 전화번호 수정
update tblMember set tel = '바꿀 전화번호' where id = '로그인 아이디' and pw = '로그인 비밀번호';

-- 문자 수신여부 수정
update tblMember set smsConsent = 'Y/N' where id = '로그인 아이디' and pw = '로그인 비밀번호';

-- 이메일 수정
update tblMember set email = '바꿀 이메일' where id = '로그인 아이디' and pw = '로그인 비밀번호';

-- 이메일 수신여부 수정
update tblMember set emailConsent = 'Y/N' where id = '로그인 아이디' and pw = '로그인 비밀번호';


--      : 회원 탈퇴
delete from tblMember where id = '탈퇴할 아이디' and pw = '비밀번호';

select * from tblMemberInfo;


--B7-06. 적립금 내역 조회
--      : 주문 및 리뷰 작성으로 쌓인 적립금 상세 내역을 조회 (적립 날짜, 적립 유형(주문/리뷰 작성), 적립 금액, 누적 금액

--적립금 상세 내역 확인
select 
    p.savedate as "적립날짜",
    pc.category as "적립유형",
    p.point || '원' as "적립금액" 
from tblPoint p
    inner join tblPointCategory pc on p.pcategorySeq = pc.seq
        where p.memberSeq = 회원번호;
        
--적립금 누적 금액 확인
select 
    sum(p.point) || '원' as "누적금액"
from tblPoint p
    inner join tblPointCategory pc on p.pcategorySeq = pc.seq
        where p.memberSeq = 회원번호;
        
-- 회원정보 확인        
select * from tblMember m inner join tblMemberInfo i on m.seq = i.memberSeq where m.seq = 회원번호; 
