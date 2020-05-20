package com.edu.shop.emp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class EmpDAOImpl implements EmpDAO {

	@Override
	public List<Map<String, Object>> empList(SqlSession sql) {
		return sql.selectList("emp.selectEmpList");
	}

	@Override
	public List<EmpVO> empListVO(SqlSession sql) {
		return sql.selectList("emp.selectEmpListVO");
	}

	@Override
	public List<EmpVO> empListParam(SqlSession sql, Map<String, Object> map) {
		return sql.selectList("emp.selectEmpListVO", map);
	}

}
