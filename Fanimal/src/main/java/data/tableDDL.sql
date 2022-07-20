SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;
DROP TABLE "TBLVISIT" CASCADE CONSTRAINTS;
DROP TABLE "TBLOPEN" CASCADE CONSTRAINTS;
DROP TABLE "TBLSTAT" CASCADE CONSTRAINTS;
DROP TABLE "TBLCOMTYPE" CASCADE CONSTRAINTS;
DROP TABLE "TBLADMIN" CASCADE CONSTRAINTS;
DROP TABLE "TBLDIS" CASCADE CONSTRAINTS;
DROP TABLE "TBLDIVCI" CASCADE CONSTRAINTS;
DROP TABLE "TBLDOCTOR" CASCADE CONSTRAINTS;
DROP TABLE "TBLDOSAGE" CASCADE CONSTRAINTS;
DROP TABLE "TBLFAQ" CASCADE CONSTRAINTS;
DROP TABLE "TBLHOSDATE" CASCADE CONSTRAINTS;
DROP TABLE "TBLHOSREVIEW" CASCADE CONSTRAINTS;
DROP TABLE "TBLHOSPITAL" CASCADE CONSTRAINTS;
DROP TABLE "TBLID" CASCADE CONSTRAINTS;
DROP TABLE "TBLINGRED" CASCADE CONSTRAINTS;
DROP TABLE "TBLNDIV" CASCADE CONSTRAINTS;
DROP TABLE "TBLPSURGERY" CASCADE CONSTRAINTS;
DROP TABLE "TBLPVACCIN" CASCADE CONSTRAINTS;
DROP TABLE "TBLPRESC" CASCADE CONSTRAINTS;
DROP TABLE "TBLPRODUCT" CASCADE CONSTRAINTS;
DROP TABLE "TBLPURPOSE" CASCADE CONSTRAINTS;
DROP TABLE "TBLQUESANS" CASCADE CONSTRAINTS;
DROP TABLE "TBLRESHOS" CASCADE CONSTRAINTS;
DROP TABLE "TBLSCHE" CASCADE CONSTRAINTS;
DROP TABLE "TBLSCHEANI" CASCADE CONSTRAINTS;
DROP TABLE "TBLSCHETYPE" CASCADE CONSTRAINTS;
DROP TABLE "TBLSURGERY" CASCADE CONSTRAINTS;
DROP TABLE "TBLANIDIS" CASCADE CONSTRAINTS;
DROP TABLE "TBLANIINFO" CASCADE CONSTRAINTS;
DROP TABLE "TBLANIKIND" CASCADE CONSTRAINTS;
DROP TABLE "TBLANITYPE" CASCADE CONSTRAINTS;
DROP TABLE "TBLANIMAL" CASCADE CONSTRAINTS;
DROP TABLE "TBLANSWER" CASCADE CONSTRAINTS;
DROP TABLE "TBLCOMMU" CASCADE CONSTRAINTS;
DROP TABLE "TBLCOMPANY" CASCADE CONSTRAINTS;
DROP TABLE "TBLUSER" CASCADE CONSTRAINTS;
DROP TABLE "TBLUSERANI" CASCADE CONSTRAINTS;
DROP TABLE "TBLVACCIN" CASCADE CONSTRAINTS;
DROP TABLE "TBLWALKANI" CASCADE CONSTRAINTS;
DROP TABLE "TBLWALKDIARY" CASCADE CONSTRAINTS;
DROP TABLE "TBLNOTICE" CASCADE CONSTRAINTS;
DROP TABLE "TBLCIBBS" CASCADE CONSTRAINTS;
DROP TABLE "TBLCDIARY" CASCADE CONSTRAINTS;
DROP TABLE "TBLQUES" CASCADE CONSTRAINTS;
DROP TABLE "TBLCIANSWER" CASCADE CONSTRAINTS;
DROP TABLE "TBLHASH" CASCADE CONSTRAINTS;
DROP TABLE "TBLPID" CASCADE CONSTRAINTS;
DROP TABLE "TBLPROING" CASCADE CONSTRAINTS;
DROP TABLE "TBLSI" CASCADE CONSTRAINTS;
DROP TABLE "TBLGU" CASCADE CONSTRAINTS;
DROP TABLE "TBLSG" CASCADE CONSTRAINTS;

/* 1. 아이디 */
CREATE TABLE tblId (
	id VARCHAR2(20) NOT NULL, /* 아이디 */
    CONSTRAINT PK_TBLID PRIMARY KEY (id),
    CONSTRAINT tblId_id_ck CHECK (length(id) between 5 and 12)
    
);

/* 2. 타입 */
CREATE TABLE tblAniType (
	tseq NUMBER NOT NULL, /* 타입번호 */
	type VARCHAR2(100) NOT NULL, /* 타입 */
    
    CONSTRAINT PK_TBLANITYPE PRIMARY KEY (tseq)
);

/* 3. 품종 */
CREATE TABLE tblAniKind (
	kseq NUMBER NOT NULL, /* 품종번호 */
	tseq NUMBER NOT NULL, /* 타입번호 */
	kind VARCHAR2(100) NOT NULL, /* 품종 */
    
    CONSTRAINT PK_TBLANIKIND PRIMARY KEY (kseq),
    CONSTRAINT tblAniKind_tseq_fk FOREIGN KEY (tseq) REFERENCES tblAniType (tseq)

);

/* 4. 반려동물 */
CREATE TABLE tblAnimal (
	aseq NUMBER NOT NULL, /* 반려동물번호 */
	name VARCHAR2(15) NOT NULL, /* 이름 */
	gender VARCHAR2(1) NOT NULL, /* 성별 */
	age NUMBER NOT NULL, /* 나이 */
	kseq NUMBER NOT NULL, /* 품종번호 */
	birth DATE NOT NULL, /* 생일 */
    
    CONSTRAINT PK_TBLANIMAL PRIMARY KEY (aseq),
    CONSTRAINT tblAnimal_kseq_fk FOREIGN KEY (kseq)	REFERENCES tblAniKind (kseq),
    
    CONSTRAINT tblAnimal_gender_ck 	CHECK (gender in ('m', 'f')),
    CONSTRAINT tblAnimal_name_ck CHECK (length(name) between 1 and 5)
        
);

/* 5. 반려동물정보 */
CREATE TABLE tblAniInfo (
	aiseq NUMBER NOT NULL, /* 반려동물정보번호 */
	aseq NUMBER NOT NULL, /* 반려동물번호 */
	pic VARCHAR2(100) DEFAULT 'pic.png' NOT NULL, /* 사진 */
	neutral VARCHAR2(1) NOT NULL, /* 중성화수술여부 */
	state VARCHAR2(1) default 'n' NOT NULL, /* 상태 */
	weight NUMBER NOT NULL, /* 무게 */
    
    CONSTRAINT PK_TBLANIINFO PRIMARY KEY (aiseq),
    CONSTRAINT tblAniInfo_aseq_fk FOREIGN KEY (aseq) REFERENCES tblAnimal (aseq),
    
    CONSTRAINT tblAniInfo_neutral_ck CHECK (neutral in ('y', 'n')),
    CONSTRAINT tblAniInfo_state_ck CHECK (state in ('y', 'n'))
    
);

/* 6. 질병 */
CREATE TABLE tblDis (
	dseq NUMBER NOT NULL, /* 질병번호 */
	dname VARCHAR2(100) NOT NULL, /* 질병 */
    
    CONSTRAINT PK_TBLDIS PRIMARY KEY (dseq)
);

/* 7. 동물&질병 */
CREATE TABLE tblAniDis (
	adseq NUMBER NOT NULL, /* 동물질병번호 */
	aseq NUMBER NOT NULL, /* 반려동물번호 */
	dseq NUMBER NOT NULL, /* 질병번호 */
    
    CONSTRAINT PK_TBLANIDIS PRIMARY KEY (adseq),
    CONSTRAINT tblAniDis_aseq_fk FOREIGN KEY (aseq) REFERENCES tblAnimal (aseq),
    CONSTRAINT tblAniDis_dseq_fk FOREIGN KEY (dseq) REFERENCES tblDis (dseq)
);

/* 8. 성분명 */
CREATE TABLE tblIngred (
	iseq NUMBER NOT NULL, /* 성분명번호 */
	component VARCHAR2(150) NOT NULL, /* 성분명 */
    
    CONSTRAINT PK_TBLINGRED PRIMARY KEY (iseq)
);

/* 9. 권장제품 */
CREATE TABLE tblProduct (
	pseq NUMBER NOT NULL, /* 권장제품번호 */
	pname VARCHAR2(300) NOT NULL, /* 권장제품명 */
    
    CONSTRAINT PK_TBLPRODUCT PRIMARY KEY (pseq)
);

/* 10. 제품&성분 */
CREATE TABLE tblProIng (
	proingseq NUMBER NOT NULL, /* 제품성분명 */
	iseq NUMBER NOT NULL, /* 성분명번호 */
	pseq NUMBER NOT NULL, /* 권장제품번호 */
    
    CONSTRAINT PK_tblProIng PRIMARY KEY (proingseq),
    CONSTRAINT tblProIng_pseq_fk FOREIGN KEY (pseq) REFERENCES tblProduct (pseq),
    CONSTRAINT tblProIng_iseq_fk FOREIGN KEY (iseq) REFERENCES tblIngred (iseq)
);

/* 11. 운영요일 */
CREATE TABLE tblOpen (     
	openseq NUMBER NOT NULL, /* 운영요일번호 */             -- *** opneseq -> openseq
	open VARCHAR2(30) NOT NULL, /* 운영요일 */
    
    CONSTRAINT PK_tblOpen PRIMARY KEY (opneseq),

    CONSTRAINT tblOpen_open_ck CHECK (open in ('월', '화', '수', '목', '금', '토', '일', '평일', '주말'))
);

/* 12. 승인상태 */
CREATE TABLE tblStat (
	statseq NUMBER NOT NULL, /* 승인상태번호 */
	stat VARCHAR2(6) NOT NULL, /* 승인상태 */
    
    CONSTRAINT PK_tblStat PRIMARY KEY (statseq),
    CONSTRAINT tblStat_stat_ck CHECK (stat in ('승인', '대기' ,'거절'))
);

/* 13. 기업 */
CREATE TABLE tblCompany (
	cseq NUMBER NOT NULL, /* 기업번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	name VARCHAR2(15) NOT NULL, /* 사용자이름 */
	tel VARCHAR2(30) NOT NULL, /* 전화번호 */
	address VARCHAR2(100) NOT NULL, /* 주소 */
	xcoor NUMBER NOT NULL, /* X좌표 */
	ycoor NUMBER NOT NULL, /* Y좌표 */
	business NUMBER NOT NULL, /* 사업자번호 */
	password VARCHAR2(30) NOT NULL, /* 비밀번호 */
	email VARCHAR2(100) NOT NULL, /* 이메일 */
    
    CONSTRAINT PK_TBLCOMPANY PRIMARY KEY (cseq),
    CONSTRAINT tblCompany_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    
    CONSTRAINT tblCompany_name_ck CHECK (length(name) between 2 and 5),
    CONSTRAINT tblCompany_tel_ck CHECK (tel like '%-%-%'),
    CONSTRAINT tblCompany_business_ck CHECK (length(business) = 13),
    CONSTRAINT tblCompany_password_ck CHECK (length(password) between 8 and 20)

);

/* 14. 병원세부정보 */
CREATE TABLE tblHospital (
	hpseq NUMBER NOT NULL, /* 병원세부정보 */
	hosname VARCHAR2(120) NOT NULL, /* 기업이름 */
	license VARCHAR2(18) NOT NULL, /* 인허가번호 */
	info VARCHAR2(2000) NOT NULL, /* 소개 */
	starttime VARCHAR2(15) NOT NULL, /* 운영시작시간 */
	endtime VARCHAR2(15) NOT NULL, /* 운영종료시간 */
	statseq NUMBER NOT NULL, /* 승인상태번호 */
	cseq NUMBER NOT NULL, /* 기업번호 */
    
    CONSTRAINT PK_TBLHOSPITAL PRIMARY KEY (hpseq),
    CONSTRAINT tblHospital_cseq_fk FOREIGN KEY (cseq) REFERENCES tblCompany (cseq),
    CONSTRAINT tblHospital_statseq_fk FOREIGN KEY (statseq) REFERENCES tblStat (statseq),

    CONSTRAINT tblHospital_license_ck CHECK (length(license) = 18)
    
);

/* 15. 회원 */
CREATE TABLE tblUser (
	useq NUMBER NOT NULL, /* 회원번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	name VARCHAR2(30) NOT NULL, /* 이름 */
	nickname VARCHAR2(30) NOT NULL, /* 닉네임 */
	password VARCHAR2(30) NOT NULL, /* 비밀번호 */
	tel VARCHAR2(30) NOT NULL, /* 전화번호 */
	address VARCHAR2(100) NOT NULL, /* 주소 */
	joindate DATE DEFAULT sysdate NOT NULL, /* 가입시기 */
	xcoor NUMBER NOT NULL, /* X좌표 */
	ycoor NUMBER NOT NULL, /* Y좌표 */
	birth DATE NOT NULL, /* 생년월일 */
    picture VARCHAR2(100) DEFAULT 'pic.png' NOT NULL, /* 사진 */
    
    CONSTRAINT PK_TBLUSER PRIMARY KEY (useq),
    CONSTRAINT tblUser_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    
    CONSTRAINT tblUser_password_ck CHECK (length(password) between 8 and 20),
    CONSTRAINT tblUser_name_ck CHECK (length(name) between 2 and 5),
    CONSTRAINT tblUser_tel_ck CHECK (tel like '010-____-____'),
    CONSTRAINT tblUser_nickname_ck CHECK (length(nickname) between 2 and 10)
);

/* 16. 회원&반려동물 */
CREATE TABLE tblUserAni (
	uaseq NUMBER NOT NULL, /* 회원반려동물번호 */
	useq NUMBER NOT NULL, /* 회원번호 */
	aseq NUMBER NOT NULL, /* 반려동물번호 */
    
    CONSTRAINT PK_TBLUSERANI PRIMARY KEY (uaseq),
    CONSTRAINT tblUserAni_useq_fk FOREIGN KEY (useq) REFERENCES tblUser (useq),
    CONSTRAINT tblUserAni_aseq_fk FOREIGN KEY (aseq) REFERENCES tblAnimal (aseq)
    
);

/* 17. 일정타입 */
CREATE TABLE tblScheType (
	stseq NUMBER NOT NULL, /* 일정타입번호 */
	type VARCHAR2(100) NOT NULL, /* 타입 */
    
    CONSTRAINT PK_TBLSCHETYPE PRIMARY KEY (stseq)
);


/* 18. 방문여부 */
CREATE TABLE tblVisit (
	visitseq NUMBER NOT NULL, /* 방문여부번호 */
	visit VARCHAR2(15) NOT NULL, /* 방문여부 */
    
    CONSTRAINT PK_tblVisit PRIMARY KEY (visitseq),
    CONSTRAINT CK_tblVisit CHECK (visit in('미방문', '방문예정', '방문완료'))
);

/* 19. 방문목적 */
CREATE TABLE tblPurpose (
	pseq NUMBER NOT NULL, /* 방문목적번호 */
	purpose VARCHAR2(30) NOT NULL, /* 목적명 */
    
    CONSTRAINT PK_TBLPURPOSE PRIMARY KEY (pseq)
);



/* 20. 수술 */
CREATE TABLE tblSurgery (
	suseq NUMBER NOT NULL, /* 수술번호 */
	surgery VARCHAR2(100) NOT NULL, /* 수술 */
    
    CONSTRAINT PK_TBLSURGERY PRIMARY KEY (suseq)
);

/* 21. 일정표 */
CREATE TABLE tblSche (
	sseq NUMBER NOT NULL, /* 일정표번호 */
	memo VARCHAR2(150), /* 메모 */
	datetime DATE NOT NULL, /* 날짜시간 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	stseq NUMBER NOT NULL, /* 일정타입번호 */
    
    CONSTRAINT PK_TBLSCHE PRIMARY KEY (sseq),
    CONSTRAINT tblSche_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblSche_stseq_fk FOREIGN KEY (stseq) REFERENCES tblScheType (stseq)
    
);

/* 22. 일정표반려동물 */
CREATE TABLE tblScheAni (
	saseq NUMBER NOT NULL, /* 일정표반려동물번호 */
	sseq NUMBER NOT NULL, /* 일정표번호 */
	aseq NUMBER NOT NULL, /* 반려동물번호 */
    
    CONSTRAINT PK_TBLSCHEANI PRIMARY KEY (saseq),
    CONSTRAINT tblScheAni_sseq_fk FOREIGN KEY (sseq) REFERENCES tblSche (sseq),
    CONSTRAINT tblScheAni_aseq_fk FOREIGN KEY (aseq) REFERENCES tblAnimal (aseq)

);


/* 23. 산책일기 */
CREATE TABLE tblWalkDiary (
	wseq NUMBER NOT NULL, /* 산책일기번호 */
	datetime DATE DEFAULT sysdate NOT NULL, /* 날짜시간 */
	place VARCHAR2(100) NOT NULL, /* 장소 */
	pic VARCHAR2(100), /* 사진 */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	content VARCHAR2(3000) NOT NULL, /* 내용 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
    
    CONSTRAINT PK_TBLWALKDIARY PRIMARY KEY (wseq),
    CONSTRAINT tblWalkDiary_id_fk FOREIGN KEY (id) REFERENCES tblId (id)
    
);

/* 24. 등록구분 */
CREATE TABLE tblDivci (
	dseq NUMBER NOT NULL, /* 등록구분번호 */
	div VARCHAR2(20) NOT NULL, /* 등록구분 */
    
    CONSTRAINT PK_TBLDIVCI PRIMARY KEY (dseq)
);

/* 25. 고객센터 문의사항 */
CREATE TABLE tblCIBbs (
	cibseq NUMBER NOT NULL, /* 고객선테문의사항번호 */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	datetime DATE DEFAULT sysdate NOT NULL, /* 날짜 */
	secret VARCHAR2(1) NOT NULL, /* 비밀글여부 */
	attachFile VARCHAR2(30), /* 참부파일명 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	dseq NUMBER NOT NULL, /* 등록구분번호 */
    
    CONSTRAINT PK_tblCIBbs PRIMARY KEY (cibseq),
    CONSTRAINT tblCIBbs_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblCIBbs_dseq_fk FOREIGN KEY (dseq) REFERENCES tblDivci (dseq),
    
    
    CONSTRAINT tblCIBbs_public_ck CHECK (secret in ('y', 'n'))
);

/* 26. 고객센터문의사항답변 */
CREATE TABLE tblCIAnswer (
	cibaseq NUMBER NOT NULL, /* 고객센터문의사항답변번호 */
	cibseq NUMBER NOT NULL, /* 고객선테문의사항번호 */
	content VARCHAR2(3000) NOT NULL, /* 내용 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	reportDate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
    
    CONSTRAINT PK_tblCIAnswer PRIMARY KEY (cibaseq),
    CONSTRAINT FK_tblId_TO_tblCIAnswer FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblCIAnswer_cibseq_fk FOREIGN KEY (cibseq) REFERENCES tblCIBbs (cibseq)

);

/* 27. 커뮤니티유형 */
CREATE TABLE tblComType (
	typeseq NUMBER NOT NULL, /* 커뮤니티유형번호 */
	comtype VARCHAR2(12) NOT NULL, /* 커뮤니티유형 */
    
    CONSTRAINT PK_tblComType PRIMARY KEY (typeseq)
);

/* 28. 커뮤니티 */
CREATE TABLE tblCommu (
	commuseq NUMBER NOT NULL, /* 커뮤니티번호 */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	postDay DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	readcount NUMBER DEFAULT 0 NOT NULL, /* 조회수 */
	attachFile VARCHAR2(30), /* 첨부파일명 */
	typeseq NUMBER, /* 커뮤니티유형번호 */
	Field VARCHAR2(3000) NOT NULL, /* 내용 */
    
    CONSTRAINT PK_TBLCOMMU PRIMARY KEY (commuseq),
    CONSTRAINT tblCommu_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblCommu_typeseq_fk FOREIGN KEY (typeseq) REFERENCES tblComType (typeseq)

);

/* 29. 해시태그 */
CREATE TABLE tblHash (
	hseq NUMBER NOT NULL, /* 해시태그번호 */
	hash VARCHAR2(20) NOT NULL, /* 해시태그 */
	commuseq NUMBER NOT NULL, /* 커뮤니티번호 */
    
    CONSTRAINT PK_tblHash PRIMARY KEY (hseq),
    CONSTRAINT tblHash_commuseq_fk FOREIGN KEY (commuseq) REFERENCES tblCommu (commuseq)

);

/* 30. 커뮤니티답변 */
CREATE TABLE tblAnswer (
	caseq NUMBER NOT NULL, /* 커뮤니티답변번호 */
	content VARCHAR2(3000) NOT NULL, /* 내용 */
	answerDay DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	comuseq NUMBER NOT NULL, /* 커뮤니티번호 */
    
    CONSTRAINT PK_TBLANSWER PRIMARY KEY (caseq),
    CONSTRAINT tblAnswer_id_fk FOREIGN KEY (id)	REFERENCES tblId (id),
    CONSTRAINT tblAnswer_comuseq_fk FOREIGN KEY (comuseq) REFERENCES tblCommu (commuseq)
    
);

/* 31. 공지사항등록구분 */
CREATE TABLE tblNDiv (
	nDivSeq NUMBER NOT NULL, /* 공지사항등록구분 */
	div VARCHAR2(20) NOT NULL, /* 등록구분 */
    
    CONSTRAINT PK_TBLNDIV PRIMARY KEY (nDivSeq)
);

/* 32. 공지사항 */
CREATE TABLE tblNotice (
	noseq NUMBER NOT NULL, /* 공지사항번호 */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	content VARCHAR2(3000) NOT NULL, /* 내용 */
	readcount NUMBER DEFAULT 0 NOT NULL, /* 조회수 */
	reportDate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	nDivSeq NUMBER NOT NULL, /* 공지사항등록구분 */
    
    CONSTRAINT PK_tblNotice PRIMARY KEY (noseq),
    CONSTRAINT tblNotice_nDivseq_fk FOREIGN KEY (nDivSeq) REFERENCES tblNDiv (nDivSeq),
    CONSTRAINT tblNotice_id_fk FOREIGN KEY (id) REFERENCES tblId (id)

);

/* 33. 접종 */
CREATE TABLE tblVaccin (
	vseq NUMBER NOT NULL, /* 접종번호 */
	vaccination VARCHAR2(100) NOT NULL, /* 접종 */
    
    CONSTRAINT PK_TBLVACCIN PRIMARY KEY (vseq)
);

/* 34. 수의사 */
CREATE TABLE tblDoctor (
	dseq NUMBER NOT NULL, /* 수의사번호 */
	dname VARCHAR2(30) NOT NULL, /* 이름 */
	hpseq NUMBER NOT NULL, /* 병원세부정보 */
	license NUMBER NOT NULL, /* 수의사면허 */
    
    CONSTRAINT PK_TBLDOCTER PRIMARY KEY (dseq),
    CONSTRAINT tblDocter_hpseq_fk FOREIGN KEY (hpseq) REFERENCES tblHospital (hpseq),
    
    CONSTRAINT tblDocter_dname_ck CHECK (length(dname) between 2 and 5),
    CONSTRAINT tblDocter_license_ck CHECK (length(license) = 13)
);

/* 35. 산책일기반려동물 */
CREATE TABLE tblWalkAni (
	seq NUMBER NOT NULL, /* 산책일기반려동물번호 */
	wseq NUMBER NOT NULL, /* 산책일기번호 */
	aseq NUMBER NOT NULL, /* 반려동물번호 */
    
    CONSTRAINT PK_TBLWALKANI PRIMARY KEY (seq),
    CONSTRAINT tblWalkAni_aseq_fk FOREIGN KEY (aseq) REFERENCES tblAnimal (aseq),
    CONSTRAINT tblWalkAni_wseq_fk FOREIGN KEY (wseq) REFERENCES tblWalkDiary (wseq)

);

/* 36. 병원운영요일 */
CREATE TABLE tblHosDate (
	hdseq NUMBER NOT NULL, /* 병원운영요일 */
	hpseq NUMBER NOT NULL, /* 병원세부정보 */
	openseq NUMBER NOT NULL, /* 운영요일번호 */  
    
    CONSTRAINT PK_TBLHOSDATE PRIMARY KEY (hdseq),
    CONSTRAINT tblHosDate_hpseq_fk FOREIGN KEY (hpseq) REFERENCES tblHospital (hpseq),
    CONSTRAINT tblHosDate_openseq_fk FOREIGN KEY (opneseq) REFERENCES tblOpen (opneseq)

);

/* 37. 관리자 */
CREATE TABLE tblAdmin (
	adseq NUMBER NOT NULL, /* 관리자번호 */
	password VARCHAR2(30) NOT NULL, /* 비밀번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
    
    CONSTRAINT PK_TBLADMIN PRIMARY KEY (adseq),
    CONSTRAINT tblAdmin_adseq_fk FOREIGN KEY (id) REFERENCES tblId (id),

    CONSTRAINT tblAdmin_password_ck CHECK (length(password) between 8 and 20)
);


/* 38. 병원리뷰 */
CREATE TABLE tblHosReview (
	hrseq NUMBER NOT NULL, /* 병원리뷰번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	review VARCHAR2(200) NOT NULL, /* 병원리뷰 */
	star NUMBER NOT NULL, /* 별점 */
	redate DATE DEFAULT sysdate NOT NULL, /* 리뷰작성일 */
	hpseq NUMBER NOT NULL, /* 병원세부정보 */
    
    CONSTRAINT PK_TBLHOSREVIEW PRIMARY KEY (hrseq),
    CONSTRAINT tblHosReview_hpseq_fk FOREIGN KEY (hpseq) REFERENCES tblHospital (hpseq),
    CONSTRAINT tblHosReview_id_fk FOREIGN KEY (id) REFERENCES tblId (id),

    CONSTRAINT tblHosReview_star_ck CHECK (star between 1 and 5)
);

/* 39. 병원문의게시판 */
CREATE TABLE tblQues (
	hqseq NUMBER NOT NULL, /* 병원문의게시판번호 */
	cseq NUMBER NOT NULL, /* 기업번호 */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	filed VARCHAR2(3000) NOT NULL, /* 내용 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	postDate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	secret VARCHAR2(1) NOT NULL, /* 비밀글여부 */
    
    CONSTRAINT PK_tblQues PRIMARY KEY (hqseq),
    CONSTRAINT tblQues_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblQues_cseq_fk FOREIGN KEY (cseq) REFERENCES tblCompany (cseq),
    
    CONSTRAINT tblQues_public_ck CHECK (secret in ('y', 'n'))
);

/* 40. 병원문의게시판답변 */
CREATE TABLE tblQuesAns (
	qaseq NUMBER NOT NULL, /* 병원문의게시판답변번호 */
	content VARCHAR2(3000) NOT NULL, /* 답변내용 */
	regdate DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	hqseq NUMBER NOT NULL, /* 병원문의게시판번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
    
    CONSTRAINT PK_TBLQUESANS PRIMARY KEY (qaseq),
    CONSTRAINT tblQuesAns_id_fk FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblQuesAns_hqseq_fk FOREIGN KEY (hqseq) REFERENCES tblQues (hqseq)
);

/* 41. 병원예약날짜 */
CREATE TABLE tblResHos  (
	rhseq NUMBER NOT NULL, /* 병원예약날짜 */
	resdate DATE NOT NULL, /* 예약날짜 */
	visitseq NUMBER NOT NULL, /* 방문여부번호 */
	uniqueness VARCHAR2(2000), /* 특이사항 */
	hpseq NUMBER NOT NULL, /* 병원번호 */
	uaseq NUMBER NOT NULL, /* 회원반려동물번호 */
	pseq NUMBER NOT NULL, /* 방문목적번호 */
	picture VARCHAR2(100) DEFAULT 'pic.png' NOT NULL, /* 사진 */
    
    CONSTRAINT PK_TBLRESHOS PRIMARY KEY (rhseq),
    CONSTRAINT tblResHos_hpseq_fk FOREIGN KEY (hpseq) REFERENCES tblHospital (hpseq),
    CONSTRAINT tblResHos_uaseq_fk FOREIGN KEY (uaseq) REFERENCES tblUserAni (uaseq),
    CONSTRAINT tblResHos_pseq_fk FOREIGN KEY (pseq) REFERENCES tblPurpose (pseq),
    CONSTRAINT tblResHos_visitseq_fk FOREIGN KEY (visitseq) REFERENCES tblVisit (visitseq)
    
);		

/* 42. 복용법 */
CREATE TABLE tblDosage (
	dseq NUMBER NOT NULL, /* 복용법번호 */
	usage VARCHAR2(300) NOT NULL, /* 용법 */
	amount NUMBER NOT NULL, /* 주기 */
	pdate NUMBER NOT NULL, /* 처방일수(투일일수) */
    
    CONSTRAINT PK_TBLDOSAGE PRIMARY KEY (dseq)
);

/* 43. 진료확인서 */
CREATE TABLE tblPresc (
	pseq NUMBER NOT NULL, /* 진료확인서번호 */
	rhseq NUMBER NOT NULL, /* 병원예약날짜 */
	avail NUMBER NOT NULL, /* 처방전유효기간 */
	explain VARCHAR2(1000) NOT NULL, /* 의사설명 */
	dseq NUMBER NOT NULL, /* 수의사번호 */
    
    CONSTRAINT PK_TBLPRESC PRIMARY KEY (pseq),
    CONSTRAINT tblPresc_rhseq_fk FOREIGN KEY (rhseq) REFERENCES tblResHos (rhseq),
    CONSTRAINT tblPresc_dseq_fk	FOREIGN KEY (dseq) REFERENCES tblDoctor (dseq),

    CONSTRAINT tblPresc_duration_ck CHECK (length(avail) between 1 and 7)
);

/* 44. 제품&복용&진료확인서 */
CREATE TABLE tblPID (
	pidseq NUMBER NOT NULL, /* 제품복용진료번호 */
	proingseq NUMBER NOT NULL, /* 제품성분명 */
	dseq NUMBER NOT NULL, /* 복용법번호 */
	pseq NUMBER NOT NULL, /* 진료확인서번호 */
    
    CONSTRAINT PK_tblPID PRIMARY KEY (pidseq),
    CONSTRAINT tblPID_dseq_fk FOREIGN KEY (dseq) REFERENCES tblDosage (dseq),
    CONSTRAINT tblPID_proingseq_fk FOREIGN KEY (proingseq) REFERENCES tblProIng (proingseq),
    CONSTRAINT tblPID_pseq_fk FOREIGN KEY (pseq) REFERENCES tblPresc (pseq)
    
);

/* 45. 수술&처방전 */
CREATE TABLE tblPSurgery (
	psseq NUMBER NOT NULL, /* 수술처방전번호 */
	pseq NUMBER NOT NULL, /* 진료확인서번호 */
	suseq NUMBER NOT NULL, /* 수술번호 */
    
    CONSTRAINT PK_TBLPSURGERY PRIMARY KEY (psseq),
    CONSTRAINT tblPSurgery_pseq_fk FOREIGN KEY (pseq) REFERENCES tblPresc (pseq),
    CONSTRAINT tblPSurgery_suseq_fk FOREIGN KEY (suseq) REFERENCES tblSurgery (suseq)
);

/* 46. 캐어일기 */
CREATE TABLE tblCDiary (
	cdseq NUMBER NOT NULL, /* 캐어일기번호 */
	title VARCHAR2(300) NOT NULL, /* 제목 */
	content VARCHAR2(3000) NOT NULL, /* 내용 */
	datetune DATE DEFAULT sysdate NOT NULL, /* 작성날짜 */
	picture VARCHAR2(100) DEFAULT 'pic.png' NOT NULL, /* 사진 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	pseq NUMBER NOT NULL, /* 진료확인서번호 */
	aseq NUMBER NOT NULL, /* 반려동물번호 */
    
    CONSTRAINT PK_tblCDiary PRIMARY KEY (cdseq),
    CONSTRAINT tblCDiary_id_seq FOREIGN KEY (id) REFERENCES tblId (id),
    CONSTRAINT tblCDiary_pseq_fk FOREIGN KEY (pseq) REFERENCES tblPresc (pseq),
    CONSTRAINT tblCDiary_aseq_fk FOREIGN KEY (aseq) REFERENCES tblAnimal (aseq)

);

/* 47. 접종&처방전 */
CREATE TABLE tblPVaccin (
	pvseq NUMBER NOT NULL, /* 접종처방전번호 */
	pseq NUMBER NOT NULL, /* 진료확인서번호 */
	vseq NUMBER NOT NULL, /* 접종번호 */
    
    CONSTRAINT PK_TBLPVACCIN PRIMARY KEY (pvseq),
    CONSTRAINT tblPVaccin_pseq_fk FOREIGN KEY (pseq) REFERENCES tblPresc (pseq),
    CONSTRAINT tblPVaccin_vseq_fk FOREIGN KEY (vseq) REFERENCES tblVaccin (vseq)
);


/* 48. FAQ */
CREATE TABLE tblFaq (
	faqseq NUMBER NOT NULL, /* FAQ번호 */
	id VARCHAR2(20) NOT NULL, /* 아이디 */
	mainQ VARCHAR2(3000) NOT NULL, /* 질의 */
	mainA VARCHAR2(3000) NOT NULL, /* 응답 */
    
    CONSTRAINT PK_TBLFAQ PRIMARY KEY (faqseq),
    CONSTRAINT tblFaq_id_fk FOREIGN KEY (id) REFERENCES tblId (id)
    
);

/* 49. 시 */
CREATE TABLE tblSi (
   siseq NUMBER NOT NULL, /* 시번호 */
   name VARCHAR2(24) NOT NULL, /* 이름 */
    CONSTRAINT PK_tblSi   PRIMARY KEY (siseq)
);


/* 50. 구 */
CREATE TABLE tblGu (
   guseq NUMBER NOT NULL, /* 구번호 */
   name VARCHAR2(30) NOT NULL, /* 이름 */
    CONSTRAINT PK_tblGu PRIMARY KEY (guseq)
);


/* 52. 지역테이블 */
CREATE TABLE tblSG (
   sgseq NUMBER NOT NULL, /* 지역번호 */
   siseq NUMBER NOT NULL, /* 시번호 */
   guseq NUMBER NOT NULL, /* 구번호 */
    
    CONSTRAINT PK_tblSG PRIMARY KEY (sgseq),
    CONSTRAINT tblSG_siseq_fk FOREIGN KEY (siseq) REFERENCES tblSi (siseq),
    CONSTRAINT FK_tblGu_TO_tblSG_guseq_fk FOREIGN KEY (guseq) REFERENCES tblGu (guseq)
  
);
