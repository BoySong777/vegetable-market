<%--
  User: LiQingsong
  Date: 2019/5/12
  Time: 15:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<nav class="top ">
    <a href="${ctx}">
        <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
        首页
    </a>

    <span>hello，欢迎光临菜市场</span>

    <c:if test="${!empty user}">
        <a href="${ctx}/jsp/front-page/user/userManagePage.jsp">${user.account}</a>
        <a href="${ctx}/user/signOut">退出</a>
    </c:if>

    <c:if test="${empty user}">
        <a href="${ctx}/jsp/front-page/login.jsp">请登录</a>
        <a href="${ctx}/jsp/front-page/register.jsp">注册</a>
    </c:if>


    <span class="pull-right">
			<a href="${ctx}/order/myOrder">我的订单</a>
			<a href="${ctx}/cart/getCartList">
			<span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-shopping-cart redColor"></span>
			购物车
            </a>
		</span>
</nav>