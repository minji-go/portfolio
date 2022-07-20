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
                        where h.statseq = 1 and c.address like (pSigu || '%') and h.hosname like ('%' || pSearch ||'%')
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



-- 데이터에서 평일, 주말 제거!!!
create sequence seqHosDate start with 994;
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


-- Select문
select to_char(resdate, 'yy-mm-dd hh24:mi'), r.* from tblResHos r;
select * from tblOpen;
select * from tblHosDate;
select * from tblVisit;



