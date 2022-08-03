set define off;

-- 적립유형 (구매, 리뷰, 이벤트, 사용)
insert into tblPointCategory (seq, category) values (1, '구매');
insert into tblPointCategory (seq, category) values (2, '리뷰');
insert into tblPointCategory (seq, category) values (3, '이벤트');
insert into tblPointCategory (seq, category) values (4, '사용');


-- 관리자 (5명)
insert into tblAdmin (seq, name, id, pw) values (1, '대표관리', 'admin01', 'Admin01fds');
insert into tblAdmin (seq, name, id, pw) values (2, '상품관리', 'admin02', 'Admin02ape' );
insert into tblAdmin (seq, name, id, pw) values (3, '주문관리', 'admin03', 'Admin03owp');
insert into tblAdmin (seq, name, id, pw) values (4, '고객관리', 'admin04', 'Admin04pao');
insert into tblAdmin (seq, name, id, pw) values (5, '게시판관리', 'admin05', 'Admin05wdx');


-- Q&A 질문
create sequence seqQuestion;
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 13, '발볼 넓은편맞나요', '다른 사이트 스니커즈 신발을 구입했는데 한쪽발 새끼발가락이 아파서 반품했는데 여기는 댓글에 발볼이 넉넉하다기에 구입해보려 합니다.', '2020-08-01');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 17, '싸이즈요', '방금신발 받았는데 정싸이즈라고해서 245 주문했는데 잘못왔나봐요 너무커요~바닥에는38이라고써있는데 250같아요 왜 그런식으로 써있는디 답변주세요', '2021-02-08');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 9, '바쁘시고 번거로우시겠지만 꼼꼼히 검수하셔서 배송부탁드립니다~^^', '방금 재주문했습니다~ 지난번에 스크래치가 약간 난채로 배송와서 교환할까하다 그냥 신었습니다~ 바쁘시고 번거로우시겠지만 제품 꼼꼼히 검수해서 배송부탁드립니다~ 미리 감사드릴게요~^^', '2022-02-05');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 1, '배송 관련 문의 드립니다', '구입 후 예정배송일에 배송이 안되어 문의했을때, 늦어도 월요일까지 배송이 될거라 답변을 받았는데 아직도 배송준비 중으로 조회돼요. 언제 배송되는 건가요?', '2022-02-08');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 3, '택배사', '지정된 택배사 말고 다른 택배사를 이용해서 배송받을 수 있을까요? 집 주변 택배들이 우체국 아니면 너무 느려서...', '2022-04-09');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 5, '사이즈 문의용', '힐 제품들 사이즈 선택 시 평소대로 하면 되는지 한사이즈 크게 주문해야 할지 모르겠네요~ 정사이즈로 나오나요? 발 불편하지 않게 신고싶은데', '2022-04-10');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 28, '배송전 사이즈변경', '주문했는데 한사이즈 크게 보내주실 수 있으신가요? 시키고보니 너무 딱맞을거같아서ㅜ', '2022-04-11');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 15, '이염,물빠짐', '안녕하세요. 네이비색으로 구입했는데.. 편하고 다 좋은데 저녁에 들어와 양말을 보면 발등과 발 바깥 옆부분에 검은물이 들어있어요. 오늘이 3일째인데 양말에 물이 들었어요.. 양말은 빨아도 색이 안지워져서 신발을 앞으로 신고다닐 수 없을 것 같다는 생각이 들어요. 혹시 불량인거면 교환이 가능한지 문의드려요..', '2022-04-10');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 37, '반품신청', '반품신청은 어디로 하면 되죠?', '2022-04-27');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 19, '굽높이 3cm라고 표시되있으면', '속굽포함 3cm인가요? 아님 겉굽만3cm 인가요?', '2022-04-27');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 23, '늘어남', '제가 예전에 신던 신발이 많이 늘어나서 못 신고있는데 혹시 늘어나지는 않는지 궁금합니다. 발이 아파서 되도록이면 편한 신발을 신고 싶거든요', '2022-05-02');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 33, '하자없는 상품으로', '친구한테 생일선물로 선물할건데, 하자없는 상품으로 꼭 검수 잘 해서 보내주세요. 반품 교환 비용 들지 않게... 예쁜 아이로 보내주시길 부탁드립니다', '2022-05-04');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 25, '구매해서 신고있는데', '계속 구매할 예정 이구요 스니커즈 신상컬러는 언제 나오나요 제가 허리가 아파서 걷기편한걸 좋아하는데요 지금까지 구매했었던 온라인쇼핑몰 신발중 최고에요 다른컬러 나오면 종류별로 구매하고싶어요 편한신발 만들어 주셔서 감사해요', '2022-05-05');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 27, '배송', '오늘 주문하면 언제 받을 수 있을까요?? 급하게 사용해야되서 구매하려는데.. 최대한 빠르게 배송 부탁드릴수잇을까요?', '2022-05-07');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 28, '깔창 별도 구매 가능한가요?', '사이즈가 커서 앞으로 발이 자꾸 쏠려요. 한사이즈 큰 깔창만 별도로 구매하고 싶어서요.', '2022-05-08');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 14, '반품, 사이즈교환', '혹시나 시키고나서 안맞으면 무료반품되나요? 사이즈교환이나', '2022-05-10');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 41, '리뉴얼', '예전에 제품 샀었거든요..올해들어 꺼내신고 사무실 갔더니 이쁘다고 사달래서 다시 구입했는데 훨씬 더좋으네요..에어도 있고 굽높이도 더있고 쿠션이 좋으네요..신발윗등부분은 같은데 밑창굽에 에어가있고 굽높이도 더있어요. 2022년 신상으로 보네신건지요? 리뉴얼상품으로 온다면 재구매할께요..답장부탁드려요..', '2022-05-12');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 21, '배송전취소', '좀늦었긴한데 배송되기 전에 취소하고 다시 다른상품으로 구매하고싶은데 처리되나요? 이미 발송됐나요? ㅠㅠㅠ', '2022-05-14');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 2, '제품이', '예전에 구매했던 제품을 재구매하고싶은데 찾아볼수가 없네요 구매내역조회 가능한가요?', '2022-05-15');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 46, '여름신발', '세일계획은 없나요? 구매하고싶은데 가격이 조금 부담돼서 세일만 기다리고있어요', '2022-05-18');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 31, '배송비는', '무조건 2500원인가요 많이시키면 배송비 할인되는지 궁금합니다', '2022-05-19');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 50, '모델분 신발이랑 같이', '코디한 가방이나 옷같은 제품들 궁금한데 문의하면 알려주시나요? 사이트에서 판매하시는거거나 판매계획 잇는것들인지..', '2022-05-28');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 20, '신상', '대량으로 업데이트 언제되나요 이제 여름인데 여름신발종류가 너무 부족한거같아요.. 샌들위주로 부탁드려요 여기신발이 유명하고 편해서 꼭 여기서 주문하고싶은데 ㅜ', '2022-05-30');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 39, '결제시 오류', '주문하려는데 자꾸 결제클릭하면 무한로딩 걸리거나 튕겨버리네요 어떻게해야하죠?', '2022-06-04');
insert into tblQuestion (seq, memberSeq, header, content, regdate) values (seqQuestion.nextVal, 12, '지금 주문하면', '수령까지 얼마나 걸릴까요? 다음주말에 여행갈때 꼭 신고싶은데 그때까지 못받는거면 그냥 오프라인가서 아무거나 사려구요..', '2022-06-05');


-- Q&A 답변(게시판 답변 전용 관리자 5번(게시판관리)으로 통일, 미답변 1건: tblQuestion 25번)
create sequence seqAnswer;
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 1, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 발 사이즈에 따라 개인차가 있으시겠지만 타 쇼핑몰 제품들보다는 넓은 발볼과 넉넉한 사이즈로 보다 편하게 이용 가능하세요. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2020-08-03'); 
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 2, 'Q&A 답변입니다.', '안녕하세요, 고객님! 불편을 드려 죄송합니다. 38 사이즈는 유럽식 표기로, 약 240-245 사이즈인 점 참고 부탁드립니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2021-02-08'); 
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 3, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 저번 주문에 불편을 겪게 해드려 죄송합니다. 꼼꼼한 검수 거쳐 양품 보내드릴 수 있도록 노력하겠습니다! 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-02-07'); 
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 4, 'Q&A 답변입니다.', '안녕하세요, 고객님! 불편을 드려 죄송합니다. 고객님 주문 건 오늘 오후 출고 예정으로 조회됩니다. 기다려 주셔서 감사합니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-02-08');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 5, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 택배사는 저희 제휴 택배사만 이용 가능하신 점 참고 부탁드리겠습니다. 불편을 드려 죄송합니다. T_T 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-04-11');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 6, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 제품에 따라 차이가 있지만 힐 제품들은 보편적으로 한 사이즈(5단위 ▲) 크게 주문해 주시면 큰 불편감 없이 착용하실 수 있습니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-04-11');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 7, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 주문 주신 건 아직 출고 전으로 조회되므로, 문의 주신 대로 사이즈 변경해 출고 도와드리겠습니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-04-11');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 8, 'Q&A 답변입니다.', '안녕하세요, 고객님! 불편을 드려 죄송합니다. 제품에 따라 차이가 있지만, 짙은 색 제품은 밝은 색 옷이나 양말에 이염이 될 수 있는 점 참고 부탁드립니다. T_T 이염 정도가 심해 착용이 불편하시다면 반품으로 진행 도와드리겠습니다. 게시판 문의 및 유선 문의 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-04-11');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 9, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 반품은 반품 택배 접수하신 후 Q&A 게시판 혹은 유선상으로 주문번호 및 송장번호와 함께 신청해 주시면 됩니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-04-28');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 10, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 속굽 포함 약 3cm인 점 참고 부탁드립니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-04-28');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 11, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 개인차가 있을 수 있지만, 저희 쇼핑몰 제품들은 모두 사용감에 따라 알맞게 늘어나 편하게 착용하실 수 있습니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-04');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 12, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 꼼꼼한 검수 거쳐 양품 보내드릴 수 있도록 노력하겠습니다! 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-04');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 13, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 주문 감사드립니다 :) 스니커즈 제품들은 계절에 무관하게 새로운 제품들을 찾아보실 수 있도록 상시 신상품 업데이트를 진행하고 있습니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-09');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 14, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 평일 오전 주문 시 평균 2-3일(주말 및 공휴일 제외, 영업일 기준)으로 제품 받아보실 수 있지만, 주문량 혹은 공급처 수급량에 따라 제품마다 상이할수 있는 점 참고 부탁드립니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-09');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 15, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 죄송하지만 제품 깔창만 별도 구매는 불가능하신 점 참고 부탁드립니다. T_T 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-09');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 16, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 고객 단순 변심 혹은 사이즈 미스의 사유로는 반품배송비 2500원 발생하시는 점 참고 부탁드립니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-11');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 17, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 시즌 제품들은 재판매 시마다 조금씩 리뉴얼을 진행하고 있어 이전에 구매하셨던 제품들과 상이하실 수 있습니다. 이번 시즌오프 전까지 주문 주시면 리뉴얼 버전으로 발송됩니다. :) 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-13');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 18, 'Q&A 답변입니다.', '안녕하세요, 고객님! 불편을 드려 죄송합니다. 주문 주셨던 상품 이미 출고 예정으로 배송 전 취소는 불가능하신 점 참고 부탁드립니다. 제품 받아 보신 후 교환 혹은 반품으로 진행 가능하세요. T_T 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-15');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 19, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 고객님 아이디의 구매내역 조회 시 2020/04/03 주문 건("스니커즈F", "힐H", "워커I"), 2021/12/23 주문 건("스니커즈H", "스니커즈I", "힐I") 확인됩니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-16');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 20, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 아쉽게도 현재 세일이나 기획전 계획은 따로 없으며, 신상품 업데이트 시 추가 할인이나 리뷰 등으로 쌓으실 수 있는 적립금 할인 구매 가능하세요. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-18');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 21, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 배송비는 주문 건 당 부과되며, 제품 합산 결제 금액 5만 원 이상 시 무료인 점 참고 부탁드립니다. 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-19');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 22, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 죄송하지만 저희 쇼핑몰에서는 신발 이외 카테고리는 판매 계획이 없고, 촬영에 사용된 제품들은 모델 개인 소장 소품인 경우도 많아 따로 안내가 어려운 점 양해 부탁드립니다. T_T 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-29');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 23, 'Q&A 답변입니다.', '안녕하세요, 고객님! 저희 쇼핑몰을 찾아주셔서 감사합니다. 현재 여름 맞이 신상품들은 소량 업데이트 된 상태이고, 추후 더 많은 제품들 만나 보실 수 있도록 업데이트 계획 중에 있습니다. 정확한 날짜는 안내가 어려운 점 양해 부탁드립니다. T_T 추가 문의 사항은 게시판 문의 및 유선 문의를 주시면 빠르게 답변 드리겠습니다. 감사합니다. :)', '2022-05-31');
insert into tblAnswer (seq, adminSeq, questionSeq, header, content, regdate) values (seqAnswer.nextVal, 5, 24, 'Q&A 답변입니다.', '안녕하세요, 고객님! 불편을 드려 죄송합니다. 결제 시 브라우저 환경 혹은 네트워크 환경 등에 따라 오류가 발생할 수 있으나, 현재 웹사이트나 시스템 상으로는 오류가 없는 것으로 확인됩니다. 유선상으로 정확한 오류 증상 문의 주시면 빠르게 결제 안내 드리겠습니다. 감사합니다. :)', '2022-06-04');


-- 공지사항 (공지사항 등록 전용 관리자 1번(대표관리) 통일)
create sequence seqNotice;
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, 'AS 및 품질보증기간 안내', '안녕하세요. 아래의 AS 및 품질보증기간에 대한 안내를 확인하시어 쇼핑몰 이용에 참고하시기 바랍니다. 품질보증기간 : 구입일로부터 6개월 (제품의 이상이나 문제가 있을 경우 심의 접수 후 불량 판정 시 교환 및 환불이 가능합니다. 온라인 고객센터를 통해 의뢰 가능합니다.) / 주의사항 : 많은 착화로 인해 소모된 상태의 슈즈는 제품의 문제로 보기 어렵습니다. 고객의 부주의로 인한 A/S 요청시 비용이 발생하거나 무상교환 또는 환불이 불가할 수 있습니다. 구입처와 구입일 확인을 위해 영수증 또는 사진을 꼭 보관해 주십시오. 감사합니다.', '2020-05-04');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '회원 등급에 따른 적립률 안내', '안녕하세요. 저희 쇼핑몰을 사랑해 주시는 고객님들께 감사의 말씀을 드립니다. 저희 쇼핑몰은 회원 등급(일반회원, VIP회원, VVIP회원)에 따라 적립률 혜택을 드리는 제도를 운영 중에 있습니다. 등급에 따른 적립률은 일반회원 3%, VIP회원 7%, VVIP회원 10%입니다. 관련 문의 사항은 고객 센터로 연락 부탁 드립니다. 항상 더 좋은 상품과 서비스로 찾아뵐 수 있도록 최선을 다하겠습니다. 감사합니다.', '2020-05-11');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '물류센터 확장 이전 관련 배송안내', '저희 쇼핑몰을 사랑해 주시는 고객님께 양해의 말씀을 드립니다. 7일~10일 물류센터 확장 이전이 진행되었습니다. 주말 그리고 어제까지도 업무를 진행하고 있으나 부족한 부분이 있습니다. 정상화 전까지 상품 발송, 반품 및 교환접수가 평소대비 1~3일 정도 지연될 수 있습니다. 양해 부탁드립니다. 빠르게 정상화할 수 있도록 노력하겠습니다. 감사합니다.', '2021-09-14');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '당일 발송 시간변경 안내', '안녕하세요. 저희 쇼핑몰을 이용해 주시는 고객 여러분께 감사 드리며, 당일 발송 시간 변경 안내드립니다. 당일 발송 시간이 오후 2시에서 오후 4시로 변경됨을 알려드립니다. 제품 수급처의 상황에 따라 예외적으로 변경될 수 있는 점 참고 부탁드립니다. 고객님께 좋은 서비스를 할 수 있도록 항상 최선의 노력을 다하겠습니다. 감사합니다.', '2021-09-28');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, 'CS & 배송지연관련 공지', '안녕하세요. 현재 블랙프라이데이 주문량 폭주로 상품 배송 , CS, 교환/반품 응대가 지연되고 있습니다. 배송&당일배송 : 구매 순으로 순차적으로 배송 진행되고 있으며 평소보다 배송이 평소보다 하루정도 지연되는 점 양해 부탁드립니다. / CS : 전화 연결이 원활하지 않으니 게시판에 문의 글을 남겨주시면 순서대로 처리하겠습니다. 교환/반품 : 도착 순서대로 진행을 하고 있으며 평소보다 2~3일 지연되는 점 양해 부탁드립니다. 최대한 빠른 시일 내에 정상화될 수 있도록 노력하겠습니다. 감사합니다.', '2021-11-15');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '교환/반품 처리 지연 & 게시판 운영 시간 변경', '안녕하세요. 일부 지역 택배파업으로 교환/반품 회수가 지연되던 물량이 한 번에 유입되면서 교환/반품 처리가 평소보다 2~3일 정도 늦어지고 있는 상황입니다. 도착한 순서대로 처리를 하고 있으며 빠른 정상화를 위해 노력하겠습니다. 교환/반품을 우선순위로 정상화하기 위해 가능한 인원이 모두 투입을 해야 하는 상황이라 게시판 운영시간을 기존 17시 -> 13시로 변경 운영하니 이점 참고 부탁드립니다. 서비스 이용에 불편을 드려 죄송합니다. 최대한 빠른 시일 내에 정상화될 수 있도록 노력하겠습니다. 감사합니다.', '2021-12-06');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '택배 파업으로 인한 배송 지연 공지', '안녕하세요. 택배 파업으로 인해 일부지역이 배송,교환,반품이 불가한 상황이 발생하고 있습니다. 파업 지역을 확인 후 주문 부탁드리겠습니다. 이용에 불편을 드려 죄송합니다. 배송불가 지역은 다른 택배로 발송을 위해 협의중에 있습니다. 빠른 정상화를 위해 노력하겠습니다.', '2021-12-29');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '설 연휴 배송 휴무 안내', '안녕하세요. 저희 쇼핑몰을 이용해 주시는 고객 여러분께 감사 드리며, 설 연휴 기간동안 배송 휴무 관련 안내드립니다. 변경사항을 확인하시고 서비스 이용에 참고하여 주시기 바랍니다. ※ 배송 마감일: 1월28일 15시 배송마감 / ※ 1월28일 15시 이후 출고건은 2월 3일부터 순차 배송 / ※ 반품 수거일: 2월3일부터 순차적으로 수거가 진행됩니다. 감사합니다.', '2022-01-27');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '평생회원 가입 서비스 종료 안내', '안녕하세요. 개인정보보호위원회에서 개인정보 보호법 2차 개정안 입법을 예고하고 있어, 이에 맞춰 저희 쇼핑몰도 현재 제공중인 평생회원 가입 서비스 기능 종료 예정으로 안내 드립니다. 종료 일정: 2022년 3월 31일(목) / 종료 서비스: 평생회원 가입 서비스 / 평생회원 ? 일반회원 전환일: 2022년 3월 31일, 일괄 전환 감사합니다.', '2022-02-28');
insert into tblNotice (seq, adminSeq, header, content, regdate) values (seqNotice.nextVal, 1, '[2022년 6월] 카드사 무이자 할부 안내', '기간 : 2022년 6월 1일 ~ 2022년 6월 30일 / 금액 : 5만원 이상 / 무이자 대상 카드사 : 하나카드 (하나SK/외환), 비씨카드, 현대카드, KB국민카드, 삼성카드 / 무이자 대상 할부 개월수 : 2, 3, 4, 5, 6개월 무이자 ※ 상기행사는 카드사 사정에 의해 변경 및 중단될 수 있습니다. 자세한 사항은 각 카드사 홈페이지를 참조 바랍니다. 감사합니다.', '2022-05-30');



-- 배송(tblShipping) + 배송상품(tblShippingItem) + 주문상품내역 컬럼 바꾸기(update)
-- tblOrder order by orderdate (날짜순)으로 처리

create sequence seqShipping;
create sequence seqShippingItem;

update tblOrderItem set resultSeq = 3 where orderSeq = 60;
update tblOrderItem set processed = 'Y' where orderSeq = 60;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202003065320', '2020-03-06', '2020-03-10');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 1, 60, 12);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 1, 60, 195);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 1, 60, 329);

update tblOrderItem set resultSeq = 3 where orderSeq = 10;
update tblOrderItem set processed = 'Y' where orderSeq = 10;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202003170250', '2020-03-17', '2020-03-19');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 2, 10, 130);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 2, 10, 271);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 2, 10, 459);

update tblOrderItem set resultSeq = 3 where orderSeq = 14;
update tblOrderItem set processed = 'Y' where orderSeq = 14;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202003182170', '2020-03-18', '2020-03-20');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 3, 14, 226);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 3, 14, 408);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 3, 14, 836);

update tblOrderItem set resultSeq = 3 where orderSeq = 41;
update tblOrderItem set processed = 'Y' where orderSeq = 41;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202004039891', '2020-04-03', '2020-04-07');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 4, 41, 107);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 4, 41, 296);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 4, 41, 414);

update tblOrderItem set resultSeq = 3 where orderSeq = 2;
update tblOrderItem set processed = 'Y' where orderSeq = 2;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202004032619', '2020-04-03', '2020-04-07');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 5, 2, 547);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 5, 2, 1399);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 5, 2, 1792);

update tblOrderItem set resultSeq = 3 where orderSeq = 48;
update tblOrderItem set processed = 'Y' where orderSeq = 48;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202005042112', '2020-05-04', '2020-05-06');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 6, 48, 1111);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 6, 48, 1339);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 6, 48, 1573);

update tblOrderItem set resultSeq = 3 where orderSeq = 45;
update tblOrderItem set processed = 'Y' where orderSeq = 45;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202005257739', '2020-05-25', '2020-05-28');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 7, 45, 209);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 7, 45, 341);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 7, 45, 474);

update tblOrderItem set resultSeq = 3 where orderSeq = 32;
update tblOrderItem set processed = 'Y' where orderSeq = 32;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202006159617', '2020-06-15', '2020-06-18');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 8, 32, 126);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 8, 32, 328);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 8, 32, 455);

update tblOrderItem set resultSeq = 3 where orderSeq = 4;
update tblOrderItem set processed = 'Y' where orderSeq = 4;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202007083027', '2020-07-08', '2020-07-11');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 9, 4, 271);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 9, 4, 459);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 9, 4, 853);

update tblOrderItem set resultSeq = 3 where orderSeq = 40;
update tblOrderItem set processed = 'Y' where orderSeq = 40;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202007228987', '2020-07-22', '2020-07-24');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 10, 40, 104);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 10, 40, 229);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 10, 40, 411);

update tblOrderItem set resultSeq = 3 where orderSeq = 49;
update tblOrderItem set processed = 'Y' where orderSeq = 49;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202008069912', '2020-08-06', '2020-08-08');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 11, 49, 22);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 11, 49, 152);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 11, 49, 345);

update tblOrderItem set resultSeq = 3 where orderSeq = 56;
update tblOrderItem set processed = 'Y' where orderSeq = 56;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202008063227', '2020-08-06', '2020-08-10');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 12, 56, 139);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 12, 56, 281);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 12, 56, 468);

update tblOrderItem set resultSeq = 3 where orderSeq = 65;
update tblOrderItem set processed = 'Y' where orderSeq = 65;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202008107711', '2020-08-10', '2020-08-12');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 13, 65, 340);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 13, 65, 473);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 13, 65, 906);

update tblOrderItem set resultSeq = 3 where orderSeq = 36;
update tblOrderItem set processed = 'Y' where orderSeq = 36;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202008181102', '2020-08-18', '2020-08-20');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 14, 36, 309);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 14, 36, 798);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 14, 36, 1081);

update tblOrderItem set resultSeq = 3 where orderSeq = 42;
update tblOrderItem set processed = 'Y' where orderSeq = 42;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202008243397', '2020-08-24', '2020-08-27');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 15, 42, 376);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 15, 42, 507);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 15, 42, 894);

update tblOrderItem set resultSeq = 3 where orderSeq = 21;
update tblOrderItem set processed = 'Y' where orderSeq = 21;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202010052209', '2020-10-05', '2020-10-08');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 16, 21, 200);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 16, 21, 378);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 16, 21, 509);

update tblOrderItem set resultSeq = 3 where orderSeq = 66;
update tblOrderItem set processed = 'Y' where orderSeq = 66;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202102058322', '2021-02-05', '2021-02-09');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 17, 66, 211);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 17, 66, 343);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 17, 66, 476);

update tblOrderItem set resultSeq = 3 where orderSeq = 63;
update tblOrderItem set processed = 'Y' where orderSeq = 63;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202102263279', '2021-02-26', '2021-03-02');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 18, 63, 250);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 18, 63, 426);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 18, 63, 815);

update tblOrderItem set resultSeq = 3 where orderSeq = 37;
update tblOrderItem set processed = 'Y' where orderSeq = 37;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202102269901', '2021-02-26', '2021-03-03');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 19, 37, 127);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 19, 37, 268);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 19, 37, 419);

update tblOrderItem set resultSeq = 3 where orderSeq = 18;
update tblOrderItem set processed = 'Y' where orderSeq = 18;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202103091009', '2021-03-09', '2021-03-11');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 20, 18, 366);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 20, 18, 1111);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 20, 18, 1339);

update tblOrderItem set resultSeq = 3 where orderSeq = 3;
update tblOrderItem set processed = 'Y' where orderSeq = 3;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202103172292', '2020-03-17', '2020-03-18');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 21, 3, 66);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 21, 3, 245);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 21, 3, 373);

update tblOrderItem set resultSeq = 3 where orderSeq = 17;
update tblOrderItem set processed = 'Y' where orderSeq = 17;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202103229955', '2021-03-22', '2021-03-26');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 22, 17, 395);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 22, 17, 522);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 22, 17, 954);

update tblOrderItem set resultSeq = 3 where orderSeq = 9;
update tblOrderItem set processed = 'Y' where orderSeq = 9;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202103220012', '2021-03-22', '2021-03-23');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 23, 9, 214);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 23, 9, 394);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 23, 9, 521);

update tblOrderItem set resultSeq = 3 where orderSeq = 47;
update tblOrderItem set processed = 'Y' where orderSeq = 47;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202104128816', '2021-04-12', '2021-04-15');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 24, 47, 83);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 24, 47, 266);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 24, 47, 390);

update tblOrderItem set resultSeq = 3 where orderSeq = 30;
update tblOrderItem set processed = 'Y' where orderSeq = 30;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202104239775', '2021-04-23', '2021-04-27');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 25, 30, 108);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 25, 30, 297);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 25, 30, 415);

update tblOrderItem set resultSeq = 3 where orderSeq = 43;
update tblOrderItem set processed = 'Y' where orderSeq = 43;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202104266632', '2021-04-26', '2021-04-29');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 26, 43, 319);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 26, 43, 934);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 26, 43, 1120);

update tblOrderItem set resultSeq = 3 where orderSeq = 29;
update tblOrderItem set processed = 'Y' where orderSeq = 29;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202106146621', '2021-06-14', '2021-06-15');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 27, 29, 304);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 27, 29, 793);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 27, 29, 1044);

update tblOrderItem set resultSeq = 3 where orderSeq = 39;
update tblOrderItem set processed = 'Y' where orderSeq = 39;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202106251238', '2021-06-25', '2021-06-29');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 28, 39, 399);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 28, 39, 827);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 28, 39, 958);

update tblOrderItem set resultSeq = 3 where orderSeq = 23;
update tblOrderItem set processed = 'Y' where orderSeq = 23;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202107153272', '2021-07-15', '2021-07-19');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 29, 23, 716);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 29, 23, 1216);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 29, 23, 1653);

update tblOrderItem set resultSeq = 3 where orderSeq = 13;
update tblOrderItem set processed = 'Y' where orderSeq = 13;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202107169912', '2021-07-16', '2021-07-20');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 30, 13, 340);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 30, 13, 473);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 30, 13, 906);

update tblOrderItem set resultSeq = 3 where orderSeq = 27;
update tblOrderItem set processed = 'Y' where orderSeq = 27;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202107263391', '2021-07-26', '2021-07-28');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 31, 27, 422);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 31, 27, 868);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 31, 27, 1042);

update tblOrderItem set resultSeq = 3 where orderSeq = 53;
update tblOrderItem set processed = 'Y' where orderSeq = 53;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202108181512', '2021-08-18', '2021-08-20');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 32, 53, 271);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 32, 53, 459);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 32, 53, 853);

update tblOrderItem set resultSeq = 3 where orderSeq = 20;
update tblOrderItem set processed = 'Y' where orderSeq = 20;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202108191101', '2021-08-19', '2021-08-23');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 33, 20, 200);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 33, 20, 378);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 33, 20, 509);

update tblOrderItem set resultSeq = 3 where orderSeq = 31;
update tblOrderItem set processed = 'Y' where orderSeq = 31;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202108249991', '2021-08-24', '2021-08-26');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 34, 31, 307);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 34, 31, 796);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 34, 31, 1047);

update tblOrderItem set resultSeq = 3 where orderSeq = 16;
update tblOrderItem set processed = 'Y' where orderSeq = 16;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202108249917', '2021-08-24', '2021-08-26');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 35, 16, 469);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 35, 16, 858);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 35, 16, 1030);

update tblOrderItem set resultSeq = 3 where orderSeq = 69;
update tblOrderItem set processed = 'Y' where orderSeq = 69;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202109060016', '2021-09-06', '2021-09-09');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 36, 69, 615);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 36, 69, 869);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 36, 69, 1108);

update tblOrderItem set resultSeq = 3 where orderSeq = 7;
update tblOrderItem set processed = 'Y' where orderSeq = 7;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202109170012', '2021-09-17', '2021-09-24');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 37, 7, 155);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 37, 7, 299);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 37, 7, 435);

update tblOrderItem set resultSeq = 3 where orderSeq = 8;
update tblOrderItem set processed = 'Y' where orderSeq = 8;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202110056217', '2021-10-05', '2021-10-08');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 38, 8, 266);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 38, 8, 390);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 38, 8, 821);

update tblOrderItem set resultSeq = 3 where orderSeq = 11;
update tblOrderItem set processed = 'Y' where orderSeq = 11;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202110131000', '2021-10-13', '2021-10-15');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 39, 11, 263);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 39, 11, 452);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 39, 11, 851);

update tblOrderItem set resultSeq = 3 where orderSeq = 26;
update tblOrderItem set processed = 'Y' where orderSeq = 26;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202110126633', '2021-10-12', '2021-10-15');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 40, 26, 323);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 40, 26, 447);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 40, 26, 883);

update tblOrderItem set resultSeq = 3 where orderSeq = 19;
update tblOrderItem set processed = 'Y' where orderSeq = 19;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111080812', '2021-11-08', '2021-11-10');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 41, 19, 410);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 41, 19, 838);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 41, 19, 995);

update tblOrderItem set resultSeq = 3 where orderSeq = 62;
update tblOrderItem set processed = 'Y' where orderSeq = 62;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111088182', '2021-11-08', '2021-11-09');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 42, 62, 282);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 42, 62, 469);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 42, 62, 858);

update tblOrderItem set resultSeq = 3 where orderSeq = 46;
update tblOrderItem set processed = 'Y' where orderSeq = 46;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111081216', '2021-11-08', '2021-11-10');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 43, 46, 80);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 43, 46, 208);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 43, 46, 387);

update tblOrderItem set resultSeq = 3 where orderSeq = 28;
update tblOrderItem set processed = 'Y' where orderSeq = 28;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111093270', '2021-11-09', '2021-11-11');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 44, 28, 1);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 44, 28, 187);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 44, 28, 875);

update tblOrderItem set resultSeq = 3 where orderSeq = 38;
update tblOrderItem set processed = 'Y' where orderSeq = 38;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111180162', '2021-11-18', '2021-11-20');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 45, 38, 184);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 45, 38, 844);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 45, 38, 1012);

update tblOrderItem set resultSeq = 3 where orderSeq = 12;
update tblOrderItem set processed = 'Y' where orderSeq = 12;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111198829', '2021-11-19', '2021-11-23');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 46, 12, 24);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 46, 12, 216);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 46, 12, 347);

update tblOrderItem set resultSeq = 3 where orderSeq = 22;
update tblOrderItem set processed = 'Y' where orderSeq = 22;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202111239071', '2021-11-23', '2021-11-24');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 47, 22, 13);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 47, 22, 133);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 47, 22, 332);

update tblOrderItem set resultSeq = 3 where orderSeq = 57;
update tblOrderItem set processed = 'Y' where orderSeq = 57;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202112030926', '2021-12-03', '2021-12-06');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 48, 57, 276);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 48, 57, 398);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 48, 57, 826);

update tblOrderItem set resultSeq = 3 where orderSeq = 34;
update tblOrderItem set processed = 'Y' where orderSeq = 34;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202112091122', '2021-12-09', '2021-12-11');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 49, 34, 141);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 49, 34, 283);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 49, 34, 470);

update tblOrderItem set resultSeq = 3 where orderSeq = 51;
update tblOrderItem set processed = 'Y' where orderSeq = 51;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202112239912', '2021-12-23', '2021-12-24');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 50, 51, 702);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 50, 51, 807);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 50, 51, 1471);

update tblOrderItem set resultSeq = 3 where orderSeq = 68;
update tblOrderItem set processed = 'Y' where orderSeq = 68;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202201108022', '2022-01-10', '2022-01-12');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 51, 68, 378);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 51, 68, 509);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 51, 68, 896);

update tblOrderItem set resultSeq = 3 where orderSeq = 35;
update tblOrderItem set processed = 'Y' where orderSeq = 35;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202201132168', '2022-01-13', '2022-01-15');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 52, 35, 187);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 52, 35, 875);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 52, 35, 1053);

update tblOrderItem set resultSeq = 3 where orderSeq = 6;
update tblOrderItem set processed = 'Y' where orderSeq = 6;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202032161', '2022-02-03', '2022-02-04');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 53, 6, 323);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 53, 6, 447);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 53, 6, 883);

update tblOrderItem set resultSeq = 3 where orderSeq = 1;
update tblOrderItem set processed = 'Y' where orderSeq = 1;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202073332', '2022-02-07', '2022-02-10');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 54, 1, 143);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 54, 1, 339);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 54, 1, 472);

update tblOrderItem set resultSeq = 3 where orderSeq = 64;
update tblOrderItem set processed = 'Y' where orderSeq = 64;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202087291', '2022-02-08', '2022-02-10');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 55, 64, 140);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 55, 64, 282);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 55, 64, 469);

update tblOrderItem set resultSeq = 3 where orderSeq = 58;
update tblOrderItem set processed = 'Y' where orderSeq = 58;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202082162', '2022-02-08', '2022-02-09');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 56, 58, 161);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 56, 58, 351);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 56, 58, 490);

update tblOrderItem set resultSeq = 3 where orderSeq = 33;
update tblOrderItem set processed = 'Y' where orderSeq = 33;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202142317', '2022-02-14', '2022-02-16');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 57, 33, 257);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 57, 33, 383);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 57, 33, 817);

update tblOrderItem set resultSeq = 3 where orderSeq = 52;
update tblOrderItem set processed = 'Y' where orderSeq = 52;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202221729', '2022-02-22', '2022-02-24');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 58, 52, 274);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 58, 52, 396);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 58, 52, 523);

update tblOrderItem set resultSeq = 3 where orderSeq = 44;
update tblOrderItem set processed = 'Y' where orderSeq = 44;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202202223216', '2022-02-22', '2022-02-23');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 59, 44, 216);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 59, 44, 347);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 59, 44, 483);

update tblOrderItem set resultSeq = 3 where orderSeq = 24;
update tblOrderItem set processed = 'Y' where orderSeq = 24;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202203073112', '2022-03-07', '2022-03-08');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 60, 24, 267);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 60, 24, 391);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 60, 24, 822);

update tblOrderItem set resultSeq = 3 where orderSeq = 54;
update tblOrderItem set processed = 'Y' where orderSeq = 54;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202203102639', '2022-03-10', '2022-03-12');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 61, 54, 154);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 61, 54, 298);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 61, 54, 422);

update tblOrderItem set resultSeq = 3 where orderSeq = 55;
update tblOrderItem set processed = 'Y' where orderSeq = 55;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202203219918', '2022-03-21', '2022-03-22');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 62, 55, 265);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 62, 55, 389);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 62, 55, 518);

update tblOrderItem set resultSeq = 3 where orderSeq = 50;
update tblOrderItem set processed = 'Y' where orderSeq = 50;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202203212152', '2022-03-21', '2022-03-24');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 63, 50, 211);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 63, 50, 343);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 63, 50, 476);

update tblOrderItem set resultSeq = 3 where orderSeq = 25;
update tblOrderItem set processed = 'Y' where orderSeq = 25;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202203231292', '2022-03-23', '2022-03-25');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 64, 25, 450);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 64, 25, 849);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 64, 25, 1019);

update tblOrderItem set resultSeq = 3 where orderSeq = 5;
update tblOrderItem set processed = 'Y' where orderSeq = 5;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202204011883', '2022-04-01', '2022-04-05');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 65, 5, 115);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 65, 5, 320);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 65, 5, 444);

update tblOrderItem set resultSeq = 3 where orderSeq = 15;
update tblOrderItem set processed = 'Y' where orderSeq = 15;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202204052881', '2022-04-05', '2022-04-06');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 66, 15, 86);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 66, 15, 213);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 66, 15, 393);

update tblOrderItem set resultSeq = 3 where orderSeq = 61;
update tblOrderItem set processed = 'Y' where orderSeq = 61;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202204115521', '2022-04-11', '2022-04-13');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 67, 61, 316);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 67, 61, 878);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 67, 61, 1085);

update tblOrderItem set resultSeq = 3 where orderSeq = 71;
update tblOrderItem set processed = 'Y' where orderSeq = 71;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202204251242', '2022-04-25', '2022-04-26');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 68, 71, 335);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 68, 71, 465);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 68, 71, 899);

update tblOrderItem set resultSeq = 3 where orderSeq = 70;
update tblOrderItem set processed = 'Y' where orderSeq = 70;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202205046214', '2022-05-04', '2022-05-06');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 69, 70, 197);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 69, 70, 331);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 69, 70, 458);

update tblOrderItem set resultSeq = 3 where orderSeq = 59;
update tblOrderItem set processed = 'Y' where orderSeq = 59;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202205116618', '2022-05-11', '2022-05-14');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 70, 59, 335);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 70, 59, 465);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 70, 59, 899);

update tblOrderItem set resultSeq = 3 where orderSeq = 67;
update tblOrderItem set processed = 'Y' where orderSeq = 67;
insert into tblShipping (seq, company, trackingNum, beginDate, endDate) values (seqShipping.nextVal, 'CJ대한통운', '202205123162', '2022-05-12', '2022-05-14');
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 71, 67, 330);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 71, 67, 457);
insert into tblShippingItem (seq, shippingSeq, orderSeq, optionSeq) values (seqShippingItem.nextVal, 71, 67, 892);


-- 고객리뷰 (인기상품옵션 위주 20개)
create sequence seqReview;

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 4, 459, 5, '발 볼이 넓고 약간 평발이라 조금만 비좁아도 발이 아프더라구요 살까 말까 오조억번 고민하다가 도전해보자는 마음으로 구매했어요 ! 반사이즈 업해서 구매할까 하다가 240으로 주문했는데 다행히 여유있게 맞아서 편했습니다', '2020-07-13');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 10, 459, 4, '아주편해요~~ 정사이즈 사길 잘한것 같아용 사이즈업 샀으면 살짝 컸을듯 일단 굽이 키높이도 살짝 있어서 좋구 무엇보다 발이 너무편해용 강추입니다♡♡', '2020-03-21');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 53, 459, 3, '후기와 비슷하게 착화감은 괜찮은 것 같아요. 굽도 높다고 하셨는데 저는 구두를 많이 신다보니 높게 느껴지지는 않았고 편하게 느껴졌습니다. 그런데 색이 화면으로 보는 색상과 다르다고 해야하나 그렇게 저는 느꼈습니다.', '2021-08-25');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 20, 509, 5, '235 사이즈 구매, 발볼, 특히 발등 높아서 평소 구두는 235 신고 슬립온이나 운동화는 무조건 240 신는데 정사이즈 추천하셔서 235 주문했는데 전혀 불편함 없고 딱 좋습니다. 전혀 불편함 없으니 믿고 정사이즈추천드려요!', '2021-08-24');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 21, 509, 5, '일주일정도 신어본 후기입니다! 착화감 굿이네요! 생각보다 더 넉넉하고 편안해요 처음에 냄새가 좀 나지맘 하루 정도 밖에 두었더니 냄새는 다 빠졌구요 정말 예쁘네뇨 편안한 것은 물론!', '2020-10-14');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 68, 509, 4, '막 신고다닐껄로 구입했는데 가격은 저렴하지만 마감 깔끔하고 편하네요. 일반 스니커즈보다 굽이 높아서 키도 더 커보이는것 같구요. 치마에든 데님에든 잘 어울릴것 같아요.', '2022-01-14');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 16, 469, 5, '너무이뻐요 속굽이있어서 그런지 쿠션감도 정말 좋은데, 약간 마감부분이 살에 닿을때 쫌 불편하긴해요 총평: 가성비굿 양말신고 신으세요 꼭', '2021-08-26');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 62, 469, 4, '베이지색 구매했는데 예뻐요!! 본드자국이 좀 있었지만 괜찮아요 무게가 좀 있어서 그런지 발뒤꿈치쪽이 걸을때 조금 헐떡거리긴 하는데, 그렇게 무겁진 않아요 걸을 때 불편함은 전혀 없어요~ 여기저기 신기 좋아요', '2021-11-13');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 64, 469, 1, '사고서 안신고 두다가 신은날에 눈 왔는데 신발 다 벌어졌어요.. 무슨 물만 닿으면 다 벌어지는 신발이 어딨나요ㅠㅠ 실망입니다 시간 지나 반품신청도 못하고, 차라리 몇만원 더 보태서 비싼 운동화 신는 게 나을것같아요', '2022-02-16');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 18, 1111, 5, '일단 7cm임에도 많이 불편하거나 높은 느낌은 없고 라인이 아주아주 예쁘게 잘빠졌어요! 웨딩촬영에 쓰려고 밝은색 주문했는데 다른 색상도 탐나네요. 265도 여러 디자인 많이 많들어주세요~~', '2021-03-11');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 18, 1339, 4, '같이시킨 다른 신발은 편안했는데 이건 굽이 좀더 낮은데도 살짝 불편하네요 ㅠ 그래도 사이즈는 잘 맞았고 265사이즈 힐 파는곳은 별로 없어서 만족합니다!', '2021-03-12');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 13, 906, 5, '평소 발사이즈가 240~245 사이라 작게나왔다는 말에 250을 살까 고민하다 그냥 245로 샀는데 적당히 널널하고 좋아요! 안에 양말 신으면 딱 맞을 것 같아요~ 그리고 진심 예쁘네요ㅜㅜ이런 신발 갖고싶었는데 좋아요', '2021-07-24');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 65, 906, 5, '일단 너무 편해요 ㅎㅎ 밝은색 운동화 필요했는데 발모양도 슬림하게 나와서 부해보이지 않고 완전 캐주얼룩에도 또는 여성스러운 꾸안꾸룩에도 잘 신을꺼같네용 ㅎㅎ', '2020-08-15');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 16, 858, 5, '존예ㅠㅠ 기본 컨버스지만 예쁜 라벤더색과 앞코 디테일이랑 스티치, 뒤에 로고까지 귀여운 디테일을 다 모아놓은 느낌이라서 만족스럽습니다! 발볼 부자인데 끼이는 느낌도 없고 너무 마음에 들어요!', '2021-08-27');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 62, 858, 1, '발은 편한데 너무황당해요. 운동화끈 길이가 틀려요. 한쪽은 끈길이가 넉넉히남고 한쪽은 타이트하게 묶여요.', '2021-11-12');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 71, 899, 5, '스니커즈가 다 비슷비슷하게 생겼지만 이 스니커즈 보자마자 딱 제가 원했던 디자인과 색상이라 바로 구매했네요 ㅎㅎㅎ 되게 가볍구 발도 편하구 색상도 사진이랑 똑같아요!!ㅎㅎㅎ', '2022-04-29');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 59, 899, 4, '이런 류의 캔버스화 중에서는 착화감 편한 편이에요. 상품 상세컷에 나온 색이랑 똑같구요.. 청바지 치마 등등 아무데나 다 잘어울리는 색깔이네요 사이즈는 평소 240 신는데 정사이즈로 잘 맞습니다 배송도 빨리왔어요 !', '2022-05-15');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 23, 1653, 5, '오랜시간 신고 있어도 발바닥부분에 쿠션이 있어서 그런지 발에 부담이 많이 가지 않네요. 정사이즈 주문해서 신었더니 딱 입니다. 발가락 다 가려지고 앞코가 많이 부담스럽지 않게 디자인되어서 마음에 쏙 들어요.', '2021-07-22');

insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 21, 200, 5, '굽은 2센치라 낮지만 편해요~ 조금 큰 사이즈로 나왔는지 평소 235~240mm신는데 235사이즈도 넉넉하게 잘 맞았어요^^ 베이지색이라 세탁이 걱정되지만 깔끔하니 이뻐요', '2021-10-10');
insert into tblReview(seq, orderSeq, optionSeq, rating, review, regDate) values (seqReview.nextVal, 20, 200, 5, '날도 덥구 회사에서 편하게 신을 수 있는 운동화 샀어용 오늘 처음 신었는데 너무 편해요ㅜㅜ 정사이즈로 샀고 불편한거 없이 딱 맞아요 만족합니당~ 배송도 빠르고 굿굿 앞으로 신발은 여기서만!', '2021-08-25');

