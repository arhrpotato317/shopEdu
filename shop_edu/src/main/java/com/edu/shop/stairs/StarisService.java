package com.edu.shop.stairs;

import java.util.List;
import java.util.Map;

public interface StarisService {
	public List<Map<String, Object>> getStairs();
	public Map<String, Object> getStarisOne(String codeNum);
	//계층쿼리추가
	public void stairsInsert(Map<String, Object> map);
	//계층쿼리수정
	public void stairsUpdate(Map<String, Object> map);
}
