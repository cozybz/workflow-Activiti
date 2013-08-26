
<form id="userform" class="form-horizontal well">

	<div class="control-group">
		<label class="control-label" for="inputId">Id</label>
		<div class="controls">
			<input name="id" type="text" id="inputId" placeholder="Id">
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" for="inputFirstName">FirstName</label>
		<div class="controls">
			<input name="firstName" type="text" id="inputFirstName" placeholder="FirstName">
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label" for="inputLastName">LastName</label>
		<div class="controls">
			<input name="lastName" type="text" id="inputLastName" placeholder="LastName">
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" for="inputPassword">Password</label>
		<div class="controls">
			<input name="password" type="password" id="inputPassword" placeholder="Password">
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" for="reInputPassword">RePassword</label>
		<div class="controls">
			<input type="password" id="reInputPassword" placeholder="Password">
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label" for="inputEmail">Email</label>
		<div class="controls">
			<input name="email" type="text" id="inputEmail" placeholder="Email">
		</div>
	</div>

	

	<div class="control-group">
		<label class="control-label">Groups</label>
		<#list groups as group>
		<div class="controls">
			
			<label class="checkbox inline"> 
				<input name="groupsId" type="checkbox" value="${group.id}">${group.name}
			</label>
			
		</div>
		</#list>
	</div>

	<div class="control-group">
		<div class="controls">
			<button class="btn btn-large btn-primary" type="button" value="AddUser">AddUser</button>
		</div>
	</div>
	
</form>
	
	<script type="text/javascript">
	
		$("button[value='AddUser']").click(function(){
		if($("#inputPassword").val() == $("#reInputPassword").val()){
			$.ajax({
			    url: '${request.contextPath}/System/User/Add',
			    type: 'POST', 
			    data: $('#userform').serialize(),
			    dataType: 'html',
			    success: function (data) {
			    	alert("Operation Success!");
			    },
		        error: function (data) {
		        	alert("Operation Failed!");
		        }
			});
		}else{
			alert("Password error!");
		}
		});
	</script>
