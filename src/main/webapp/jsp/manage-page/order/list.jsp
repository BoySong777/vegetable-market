<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>订单列表</title>
    <jsp:include page="../../../commons/base.jsp"></jsp:include>
    <jsp:include page="../common.jsp"></jsp:include>
</head>
<body>
<div class="cBody" id="root">
    <div class="console">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <input id="orderId" type="text" name="orderId" placeholder="订单编号" autocomplete="off"
                           class="layui-input">
                </div>

                <div class="layui-input-inline">
                    <select name="orderStatus" lay-filter="orderStatus" id="orderStatus">
                        <option value="4">--订单状态--</option>
                        <option value="0">未付款</option>
                        <option value="1">未发货</option>
                        <option value="2">未收货</option>
                        <option value="3">已完成</option>
                    </select>
                </div>
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="startAndEndTime" id="test6" placeholder=" 日期范围">
                    </div>
                </div>
                <button class="layui-btn" lay-submit lay-filter="formDemo">检索</button>
            </div>
        </form>
    </div>

    <table id="user-table" class="layui-table" lay-filter="orderTable">
    </table>

</div>
<script type="text/html" id="operate">
    <a class="layui-btn layui-btn-xs" lay-event="modify">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="orderOperate">
    {{#  if(d.status==1){ }}
    {{d.statusName}}<a href="javascript:void(0)" onclick=operateOrderStatus('{{d.id}}') class="layui-table-link order-operate"> 去发货</a>
    {{#  } else { }}
    {{d.statusName}}
    {{#  } }}
</script>
<script type="text/html" id="userAddress">
    <a class="layui-table-link" lay-event="addr">查看</a>
</script>
<script>
    var basePath = '${ctx}';
    var tableIns = null;

    layui.use(['table', 'form', 'laydate'], function () {
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        //日期范围
        laydate.render({
            elem: '#test6'
            , range: true
        });

        tableIns = table.render({
            elem: "#user-table",
            url: basePath + '/order/queryList',
            method: 'post',
            contentType: 'application/json',
            page: true,
            limit: 3,
            limits: [3, 6, 9, 12],
            cols: [[
                {field: 'createTime', title: '下单时间', width: 80},
                {field: 'userName', title: '下单用户', width: 100},
                {field: 'userInfo', title: '配送地址', width: 100},
                {field: 'totalPrice', title: '支付金额', width: 100},
                {field: 'payTime', title: '支付时间', width: 150},
                {field: 'endTime', title: '完成时间', width: 150},
                {field: 'id', title: '商品详情', width: 150, toolbar: '#userAddress'},
                {field: 'statusName', title: '订单状态', width: 100, templet: "#orderOperate"},
                {fixed: 'right', title: '操作', toolbar: '#operate', width: 150}
            ]],
            toolbar: true
        });

        //监听提交
        form.on('submit(formDemo)', function (data) {
            tableIns.reload({
                page: {
                    curr: 1
                },
                where: {
                    goodsOrder: {
                        status:data.field.orderStatus
                    },
                    startAndEndTime:data.field.startAndEndTime,
                    searchId:$.trim(data.field.searchId)
                }
            })
            return false;
        });
        table.on('sort(orderTable)', function (obj) {
            tableIns.reload({
                initSort: obj,
                page: {
                    curr: 1
                },
                where: {
                    order: obj.field,
                    sort: obj.type,
                    goods: {
                        name: $.trim($('#name').val()),
                        categoryCode: $('#firstType').val(),
                        typeCode: $('#secondType').val(),
                        brand: $.trim($('#brand').val()),
                        stock: $('#stock').val()
                    }
                }
            });
        });
        table.on('tool(orderTable)', function (obj) {
            var data = obj.data;
            if (obj.event == "del") {
                layer.confirm("你确定要删除这个商品吗？", function (index) {
                    $.ajax({
                        url: basePath + "/goods/remove/" + data.id,
                        type: 'get',
                        success: function (data) {
                            if (data.msg == "success") {
                                layer.msg("删除成功", {time: 2000, icon: 1});
                                tableIns.reload();
                            }
                        },
                        error: function () {
                            layer.alert("删除商品失败！ajax发送出现错误", {icon: 5, title: "error"});
                        }

                    });
                })
            } else if (obj.event == 'modify') {
                window.location.href = "edit.jsp?" + "id=" + data.id;
            } else if (obj.event == 'addr') {
                //TODO:查看详情页
                userId = data.id;
                layer.open({
                    type: 2,
                    title: "地址列表",
                    area: ['800px', '560px'],
                    shadeClose: true,
                    content: 'addressDetail.jsp',
                    end: function () {
                        tableIns.reload();
                    }
                })
            }
        })
    });

    function operateOrderStatus(id){
        $.ajax({
            url:'${ctx}/order/setShip/'+id,
            type:'get',
            success:function (data) {
                if("success"==data){
                    layer.msg("已发货", {time: 2000, icon: 1});
                    tableIns.reload();
                }
            }
        })
    }
   /* $(function () {
        $(".order-operate").click(function () {
            var orderId =  $(this).attr("orderId");
            alert(orderId);
        });
    })*/

    function getUserId() {
        return userId;
    }
</script>
</body>
</html>
