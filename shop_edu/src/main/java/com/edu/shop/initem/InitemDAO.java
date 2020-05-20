package com.edu.shop.initem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface InitemDAO {
	public List<Map<String, Object>> categoryOneList(SqlSessionTemplate sql, String upCd);
	public List<Map<String, Object>> categoryList(SqlSessionTemplate sql, Map<String, Object> map);
	public void itemInsert(SqlSessionTemplate sql, Map<String, Object> map);
	public List<Map<String, Object>> itemSelectList(SqlSessionTemplate sql);
	public Map<String, Object> itemSelectOne(SqlSessionTemplate sql, String idxCd);
	public void itemUpdate(SqlSessionTemplate sql, Map<String, Object> map);
	public void stockAmtUp(SqlSessionTemplate sql, Map<String, Object> map);
	public Map<String, Object> itemStockAmt(SqlSessionTemplate sql, String itemCd);
	public Map<String, Object> initemStockAmt(SqlSessionTemplate sql, String itemListCd);
}
