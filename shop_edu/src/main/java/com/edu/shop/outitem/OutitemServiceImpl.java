package com.edu.shop.outitem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OutitemServiceImpl implements OutitemService {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Autowired
	private OutitemDAO dao;

	@Override
	public List<Map<String, Object>> categoryList(String upCode) {
		return dao.categoryList(sql, upCode);
	}

	@Override
	public List<Map<String, Object>> categoryItemList(String itemClsCode) {
		return dao.categoryItemList(sql, itemClsCode);
	}

	@Override
	public Map<String, Object> todayOutItem(String outItemListCode) {
		return dao.todayOutItem(sql, outItemListCode);
	}

	@Override
	public List<Map<String, Object>> todayOutItem() {
		return dao.todayOutItem(sql);
	}
	
	@Override
	public void outItemInsert(Map<String, Object> map) {
		dao.outItemInsert(sql, map);
	}
	
	@Override
	public void outItemUpdate(Map<String, Object> map) {
		dao.outItemUpdate(sql, map);
	}

	@Override
	public void stockUpdate(Map<String, Object> map) {
		dao.stockUpdate(sql, map);
	}

	@Override
	public Map<String, Object> resultAmt(String itemCode) {
		return dao.resultAmt(sql, itemCode);
	}

}
