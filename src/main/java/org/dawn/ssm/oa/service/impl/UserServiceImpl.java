package org.dawn.ssm.oa.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.activiti.engine.IdentityService;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.dawn.ssm.oa.service.UserService;
import org.springframework.stereotype.Service;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource
	private IdentityService identityService;

	@Override
	public User getUserById(String id) {
		return identityService.createUserQuery().userId(id).singleResult();
	}

	@Override
	public Long getPageCount(int pageSize) {
		return (identityService.createUserQuery().count() - 1) / pageSize +1;
	}

	@Override
	public List<User> getUserByPage(int pageNum, int pageSize) {
		return identityService.createUserQuery().listPage(
				(pageNum - 1) * pageSize, pageSize);
	}

	@Override
	public List<User> getAllUsers() {
		return identityService.createUserQuery().list();
	}

	@Override
	public void save(User entity, String[] groupsId) {
		identityService.saveUser(entity);
		if (groupsId != null)
			for (String groupId : groupsId) {
				identityService.createMembership(entity.getId(), groupId);
			}
	}

	@Override
	public void delete(String id) {
		List<Group> groups = identityService.createGroupQuery().groupMember(id)
				.list();
		for (Group group : groups) {
			identityService.deleteMembership(id, group.getId());
		}
		identityService.deleteUser(id);
	}

	@Override
	public void update(User entity, String[] groupsId) {
		identityService.saveUser(entity);

		List<Group> groups = identityService.createGroupQuery()
				.groupMember(entity.getId()).list();

		for (Group group : groups) {
			identityService.deleteMembership(entity.getId(), group.getId());
		}

		for (String groupId : groupsId) {
			identityService.createMembership(entity.getId(), groupId);
		}
	}

	@Override
	public List<Group> getGroupsByUserId(String userId) {
		return identityService.createGroupQuery().groupMember(userId).list();
	}

	@Override
	public List<Group> getAllGroups() {
		return identityService.createGroupQuery().list();
	}

	@Override
	public User newUser(String userId) {
		return identityService.newUser(userId);
	}

	@Override
	public Map<String, String> LoginAuthentication(String userId,
			String password) {
		Map<String, String> result = null;
		String userGroups = "";
		if (identityService.checkPassword(userId, password)) {
			result = new HashMap<String, String>();
			List<Group> groups = identityService.createGroupQuery()
					.groupMember(userId).list();
			for (Group group : groups) {
				userGroups += group.getId() + "#";
			}
			result.put("userId", userId);
			result.put("userGroups", userGroups);
		}
		return result;
	}
}
