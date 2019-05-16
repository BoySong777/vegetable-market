<%--
  User: LiQingsong
  Date: 2019/5/14
  Time: 16:35
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<title>网上菜市场-${c.name}</title>
<div id="category">
	<div class="categoryPageDiv">
		<img src="img/category/${c.id}.jpg">
		<%@include file="sortBar.jsp"%>
		<%@include file="productsByCategory.jsp"%>
	</div>

</div>