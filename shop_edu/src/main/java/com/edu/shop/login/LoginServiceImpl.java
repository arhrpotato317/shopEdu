package com.edu.shop.login;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginDAO dao;
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public Map<String, Object> login(Map<String, Object> map) {
		return dao.login(sql, map);
	}

	@Override
	public int idCheck(String userId) {
		return dao.idCheck(sql, userId);
	}

	@Override
	public void join(Map<String, Object> map) {
		dao.join(sql, map);
	}

	@Override
	public void joinDetail(Map<String, Object> map) {
		dao.joinDetail(sql, map);
	}

}
