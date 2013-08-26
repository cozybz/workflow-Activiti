package org.dawn.ssm.oa.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.dawn.ssm.oa.service.GroupService;
import org.springframework.stereotype.Service;

@Service("groupService")
public class GroupServiceImpl implements GroupService {
	@Resource
	private IdentityService identityService;
	@Override
	public Group getGroupById(String id) {
		return identityService.createGroupQuery().groupId(id).singleResult();
	}
	@Override
	public List<Group> getGroupsByPage(int pageNum, int pageSize) {
		return identityService.createGroupQuery().listPage(
				(pageNum - 1) * pageSize, pageSize);
	}
	

	@Override
	public Long getPageCount(int pageSize) {
		return (identityService.createGroupQuery().count() - 1) / pageSize+1;
	}



	@Override
	public List<Group> getAllGroups() {
		return identityService.createGroupQuery().list();
	}

	@Override
	public void save(Group entity) {
		identityService.saveGroup(entity);
	}

	@Override
	public void delete(String id) {
		identityService.deleteGroup(id);
	}

	@Override
	public void update(Group entity) {
		identityService.saveGroup(entity);
	}

	@Override
	public List<User> getUsersByGroupId(String groupId) {
		return identityService.createUserQuery().memberOfGroup(groupId).list();
	}

	@Override
	public List<User> getAllUsers() {
		return identityService.createUserQuery().list();
	}

	@Override
	public Group newGroup(String groupId) {
		return identityService.newGroup(groupId);
	}

}
