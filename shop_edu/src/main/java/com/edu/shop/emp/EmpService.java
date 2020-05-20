package com.edu.shop.emp;

import java.util.List;
import java.util.Map;

public interface EmpService {
	public List<Map<String, Object>> empList();
	public List<EmpVO> empListVO();
	public List<EmpVO> empListParam(Map<String, Object> map);
}
