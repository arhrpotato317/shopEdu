package com.edu.shop.product;

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
public class ProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private ProductService service;
	
	@RequestMapping("product.do")
	public ModelAndView product(ModelAndView mv) {
		logger.info("product");
		
		List<Map<String, Object>> productbig = service.categoryBig();
		mv.addObject("productbig", productbig);
		mv.setViewName("product/main");
		
		return mv;
	}
	
	// 카테고리 1차분류 가져오기
	@RequestMapping("categoryUnder.do")
	@ResponseBody
	public JSONObject categoryUnder(@RequestParam("codeNum") String codeNum) {
		logger.info("categoryUnder");
				
		List<Map<String, Object>> productsmall = service.categorySmall(codeNum);
		
		JSONObject jsonCategory = new JSONObject();
		jsonCategory.put("cdName", productsmall);
		
		return jsonCategory;
	}
	
	@RequestMapping("productList.do")
	public ModelAndView productList(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) {
		logger.info("productList");
		
		/*String selectOne = request.getParameter("categoryBig");*/
		String selectTwo = request.getParameter("categorySmall");
				
		List<Map<String, Object>> productList = service.productList(selectTwo);
		List<Map<String, Object>> productbig = service.categoryBig();
		
		mv.addObject("productbig", productbig);
		mv.addObject("productList", productList);
		mv.setViewName("product/main");
		
		return mv;
	}
	
	@RequestMapping("submitCategory.do")
	@ResponseBody
	public JSONObject submitCategory(HttpServletRequest request, HttpServletResponse response) {
		logger.info("submitCategory");
		
		JSONObject submitCategory = new JSONObject();
		
		List<Map<String, Object>> makeList = service.submitList("C0050"); // 제조사
		List<Map<String, Object>> unitList = service.submitList("C0060"); // 단위
		
		submitCategory.put("makeList", makeList);
		submitCategory.put("unitList", unitList);
		
		return submitCategory;
	}
	
	@RequestMapping("submitProduct.do")
	public ModelAndView submitProduct(ModelAndView mv, HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("submitProduct");
		
		String itemCode = request.getParameter("productCd");
		String itemName = request.getParameter("productNm");
		String madeCode = request.getParameter("categoryMade");
		String unitCode = request.getParameter("categoryUnit");
		String useYn = request.getParameter("productUse");
		
		if(useYn == null) {
			useYn = "N";
		}

		Map<String, Object> submitProduct = new HashMap<String, Object>();
		submitProduct.put("itemName", itemName);
		submitProduct.put("madeCode", madeCode);
		submitProduct.put("unitCode", unitCode);
		submitProduct.put("useYn", useYn);
		
		if(itemCode != null && itemCode.length() > 0) {
			// 수정
			submitProduct.put("itemCode", itemCode);
			service.updateProduct(submitProduct);
		} else {
			// 추가
			System.out.println("실행");
			service.insertProduct(submitProduct);
		}
		
		System.out.println("submitProduct : " + submitProduct);
		
		List<Map<String, Object>> productbig = service.categoryBig();
		mv.addObject("productbig", productbig);
		mv.setViewName("product/main");
		
		return mv;
	}
	
}


















