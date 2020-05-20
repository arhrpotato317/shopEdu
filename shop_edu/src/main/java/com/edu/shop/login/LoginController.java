package com.edu.shop.login;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private LoginService service;
	
	// 로그인 페이지
	@RequestMapping("login.do")
	public ModelAndView login(ModelAndView mv) {
		logger.info("login page");
		mv.setViewName("login/login");
		return mv;
	}
	
	// 로그인 확인
	@RequestMapping("loginCheck.do")
	public ModelAndView loginCheck(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("loginCheck");

		String userId = request.getParameter("userId");
		String userPass = request.getParameter("userPass");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userPass", userPass);
		
		if((userId != null && userId.length() > 0) && (userPass != null && userPass.length() > 0)) {
			Map<String, Object> loginMap = service.login(map);
			
			if(loginMap == null) {
				mv.addObject("msg", "로그인에 실패했습니다.");
				mv.setViewName("login/login");
			} else {
				mv.setViewName("login/main");
			}
		}
		/*else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아이디와 비밀번호를 모두 입력하여주세요.');</script>");
			out.flush();
			mv.setViewName("login/login");
		}*/
		
		return mv;
	}
	
	// 회원가입
	@RequestMapping("join.do")
	public ModelAndView join(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("join");
		
		String userId = request.getParameter("userId");
		String userPass = request.getParameter("userPass");
		String userName = request.getParameter("userName");
		
		String idDetail = request.getParameter("idDetail");
		System.out.println(idDetail);
				
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", userId);
		map.put("pass", userPass);
		map.put("name", userName);
		
		if((userId != null && userId.length() > 0) 
				&& (userPass != null && userPass.length() > 0)
				&& (userName != null && userName.length() > 0)) {
			service.join(map);
			
			mv.addObject("idDetail", idDetail); // 회원가입 상세로 아이디 값 전달
			mv.setViewName("login/detail");
		} else {
			mv.setViewName("login/join");
		}
		
		return mv;
	}
	
	// 회원가입 - 아이디 중복체크 (Ajax)
	@RequestMapping("idCheck.do")
	@ResponseBody // JSON 혹은 Object 형태로 데이터를 넘겨준다.
	public int idcheck(@RequestParam("userId") String userId, ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("idCheck");
		
		System.out.println("userId : " + userId);
		int idCheckNum = 0;
		if(userId != null && userId.length() > 0) {
			idCheckNum = service.idCheck(userId);
			System.out.println("idCheckNum : " + idCheckNum);
		}

		return idCheckNum;
	}
	
	// 상세정보 페이지
	@RequestMapping("detail.do")
	public ModelAndView detail(ModelAndView mv) {
		logger.info("detail page");
		mv.setViewName("login/detail");
		return mv;
	}
	
	// 상세정보 저장
	@RequestMapping("detailSave.do")
	public ModelAndView detail(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("detailSave");
		
		String idDetail = request.getParameter("idDetail");
		String userName = request.getParameter("userName");
		String relation = request.getParameter("relation");
		String zip = request.getParameter("zip");
		String address = request.getParameter("address");
		String cellphone = request.getParameter("cellphone");
		String homephone = request.getParameter("homephone");
		String userUse = request.getParameter("userUse");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", idDetail);
		map.put("delivName", userName);
		map.put("relCd", relation);
		map.put("addrCd", zip);
		map.put("addrName", address);
		map.put("mobileTelNo", cellphone);
		map.put("homeTelNo", homephone);
		
		if(userUse == null) {
			map.put("useYn", "N");
		} else if(userUse.equals("use")) {
			map.put("useYn", "Y");
		}
		
		System.out.println("map : " + map);
		service.joinDetail(map);
		
		mv.setViewName("login/login");
		return mv;
	}
	
}

























