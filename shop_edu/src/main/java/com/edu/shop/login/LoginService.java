package com.edu.shop.login;

import java.util.Map;

public interface LoginService {
	public Map<String, Object> login(Map<String, Object> map);
	public int idCheck(String userId);
	public void join(Map<String, Object> map);
	public void joinDetail(Map<String, Object> map);
}
