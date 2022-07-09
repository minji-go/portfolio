
-->>>>>>>>>>>>>>>>>>>>> B-06 게시판
-->>> 1. 공지사항
-- 공지사항 글 목록
select 
    seq as 번호,
    header as 제목,
    (select name from tblAdmin where seq = n.adminSeq) as 작성자,
    regdate as 등록일
from tblNotice n
    order by regdate desc;

-- 공지사항 세부내용
select 
    seq as 번호,
    header as 제목,
    (select name from tblAdmin where seq = n.adminSeq) as 작성자,
    regdate as 등록일,
    content as 내용
from tblNotice n
    where seq = ?;
    

-->>> 2. Q&A
-- Q&A 글 목록
select 
    seq as 글번호,
    (select substr(id, 1, 6)||'***' from tblMember where seq = q.memberSeq) as 작성자,  
    case
    when (select count(*) from tblAnswer where questionSeq = q.seq) > 0 then '[답변 완료]'
    else '[답변 준비중]'
    end as 답변상태,
    header as 제목,
    regdate as 등록일
from tblQuestion q;

alter table tblQuestion add (secret char(1) default 'N' not null);
alter table tblQuestion add constraint tblQuestion_secret_ck 
	check(secret in ('Y', 'N'));


create or replace view vwQna
as
select 
    seq, 0 as answerSeq, 
    (select id from tblMember where seq = tblQuestion.memberseq) as id, 
    header, content,
    regdate,
    secret
from tblQuestion
union
select 
    questionseq, seq, 
    (select id from tblAdmin where seq = a.adminseq) as id,
    header, content, regdate,
    (select secret from tblQuestion where seq = a.questionseq)
from tblAnswer a
order by seq, regdate;

select * from vwQNA;

insert into tblQuestion values (seqQuestion.nextVal, 1, '상품 문의드려요', '스니커즈 A 입고 언제되나요?', DEFAULT, 'Y');


-- Q&A 글 세부내용 
select 
    q.content as 질문내용,
    a.content as 답변내용
from tblQuestion q inner join tblAnswer a
    on q.seq = a.questionSeq
        where q.seq = ?;
         
        
-->>> 3. 리뷰
-- 리뷰조회
select  
    r.seq as 번호,
    i.seq as 상품번호,
    i.name as 상품명,
    o.heel || 'cm' as 굽높이,
    (select name from tblColor where seq = o.colorseq) as 색상,
    o.footSize || 'mm' as 사이즈,
    (select footSize || 'mm' from tblMemberInfo where memberseq = m.seq) as 평소사이즈,
    r.rating as 평점,
    r.review as 후기,
    substr(m.id, 1, 6) || '***' as 작성자,
    r.regdate as 작성일
from tblReview r
    inner join tblOption o on r.optionSeq = o.seq
    inner join tblItem i on o.itemSeq = i.seq
    inner join tblOrderItem t on r.orderseq = t.orderseq and r.optionseq = t.optionseq
    inner join tblOrder o on t.orderseq = o.seq
    inner join tblMember m on o.memberseq = m.seq
        order by r.regdate;
        
-- 리뷰등록
-- 1) 리뷰등록할 주문상품 선택
select 
    t.orderseq, t.optionseq
from tblReview r 
    right outer join tblOrderItem t on r.orderseq = t.orderseq and r.optionseq = t.optionseq
    inner join tblOrder o on t.orderseq = o.seq
        where o.memberseq = 1 
            and t.resultseq = 3
            and r.seq is null;
-- 2) 리뷰등록
insert into tblReview values (seqReview.nextVal, orderseq, optionseq, rating, review, sysdate);
            