package com.edu.shop.product;

import java.util.List;
import java.util.Map;

public interface ProductService {
	public List<Map<String, Object>> categoryBig();
	public List<Map<String, Object>> categorySmall(String codeNum);
	public List<Map<String, Object>> productList(String codeNum);
	public List<Map<String, Object>> submitList(String codeNum);
	public void insertProduct(Map<String, Object> map);
	public void updateProduct(Map<String, Object> map);
}
