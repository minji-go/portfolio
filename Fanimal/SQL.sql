set serverout on;

create or replace procedure procHospitalList(
    pBegin  in number,
    pEnd    in number,
    pSigu   in tblcompany.address%type,
    pXcoor  in number,
    pYcoor  in number, 
    pSearch in tblhospital.hosname%type,
    pAlign  in varchar2,
    pResult out sys_refcursor
)
is
begin

    if pAlign = 'distance' then
        
        open pResult for 
        select hpseq, hosname, tel, address, avgstar from
            (select rownum as rnum, hpseq, hosname, tel, address, avgstar from (select h.hpseq, h.hosname, c.tel, c.address, 
                (select avg(star) from tblHosReview where hpseq = h.hpseq) as avgstar
                    from tblHospital h inner join tblCompany c on h.cseq = c.cseq
                        where h.statseq = 1 and c.address like (pSigu || '%') and h.hosname like ('%' || pSearch ||'%')
                            order by (select sqrt(power(pXcoor-c.xcoor,2) + power(pYcoor-c.ycoor,2)) from dual) asc NULLS last)) 
            where rnum between pBegin and pEnd;
                
    elsif pAlign = 'avgstar' then
        
        open pResult for 
        select hpseq, hosname, tel, address, avgstar from
            (select rownum as rnum, hpseq, hosname, tel, address, avgstar from (select h.hpseq, h.hosname, c.tel, c.address, 
                (select avg(star) from tblHosReview where hpseq = h.hpseq) as avgstar
                    from tblHospital h inner join tblCompany c on h.cseq = c.cseq
                        where h.statseq = 1 and c.address like (pSigu || '%') and h.hosname like ('%' || pSearch || '%')
                            order by avgstar desc NULLS last)) 
            where rnum between pBegin and pEnd;
    else 
    
         open pResult for select null as hpseq, null as hosname, null as tel, null as address, null as avgstar from dual;
         
    end if;
end;
 


declare
    vresult SYS_REFCURSOR;
    hpseq number;
    hosname varchar2(100);
    tel varchar2(50);
    address varchar2(300);
    avgstar number;
begin
    procHospitalList(1, 10, '', 0, 0, '', 'distance', vresult);
    
    loop
        fetch vresult into hpseq, hosname, tel, address, avgstar;
        exit when vresult%notfound;
        
        dbms_output.put_line(hpseq || ',' || hosname);
    
    end loop;
    
end;

-- 테이블 오타수정
alter table tblOpen rename column opneseq to openseq;
alter table tblHosDate rename column opneseq to openseq;

-- 시퀀스 생성
create sequence seqHosReview start with 2;
create sequence seqResHos start with 2;
create sequence seqQues start with 2;
create sequence seqQuesAns start with 2;
create sequence seqHosDate start with 994;


-- 데이터에서 평일, 주말 제거!!!
update tblHosDate set openseq = 6 where openseq = 9;
insert into tblHosDate values (SEQHOSDATE.nextval, 1, 2);
insert into tblHosDate values (SEQHOSDATE.nextval, 1, 3);
insert into tblHosDate values(SEQHOSDATE.nextval, 1, 4);
insert into tblHosDate values(SEQHOSDATE.nextval, 1, 5);
insert into tblHosDate values(SEQHOSDATE.nextval, 1, 6);
insert into tblHosDate values(SEQHOSDATE.nextval, 2, 2);
insert into tblHosDate values(SEQHOSDATE.nextval, 2, 3);
insert into tblHosDate values(SEQHOSDATE.nextval, 2, 4);
insert into tblHosDate values(SEQHOSDATE.nextval, 2, 5);



-- 병원 진료 예약
alter table tblResHos MODIFY visitseq DEFAULT 3; 


-- 병원 문의게시판
alter table tblQues add attachfile varchar2(50) null;
alter table tblQues rename column filed to content;


insert into tblQues values (seqQues.nextVal, 1, '늘푸른병원 휴무 공지', '늘푸른 병원의 휴무일은 일요일입니다.', 'company1234', default, 'n', null);
insert into tblQues values (seqQues.nextVal, 1, '문의글 작성시 주의사항', '주의사항입니다.', 'company1234', default, 'n', 'company.png');
insert into tblQues values (seqQues.nextVal, 1, '진료문의', '안녕하세요. 혹시 새 진료도 가능한가요?', 'hong1234', default, 'n', 'bird.png');
insert into tblQues values (seqQues.nextVal, 1, '진료문의', '안녕하세요. 혹시 새 진료도 가능한가요?', 'hong1234', default, 'n', null);
insert into tblQues values (seqQues.nextVal, 1, '안녕하세요.', '안녕하세요. 혹시 새 진료도 가능한가요?', 'hong1234', default, 'n', null);


create view vwQues as
select q.*, nickname from tblQues q inner join
    (select i.id, nickname from tblId i inner join tblUser u on i.id = u.id 
    union
    select i.id, hosname from tblId i 
        inner join tblCompany c on i.id = c.id 
        inner join tblHospital h on c.cseq = h.cseq) u 
on q.id = u.id;



create or replace procedure procQues (
    pCseq in number,
    pId in varchar2,
    pBegin in number,
    pEnd in number,
    pSearchKey in varchar2,
    pSearchValue in varchar2,
    pResult out sys_refcursor
)
is
begin

    if pSearchKey = 'title' then

        open pResult for
        select hqseq, title, postdate, attachFile, nickname, secret, type, answer from
            (select rownum as rnum, k.* from
                (select * from
                    (select * from
                        (select hqseq, title, postdate, attachFile, nickname, secret,  0 as type, 'n' as answer from vwQues 
                            where cseq = pCseq and id = pId order by postdate desc)
                    union 
                    select * from 
                        (select q.hqseq, q.title, q.postdate, q.attachFile, q.nickname, secret, 1, case when a.qaseq is not null then 'y' else 'n' end as answer
                            from vwQues q left outer join tblQuesAns a on q.hqseq = a.hqseq
                                where q.cseq = pCseq and q.id <> pId order by postdate desc))
                    where title like ('%'|| pSearchValue ||'%')
                    order by type, postdate desc) k)
        where rnum between pBegin and pEnd;
    
    elsif pSearchKey = 'content' then
        
        open pResult for
        select hqseq, title, postdate, attachFile, nickname, secret, type, answer from
            (select rownum as rnum, k.* from
                (select * from
                    (select * from
                        (select hqseq, title, postdate, attachFile, nickname, content, secret, 0 as type, 'n' as answer from vwQues
                            where cseq = pCseq and id = pId order by postdate desc)
                    union 
                    select * from 
                        (select q.hqseq, q.title, q.postdate, q.attachFile, q.nickname, q.content, q.secret, 1, case when a.qaseq is not null then 'y' else 'n' end as answer
                            from vwQues q left outer join tblQuesAns a on q.hqseq = a.hqseq
                                where q.cseq = pCseq and q.id <> pId order by postdate desc))
                    where content like ('%'|| pSearchValue ||'%') 
                    order by type, postdate desc) k)
        where rnum between pBegin and pEnd;
    
    elsif pSearchKey = 'nickname' then
        
        open pResult for
        select hqseq, title, postdate, attachFile, nickname, secret, type, answer from
            (select rownum as rnum, k.* from
                (select * from
                    (select * from
                        (select id, hqseq, title, postdate, attachFile, nickname, secret, 0 as type, 'n' as answer from vwQues
                            where cseq = pCseq and id = pId order by postdate desc)
                    union 
                    select * from 
                        (select q.id , q.hqseq, q.title, q.postdate, q.attachFile, q.nickname, q.secret, 1, case when a.qaseq is not null then 'y' else 'n' end as answer
                            from vwQues q left outer join tblQuesAns a on q.hqseq = a.hqseq
                                where q.cseq = pCseq and q.id <> pid order by postdate desc))
                where nickname like ('%'|| pSearchValue ||'%')
                    order by type, postdate desc) k)
        where rnum between pBegin and pEnd;
        
    else 
         open pResult for select null as hqseq, null as title, null as postdate, null as attachFile, null as nickname, null as secret, null as type, null as answer from dual;
    end if;

end;
/

declare 
    vresult sys_refcursor; 
    hqseq number;
    title varchar2(100);
    postdate date;
    attachFile varchar2(100);
    nickname varchar2(100);
    secret varchar2(10);
    aa number;
    answer varchar2(10);
begin
    procQues(1, 'company1234', 1, 20, 'title', '', vresult);
 
    loop
    fetch vresult into hqseq, title, postdate, attachFile, nickname, secret, aa, answer;
    exit when vresult%notfound;
        
        dbms_output.put_line(hqseq || ',' || title || ',' || postdate || ',' || attachFile || ',' || nickname || ',' ||secret|| ',' || aa || ',' || answer);
    
    end loop;
    
end;

create view vwUserCompany as
select i.id, '0' as type from tblId i inner join tblUser u on i.id = u.id 
union
select i.id, '1' from tblId i 
    inner join tblCompany c on i.id = c.id 
    inner join tblHospital h on c.cseq = h.cseq;



-- Select문
select to_char(resdate, 'yy-mm-dd hh24:mi'), r.* from tblResHos r;
select * from tblOpen;
select * from tblHosDate;
select * from tblVisit;
select * from tblQues;
select * from tblQuesAns;
select * from tblUser;
select * from vwQues;
select * from tblType;
select * from tblCompany;
