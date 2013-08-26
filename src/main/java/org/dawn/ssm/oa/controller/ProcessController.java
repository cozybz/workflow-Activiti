package org.dawn.ssm.oa.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipInputStream;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.impl.bpmn.diagram.ProcessDiagramGenerator;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/System/Process")
public class ProcessController {
	@Resource
	private RepositoryService repositoryService;
	@Resource
	private RuntimeService runtimeService;
	@Resource
	private TaskService taskService;
	@Resource
	private HistoryService historyService;
	@Resource
	private ManagementService managementService;
	@Resource
	private IdentityService identityService;
	@Resource
	private FormService formService;

	@RequestMapping(value = "/PreDeployProcess", method = RequestMethod.POST)
	public String preDeployProcess() {
		return "DeployProcess";
	}

	@RequestMapping(value = "/DeployProcess", method = RequestMethod.POST)
	@ResponseBody
	public void deployProcess(String name, String category, MultipartFile bpmn,
			HttpServletRequest request) throws IOException {
		if (bpmn.getOriginalFilename().endsWith(".zip")) {
			repositoryService
					.createDeployment()
					.name(name)
					.category(category)
					.addZipInputStream(
							new ZipInputStream(bpmn.getInputStream())).deploy();
		}
	}

	@RequestMapping(value = "/DeleteDeploymentByProcessDefinitionId", method = RequestMethod.POST)
	@ResponseBody
	public void deleteDeploymentByProcessDefinitionId(String id) {
		repositoryService.deleteDeployment(repositoryService
				.createProcessDefinitionQuery().processDefinitionId(id)
				.singleResult().getDeploymentId());

	}

	@RequestMapping(value = "/ShowProcessDefinitionsByPage", method = RequestMethod.POST)
	public ModelAndView showProcessDefinitionsByPage(int thisPage, int pageSize) {
		List<ProcessDefinition> processDefinitions = repositoryService
				.createProcessDefinitionQuery().listPage(
						(thisPage - 1) * pageSize, pageSize);
		Long pageCount = (repositoryService.createDeploymentQuery().count() - 1)
				/ pageSize + 1;
		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowProcessDefinitions");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount", pageCount);
		mv.addObject("processDefinitions", processDefinitions);
		return mv;
	}

	@RequestMapping(value = "/StartProcessInstance", method = RequestMethod.POST)
	@ResponseBody
	public void startProcessInstance(String processDefinitionId,
			String authenticatedUserId, HttpServletRequest request) {
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("authenticatedUserId", authenticatedUserId);
		variables.put("ctx", request.getContextPath());
		identityService.setAuthenticatedUserId(authenticatedUserId);
		runtimeService.startProcessInstanceById(processDefinitionId, variables);
	}

	@RequestMapping(value = "/SuspendProcessInstance", method = RequestMethod.POST)
	@ResponseBody
	public void suspendProcessInstance(String processInstanceId) {
		runtimeService.suspendProcessInstanceById(processInstanceId);
	}

	@RequestMapping(value = "/ActivateProcessInstance", method = RequestMethod.POST)
	@ResponseBody
	public void activateProcessInstance(String processInstanceId) {
		runtimeService.activateProcessInstanceById(processInstanceId);
	}
	
	@RequestMapping(value = "/DeleteProcessInstance", method = RequestMethod.POST)
	@ResponseBody
	public void deleteProcessInstance(String processInstanceId) {
		runtimeService.deleteProcessInstance(processInstanceId,null);
	}
	
	@RequestMapping(value = "/DeleteHistoryProcessInstance", method = RequestMethod.POST)
	@ResponseBody
	public void deleteHistoryProcessInstance(String processInstanceId) {
		historyService.deleteHistoricProcessInstance(processInstanceId);
	}

	@RequestMapping(value = "/ShowHistoryProcessInstancesByPage", method = RequestMethod.POST)
	public ModelAndView showHistoryProcessInstancesByPage(int thisPage, int pageSize) {

		List<HistoricProcessInstance> processInstances = historyService
				.createHistoricProcessInstanceQuery().listPage(
						(thisPage - 1) * pageSize, pageSize);
		Long pageCount = (historyService.createHistoricProcessInstanceQuery()
				.count() - 1) / pageSize + 1;

		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowHistoryProcessInstances");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount", pageCount);
		mv.addObject("processInstances", processInstances);
		return mv;
	}

	@RequestMapping(value = "/ShowProcessInstancesByPage", method = RequestMethod.POST)
	public ModelAndView showProcessInstancesByPage(int thisPage,
			int pageSize) {
		List<ProcessInstance> processInstances = runtimeService
				.createProcessInstanceQuery().listPage(
						(thisPage - 1) * pageSize, pageSize);
		Long pageCount = (runtimeService.createProcessInstanceQuery().count() - 1)
				/ pageSize + 1;

		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowProcessInstances");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount", pageCount);
		mv.addObject("processInstances", processInstances);
		return mv;
	}
	
	

	@RequestMapping(value = "/ShowAssigneeTasksByPage", method = RequestMethod.POST)
	public ModelAndView showAssigneeTasks(String userId, int thisPage,
			int pageSize) {

		Long pageCount = (taskService.createTaskQuery().taskAssignee(userId)
				.count() - 1)
				/ pageSize + 1;

		List<Task> tasks = taskService.createTaskQuery().taskAssignee(userId)
				.listPage((thisPage - 1) * pageSize, pageSize);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowAssigneeTasks");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount", pageCount);
		mv.addObject("tasks", tasks);

		return mv;
	}

	@RequestMapping(value = "/GetTaskForm", method = RequestMethod.POST)
	public void getTaskForm(String taskId) {
		formService.getRenderedTaskForm(taskId);
	}

	@RequestMapping(value = "/ClaimTask", method = RequestMethod.POST)
	@ResponseBody
	public void claimTask(String taskId, String userId) {
		taskService.claim(taskId, userId);
	}

	@RequestMapping(value = "/CompleteTask", method = RequestMethod.POST)
	@ResponseBody
	public void completeTask(HttpServletRequest request) {
		Map<String, String> properties = new HashMap<String, String>();
		Map<String, String[]> map = request.getParameterMap();
		for (Map.Entry<String, String[]> entry : map.entrySet()) {
			properties.put(entry.getKey(), entry.getValue()[0]);
		}
		String taskId = properties.remove("taskId");
		formService.submitTaskFormData(taskId, properties);
	}

	@RequestMapping(value = "/PreCompleteTask", method = RequestMethod.POST)
	@ResponseBody
	public String preCompleteTask(String taskId) {
		return formService.getRenderedTaskForm(taskId).toString();

	}

	@RequestMapping(value = "/ShowProcessInstanceDiagram", method = RequestMethod.GET)
	@ResponseBody
	public void showProcessInstanceDiagram(String processInstanceId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("image/png");
		String processDefinitionId = runtimeService
				.createProcessInstanceQuery().processInstanceId(processInstanceId)
				.singleResult().getProcessDefinitionId();
		BpmnModel bpmnModel = repositoryService
				.getBpmnModel(processDefinitionId);
		InputStream imageStream = ProcessDiagramGenerator.generateDiagram(
				bpmnModel, "png", runtimeService.getActiveActivityIds(processInstanceId));
		OutputStream out = response.getOutputStream();
		byte[] buf = new byte[1024];
		int len = 0;
		while ((len = imageStream.read(buf)) >= 0) {
			out.write(buf, 0, len);
		}
		imageStream.close();
		out.close();
	}
	
	@RequestMapping(value = "/ShowProcessDefinitionDiagram", method = RequestMethod.GET)
	@ResponseBody
	public void showProcessDefinitionDiagram(String processDefinitionId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setContentType("image/png");

		InputStream imageStream = repositoryService.getProcessDiagram(processDefinitionId);
		
		OutputStream out = response.getOutputStream();
		byte[] buf = new byte[1024];
		int len = 0;
		while ((len = imageStream.read(buf)) >= 0) {
			out.write(buf, 0, len);
		}
		imageStream.close();
		out.close();
	}
	

	@RequestMapping(value = "/ShowCandidateUserTasksByPage", method = RequestMethod.POST)
	public ModelAndView showCandidateUserTasks(String userId, int thisPage,
			int pageSize) {

		Long pageCount = (taskService.createTaskQuery()
				.taskCandidateUser(userId).count() - 1)
				/ pageSize + 1;
		List<Task> tasks = taskService.createTaskQuery()
				.taskCandidateUser(userId)
				.listPage((thisPage - 1) * pageSize, pageSize);

		ModelAndView mv = new ModelAndView();
		mv.setViewName("ShowCandidateUserTasks");
		mv.addObject("thisPage", thisPage);
		mv.addObject("pageCount", pageCount);
		mv.addObject("tasks", tasks);
		return mv;
	}
}
