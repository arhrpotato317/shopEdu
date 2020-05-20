package com.edu.shop.initem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InitemServiceImpl implements InitemService {

	@Autowired
	private InitemDAO dao;
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public List<Map<String, Object>> categoryOneList(String upCd) {
		return dao.categoryOneList(sql, upCd);
	}

	@Override
	public List<Map<String, Object>> categoryList(Map<String, Object> map) {
		return dao.categoryList(sql, map);
	}

	@Override
	public void itemInsert(Map<String, Object> map) {
		dao.itemInsert(sql, map);
	}

	@Override
	public List<Map<String, Object>> itemSelectList() {
		return dao.itemSelectList(sql);
	}

	@Override
	public Map<String, Object> itemSelectOne(String idxCd) {
		return dao.itemSelectOne(sql, idxCd);
	}

	@Override
	public void itemUpdate(Map<String, Object> map) {
		dao.itemUpdate(sql, map);
	}

	@Override
	public void stockAmtUp(Map<String, Object> map) {
		dao.stockAmtUp(sql, map);
	}

	@Override
	public Map<String, Object> itemStockAmt(String itemCd) {
		return dao.itemStockAmt(sql, itemCd);
	}

	@Override
	public Map<String, Object> initemStockAmt(String itemListCd) {
		return dao.initemStockAmt(sql, itemListCd);
	}

}
