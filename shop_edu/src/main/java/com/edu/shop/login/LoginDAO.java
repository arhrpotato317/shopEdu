package com.edu.shop.login;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface LoginDAO {
	public Map<String, Object> login(SqlSessionTemplate sql, Map<String, Object> map);
	public int idCheck(SqlSessionTemplate sql, String userId);
	public void join(SqlSessionTemplate sql, Map<String, Object> map);
	public void joinDetail(SqlSessionTemplate sql, Map<String, Object> map);
}
