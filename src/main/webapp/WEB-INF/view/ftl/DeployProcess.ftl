
<form id="deployProcessForm" action="${request.contextPath}/System/Process/DeployProcess"  class="form-horizontal well" enctype="multipart/form-data" method="post"  >

	<div class="control-group">
		<label class="control-label" for="inputName">Name</label>
		<div class="controls">
			<input name="name" type="text" id="inputName" placeholder="Name">
		</div>
	</div>
	
	<div class="control-group">
		<label class="control-label" for="inputCategory">Category</label>
		<div class="controls">
			<input name="category" type="text" id="inputCategory" placeholder="Category">
		</div>
	</div>
	
	
	<div class="control-group">
		<label class="control-label" for="inputFile">File</label>
		<div class="controls">
			<input name="bpmn" type="file" id="inputFile" placeholder="file">
		</div>
	</div>


	<div class="control-group">
		<div class="controls">
			<input type="submit" class="btn btn-large btn-primary" value="Deploy" >
		</div>
	</div>
	
</form>

	<script src="${request.contextPath}/resources/js/jquery.form.js"></script>
	
	<script type="text/javascript">
	
	 	$(document).ready(function() { 
            $('#deployProcessForm').ajaxForm(function() { 
                alert("Deploy Success!"); 
            }); 
        }); 
	</script>
