package org.dawn.ssm.oa.service;

import java.util.List;

import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;


public interface GroupService{

	public Group newGroup(String groupId);
	public List<User> getAllUsers();
	public List<User> getUsersByGroupId(String groupId);
	public Group getGroupById(String id);
	public Long getPageCount(int pageSize);
	public List<Group> getGroupsByPage(int pageNum, int pageSize);
	public void save(Group entity);
	public void delete(String id);
	public void update(Group entity);
	public List<Group> getAllGroups();

}
