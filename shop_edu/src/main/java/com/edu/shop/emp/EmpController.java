package com.edu.shop.emp;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmpController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmpController.class);
	
	@Autowired
	private EmpService service;
	
	@RequestMapping("empList.do")
	public ModelAndView getEmpList(ModelAndView mv) {
		logger.info("getEmpList");
		
		List<Map<String, Object>> empList = service.empList();
		mv.addObject("empList", empList);
		mv.setViewName("emp/list");
		
		return mv;
	}
	
	@RequestMapping("empListVO.do")
	public ModelAndView getEmpListVO(ModelAndView mv) {
		logger.info("getEmpListVO");
		
		List<EmpVO> empListVO = service.empListVO();
		mv.addObject("empListVO", empListVO);
		mv.setViewName("emp/listVO");
		
		return mv;
	}
	
	@RequestMapping("empListParam.do")
	public ModelAndView getEmpListParam(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("getEmpListParam");
		
		String empNo = request.getParameter("empNo");
		String deptNo = request.getParameter("deptNo");
		System.out.println(empNo + ", " + deptNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empNo", empNo);
		map.put("deptNo", deptNo);
		
		if((empNo != null && empNo.length() > 0) || (deptNo != null && deptNo.length() > 0)) {
			List<EmpVO> empListParam = service.empListParam(map);
			mv.addObject("empListParam", empListParam);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('조회가 완료되었습니다.');</script>");
			out.flush();
		} else {
			List<EmpVO> empListParam = null;
			mv.addObject("empListParam", empListParam);
			mv.addObject("msg", "검색어를 하나이상 입력해주세요.");
		}
		
		mv.setViewName("emp/listParam");
		
		return mv;
	}
	
}















