package org.dawn.ssm.oa.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.identity.Group;
import org.dawn.ssm.oa.service.GroupService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/System/Group")
public class GroupController {
	@Resource
	private GroupService groupService;
	@RequestMapping(value = "/Add", method = RequestMethod.POST)
	@ResponseBody
	public void add(HttpServletRequest request) {
		Group group = groupService.newGroup(request.getParameter("id"));
		group.setName(request.getParameter("name"));
		group.setType(request.getParameter("type"));
		groupService.save(group);
	}
	@RequestMapping(value = "/Delete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(String id) {
		if (groupService.getUsersByGroupId(id).size() == 0) {
			groupService.delete(id);
		}
	}
	
	@RequestMapping(value = "/PreAdd", method = RequestMethod.POST)
	public String preAdd(){
		return "AddGroup";
	}


	
	@RequestMapping(value = "/Update", method = RequestMethod.POST)
	@ResponseBody
	public void update(HttpServletRequest request) {
		Group group = groupService.getGroupById(request.getParameter("id"));
		group.setName(request.getParameter("name"));
		group.setType(request.getParameter("type"));
		groupService.update(group);
	}
	
	@RequestMapping(value = "/PreUpdate", method = RequestMethod.POST)
	public ModelAndView preUpdater(String id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("UpdateGroup");
		mv.addObject("group", groupService.getGroupById(id));
		return mv;
	}
	
	@RequestMapping(value = "/ShowGroupsByPage", method = RequestMethod.POST)
	public ModelAndView showGroupsByPage(int thisPage, int pageSize) {
		Long pageCount = groupService.getPageCount(pageSize);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowGroups");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount",pageCount);
		mv.addObject("groups",groupService.getGroupsByPage(thisPage, pageSize));
		return mv;
	}
}
