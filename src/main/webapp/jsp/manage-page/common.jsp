<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:15
--%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
<!-- Google Chrome Frame也可以让IE用上Chrome的引擎: -->
<meta name="renderer" content="webkit">
<!--国产浏览器高速模式-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="author" content="LiQingsong"/>
<!-- 作者 -->
<!-- 公共样式 开始 -->
<%
    String ctx = request.getContextPath();
    request.setAttribute("ctx",ctx);
%>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/managePage/css/base.css">
<link rel="stylesheet" type="text/css" href="${ctx}/assets/managePage/css/iconfont.css">
<script type="text/javascript" src="${ctx}/assets/managePage/framework/jquery-1.11.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/assets/managePage/layui/css/layui.css">
<script src="${ctx}/assets/managePage/layui/layui.js"></script>
<!-- 滚动条插件 -->
<link rel="stylesheet" type="text/css" href="${ctx}/assets/managePage/css/jquery.mCustomScrollbar.css">
<script src="${ctx}/assets/managePage/framework/jquery-ui-1.10.4.min.js"></script>
<script src="${ctx}/assets/managePage/framework/jquery.mousewheel.min.js"></script>
<script src="${ctx}/assets/managePage/framework/jquery.mCustomScrollbar.min.js"></script>
<script src="${ctx}/assets/managePage/framework/cframe.js"></script><!-- 仅供所有子页面使用 -->
<!--jQuery-json-->
<script type="text/javascript" src="${ctx}/assets/script/jquery.json.min.js"></script>
<!-- 公共样式 结束 -->
