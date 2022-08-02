-- B-01. 회원가입
-- procRegister('아이디', '비밀번호', '이름', '주소', '전화번호', 'SMS 수신여부(Y/N)', '이메일', '이메일 수신여부(Y/N)');


-- procedure 생성



create or replace procedure procRegister(
    pid varchar2,
    ppw varchar2,
    pname varchar2,
    paddress varchar2,
    ptel varchar2,
    psmsconsent varchar2,
    pemail varchar2,
    pemailconsent varchar2
)

is
    vresult number;
begin
    vresult := 1;
    if (fnCheckID(pid) = 0) then
        dbms_output.put_line('아이디 형식(영문 대소문자 및 숫자 4~12자)이 올바르지 않습니다.');
        vresult := 0;
        
    elsif (fnCheckDupID(pid) = 0) then
        dbms_output.put_line('중복된 아이디입니다.');
        vresult := 0;
        
    elsif (fnCheckPW(ppw) = 0) then
        dbms_output.put_line('비밀번호 형식(영문 대소문자 및 숫자, 특수문자(~!@#$%^&*) 8~15자)이 올바르지 않습니다.');
        vresult := 0;        
        
    elsif (fnCheckName(pname) = 0) then
        dbms_output.put_line('이름 형식(한글 2~5자)이 올바르지 않습니다.');
        vresult := 0;
        
    elsif (fnCheckTel(ptel) = 0) then
        dbms_output.put_line('전화번호 형식(010-xxxx-xxxx)이 올바르지 않습니다.');
        vresult := 0;
        
    elsif (fnCheckAddress(paddress) = 0) then
        dbms_output.put_line('주소 형식(한글+숫자)이 올바르지 않습니다.');
        vresult := 0;
        
    elsif (fnCheckEmail(pemail) = 0) then
        dbms_output.put_line('이메일 형식(아이디@도메인)이 올바르지 않습니다.');
        vresult := 0;
        
    elsif (psmsconsent not in ('y', 'Y', 'n', 'N') or pemailconsent not in ('y', 'Y', 'n', 'N')) then
        dbms_output.put_line('문자 및 이메일 수신 동의 여부(Y/N)가 올바르지 않습니다.');
        vresult := 0;
        
    end if;
    
    if (vresult = 1) then
        insert into tblMember values (seqMember.nextVal, 1, pid, ppw, pname, paddress, ptel, upper(psmsconsent), pemail, upper(pemailconsent));
        dbms_output.put_line('회원가입에 성공했습니다. ' || pname || ' 회원님, 환영합니다.');
    else
        dbms_output.put_line('회원가입에 실패했습니다. 다시 시도해 주세요.');
    end if;
end;



-- procedure 실행

create sequence seqMember start with 51;

begin
    procRegister('sy333262', 'qwera33#', '김승연', '경기도 부천시 행복한아파트 406-2103', '010-1234-1234', 'Y', 'a0a9sss3@gmail.com', 'N');
end;

select * from tblMember;
rollback;



-- 회원가입  (O)
create or replace procedure procJoin(
    pid varchar2,
    ppw varchar2,
    pname varchar2,
    paddress varchar2,
    ptel varchar2,
    psmsConsent varchar2,
    pemail varchar2,
    pemailConsent varchar2,
    psolarLunar varchar2,
    pbirthdate date,
    pfootSize number,
    presult out number
)
is
    vmemberseq number;
begin
    vmemberseq := seqMember.nextVal;
-- 회원 기본 정보 등록
    insert into tblMember(seq, gradeSeq, id, pw, name, address, tel, smsconsent, email, emailconsent)
        values (vmemberseq, 1, pid, ppw, pname, paddress, ptel,  psmsConsent, pemail, pemailConsent);

    dbms_output.put_line(psmsConsent);
    dbms_output.put_line(pbirthdate);
    
    
-- 회원 추가 정보 등록(선택)
    if (pbirthdate is not null) and (pfootSize is not null) then
        insert into tblMemberInfo(memberseq, solarLunar, birthDate, footSize)
            values (vmemberseq, psolarLunar, pbirthdate, pfootSize);
    end if;
    
    presult:=1;
exception
    when others then 
        presult := 0;
        rollback;
end;


-- 아이디 유효성 검사 함수 (영문 대소문자+숫자 4~12자)

create or replace function fnCheckID (
    pid varchar2
) return number
is
begin
    if REGEXP_LIKE(pid, '^[0-9a-zA-Z]{4,12}$') then return 1;
    else return 0;
    end if;
end;


-- 아이디 유효성 검사 함수 (중복 검사)

create or replace function fnCheckDupID (
    pid varchar2
) return number
is
    vid tblMember.id%type;
    cursor vcursor
    is
    select id from tblMember;
begin
    open vcursor;
        loop
            fetch vcursor into vid;
            exit when vcursor%notfound;
            
            if vid = pid then return 0;
            end if;
        end loop;
    close vcursor;
    return 1;
end;


-- 비밀번호 유효성 검사 함수 

create or replace function fnCheckPW (
    ppw varchar2
) return number
is
begin
    if REGEXP_LIKE(ppw, '^[0-9a-zA-Z~!@#$%^&*]{8,15}$') then return 1;
    else return 0;
    end if;
end;


-- 이름 유효성 검사 함수

create or replace function fnCheckName (
    pname varchar2
) return number
is
begin
    if REGEXP_LIKE(pname, '^[가-힣]{2,5}$') then return 1;
    else return 0;
    end if;
end;




-- 전화번호 유효성 검사 함수

create or replace function fnCheckTel (
    ptel varchar2
) return number
is
begin
    if REGEXP_LIKE(ptel, '^010-\d{4}-\d{4}$') then return 1;
    else return 0;
    end if;
end;


-- 주소 유효성 검사 함수

create or replace function fnCheckAddress (
    paddress varchar2
) return number
is
begin
    if REGEXP_LIKE(paddress, '^[가-힣0-9\ -]*$') then return 1;
    else return 0;
    end if;
end;


-- 이메일 유효성 검사 함수

create or replace function fnCheckEmail (
    pemail varchar2
) return number
is
begin
    if REGEXP_LIKE(pemail, '^[a-zA-Z0-9!#$%''\*\+-/=\?^_`\{|\}~]+@[a-zA-Z0-9._%-]+\.[a-zA-Z]{2,4}$') then return 1;
    else return 0;
    end if;
end;

drop sequence seqMember;
create sequence seqMember start with 52;

select * from tblMemberInfo;



