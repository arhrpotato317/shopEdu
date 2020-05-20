package com.edu.shop.stairs;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.minidev.json.JSONObject;

@Controller
public class StairsController {
	
	private static final Logger logger = LoggerFactory.getLogger(StairsController.class);

	@Autowired
	private StarisService service;
	
	// 계층쿼리 페이지
	@RequestMapping("stairs.do")
	public ModelAndView stairs(ModelAndView mv) {
		logger.info("stairs");
		
		List<Map<String, Object>> stairsList = service.getStairs();
		mv.addObject("stairsList", stairsList);
		mv.setViewName("stairs/main");
		return mv;
	}
	// 계층쿼리 페이지
	@RequestMapping("list.do")
	public ModelAndView list(ModelAndView mv) {
		logger.info("list");
		mv.setViewName("stairs/list");
		return mv;
	}
	
	// Ajax 처리
	@RequestMapping("stairsAjax.do")
	@ResponseBody
	public JSONObject stairsAjax(@RequestParam("cdno") String codeNum, ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("stairsAjax");
				
		Map<String, Object> stairsOne = new HashMap<String, Object>();
		if(codeNum != null && codeNum.length() > 0) {
			stairsOne = service.getStarisOne(codeNum);
			System.out.println("stairsOne : " + stairsOne);
		}
		
		JSONObject obj = new JSONObject();
		obj.put("CDNO", stairsOne.get("CDNO"));
		obj.put("CDLVL", stairsOne.get("CDLVL"));
		obj.put("UPCD", stairsOne.get("UPCD"));
		obj.put("CDNAME", stairsOne.get("CDNAME"));
		obj.put("USEYN", stairsOne.get("USEYN"));
		
		System.out.println("obj : " + obj);
		
		return obj;
	}
	
	// 계층쿼리 추가 and 수정
	@RequestMapping("stairsSubmit.do")
	public ModelAndView stairsSelect(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("stairsSubmit");
		
		String codeNum = request.getParameter("codeNum");
		String codeLvl = request.getParameter("codeLvl");
		String codeUp = request.getParameter("codeUp");
		String codeName = request.getParameter("codeName");
		String insertUse = request.getParameter("insertUse");
		
		if(insertUse == null) {
			insertUse = "N";
		}
		
		System.out.println(codeNum + ", " + codeLvl + ", " + codeUp + ", " + codeName + ", " + insertUse);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cdLvl", codeLvl);
		map.put("upCd", codeUp);
		map.put("cdName", codeName);
		map.put("useYn", insertUse);
		
		if(codeNum == null) {
			// 계층쿼리 추가
			service.stairsInsert(map);
		} else {
			// 계층쿼리 수정
			map.put("cdNo", codeNum);
			service.stairsUpdate(map);
		}
		
		System.out.println("map : " + map);
		
		List<Map<String, Object>> stairsList = service.getStairs();
		mv.addObject("stairsList", stairsList);
		mv.setViewName("stairs/main");
		return mv;
	}
	
	// 계층쿼리 연습 페이지
	@RequestMapping("listPractice.do")
	public ModelAndView listPractice(ModelAndView mv) {
		logger.info("listPractice");
		
		List<Map<String, Object>> stairsList = service.getStairs();
		mv.addObject("stairsList", stairsList);
		mv.setViewName("stairs/listPractice");
		return mv;
	}
}



























