<%--
  User: LiQingsong
  Date: 2019/5/15
  Time: 17:13
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>收货地址</title>
</head>
<body>
<div class="search_bar clearfix">
    <a href="${ctx}/index.jsp" class="logo fl"><img src="${ctx}/assets/img/logo3.png"></a>
    <div class="sub_page_name fl"></div>
</div>

<div class="main_con clearfix">
    <div class="left_menu_con clearfix">
        <h3>用户中心</h3>
        <ul>
            <li><a href="userManagePage.jsp">· 个人信息</a></li>
            <li><a href="userAddressPage.jsp"  class="active">· 收货地址</a></li>
            <li><a href="userPasswordPage.jsp">· 修改密码</a></li>
        </ul>
    </div>
    <div class="right_content clearfix">
        <div class="info_con clearfix">
            <h3 class="common_title2">收货地址</h3>
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">地址</label>
                    <div  class="col-sm-2">
                        <select id="province" class="form-control">
                            <option value="">--省市--</option>
                        </select>
                    </div>
                    <div class="col-sm-2">
                        <select  id="area"  class="form-control">
                            <option value="">--区域--</option>
                        </select>
                    </div>
                    <div  class="col-sm-2">
                        <select id="street" class="form-control">
                            <option value="">--街道--</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="detail" class="col-sm-2 control-label">详细地址</label>
                    <div class="col-sm-6">
                        <textarea class="form-control" id="detail" rows="3"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="recipient" class="col-sm-2 control-label">收货人</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control " id="recipient" placeholder="收货人">
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="col-sm-2 control-label">手机号</label>
                    <div class="col-sm-6">
                        <input type="number" class="form-control " id="phone" placeholder="手机号">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" id="createAddrBtn" class="btn btn-success center-block">创建</button>
                    </div>
                </div>
            </form>
            <h4>已保存的地址</h4>
            <table class="layui-table" lay-data="{url:'${ctx}/address/queryListByUser/${user.id}', page:false, id:'idTest'}" lay-filter="addressTable">
                <thead>
                <tr>

                    <th lay-data="{field:'provinceName', width:90}">省市</th>
                    <th lay-data="{field:'areaName', width:90}">区域</th>
                    <th lay-data="{field:'streetName', width:100}">街道</th>
                    <th lay-data="{field:'detail', width:260}">详细地址</th>
                    <th lay-data="{field:'recipient', width:100}">收件人</th>
                    <th lay-data="{field:'phone', width:130}">手机号</th>
                    <th lay-data="{fixed: 'right', width:178, align:'center', toolbar: '#barDemo'}">操作</th>
                </tr>
                </thead>
            </table>

            <script type="text/html" id="barDemo">
                <a class="layui-btn layui-btn-xs" lay-event="setDefault">设为默认地址</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>


    </div>
</div>
</body>
<script>
    var basePath = '${ctx}';

    layui.use(['table','form'],function () {
        var table = layui.table;

        table.on('tool(addressTable)',function (obj) {
            var data = obj.data;
            if(obj.event=="del"){
                layer.confirm("你确定要删除该地址吗？",function (index) {
                    $.ajax({
                        url:basePath+"/address/remove/"+data.id,
                        type:'get',
                        success:function (data) {
                            if(data.msg=="success"){
                                layer.msg("删除成功",{time: 2000,icon: 1});
                                table.reload('idTest');
                            }
                        },
                        error:function () {
                            layer.alert("删除地址失败！ajax发送出现错误",{icon:5,title:"error"});
                        }

                    });
                })
            }else if(obj.event=='setDefault'){
                $.ajax({
                    url:basePath+"/address/setDefault/"+data.id,
                    type:'get',
                    success:function (data) {
                        if(data.msg=="success"){
                            layer.msg("设置默认地址成功",{time: 2000,icon: 1});
                            table.reload('idTest');
                        }
                    },
                    error:function () {
                        layer.alert("重置密码失败！ajax发送出现错误",{icon:5,title:"error"});
                    }

                });
            }
        })
    });

    $(function () {
        var user = '${user}';
        $.ajax({
            url: basePath + "/address/getProvinceAndArea",
            type: 'get',
            success: function (data) {
                $.each(data.province, function (index, item) {
                    $("#province").append(new Option(item.name, item.code));
                });
                $.each(data.area, function (index, item) {
                    $("#area").append(new Option(item.name, item.code));
                });
            }
        });
        $("#area").change(function () {
            var area = $("#area option:selected").val()
            $.ajax({
                url: basePath + "/address/getTown/"+area,
                type: 'get',
                success: function (data) {
                    $("#street option").not(":first").remove();
                    $.each(data.town, function (index, item) {
                        $("#street").append(new Option(item.name, item.code));
                    })
                }
            });
        });
        $("#createAddrBtn").click(function () {
            var province = $("#province option:selected").val();
            var area = $("#area option:selected").val();
            var street = $("#street option:selected").val();
            var detail = $("#detail").val();
            var recipient = $("#recipient").val();
            var phone = $("#phone").val();
            if(province==""||area ==""||street==""||detail==""||recipient==""||phone==""){
                layer.alert("信息不能为空",{icon:5,title:"error"});
                return false;
            }
            var pattern = /^1[34578]\d{9}$/;
            if(!pattern.test(phone)){
                layer.alert("手机号格式不正确",{icon:5,title:"error"});
                return false;
            }
            $.ajax({
                url:basePath+"/address/createAddress",
                type:'post',
                data:$.toJSON({province:province,area:area,street:street,detail:detail,recipient:recipient,phone:phone}),
                contentType:'application/json',
                success:function (data) {
                    if(data.code==0){
                        window.location.reload();
                    }else{
                        alert("添加地址失败！返回数据出错");
                    }
                },
                error:function () {
                    alert("添加地址失败！！ajax发送出现错误");
                }

            });
        });
    })
</script>
</html>
