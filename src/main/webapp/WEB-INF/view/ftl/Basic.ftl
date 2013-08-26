<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${request.contextPath}/resources/css/system.css"
	rel="stylesheet">
<link
	href="${request.contextPath}/resources/css/bootstrap-responsive.min.css"
	rel="stylesheet">

<title>OA System</title>
</head>
<body>

<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container-fluid">
      <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> 
        <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> 
      </button>
      <a class="brand">OA System</a>
      <p class="navbar-text pull-right"> Logged in as ${loginInfo.userId} ;<a href="${request.contextPath}/System/Logout" class="navbar-link">Logout</a></p>
      <div class="nav-collapse collapse"> 
        <ul class="nav">
  		  <li class="active"><a href="#">Home</a></li>
		</ul>
      </div>
    </div>
  </div>
</div>


<div class="container-fluid">
  <div class="row-fluid">
    <div class="span3">
      <div class="well sidebar-nav">
        <ul class="nav nav-list">
          <!-- Nav List -->
          
          <li class="nav-header">UserManagement</li>

          
          <#if (loginInfo.userGroups?contains("0#"))||(loginInfo.userGroups?contains("1#")) >
          	 <li><a href="#" name="ShowUsers">ShowUsers</a></li>
          </#if>

          
         <#if (loginInfo.userGroups?contains("0#"))||(loginInfo.userGroups?contains("1#")) >
          	 <li><a href="#" name="AddUser">AddUser</a></li>
          </#if>

          <li class="nav-header">GroupManagement</li>
          
          <#if (loginInfo.userGroups?contains("0#"))||(loginInfo.userGroups?contains("1#")) >
          	 <li><a href="#" name="ShowGroups">ShowGroups</a></li>
          </#if>
          
         <#if (loginInfo.userGroups?contains("0#"))||(loginInfo.userGroups?contains("1#")) >
          	 <li><a href="#" name="AddGroup">AddGroup</a></li>
          </#if>
          
           <#if loginInfo.userGroups?contains("0#") >
          <li class="nav-header">DeploymentManagement</li>
          <li><a href="#" name="DeployProcess">DeployProcess</a></li>
          </#if>
          
          <li class="nav-header">ProcessManagement</li>
          <li><a href="#" name="ShowProcessDefinitions">ShowProcessDefinitions</a></li>
          <#if loginInfo.userGroups?contains("0#") >
          <li><a href="#" name="ShowProcessInstances">ShowProcessInstances</a></li>
          <li><a href="#" name="ShowHistoryProcessInstances">ShowHistoryProcessInstances</a></li>
          </#if>
          <li class="nav-header">TaskManagement</li>
          <li><a href="#" name="ShowAssigneeTasks">ShowAssigneeTasks</a></li>
          <li><a href="#" name="ShowCandidateUserTasks">ShowCandidateUserTasks</a></li>
          
          <!-- Nav List -->
          
        </ul>
      </div>
    </div>
    <div id="content" class="span9"> 
      <!-- Content --> 
    </div>
  </div>
</div>


	<script src="${request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${request.contextPath}/resources/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		$("a[name='ShowUsers']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
				contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			    url: '${request.contextPath}/System/User/ShowUsersByPage',
			    type: 'POST', 
			    data: "thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		
		$("a[name='AddUser']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/User/PreAdd',
			    type: 'POST', 
			    data: "",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		
		$("a[name='ShowGroups']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
				contentType: 'application/x-www-form-urlencoded;charset=utf-8',
			    url: '${request.contextPath}/System/Group/ShowGroupsByPage',
			    type: 'POST', 
			    data: "thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		
		$("a[name='AddGroup']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Group/PreAdd',
			    type: 'POST', 
			    data: "",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		$("a[name='DeployProcess']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Process/PreDeployProcess',
			    type: 'POST', 
			    data: "",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		$("a[name='ShowProcessDefinitions']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Process/ShowProcessDefinitionsByPage',
			    type: 'POST', 
			    data: "thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		$("a[name='ShowProcessInstances']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Process/ShowProcessInstancesByPage',
			    type: 'POST', 
			    data: "thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		$("a[name='ShowHistoryProcessInstances']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Process/ShowHistoryProcessInstancesByPage',
			    type: 'POST', 
			    data: "thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		$("a[name='ShowAssigneeTasks']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Process/ShowAssigneeTasksByPage',
			    type: 'POST', 
			    data: "userId=${loginInfo.userId}&thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		$("a[name='ShowCandidateUserTasks']").click(function(){
			var this_li = $(this).parent();
			$.ajax({
			    url: '${request.contextPath}/System/Process/ShowCandidateUserTasksByPage',
			    type: 'POST', 
			    data: "userId=${loginInfo.userId}&thisPage=1&pageSize=10",
			    dataType: 'html',
			    success: function (data) {
			    	$("#content").empty();
					$("#content").append(data);
					$(".active").removeClass("active");
					$(this_li).addClass("active");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }    
			});
		});
		
		
	</script>
	
</body>
</html>