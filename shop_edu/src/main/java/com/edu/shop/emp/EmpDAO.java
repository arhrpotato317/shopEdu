package com.edu.shop.emp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public interface EmpDAO {
	public List<Map<String, Object>> empList(SqlSession sql);
	public List<EmpVO> empListVO(SqlSession sql);
	public List<EmpVO> empListParam(SqlSession sql, Map<String, Object> map);
}
