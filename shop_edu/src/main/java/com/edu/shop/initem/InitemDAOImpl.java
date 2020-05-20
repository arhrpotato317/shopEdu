package com.edu.shop.initem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class InitemDAOImpl implements InitemDAO {

	@Override
	public List<Map<String, Object>> categoryOneList(SqlSessionTemplate sql, String upCd) {
		return sql.selectList("initem.categoryOneList", upCd);
	}

	@Override
	public List<Map<String, Object>> categoryList(SqlSessionTemplate sql, Map<String, Object> map) {
		return sql.selectList("initem.categoryList", map);
	}

	@Override
	public void itemInsert(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.insert("initem.itemInsert", map);
	}

	@Override
	public List<Map<String, Object>> itemSelectList(SqlSessionTemplate sql) {
		return sql.selectList("initem.itemSelectList");
	}

	@Override
	public Map<String, Object> itemSelectOne(SqlSessionTemplate sql, String idxCd) {
		return sql.selectOne("initem.itemSelectList", idxCd);
	}

	@Override
	public void itemUpdate(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.update("initem.itemUpdate", map);
	}

	@Override
	public void stockAmtUp(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.update("initem.stockAmtUp", map);
	}

	@Override
	public Map<String, Object> itemStockAmt(SqlSessionTemplate sql, String itemCd) {
		return sql.selectOne("initem.itemStockAmt", itemCd);
	}

	@Override
	public Map<String, Object> initemStockAmt(SqlSessionTemplate sql, String itemListCd) {
		return sql.selectOne("initem.initemStockAmt", itemListCd);
	}

}
