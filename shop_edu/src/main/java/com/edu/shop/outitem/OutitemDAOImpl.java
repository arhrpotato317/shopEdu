package com.edu.shop.outitem;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class OutitemDAOImpl implements OutitemDAO {

	@Override
	public List<Map<String, Object>> categoryList(SqlSessionTemplate sql, String upCode) {
		return sql.selectList("outitem.categoryList", upCode);
	}

	@Override
	public List<Map<String, Object>> categoryItemList(SqlSessionTemplate sql, String itemClsCode) {
		return sql.selectList("outitem.categoryItemList", itemClsCode);
	}

	@Override
	public Map<String, Object> todayOutItem(SqlSessionTemplate sql, String outItemListCode) {
		return sql.selectOne("outitem.todayOutItem", outItemListCode);
	}

	@Override
	public List<Map<String, Object>> todayOutItem(SqlSessionTemplate sql) {
		return sql.selectList("outitem.todayOutItem");
	}
	
	@Override
	public void outItemInsert(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.insert("outitem.outItemInsert", map);
	}
	
	@Override
	public void outItemUpdate(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.update("outitem.outItemUpdate", map);
	}

	@Override
	public void stockUpdate(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.update("outitem.stockUpdate", map);
	}

	@Override
	public Map<String, Object> resultAmt(SqlSessionTemplate sql, String itemCode) {
		return sql.selectOne("outitem.resultAmt", itemCode);
	}

}
