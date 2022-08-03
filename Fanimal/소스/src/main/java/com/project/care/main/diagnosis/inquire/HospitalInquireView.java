package com.project.care.main.diagnosis.inquire;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.care.dto.CompanyDTO;
import com.project.care.dto.HospitalListDTO;
import com.project.care.dto.QuesDTO;
import com.project.care.dto.QuesHospitalDTO;
import com.project.care.dto.UserDTO;

@WebServlet("/inquire/hospitalinquireview.do")
public class HospitalInquireView extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		
		String type = "2";
		String id = "";
		
		if (session.getAttribute("auth") instanceof CompanyDTO) {
			CompanyDTO dto = (CompanyDTO)session.getAttribute("auth");
			id = session.getId();
			type = "0";
		} else if (session.getAttribute("auth") instanceof UserDTO) {
			UserDTO dto = (UserDTO)session.getAttribute("auth");
			id = session.getId();
			type = "1";
		}
		
		
		HospitalListDTO hdto = new HospitalListDTO();
		hdto.setSi(req.getParameter("si"));
		hdto.setGu(req.getParameter("gu"));
		hdto.setAlign(req.getParameter("align"));
		hdto.setSearch(req.getParameter("search"));
		hdto.setPage(req.getParameter("page"));
		
		String hpseq = req.getParameter("hpseq");
		String hqseq = req.getParameter("hqseq");
		

		QuesHospitalDTO dto = new QuesHospitalDTO();
		dto.setHpseq(hpseq);
		String qSearchKey = req.getParameter("qSearchKey");
		String qSearchValue = req.getParameter("qSearchValue");
		
		if (qSearchKey != null && qSearchValue != null) { 
			dto.setQSearchKey(qSearchKey); 
			dto.setQSearchValue(qSearchValue);
		} else {
			dto.setQSearchKey("title");
			dto.setQSearchValue("");
		}
		
		InquireDAO dao = new InquireDAO();
		QuesDTO qdto = dao.getQues(hqseq);
		qdto.setPostdate(qdto.getPostdate().substring(0, 16));
		
		QuesAnsDTO adto = dao.getAns(hqseq);
		
		
		req.setAttribute("dto", dto);   //문의게시판 검색조건
		req.setAttribute("hdto", hdto); //병원리스트 검색조건
		req.setAttribute("qdto", qdto);	//문의글
		req.seqAttribute("adto", adto); //답변글
		req.setAttribute("type", type);
		req.setAttribute("id", id);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/main/diagnosis/inquire/hospitalinquireview.jsp");

		dispatcher.forward(req, resp);
	}

}
