<%--
  User: LiQingsong
  Date: 2019/4/30
  Time: 17:18
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <%--<jsp:include page="../../commons/base.jsp"></jsp:include>
    <jsp:include page="common.jsp"></jsp:include>--%>
    <%
        String ctx = request.getContextPath();
        request.setAttribute("ctx",ctx);
        String img = "http://localhost:81/img/";
        request.setAttribute("img",img);
    %>
    <link rel="stylesheet" type="text/css" href="../../assets/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/css/admin.css"/>
</head>
<body>
<div class="wrap-container welcome-container">
    <div class="row">
        <div class="welcome-left-container col-lg-9">
            <div class="data-show">
                <ul class="clearfix">
                    <li class="col-sm-12 col-md-4 col-xs-12">
                        <a href="javascript:;" class="clearfix">
                            <div class="icon-bg bg-org f-l">
                                <span class="iconfont">&#xe604;</span>
                            </div>
                            <div class="right-text-con">
                                <p class="name">今日销量</p>
                                <p><span id="todaySales" class="color-org">89</span></p>
                            </div>
                        </a>
                    </li>
                    <li class="col-sm-12 col-md-4 col-xs-12">
                        <a href="javascript:;" class="clearfix">
                            <div class="icon-bg bg-blue f-l">
                                <span class="iconfont">&#xe602;</span>
                            </div>
                            <div class="right-text-con">
                                <p class="name">订单量</p>
                                <p><span id="todayOrders" class="color-blue">189</span></p>
                            </div>
                        </a>
                    </li>
                    <li class="col-sm-12 col-md-4 col-xs-12">
                        <a href="javascript:;" class="clearfix">
                            <div class="icon-bg bg-green f-l">
                                <span class="iconfont">&#xe605;</span>
                            </div>
                            <div class="right-text-con">
                                <p class="name">访问量</p>
                                <p><span id="todayAccess" class="color-green">221</span></p>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <!--图表-->
            <div class="chart-panel panel panel-default">
                <div class="panel-body" id="chart" style="height: 376px;">
                </div>
            </div>
            <!--服务器信息-->
            <div class="server-panel panel panel-default">
                <div class="panel-header">通知信息</div>
                <div class="panel-body clearfix">
                    <div class="col-md-5">
                        <p class="title">未发货订单消息</p>
                        <span class="info">&nbsp;&nbsp;&nbsp;系统中有<a id="noShipOrderNumber" style="color: #0C78DD" href="javascript:void(0)">10</a>个未发货订单，<a  style="color: #0C78DD" href="${ctx}/jsp/manage-page/order/list.jsp">去发货</a></span>
                    </div>
                    <div class="col-md-2"></div>
                    <div class="col-md-5">
                        <p class="title">需补货商品</p>
                        <span class="info">&nbsp;&nbsp;&nbsp;系统中有<a id="needAddGoodsNumber" style="color: #0C78DD" href="javascript:void(0)">10</a>个商品数量低于(等于)10，<a  style="color: #0C78DD" href="${ctx}/jsp/manage-page/goods/list.jsp">去补货</a></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../../assets/layui/layui.js" type="text/javascript" charset="utf-8"></script>
<script src="../../assets/echarts/echarts.js"></script>
<script type="text/javascript">
    var basePath = '${ctx}';
    layui.use(['layer','jquery'], function(){
        var layer 	= layui.layer;
        var $=layui.jquery;
        //图表
        var myChart;
        require.config({
            paths: {
                echarts: '../../assets/echarts'
            }
        });
        require(
            [
                'echarts',
                'echarts/chart/bar',
                'echarts/chart/line',
                'echarts/chart/map'
            ],
            function (ec) {

                //--- 折柱 ---
                $.ajax({
                    url:basePath+"/searchRecord",
                    type:"get",
                    success:function (data) {
                        if(data.msg=="success"){
                            var todayData = data.todayData;
                            $("#todaySales").text(todayData.sales);
                            $("#todayAccess").text(todayData.access);
                            $("#todayOrders").text(todayData.orders);
                            var noShipOrderNumber = data.noShipOrderNumber;
                            $("#noShipOrderNumber").text(noShipOrderNumber);
                            var needAddGoodsNumber = data.needAddGoodsNumber;
                            $("#needAddGoodsNumber").text(needAddGoodsNumber);
                            var dayStr = data.dateStr;
                            var daySales = data.dateSales;
                            myChart = ec.init(document.getElementById('chart'));
                            myChart.setOption(
                                {
                                    title: {
                                        text: "销量统计",
                                        textStyle: {
                                            color: "rgb(85, 85, 85)",
                                            fontSize: 18,
                                            fontStyle: "normal",
                                            fontWeight: "normal"
                                        }
                                    },
                                    tooltip: {
                                        trigger: "axis"
                                    },
                                    legend: {
                                        data: ["销量"],
                                        selectedMode: false,
                                    },
                                    toolbox: {
                                        show: true,
                                        feature: {
                                            dataView: {
                                                show: false,
                                                readOnly: true
                                            },
                                            magicType: {
                                                show: false,
                                                type: ["line", "bar", "stack", "tiled"]
                                            },
                                            restore: {
                                                show: true
                                            },
                                            saveAsImage: {
                                                show: true
                                            },
                                            mark: {
                                                show: false
                                            }
                                        }
                                    },
                                    calculable: false,
                                    xAxis: [
                                        {
                                            type: "category",
                                            boundaryGap: false,
                                            data: dayStr
                                        }
                                    ],
                                    yAxis: [
                                        {
                                            type: "value"
                                        }
                                    ],
                                    grid: {
                                        x2: 30,
                                        x: 50
                                    },
                                    series: [
                                        {
                                            name: "销量",
                                            type: "line",
                                            smooth: true,
                                            itemStyle: {
                                                normal: {
                                                    areaStyle: {
                                                        type: "default"
                                                    }
                                                }
                                            },
                                            data: daySales
                                        }
                                    ]
                                }
                            );

                        }
                    }
                });

            }
        );
        $(window).resize(function(){
            myChart.resize();
        })
    });
</script>
</body>
</html>
