package com.edu.shop.stairs;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class StairsDAOImpl implements StairsDAO {

	@Override
	public List<Map<String, Object>> getStairs(SqlSessionTemplate sql) {
		return sql.selectList("stairs.selectStairs");
	}

	@Override
	public Map<String, Object> getStairsOne(SqlSessionTemplate sql, String codeNum) {
		return sql.selectOne("stairs.selectStairsOne", codeNum);
	}
	
	//계층쿼리추가
	@Override
	public void stairsInsert(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.insert("stairs.insertStairs", map);
	}

	//계층쿼리수정
	@Override
	public void stairsUpdate(SqlSessionTemplate sql, Map<String, Object> map) {
		sql.update("stairs.updateStairs", map);
	}

}
