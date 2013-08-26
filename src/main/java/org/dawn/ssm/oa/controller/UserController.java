package org.dawn.ssm.oa.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.activiti.engine.identity.User;
import org.dawn.ssm.oa.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/System/User")
public class UserController {

	@Resource
	private UserService userService;

	@RequestMapping(value = "/Add", method = RequestMethod.POST)
	@ResponseBody
	public void add(HttpServletRequest request) {
		User user = userService.newUser(request.getParameter("id"));
		
		user.setPassword(request.getParameter("password"));
		user.setFirstName(request.getParameter("firstName"));
		user.setLastName(request.getParameter("lastName"));
		user.setEmail(request.getParameter("email"));
		
		userService.save(user, request.getParameterValues("groupsId"));
	}

	@RequestMapping(value = "/Delete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(String id) {
		
		userService.delete(id);
	
	}

	@RequestMapping(value = "/Update", method = RequestMethod.POST)
	@ResponseBody
	public void update(HttpServletRequest request) {
		User user = userService.getUserById(request.getParameter("id"));

		user.setPassword(request.getParameter("password"));
		user.setFirstName(request.getParameter("firstName"));
		user.setLastName(request.getParameter("lastName"));
		user.setEmail(request.getParameter("email"));
		
		userService.update(user, request.getParameterValues("groupsId"));
	}

	@RequestMapping(value = "/PreUpdate", method = RequestMethod.POST)
	public ModelAndView preUpdater(String id) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("UpdateUser");
		mv.addObject("user", userService.getUserById(id));
		mv.addObject("nowGroups", userService.getGroupsByUserId(id));
		mv.addObject("groups", userService.getAllGroups());
		return mv;
	}

	@RequestMapping(value = "/PreAdd", method = RequestMethod.POST)
	public ModelAndView preAdd() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("AddUser");
		mv.addObject("groups", userService.getAllGroups());
		return mv;
	}

	@RequestMapping(value = "/ShowUsersByPage", method = RequestMethod.POST)
	public ModelAndView showUsersByPage(int thisPage, int pageSize) {
		Long pageCount = userService.getPageCount(pageSize);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowUsers");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount",pageCount);
		mv.addObject("users",userService.getUserByPage(thisPage, pageSize));
		return mv;
	}

}
