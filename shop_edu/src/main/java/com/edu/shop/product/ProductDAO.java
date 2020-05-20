package com.edu.shop.product;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface ProductDAO {
	public List<Map<String, Object>> categoryBig(SqlSessionTemplate sql);
	public List<Map<String, Object>> categorySmall(SqlSessionTemplate sql, String codeNum);
	public List<Map<String, Object>> productList(SqlSessionTemplate sql, String codeNum);
	public List<Map<String, Object>> submitList(SqlSessionTemplate sql, String codeNum);
	public void insertProduct(SqlSessionTemplate sql, Map<String, Object> map);
	public void updateProduct(SqlSessionTemplate sql, Map<String, Object> map);
}
