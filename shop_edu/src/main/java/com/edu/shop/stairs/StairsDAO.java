package com.edu.shop.stairs;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public interface StairsDAO {
	public List<Map<String, Object>> getStairs(SqlSessionTemplate sql);
	public Map<String, Object> getStairsOne(SqlSessionTemplate sql, String codeNum);
	//계층쿼리추가
	public void stairsInsert(SqlSessionTemplate sql, Map<String, Object> map);
	//계층쿼리수정
	public void stairsUpdate(SqlSessionTemplate sql, Map<String, Object> map);
}
