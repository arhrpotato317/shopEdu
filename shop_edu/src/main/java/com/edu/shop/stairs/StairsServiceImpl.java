package com.edu.shop.stairs;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StairsServiceImpl implements StarisService {
	
	@Autowired
	private StairsDAO dao;
	
	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public List<Map<String, Object>> getStairs() {
		return dao.getStairs(sql);
	}

	@Override
	public Map<String, Object> getStarisOne(String codeNum) {
		return dao.getStairsOne(sql, codeNum);
	}

	//계층쿼리추가
	@Override
	public void stairsInsert(Map<String, Object> map) {
		dao.stairsInsert(sql, map);
	}

	//계층쿼리수정
	@Override
	public void stairsUpdate(Map<String, Object> map) {
		dao.stairsUpdate(sql, map);
	}
	
}
