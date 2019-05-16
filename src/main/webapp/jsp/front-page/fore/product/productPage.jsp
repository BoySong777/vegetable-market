<%--
  User: LiQingsong
  Date: 2019/5/14
  Time: 16:35
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<title>网上菜市场 ${p.name}</title>
<div class="categoryPictureInProductPageDiv">
	<img class="categoryPictureInProductPage" src="img/category/${p.category.id}.jpg">
</div>

<div class="productPageDiv">

	<%@include file="imgAndInfo.jsp" %>

	<%@include file="productReview.jsp" %>

	<%@include file="productDetail.jsp" %>
</div>