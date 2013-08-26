
<div id="updateGroup" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3>Update User</h3>
	</div>
	<div class="modal-body">

		<form id="groupform" class="form-horizontal well">

			<div class="control-group">
				<label class="control-label" for="inputId">Id</label>
				<div class="controls">
					<input name="id" readonly="readonly" type="text" id="inputId" value="${group.id}" >
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="inputName">Name</label>
				<div class="controls">
					<input name="name" type="text" id="inputName" value="${group.name!""}">
				</div>
			</div>

			

			<div class="control-group">
				<label class="control-label" for="inputType">Type</label>
				<div class="controls">
					<input name="type" type="text" id="inputType" value="${group.type!""}">
				</div>
			</div>
			
		</form>
	</div>

	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true" value="Close">Close</button>
		<button class="btn btn-primary" value="SaveGroup" >SaveGroup</button>
	</div>

</div>

<script type="text/javascript">

  
$("button[value='SaveGroup']").click(function(){
	$.ajax({
	    url: '${request.contextPath}/System/Group/Update',
	    type: 'POST', 
	    data: $('#groupform').serialize(),
	    dataType: 'html',
	    success: function (data) {
	    	alert("Operation Success!");
	    },
        error: function (data) {
        	alert("Operation Failed!");
        }
	    });
});
  
  

  
</script>

