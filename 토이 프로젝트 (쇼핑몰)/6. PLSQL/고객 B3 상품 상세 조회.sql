-->>>>>>>>>>>>>>>>>>>>> B-03 상품조회
-- 상품 상세 조회
create or replace procedure procDisplayDetail(
    pItemSeq in number,
    pCursorOption out sys_refcursor, --상품 옵션
    pCursorItem out sys_refcursor   --상품 설명
)
is
begin
    open pCursorOption for
    select  
        decode(sale, 'Y', 'O', 'N', 'soldout') as 판매여부,
        heel as 굽높이,
        (select name from tblColor where seq = o.colorSeq) as 색상,
        footSize as 사이즈
    from tblOption o 
        where itemSeq = pItemSeq
            order by sale, heel, colorSeq, footSize;

    open pCursorItem for    
    select  
        i.seq as 번호,
        i.name as 상품명,
        i.price as 판매가,
        i.sellingPrice as 할인판매가,
        i.content as 상품설명,
        (select name from tblMaterial where seq = i.materialSeq) as 소재,
        (select name from tblManufacturer where seq = i.manufacturerSeq) as 제조사,
        (select name from tblOrigin where seq = i.originSeq) as 원산지
    from tblItem i
        where seq= pItemSeq;
end;

-- 상품 상세 조회 출력문
create or replace procedure procDisplayDetail_Print(
    pItemSeq in number
)
is
begin
    declare
        vsale varchar2(10);
        vheel number;
        vcolor varchar2(30);
        vFootSize varchar2(20);
        vItemSeq number;
        vName varchar2(30);
        vPrice number;
        vSellingPrice number;
        vContent varchar2(3000);
        vMaterial tblMaterial.name%type;
        vManufacturer  tblManufacturer.name%type;
        vOrigin tblOrigin.name%type;
        vCursorOption sys_refcursor;
        vCursorItem sys_refcursor;
        vPercent varchar(4);
        vpreHeel number;
        vpreColor varchar(30);
    begin
        procDisplayDetail(pItemSeq, vCursorOption, vCursorItem);
        
        dbms_output.put_line('----------------------------------------------------------------');
        loop
        fetch vCursorItem into vItemseq ,vName, vprice, vsellingprice, vContent, vMaterial,  vManufacturer,  vOrigin;
        exit when vCursorItem%notfound;
        vPercent := to_char(((vprice-vsellingprice)/vprice)*100, '99');
        
        dbms_output.put_line('상품: '||vName ||' ('||vItemseq||')');
        dbms_output.put_line('가격: '||vprice||' ──▶ "'||vsellingprice||'"('||vPercent||'%할인 )');
        dbms_output.put_line('');
        dbms_output.put_line('----------------------------------------------------------------');
        dbms_output.put_line('옵션 [ 굽높이   색상      사이즈(mm)]');
                            
            vpreHeel := 0;
            vpreColor:= '없음';
            loop
            fetch vCursorOption into vsale,vheel, vcolor, vFootSize;
            exit when vCursorOption%notfound;
               
            if vSale = 'O' then  dbms_output.put_line('        '||vheel||'cm     '||vcolor||'    '||vfootsize);
            else  dbms_output.put_line('        '||vheel||'cm     '||vcolor||'    '||vfootsize||' (soldout)');
            end if;
               
            end loop;
            
        dbms_output.put_line('----------------------------------------------------------------');
        dbms_output.put_line(' ');
        dbms_output.put_line(vContent);
        dbms_output.put_line('소재: ' || vMaterial);
        dbms_output.put_line('제조사: ' || vManufacturer);
        dbms_output.put_line('원산지: ' || vOrigin);    
        dbms_output.put_line('----------------------------------------------------------------');
        end loop;

        close vCursorItem;
        close vCursorOption;
    
    exception
        when others then
            dbms_output.put_line('--------------------------------');
            dbms_output.put_line(' 상품 상세정보를 불러올 수 없습니다.');
            dbms_output.put_line('--------------------------------');
    end;
end;


-- 상품 상세 조회 실행문
begin
    procDisplayDetail_Print(1);
end;