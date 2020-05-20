package com.edu.shop.outitem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface OutitemDAO {
	public List<Map<String, Object>> categoryList(SqlSessionTemplate sql, String upCode);
	public List<Map<String, Object>> categoryItemList(SqlSessionTemplate sql, String itemClsCode);
	public Map<String, Object> todayOutItem(SqlSessionTemplate sql, String outItemListCode);
	public List<Map<String, Object>> todayOutItem(SqlSessionTemplate sql);
	public void outItemInsert(SqlSessionTemplate sql, Map<String, Object> map);
	public void outItemUpdate(SqlSessionTemplate sql, Map<String, Object> map);
	public void stockUpdate(SqlSessionTemplate sql, Map<String, Object> map);
	public Map<String, Object> resultAmt(SqlSessionTemplate sql, String itemCode);
}
