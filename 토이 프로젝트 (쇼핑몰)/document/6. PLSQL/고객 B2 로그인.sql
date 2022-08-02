
-- B-02. 회원 로그인
-- procLogin('회원 아이디', '회원 비밀번호');


-- procedure 생성

create or replace procedure procLogin(
    pid varchar2,
    ppw varchar2
)
is
    vname tblMember.name%type;
    vseq tblMember.seq%type;
begin
    select name, seq into vname, vseq from tblMember where id = pid and pw = ppw;
    dbms_output.put_line('----------------------------------------------------');
    dbms_output.put_line(vname || '(회원번호 ' || vseq || ') 님, 환영합니다.');
    dbms_output.put_line('로그인에 성공했습니다.');
    

exception
    when others then
        dbms_output.put_line('입력한 아이디: ' || pid || ', 입력한 비밀번호: ' || ppw);
        dbms_output.put_line('로그인에 실패했습니다.');
end;
/



-- procedure 실행
begin
    procLogin('sineob7', 'CkwPPWmoME%');
end;



-- 더미 데이터 복구
select * from tblMember;
select * from tblMemberInfo;
insert into tblMember values (1, 1, 'sineob7', 'CkwPPWmoME%', '주유아', '부산광역시 사상구 동대문10 101-505', '010-7828-7034', 'Y', 'sineob7@naver.com', 'Y');
insert into tblMemberInfo values (1, '양력', '01/02/23', 235);