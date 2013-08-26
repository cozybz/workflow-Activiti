<#macro pagination pageCount thisPage>
<div class="pagination pagination-right">
  <ul>

<#if (pageCount <= 0)>

<#elseif (pageCount <= 5)>
	<#assign end = pageCount >
	<#assign start = 1 >
<#elseif (thisPage+2 <= pageCount) && (thisPage-2>=1)>
	<#assign end = thisPage+2 >
	<#assign start = thisPage-2 >
<#elseif (thisPage+2 > pageCount)>
	<#assign end = pageCount >
	<#assign start = pageCount-4 >
<#elseif (thisPage-2 <1)>
	<#assign end = 5 >
	<#assign start = 1 >
	
</#if>

<#if (pageCount > 0)>
 <li name="${thisPage-1}"
 <#if thisPage=1 >
 class="disabled"
 </#if>
 ><a href="#" >Prev</a></li>
 
<#list start..end as i>
	<li name="${i}"
	<#if i==thisPage>class="active"</#if>
	><a href="#" >${i}</a></li>
</#list>

<li name="${thisPage+1}"
<#if thisPage=pageCount>
class="disabled"
</#if>
><a href="#" >Next</a></li>

</#if>
    
  </ul>
</div>

</#macro>