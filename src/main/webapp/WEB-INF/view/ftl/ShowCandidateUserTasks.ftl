<div id="modal"></div>
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
			<button name="${(task.id)!''}" class="btn btn-danger btn-mini" value="Claim">Claim</button
		</td>
	</tr>
	</#list>
</table>

<#import "Pagination.ftl" as dawn>
<@dawn.pagination pageCount=pageCount thisPage=thisPage />


<script>

$("button[value='Claim']").click(function() {
	var this_tr = $(this).parent().parent();
	$.ajax({
		url : '${request.contextPath}/System/Process/ClaimTask',
		type : 'POST',
		data : "userId=${loginInfo.userId}&taskId=" + $(this).attr("name"),
		dataType : 'html',
		success : function(data) {
			$(this_tr).remove();
			alert("Operation Success!");
		},
		error : function(errormessage) {
			alert("Operation Error!");
		}
	});	

});

$(".pagination li[class!='disabled']").click(function(){
	$.ajax({
	    url: '${request.contextPath}/System/Process/ShowCandidateUserTasksByPage',
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
