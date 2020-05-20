package com.edu.shop.initem;

import java.util.List;
import java.util.Map;

public interface InitemService {
	public List<Map<String, Object>> categoryOneList(String upCd);
	public List<Map<String, Object>> categoryList(Map<String, Object> map);
	public void itemInsert(Map<String, Object> map);
	public List<Map<String, Object>> itemSelectList();
	public Map<String, Object> itemSelectOne(String idxCd);
	public void itemUpdate(Map<String, Object> map);
	public void stockAmtUp(Map<String, Object> map);
	public Map<String, Object> itemStockAmt(String itemCd);
	public Map<String, Object> initemStockAmt(String itemListCd);
}
