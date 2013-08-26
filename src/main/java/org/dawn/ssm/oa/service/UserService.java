package org.dawn.ssm.oa.service;

import java.util.List;
import java.util.Map;

import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;

public interface UserService{
	public List<Group> getGroupsByUserId(String userId);
	public void save(User entity, String[] groupsId);
	public User newUser(String userId);
	public List<Group> getAllGroups();
	public void update(User entity, String[] groupsId);
	public User getUserById(String id);
	public Long getPageCount(int pageSize);
	public List<User> getUserByPage(int pageNum, int pageSize);
	public List<User> getAllUsers();
	public void delete(String id);
	public Map<String, String> LoginAuthentication(String userId, String password);
}
