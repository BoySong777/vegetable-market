<%--
  User: LiQingsong
  Date: 2019/5/14
  Time: 16:35
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
	
<div class="categoryMenu">
		<c:forEach items="${cs}" var="c">
			<div cid="${c.id}" class="eachCategory">
				<span class="glyphicon glyphicon-link"></span>
				<a href="forecategory?cid=${c.id}">
					${c.name}
				</a>
			</div>
		</c:forEach>
	</div>  