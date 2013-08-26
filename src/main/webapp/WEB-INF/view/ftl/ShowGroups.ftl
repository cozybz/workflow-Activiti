<div id="modal"></div>
<table class="table table-striped table-bordered table-hover">
	<tr class="info">
		<td>ID</td>
		<td>Name</td>
		<td>Type</td>
		<td>Operation</td>
	</tr>
	<#list groups as group>
	<tr>
		<td>${(group.id)!''}</td>
		<td>${(group.name)!''}</td>
		<td>${(group.type)!''}</td>
		<td>
			<button name="${(group.id)!''}" class="btn btn-danger btn-mini" value="Delete">Delete</button>
			<button name="${(group.id)!''}" class="btn btn-inverse btn-mini" value="PreUpdate">Update</button>
		</td>
	</tr>
	</#list>
</table>

<#import "Pagination.ftl" as dawn>
<@dawn.pagination pageCount=pageCount thisPage=thisPage />


<script>

$("button[value='Delete']").click(function() {
	var this_tr = $(this).parent().parent();
	$.ajax({
		url : '${request.contextPath}/System/Group/Delete',
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


$("button[value='PreUpdate']").click(function() {
	$.ajax({
		url : '${request.contextPath}/System/Group/PreUpdate',
		type : 'POST',
		data : "id=" + $(this).attr("name"),
		dataType : 'html',
		success : function(data) {
			$("#modal").append(data);
			$('#updateGroup').modal('show');
			$('#updateGroup').on('hidden',function(){
				$('#modal').empty();
			});
		},
		error : function(errormessage) {
			alert("Operation Error!");
		}
	});
});

$(".pagination li[class!='disabled']").click(function(){
	$.ajax({
	    url: '${request.contextPath}/System/Group/ShowGroupsByPage',
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
