<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>OA System Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${request.contextPath}/resources/css/login.css"
	rel="stylesheet">
<link
	href="${request.contextPath}/resources/css/bootstrap-responsive.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="brand" href="${request.contextPath}/Login">OA System</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">
					<#if loginInfo??>
						Logged in as ${loginInfo.userId} ;<a href="${request.contextPath}/System/Logout" class="navbar-link">Logout</a>
					<#else>
						<a href="${request.contextPath}/Login" class="navbar-link">Sign In</a>
					</#if>
					</p>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<form class="form-signin" action="${request.contextPath}/LoginAuthentication" method="post">
			<h2 class="form-signin-heading">Please sign in</h2>
			<input name="userId" type="text" class="input-block-level" placeholder="userId"> 
			<input name="password" type="password" class="input-block-level" placeholder="Password">
			<button class="btn btn-large btn-primary" type="submit">Sign in</button>
		</form>
	</div>

	<script src="${request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>