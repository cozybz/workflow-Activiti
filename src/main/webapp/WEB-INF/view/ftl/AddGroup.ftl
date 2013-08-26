
<form id="groupform" class="form-horizontal well">

	<div class="control-group">
		<label class="control-label" for="inputId">Id</label>
		<div class="controls">
			<input name="id" type="text" id="inputId" placeholder="Id">
		</div>
	</div>

	<div class="control-group">
		<label class="control-label" for="inputName">Name</label>
		<div class="controls">
			<input name="name" type="text" id="inputName" placeholder="Name">
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label" for="inputType">Type</label>
		<div class="controls">
			<input name="type" type="text" id="inputType" placeholder="Type">
		</div>
	</div>


	<div class="control-group">
		<div class="controls">
			<button class="btn btn-large btn-primary" type="button" value="AddGroup">AddGroup</button>
		</div>
	</div>
	
</form>
	
	<script type="text/javascript">
	
		$("button[value='AddGroup']").click(function(){

			$.ajax({
			    url: '${request.contextPath}/System/Group/Add',
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
