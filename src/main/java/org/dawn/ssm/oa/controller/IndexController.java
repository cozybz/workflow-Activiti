package org.dawn.ssm.oa.controller;

import java.io.IOException;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.dawn.ssm.oa.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@Resource
	private UserService userService;

	@RequestMapping("/Login")
	public String login() {
		return "Login";
	}

	@RequestMapping("/LoginAuthentication")
	public void loginAuthentication(String userId, String password,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		Map<String, String> result = userService.LoginAuthentication(userId,
				password);
		if (result != null) {
			request.getSession().setAttribute("loginInfo", result);
			response.sendRedirect(request.getContextPath() + "/System/Index");
		} else {
			response.sendRedirect(request.getContextPath() + "/Login");
		}
	}	
}
