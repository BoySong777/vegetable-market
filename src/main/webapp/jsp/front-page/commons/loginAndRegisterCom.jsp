<%--
  User: LiQingsong
  Date: 2019/5/13
  Time: 13:35
--%>
<%
    String ctx = request.getContextPath();
    request.setAttribute("ctx",ctx);
    String img = "http://localhost:81/img/";
    request.setAttribute("img",img);
%>
<!-- 引入JQuery -->
<script type="text/javascript" src="${ctx}/assets/script/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/assets/script/jquery.json.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/css/user-login/reset.css">
<link rel="stylesheet" type="text/css" href="${ctx}/assets/css/user-login/main.css">