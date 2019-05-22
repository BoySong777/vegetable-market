<%--
  User: LiQingsong
  Date: 2019/5/14
  Time: 13:07
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<a href="${ctx}/index.jsp">
    <img id="logo" src="${ctx}/assets/img/logo2.png" class="logo">
</a>

<form action="${ctx}/goods/searchGoods" method="post" >
    <div class="searchDiv">
        <input name="searchValue" value="${searchVal}" type="text" placeholder="香蕉  白菜 ">
        <button  type="submit" class="searchButton">搜索</button>

    </div>
</form>
