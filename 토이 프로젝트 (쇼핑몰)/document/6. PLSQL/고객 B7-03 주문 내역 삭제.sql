--B7-03. 주문 내역 삭제
-- procDeleteOrder('로그인 아이디', '로그인 비밀번호', 주문번호);

-- 프로시저 생성
create or replace procedure procDeleteOrder(
    pid varchar2,
    ppw varchar2,
    porderSeq number
)
is
    vnum number;
begin
    
    select count(*) into vnum from tblOrder where seq = porderSeq and memberSeq = (select seq from tblMember where id = pid and pw = ppw);
    
    if (vnum <> 0) then
        delete from tblShippingItem where orderSeq = porderSeq;
        delete from tblOrderItem where orderSeq = porderSeq;
        delete from tblPay where orderSeq = porderSeq;
        delete from tblOrder where seq = porderSeq;
    
        dbms_output.put_line('--------------------------------------------------------------');
        dbms_output.put_line('');
        dbms_output.put_line('      주문내역 ' || porderSeq || '번 삭제를 완료했습니다.');
        dbms_output.put_line('');
        dbms_output.put_line('--------------------------------------------------------------');

    else
    
        dbms_output.put_line('--------------------------------------------------------------');
        dbms_output.put_line('');
        dbms_output.put_line('                 주문내역 삭제를 실패했습니다.');
        dbms_output.put_line('       아이디, 비밀번호 혹은 주문번호를 다시 확인해 주세요.');
        dbms_output.put_line('');
        dbms_output.put_line('--------------------------------------------------------------');        
    end if;
end;



-- 프로시저 실행, 테스트용 81번 주문 삭제

begin
    procDeleteOrder('hbtqayxe3', 'mDJsjtKohqm%', 81);
end;

