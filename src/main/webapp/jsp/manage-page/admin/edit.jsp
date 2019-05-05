<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<!--jQuery-json-->
<script type="text/javascript" src="${ctx}/assets/script/jquery.json.min.js"></script>
<!-- 公共样式 结束 -->
<html>
<head>
    <title>修改员工信息</title>
    <style>
        .layui-form-label{
            width: 100px;
        }
        .layui-input-block{
            margin-left: 130px;
            margin-right: 30%;
        }
        .layui-form{
            margin-right: 30%;
        }
    </style>

</head>

<body>
<div class="cBody">
    <form id="addForm" class="layui-form" lay-filter="editForm" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="account" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">职位</label>
            <div class="layui-input-inline">
                <select name="position" id="position" lay-filter="position">
                    <option value="">--请选择--</option>
                    <option value="管理员">管理员</option>
                    <option value="高级管理员">高级管理员</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-block">
                <input type="text" name="phone" required lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="submitBut">提交</button>
                <button class="layui-btn layui-btn-primary" id="cancel">取消</button>
            </div>
        </div>
    </form>


    <script>

        var basePath = '${ctx}';
        var id = "";
        var oldAccount = "";
        layui.use('form', function() {
            var form = layui.form;
            $.ajax({
                url:basePath+"/administratorController/findOneById",
                type:"post",
                data:$.toJSON({id:id}),
                contentType:'application/json',
                success:function (data) {
                    oldAccount = data.administrator.account,
                    form.val('editForm',{
                        "account":data.administrator.account,
                        "position":data.administrator.position,
                        "phone":data.administrator.phone
                    })
                },
                error:function () {

                }
            });
            //监听提交
            form.on('submit(submitBut)', function(data) {
                var me = data;
                me.field.id = id;
                if(oldAccount!=data.field.account){
                    $.ajax({
                        url:basePath+"/administratorController/selectAccount/"+data.field.account,
                        type:"get",
                        success:function (data) {
                            if(data.num==0){
                                $.ajax({
                                    url:basePath+"/administratorController/updateById",
                                    type:'post',
                                    data:$.toJSON(me.field),
                                    contentType:'application/json',
                                    success:function (data) {
                                        if(data.data){
                                            layer.msg("修改成功",{time: 2000,icon: 1});
                                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                            parent.layer.close(index); //再执行关闭
                                        }else{
                                            layer.alert("修改失败！",{icon:5,title:"警告"});
                                        }
                                    },
                                    error:function () {
                                        layer.alert("修改失败！ajax发送出现错误",{icon:5,title:"error"});

                                    }
                                });
                            }else{
                                layer.msg("此用户名已经被占用",{anim:6,time: 2000,icon: 5});
                            }
                        },
                        error:function () {
                            layer.alert("用户名验证失败，ajax出现错误",{icon:5,title:"警告"});
                        }
                    });
                }else{
                    $.ajax({
                        url:basePath+"/administratorController/updateById",
                        type:'post',
                        data:$.toJSON(me.field),
                        contentType:'application/json',
                        success:function (data) {
                            if(data.data){
                                layer.msg("修改成功",{time: 2000,icon: 1});
                                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                parent.layer.close(index); //再执行关闭
                            }else{
                                layer.alert("修改失败！",{icon:5,title:"警告"});
                            }
                        },
                        error:function () {
                            layer.alert("修改失败！ajax发送出现错误",{icon:5,title:"error"});

                        }
                    });
                }
                return false;
            });
            form.verify({
                phone:function (value,item) {
                    var pattern = /^1[34578]\d{9}$/;
                    if(!pattern.test(value)){
                        return "手机号格式错误！";
                    }
                }
            });
        });
        $(function () {
            id = parent.getId();
            $("#cancel").click(function () {
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                parent.layer.close(index); //再执行关闭
            });
        });
    </script>

</div>
</body>
</html>
