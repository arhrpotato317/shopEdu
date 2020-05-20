package com.edu.shop.emp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDAO dao;
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public List<Map<String, Object>> empList() {
		return dao.empList(session);
	}

	@Override
	public List<EmpVO> empListVO() {
		return dao.empListVO(session);
	}

	@Override
	public List<EmpVO> empListParam(Map<String, Object> map) {
		return dao.empListParam(session, map);
	}
	
}
