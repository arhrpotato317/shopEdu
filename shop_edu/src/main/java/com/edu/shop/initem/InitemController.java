package com.edu.shop.initem;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Controller
public class InitemController {
	
	private static final Logger logger = LoggerFactory.getLogger(InitemController.class);

	@Autowired
	private InitemService service;
	
	// 첫 화면
	@RequestMapping("initemMain.do")
	public ModelAndView initemMain(ModelAndView mv) {
		logger.info("initemMain");
		
		// SelectBox 첫번째 카테고리 option 가져오기
		List<Map<String, Object>> categoryOneList = service.categoryOneList("C0001");
		
		mv.addObject("categoryOneList", categoryOneList);
		
		// 금일 입고리스트 가져오기
		List<Map<String, Object>> itemInsertList = service.itemSelectList();
		
		mv.addObject("itemInsertList", itemInsertList);
		mv.setViewName("initem/main");
		return mv;
	}
	
	// SelectBox 두번째 카테고리 option 가져오기 (AJAX)
	@RequestMapping("cateAjax.do")
	@ResponseBody
	public JSONObject cateAjax(@RequestBody String ajaxRtn, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cateAjax");
		
		// JSON형식의 문자열을 JSON객체로 파싱하기
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxOneCode = (JSONObject)jsonParser.parse(ajaxRtn);
		String cateOne = (String) ajaxOneCode.get("cateOne");
		
		List<Map<String, Object>> categoryTwoList = service.categoryOneList(cateOne);
		
		JSONObject ajaxTwoList = new JSONObject();
		ajaxTwoList.put("categoryTwoList", categoryTwoList);
		
		return ajaxTwoList;
	}
	
	// SelectBox 조회 결과 가져오기 (AJAX)
	@RequestMapping("cateRtnAjax.do")
	@ResponseBody
	public JSONObject cateRtnAjax(@RequestBody String ajaxRtn, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cateRtnAjax");
		
		// JSON형식의 문자열을 JSON객체로 파싱하기
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxCateCode = (JSONObject)jsonParser.parse(ajaxRtn);
		String cateOne = (String) ajaxCateCode.get("cateOne");
		String cateTwo = (String) ajaxCateCode.get("cateTwo");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cateOne", cateOne);
		map.put("cateTwo", cateTwo);
		
		List<Map<String, Object>> categoryList = service.categoryList(map);
		
		JSONObject ajaxCategoryList = new JSONObject();
		ajaxCategoryList.put("categoryList", categoryList);
		
		return ajaxCategoryList;
	}
	
	// Form 입고내용 저장하기 (AJAX)
	@RequestMapping("saveformAjax.do")
	@ResponseBody
	public JSONObject saveformAjax(@RequestBody String ajaxRtn, HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("saveformAjax");
		
		// JSON형식의 문자열을 JSON객체로 파싱하기
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxCateCode = (JSONObject)jsonParser.parse(ajaxRtn);
		
		String itemListCode = (String) ajaxCateCode.get("itemListCode");
		String itemCode = (String) ajaxCateCode.get("itemCode");
		int itemStock = Integer.parseInt((String) ajaxCateCode.get("itemStock"));
		
		JSONObject ajaxCategoryList = new JSONObject();
		if(itemListCode != null && itemListCode.length() > 0) {
			// 수정
			System.out.println("수정로직 실행");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemListCd", itemListCode);
			map.put("itemCd", itemCode);
			map.put("insAmt", itemStock);
			
			// 전체 리스트 물품 수량 수정
			Map<String, Object> initemStockAmt = service.initemStockAmt(itemListCode);
			int oldAmt = Integer.parseInt(initemStockAmt.get("INSAMT").toString());
			
			if(oldAmt > itemStock) {
				// 수정한 수량이 더 적다면 차액을 -
				System.out.println("수정한 수량이 더 적다면 차액을 -");
				int updateNum = oldAmt - itemStock;
				map.put("updateNum", updateNum);
				map.put("upDown", "down");
			} else {
				// 수정한 수량이 더 많다면 차액을 +
				System.out.println("수정한 수량이 더 많다면 차액을 +");
				int updateNum = itemStock - oldAmt;
				map.put("updateNum", updateNum);
				map.put("upDown", "up");
			}
			service.stockAmtUp(map);
			
			// 금일 입고리스트 테이블 Update
			service.itemUpdate(map);
			
			// 전체 리스트 물품 수량 수정
			Map<String, Object> itemStockAmt = service.itemStockAmt(itemCode);
			System.out.println("물품 수정 후 총수량 : " + itemStockAmt);
			
			ajaxCategoryList = new JSONObject();
			ajaxCategoryList.put("itemUpdateInfo", map);
			ajaxCategoryList.put("itemStockAmt", itemStockAmt);
		} else {
			// 추가
			System.out.println("추가로직 실행");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("itemCd", itemCode);
			map.put("updateNum", itemStock);
			map.put("insAmt", itemStock);
			
			// 입고수량만큼 물품테이블 재고수량 추가
			map.put("upDown", "up");
			service.stockAmtUp(map);
			
			// 금일 입고리스트 테이블 Insert
			service.itemInsert(map);
			String idxCd = (String) map.get("INSITEMLISTCD");

			// 금일 입고리스트에 행추가하기
			Map<String, Object> itemInsertList = service.itemSelectOne(idxCd);
			
			// 전체 리스트 물품 수량 수정
			Map<String, Object> itemStockAmt = service.itemStockAmt(itemCode);
			System.out.println("물품 수정 후 총수량 : " + itemStockAmt);
			
			ajaxCategoryList = new JSONObject();
			ajaxCategoryList.put("itemInsertList", itemInsertList);
			ajaxCategoryList.put("itemStockAmt", itemStockAmt);
		}
		
		return ajaxCategoryList;
	}
	
}
















