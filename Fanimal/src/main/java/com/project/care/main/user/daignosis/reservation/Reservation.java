package com.project.care.main.user.daignosis.reservation;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.care.dto.AnimalListDTO;
import com.project.care.dto.HospitalDTO;
import com.project.care.dto.HospitalListDTO;
import com.project.care.dto.PurposeDTO;
import com.project.care.dto.UserDTO;

@WebServlet("/reservation/reservation.do")
public class Reservation extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


		HttpSession session = req.getSession();
		//UserDTO auth = (UserDTO)session.getAttribute("auth");
		
		//-----------임시-----------
		UserDTO auth = new UserDTO();
		auth.setId("hong1234");
		auth.setNickname("길길동이");
		//---------------------------
		
		//1
		HospitalListDTO dto = new HospitalListDTO();
		dto.setSi(req.getParameter("si"));
		dto.setGu(req.getParameter("gu"));
		dto.setPage(req.getParameter("page"));
		dto.setAlign(req.getParameter("align"));
		dto.setSearch(req.getParameter("search"));
		String hpseq = req.getParameter("hpseq");
		
		
		//반려동물 리스트 
		ReservationDAO dao = new ReservationDAO();
		ArrayList<AnimalListDTO> animals = dao.getAnimal(auth.getId());
		
		//오늘기준 한달 내의 일정 중 예약 가능한 일정을 찾아 달력에 표시한다 
		ArrayList<String> days = dao.getDay(hpseq); 
		HospitalDTO time = dao.getTime(hpseq);
		
		//방문 목적 종류
		ArrayList<PurposeDTO> purposes = dao.getPurpose();
		
		
		req.setAttribute("dto", dto);
		req.setAttribute("hpseq", hpseq);
		req.setAttribute("animals", animals);
		req.setAttribute("purposes", purposes);
		req.setAttribute("hosname", time.getHosname());
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/main/user/diagnosis/reservation/reservation.jsp");

		dispatcher.forward(req, resp);
	}

}

