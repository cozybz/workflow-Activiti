<div id="modal"></div>
<table class="table table-striped table-bordered table-hover">
	<tr class="info">
		<td>ID</td>
		<td>Name</td>
		<td>Description</td>
		<td>Operation</td>
	</tr>
	<#list processDefinitions as processDefinition>
	<tr>
		<td>${(processDefinition.id)!''}</td>
		<td>${(processDefinition.name)!''}</td>
		<td>${(processDefinition.description)!''}</td>
		<td>
			<button name="${(processDefinition.id)!''}" class="btn btn-success btn-mini" value="Start">Start</button>
			<#if loginInfo.userGroups?contains("0#") >
			<button name="${(processDefinition.id)!''}" class="btn btn-danger btn-mini" value="Delete">Delete</button>
			</#if>
			<button name="${(processDefinition.id)!''}" class="btn btn-success btn-mini" value="ShowDiagram">ShowDiagram</button>
		</td>
	</tr>
	</#list>
</table>


<#import "Pagination.ftl" as dawn>
<@dawn.pagination pageCount=pageCount thisPage=thisPage />
<img id="pngDiagram"/>

<script>

$("button[value='ShowDiagram']").click(function() {
	$("#pngDiagram").attr("src","${request.contextPath}/System/Process/ShowProcessDefinitionDiagram?processDefinitionId="+ $(this).attr("name"));
});

$("button[value='Start']").click(function() {
	$.ajax({
		url : '${request.contextPath}/System/Process/StartProcessInstance',
		type : 'POST',
		data : "processDefinitionId=" + $(this).attr("name")+"&authenticatedUserId="+"${loginInfo.userId}",
		dataType : 'html',
		success : function(data) {
			alert("Operation Success!");
		},
		error : function(errormessage) {
			alert("Operation Error!");
		}
	});	

});


$("button[value='Delete']").click(function() {
	var this_tr = $(this).parent().parent();
	$.ajax({
		url : '${request.contextPath}/System/Process/DeleteDeploymentByProcessDefinitionId',
		type : 'POST',
		data : "id=" + $(this).attr("name"),
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
	    url: '${request.contextPath}/System/Process/ShowProcessDefinitionsByPage',
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
