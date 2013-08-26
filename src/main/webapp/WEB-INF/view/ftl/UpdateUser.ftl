
<div id="updateUser" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3>Update User</h3>
	</div>
	<div class="modal-body">

		<form id="userform" class="form-horizontal well">

			<div class="control-group">
				<label class="control-label" for="inputId">Id</label>
				<div class="controls">
					<input name="id" readonly="readonly" type="text" id="inputId" value="${user.id}" >
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="inputFirstName">FirstName</label>
				<div class="controls">
					<input name="firstName" type="text" id="inputFirstName" value="${user.firstName!""}">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="inputLastName">LastName</label>
				<div class="controls">
					<input name="lastName" type="text" id="inputLastName" value="${user.lastName!""}">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="inputPassword">Password</label>
				<div class="controls">
					<input name="password" type="password" id="inputPassword" value="${user.password!""}">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="reInputPassword">RePassword</label>
				<div class="controls">
					<input type="password" id="reInputPassword" value="${user.password!""}">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="inputEmail">Email</label>
				<div class="controls">
					<input name="email" type="text" id="inputEmail" value="${user.email!""}">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">Groups</label>
				
					<#list groups as group> 
					<div class="controls">
					<label class="checkbox inline"> 
					<input name="groupsId" type="checkbox" value="${group.id}" 
					
					<#list nowGroups as nowGroup> 
					<#if group.id = nowGroup.id>
						checked="checked"
					</#if>
					</#list>
					
					>${group.name!""}
					</label> 
					</div>
					</#list>
				
			</div>

		</form>
	</div>

	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true" value="Close">Close</button>
		<button class="btn btn-primary" value="SaveUser" >SaveUser</button>
	</div>
	
	

</div>

<script type="text/javascript">

  
$("button[value='SaveUser']").click(function(){
	if($("#inputPassword").val() == $("#reInputPassword").val()){
		$.ajax({
		    url: '${request.contextPath}/System/User/Update',
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

