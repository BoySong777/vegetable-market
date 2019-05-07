<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>地址列表</title>
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
    <!--jQuery-json-->
    <script type="text/javascript" src="${ctx}/assets/script/jquery.json.min.js"></script>
    <!-- 公共样式 结束 -->
</head>
<body>
<div class="cBody" id="root">
    <table id="addr-table" class="layui-table" lay-filter="addrTable">
    </table>
</div>

<script>
    var basePath = '${ctx}';

    layui.use('table',function () {
        var table = layui.table;

        tableIns = table.render({
            elem:"#addr-table",
            url:basePath+'/address/queryListByUser/'+parent.getUserId(),
            method:'get',
            cols:[[
                {field:'provinceName',title:'省市',width:80},
                {field:'areaName',title:'区县',width:100},
                {field:'streetName',title:'街道',width:100},
                {field:'detail',title:'详细地址',width:175},
                {field:'phone',title:'手机号',width:150},
                {field:'recipient',title:'联系人',width:150},
            ]],
            toolbar: true
        });

    });

</script>
</body>
</html>
