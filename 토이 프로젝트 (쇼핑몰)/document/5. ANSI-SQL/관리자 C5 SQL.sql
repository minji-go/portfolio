--C5
--공지사항
--  공지사항의 조회를 통해 제목, 내용, 등록일을 확인할 수 있다.
--  게시판 관리자에 의해 새로운 공지사항을 등록하거나 수정, 삭제할 수 있다.
--Q&A
--  고객이 질문한 내역에 대해서 답변 글을 카테고리, 제목, 내용, 등록일 데이터를 넣어 작성할 수 있다.
--  답변 글은 조회, 등록, 수정, 삭제가 모두 가능하다.
--리뷰
--  리뷰 조회는 상품번호, 별점, 리뷰내용을 확인할 수 있다.
--  관리자는 리뷰를 삭제할 권한을 가진다



--C5-01. 공지사항 조회/등록/수정/삭제

--공지사항 조회
select
    seq as "글번호",
    header as "제목",
    content as "내용",
    regdate as "등록일"
from tblNotice;


--공지사항 등록
insert into tblNotice values (seqNotice.nextVal, 1, '공지사항 제목', '공지사항 내용', sysdate);

--공지사항 수정(제목, 내용)
update tblNotice set header = '수정할 제목' where seq = 수정할 글번호;
update tblNotice set content = '수정할 내용' where seq = 수정할 글번호;

--공지사항 삭제
delete from tblNotice where seq = 삭제할 글번호;




--C5-02. Q&A 답변 조회, 등록, 수정, 삭제

select
    seq as "글번호",
    header as "제목",
    content as "내용",
    regdate as "등록일"
from tblAnswer;

-- Q&A 답변 등록
insert into tblAnswer values (seqAnswer.nextVal, 5, 답변할 질문번호, '제목', '내용', sysdate);

-- Q&A 답변 수정 (제목, 내용)
update tblAnswer set header = '수정할 제목' where seq = 수정할 글번호;
update tblAnswer set content = '수정할 내용' where seq = 수정할 글번호;

-- Q&A 답변 삭제
delete from tblAnswer where seq = 삭제할 글번호;



--C5-03. 리뷰 게시판 조회, 삭제
--리뷰 조회는 상품번호, 별점, 리뷰내용을 확인할 수 있다.
--관리자는 리뷰를 삭제할 권한을 가진다

-- 리뷰 조회
select 
    r.seq as "글번호",
    m.name as "작성자",
    m.seq as "회원번호",
    op.itemseq as "상품번호",
    c.name as "컬러",
    op.footsize as "사이즈",
    op.heel || 'cm' as "굽높이",
    case
        when r.rating = 1 then '☆'
        when r.rating = 2 then '☆☆'
        when r.rating = 3 then '☆☆☆'
        when r.rating = 4 then '☆☆☆☆'
        when r.rating = 5 then '☆☆☆☆☆'
    end as "별점",
    r.review as "리뷰",
    r.regdate as "작성일"

from tblReview r
    inner join tblOption op on r.optionseq = op.seq
    inner join tblColor c on op.colorSeq = c.seq
    inner join tblOrder o on r.orderSeq = o.seq
    inner join tblMember m on o.memberSeq = m.seq
        order by r.seq asc;
    
    

-- C5-04. 리뷰 삭제
delete from tblReview where seq = 삭제할 글번호;