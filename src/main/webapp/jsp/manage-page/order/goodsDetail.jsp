<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品列表</title>
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
    <table id="orderGoods-table" class="layui-table" lay-filter="goodsDetailTable">
    </table>
</div>
<script type="text/html" id="goodDetail">
    <a href="${ctx}/goods/goodsDetail/{{d.goodsId}}"  target="view_window" class="layui-table-link" lay-event="deta">{{d.goodsName}}</a>
</script>
<script>
    var basePath = '${ctx}';

    layui.use('table',function () {
        var table = layui.table;

        tableIns = table.render({
            elem:"#orderGoods-table",
            url:basePath+'/order/queryOrderGoodsByOrderId/'+parent.getOrderId(),
            method:'get',
            cols:[[
                {field:'goodsName',title:'商品名称',width:350, toolbar: '#goodDetail'},
                {field:'goodsPrice',title:'商品价格',width:100},
                {field:'number',title:'购买数量',width:100}
            ]],
            toolbar: true
        });

    });

</script>
</body>
</html>
