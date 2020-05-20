package com.edu.shop.login;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Override
	public Map<String, Object> login(SqlSessionTemplate sql, Map<String, Object> map) {
		return sql.selectOne("login.selectLogin", map);
	}

	@Override
	public int idCheck(SqlSessionTemplate sql, String userId) {
		return sql.selectOne("login.selectIdCheck", userId);
	}

	@Override
	public void join(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.insert("login.insertJoin", map);
	}

	@Override
	public void joinDetail(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.insert("login.insertDetail", map);
	}

}
