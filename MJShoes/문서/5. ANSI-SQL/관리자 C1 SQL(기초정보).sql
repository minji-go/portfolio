
-->>>>>>>>>>>>>>>>>>>>> C-01 기초 정보 관리

select * from tblCategory;
insert into tblCategory values(seq, name?);
update tblCategory set name = ? where seq = ?;
delete from tblCategory where seq = ?;


select * from tblMaterial;
insert into tblMaterial values(seq, name?);
update tblMaterial set name = ? where seq = ?;
delete from tblMaterial where seq = ?;

select * from tblColor;
insert into tblColor values(seq, name?);
update tblColor set name = ? where seq = ?;
delete from tblColor where seq = ?;

select * from tblManufacturer;
insert into tblManufacturer values(seq, name?, tel?);
update tblManufacturer set (name, tel) = (select..) where seq = ?;
delete from tblManufacturer where seq = ?;

select * from tblOrigin;
insert into tblOrigin values(seq, name?);
update tblOrigin set name = ? where seq = ?;
delete from tblOrigin where seq = ?;

select * from tblGrade;
insert into tblGrade values(seq, name?, rate?, upgrade?);
update tblGrade set (name, rate, upgrade) = (select..) where seq = ?;
delete from tblGrade where seq = ?;

select * from tblPointCategory;
insert into tblPointCategory values(seq, category?);
update tblPointCategory set category = ? where seq = ?;
delete from tblPointCategory where seq = ?;

select * from tblOrderResult;
insert into tblOrderResult values(seq, name?);
update tblOrderResult set name = ? where seq = ?;
delete from tblOrderResult where seq = ?;
