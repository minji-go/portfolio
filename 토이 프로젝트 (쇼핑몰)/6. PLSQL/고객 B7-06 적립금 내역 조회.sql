--B7-06. 적립금 내역 조회
--      : 주문 및 리뷰 작성으로 쌓인 적립금 상세 내역을 조회 (적립 날짜, 적립 유형(주문/리뷰 작성), 적립 금액, 누적 금액

--적립금 상세 내역 확인(내역 + 누적금액)
-- procPoints('회원 아이디', '회원 비밀번호');

-- ansi view 생성
create or replace view vwPoints
as
select 
    p.memberSeq as "회원번호",
    p.savedate as "적립날짜",
    pc.category as "적립유형",
    p.point || '원' as "적립금액" 
from tblPoint p
    inner join tblPointCategory pc on p.pcategorySeq = pc.seq;
    
    


-- view + 프로시저 생성
create or replace procedure procPoints (
    pid varchar2,
    ppw varchar2
)
is
    cursor vcursor
    is
    select * from vwPoints where "회원번호" = (select seq from tblMember where id = pid and pw = ppw);
    vrow vwPoints%rowtype;
    vindex number;
    vspace varchar2(2);
    vspace2 varchar2(2);
    vtotal number;
    vname tblMember.name%type;
begin
    
    vindex := 0;
    vspace := ' ';
    vtotal := 0;

    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        select name into vname from tblMember where seq = vrow."회원번호";
        if (to_number(replace(vrow."적립금액", '원', '')) >= 1000) then
            vspace2 := '';
        else 
            vspace2 := ' ';
        end if;
        
        vtotal := vtotal + to_number(replace(vrow."적립금액", '원', ''));
        if (vindex >= 10) then
            vspace := '';
        end if;
        
        if (vindex = 0) then
            dbms_output.put_line('---------- ' || vname || ' (회원번호 ' || vrow."회원번호" || ') 님의 적립 내역 ----------');
            dbms_output.put_line('');
            dbms_output.put_line('  번호    적립날짜    적립유형    적립금액    누적금액');
            vindex := 1;
        end if;     
        

        dbms_output.put_line('   ' || vspace || vindex || '   ' || vrow."적립날짜" || '     ' || vrow."적립유형" || '       ' || vspace2 || vrow."적립금액" || '    ' || vtotal || '원');
        vindex := vindex + 1;
            
    end loop;
    close vcursor;
    
    if (vindex = 0) then
        dbms_output.put_line('--------------------------------------------------');
        dbms_output.put_line(''); dbms_output.put_line('');
        dbms_output.put_line('            적립 내역을 찾을 수 없습니다.');
        dbms_output.put_line(''); 
        
    end if;
    dbms_output.put_line('');
    dbms_output.put_line('--------------------------------------------------');

exception
    when others then
    
        dbms_output.put_line('--------------------------------------------------');    
        dbms_output.put_line('');
        dbms_output.put_line('              내역을 찾을 수 없습니다.');
        dbms_output.put_line('');
        dbms_output.put_line('--------------------------------------------------');    
end;
        
        
    

-- 프로시저 실행        
begin
    procPoints('sineob7', 'CkwPPWmoME%');
end;