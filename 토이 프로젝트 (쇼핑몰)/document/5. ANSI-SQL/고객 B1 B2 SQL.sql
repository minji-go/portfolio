--B-01. 회원가입

-- 회원 기본 정보 등록
insert into tblMember(seq, gradeSeq, id, pw, name, address, tel, smsconsent, email, emailconsent)
    values (seqMember.nextVal, 1, '가입 ID', '가입 PW', '이름', '주소', '전화번호', '문자수신동의여부(Y/N)', '이메일', '이메일수신동의여부(Y/N)');


-- 회원 추가 정보 등록(선택)
insert into tblMemberInfo(memberseq, solarLunar, birthDate, footSize)
    values (seqMemberInfo.nextVal, '양력/음력', '생년월일', 발사이즈);


--B-02. 로그인

select
    case
        when count(*) = 0 then '로그인에 실패했습니다.'
        when count(*) = 1 then '로그인에 성공했습니다. 환영합니다.'
    end as "로그인 결과"
from tblMember where id = ' sineob7' and pw = 'CkwPPWmoME%';

-- 결과값이 0이면 실패, 1이면 성공 처리


select * from tblMemberInfo;

