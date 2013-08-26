<div id="modal">


	
	<div id="TaskInfo" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3>TaskForm</h3>
	</div>
	<div class="modal-body">

		<form id="taskForm" class="form-horizontal well">
			<input name="taskId" type="hidden">
			<div id="recvFrom"></div>
		</form>
	</div>

	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true" value="Close">Close</button>
		<button class="btn btn-primary" value="SubmitTask" >SubmitTask</button>
	</div>

</div>
<table class="table table-striped table-bordered table-hover">
	<tr class="info">
		<td>ID</td>
		<td>Name</td>
		<td>Description</td>
		<td>DueDate</td>
		<td>Operation</td>
	</tr>
	<#list tasks as task>
	<tr>
		<td>${(task.id)!''}</td>
		<td>${(task.name)!''}</td>
		<td>${(task.description)!''}</td>
		<td>${(task.dueDate)!''}</td>
		<td>
			<button name="${(task.id)!''}" class="btn btn-danger btn-mini" value="ShowForm">ShowForm</button>
		</td>
	</tr>
	</#list>
</table>

<#import "Pagination.ftl" as dawn>
<@dawn.pagination pageCount=pageCount thisPage=thisPage />


<script>
var result=false;
$("button[value='ShowForm']").click(function() {
	var this_tr = $(this).parent().parent();
	var taskId = $(this).attr("name");
	$.ajax({
		url : '${request.contextPath}/System/Process/PreCompleteTask',
		type : 'POST',
		data : "taskId=" + taskId,
		dataType : 'html',
		success : function(data) {
			result = false;
			$("input[name='taskId']").attr("value",taskId);
			$("#recvFrom").append(data);
			$('#TaskInfo').modal('show');
			$('#TaskInfo').on('hidden',function(){
				$('#recvFrom').empty();
				if(result){
					$(this_tr).remove();
				}
			});
		},
		error : function(errormessage) {
			alert("Operation Error!");
		}
	});	
});

$("button[value='SubmitTask']").click(function() {
	
	$.ajax({
		url : '${request.contextPath}/System/Process/CompleteTask',
		type : 'POST',
		data : $("#taskForm").serialize(),
		dataType : 'html',
		success : function(data) {
			result = true;
			alert("Operation Success!");
		},
		error : function(errormessage) {
			alert("Operation Error!");
		}
	});	

});

$(".pagination li[class!='disabled']").click(function(){
	$.ajax({
	    url: '${request.contextPath}/System/Process/ShowAssigneeTasksByPage',
	    type: 'POST', 
	    data: "userId=${loginInfo.userId}&thisPage="+$(this).attr("name")+"&pageSize=10",
	    dataType: 'html',
	    success: function (data) {
	    	$("#content").empty();
			$("#content").append(data);
	    },
        error: function (data) {
        	alert("Operation Failed!");
        }    
	});
});
</script>
