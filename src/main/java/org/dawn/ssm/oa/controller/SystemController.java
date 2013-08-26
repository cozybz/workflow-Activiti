package org.dawn.ssm.oa.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/System")
public class SystemController {
	@RequestMapping("/Index")
	public String index() {
		return "Basic";
	}

	@RequestMapping("/Logout")
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		request.getSession().removeAttribute("loginInfo");
		response.sendRedirect(request.getContextPath() + "/Login");

	}

}
