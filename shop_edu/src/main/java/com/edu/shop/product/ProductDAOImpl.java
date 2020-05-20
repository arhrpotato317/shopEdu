package com.edu.shop.product;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Override
	public List<Map<String, Object>> categoryBig(SqlSessionTemplate sql) {
		return sql.selectList("product.selectCategoryOne");
	}

	@Override
	public List<Map<String, Object>> categorySmall(SqlSessionTemplate sql, String codeNum) {
		return sql.selectList("product.selectCategoryTwo", codeNum);
	}

	@Override
	public List<Map<String, Object>> productList(SqlSessionTemplate sql, String codeNum) {
		return sql.selectList("product.selectProductList", codeNum);
	}

	@Override
	public List<Map<String, Object>> submitList(SqlSessionTemplate sql, String codeNum) {
		return sql.selectList("product.selectsubmitList", codeNum);
	}

	@Override
	public void insertProduct(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.insert("product.insertProduct", map);
	}

	@Override
	public void updateProduct(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.update("product.updateProduct", map);
	}

}
