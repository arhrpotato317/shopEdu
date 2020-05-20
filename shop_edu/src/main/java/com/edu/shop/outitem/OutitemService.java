package com.edu.shop.outitem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface OutitemService {
	public List<Map<String, Object>> categoryList(String upCode);
	public List<Map<String, Object>> categoryItemList(String itemClsCode);
	public Map<String, Object> todayOutItem(String outItemListCode);
	public List<Map<String, Object>> todayOutItem();
	public void outItemInsert(Map<String, Object> map);
	public void outItemUpdate(Map<String, Object> map);
	public void stockUpdate(Map<String, Object> map);
	public Map<String, Object> resultAmt(String itemCode);
}
