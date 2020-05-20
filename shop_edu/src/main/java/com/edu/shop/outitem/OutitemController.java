package com.edu.shop.outitem;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.minidev.json.JSONObject;
import net.minidev.json.parser.JSONParser;

@Controller
public class OutitemController {
	
	private static final Logger logger = LoggerFactory.getLogger(OutitemController.class);

	@Autowired
	private OutitemService service;
	
	// 출고관리 메인페이지
	@RequestMapping("outitemMain.do")
	public ModelAndView outitemMain(ModelAndView mv) {
		logger.info("outitemMain");
		
		// 첫번째 카테고리
		List<Map<String, Object>> categoryOneList = service.categoryList("C0001");
		
		// 금일 출고관리
		List<Map<String, Object>> todayList = service.todayOutItem();
		System.out.println("금일 출고 리스트 : " + todayList);
		
		// 배송회사 리스트
		List<Map<String, Object>> addrCompanyList = service.categoryList("C0080");
		
		mv.addObject("categoryOneList", categoryOneList);
		mv.addObject("todayList", todayList);
		mv.addObject("addrCompanyList", addrCompanyList);
		mv.setViewName("outitem/main");
		return mv;
	}
	
	// 두번째 카테고리 리스트 가져오기 Ajax
	@RequestMapping("categoryTwo.do")
	@ResponseBody
	public JSONObject categoryTwo(@RequestParam("cateOneValue") String cateOneValue, ModelAndView mv) {
		logger.info("categoryTwo");
		
		// 두번째 카테고리
		List<Map<String, Object>> categoryTwoList = service.categoryList(cateOneValue);
		
		JSONObject twoList = new JSONObject();
		twoList.put("categoryTwoList", categoryTwoList);
		
		return twoList;
	}
	
	// 카테고리 선택 결과 Ajax
	@RequestMapping("categoryList.do")
	@ResponseBody
	public JSONObject categoryList(@RequestParam("cateTwoValue") String cateTwoValue, ModelAndView mv) {
		logger.info("categoryList");
		
		// 두번째 카테고리
		List<Map<String, Object>> categoryItemList = service.categoryItemList(cateTwoValue);
		
		JSONObject itemList = new JSONObject();
		itemList.put("categoryItemList", categoryItemList);
		
		return itemList;
	}
	
	// 출고관리 저장버튼 클릭 Ajax
	@RequestMapping("outSubmit.do")
	@ResponseBody
	public JSONObject outSubmit(@RequestBody String ajaxRtn, ModelAndView mv) throws Exception {
		logger.info("outSubmit");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject ajaxRequest = (JSONObject) jsonParser.parse(ajaxRtn);
		
		String outItemOnlyCode = (String) ajaxRequest.get("outItemListCode");
		
		String itemCode = (String) ajaxRequest.get("itemCode"); //ITEMCD
		String userId = (String) ajaxRequest.get("userId"); //USERID
		String userName = (String) ajaxRequest.get("userName"); //USERNAME
		int outStock = Integer.parseInt((String) ajaxRequest.get("outStock")); //DELIVAMT - 출고수량
		String checkYn = (String) ajaxRequest.get("checkYn"); //CHECKYN
		String delivYn = (String) ajaxRequest.get("delivYn"); //DELIVYN
		String readyDelivYn = (String) ajaxRequest.get("readyDelivYn"); //DELIVYN
		String addrCompany = (String) ajaxRequest.get("addrCompany"); //DELIVCORPCD - 택배회사
		String invoiceNum = (String) ajaxRequest.get("invoiceNum"); //DELIVNO - 송장번호
		
		if(checkYn == null) {
			checkYn = "N";
		}
		if(delivYn == null) {
			delivYn = "N";
		}
		if(readyDelivYn == null) {
			readyDelivYn = "N";
		}
		
		System.out.println("readyDelivYn : " + readyDelivYn + ", delivYn : " + delivYn);
		
		Map<String, Object> outItemInsert = new HashMap<String, Object>(); // DB테이블 저장 Map
		outItemInsert.put("itemCd", itemCode);
		outItemInsert.put("userId", userId);
		outItemInsert.put("userName", userName);
		outItemInsert.put("delivAmt", outStock);
		outItemInsert.put("checkYn", checkYn);
		outItemInsert.put("delivYn", delivYn);
		outItemInsert.put("delivcorpCd", addrCompany);
		outItemInsert.put("delivNo", invoiceNum);
		System.out.println("outItemInsert : " + outItemInsert);
		
		JSONObject todayOutList = new JSONObject(); // 저장하고 난 뒤 화면에 뿌려주기 위한 JSON
		
		System.out.println("outItemOnlyCode : " + outItemOnlyCode);
		if(outItemOnlyCode != null && outItemOnlyCode.length() > 0) {
			System.out.println("수정 로직");
			
			int readyStock = Integer.parseInt((String) ajaxRequest.get("readyStock"));
			
			if(readyDelivYn.equals("N") && delivYn.equals("Y")) {
				System.out.println("배송여부 체크X -> 체크O");
				outItemInsert.put("updateNum", outStock);
				outItemInsert.put("upDown", "down");
				service.stockUpdate(outItemInsert); // 물품관리 재고수량 변경
			} else if(readyDelivYn.equals("Y") && delivYn.equals("N")) {
				System.out.println("배송여부 체크O -> 체크X");
				outItemInsert.put("updateNum", outStock);
				outItemInsert.put("upDown", "up");
				service.stockUpdate(outItemInsert); // 물품관리 재고수량 변경
			} else if(delivYn.equals("Y") && delivYn.equals("Y")) {
				System.out.println("배송체크 -> 수량변경");
				if(readyStock > outStock) {
					int updateNum = readyStock - outStock;
					outItemInsert.put("updateNum", updateNum);
					outItemInsert.put("upDown", "up");
				} else {
					int updateNum = outStock - readyStock;
					outItemInsert.put("updateNum", updateNum);
					outItemInsert.put("upDown", "down");
				}
				service.stockUpdate(outItemInsert); // 물품관리 재고수량 변경
			}
			
			System.out.println("outItemInsert : " + outItemInsert);
			
			// 출고관리 테이블 수정하기
			outItemInsert.put("outItemListCode", outItemOnlyCode);
			service.outItemUpdate(outItemInsert);
			
			// 금일 출고리스트에 수정하기 Ajax
			Map<String, Object> todayUpdateItem = service.todayOutItem(outItemOnlyCode);
			todayOutList.put("todayUpdateItem", todayUpdateItem);
			
		} else {
			System.out.println("추가 로직");
			
			// 배송여부가 체크가 되어 있다면
			if(delivYn.equals("Y")) {
				System.out.println("추가 - 재고수량 변경");
				outItemInsert.put("updateNum", outStock);
				outItemInsert.put("upDown", "down");
				service.stockUpdate(outItemInsert);  // 물품관리 재고수량 변경
			}
						
			// 출고관리 테이블에 추가하기
			service.outItemInsert(outItemInsert);
			String outItemListCd = (String) outItemInsert.get("OUTITEMLISTCD");
			
			// 금일 출고리스트에 추가하기 Ajax
			Map<String, Object> todayInsertItem = service.todayOutItem(outItemListCd);
			todayOutList.put("todayInsertItem", todayInsertItem);
			System.out.println("추가 수량변경 : " + todayOutList);
		}

		// 전체리스트에 수정해줄 수량 최종 결과
		Map<String, Object> resultAmt = service.resultAmt(itemCode);
		todayOutList.put("resultAmt", resultAmt);
		
		return todayOutList;
	}
}





















