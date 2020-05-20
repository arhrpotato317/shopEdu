package com.edu.shop.product;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO dao;
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public List<Map<String, Object>> categoryBig() {
		return dao.categoryBig(sql);
	}

	@Override
	public List<Map<String, Object>> categorySmall(String codeNum) {
		return dao.categorySmall(sql, codeNum);
	}

	@Override
	public List<Map<String, Object>> productList(String codeNum) {
		return dao.productList(sql, codeNum);
	}

	@Override
	public List<Map<String, Object>> submitList(String codeNum) {
		return dao.submitList(sql, codeNum);
	}

	@Override
	public void insertProduct(Map<String, Object> map) {
		dao.insertProduct(sql, map);
	}

	@Override
	public void updateProduct(Map<String, Object> map) {
		dao.updateProduct(sql, map);
	}

}
