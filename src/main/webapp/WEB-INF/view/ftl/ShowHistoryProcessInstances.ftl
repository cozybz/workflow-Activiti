<div id="modal"></div>
<table class="table table-striped table-bordered table-hover">
	<tr class="info">
		<td>ID</td>
		<td>processDefinition</td>
		<td>StartUserId</td>
		<td>StartTime</td>
		<td>EndTime</td>
		<td>Operation</td>
	</tr>
	<#list processInstances as processInstance>
	<tr>
		<td>${(processInstance.id)!''}</td>
		<td>${(processInstance.processDefinitionId)!''}</td>
		<td>${(processInstance.startUserId)!''}</td>
		<td>${(processInstance.startTime?datetime)!''}</td>
		<td>${(processInstance.endTime?datetime)!''}</td>
		<td>
			<button name="${(processInstance.id)!''}" class="btn btn-success btn-mini" value="Delete">Delete</button>
			<button name="${(processInstance.processDefinitionId)!''}" class="btn btn-success btn-mini" value="ShowDiagram">ShowDiagram</button>
		</td>
	</tr>
	</#list>
</table>



<#import "Pagination.ftl" as dawn>
<@dawn.pagination pageCount=pageCount thisPage=thisPage />
<img id="pngDiagram"/>

<script>


$("button[value='Delete']").click(function() {
	var this_tr = $(this).parent().parent();
	$.ajax({
		url : '${request.contextPath}/System/Process/DeleteHistoryProcessInstance',
		type : 'POST',
		data : "processInstanceId=" + $(this).attr("name"),
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

$("button[value='ShowDiagram']").click(function() {
	$("#pngDiagram").attr("src","${request.contextPath}/System/Process/ShowProcessDefinitionDiagram?processDefinitionId="+ $(this).attr("name"));
});


$(".pagination li[class!='disabled']").click(function(){
	$.ajax({
	    url: '${request.contextPath}/System/Process/ShowProcessInstancesByPage',
	    type: 'POST', 
	    data: "thisPage="+$(this).attr("name")+"&pageSize=10",
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
