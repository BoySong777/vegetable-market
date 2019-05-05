<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../common.jsp"></jsp:include>
<html>
<head>
    <title>Title</title>
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
    <form id="addForm" class="layui-form" action="">
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
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>


    <script>
        var basePath = '${ctx}';
        layui.use('form', function() {
            var form = layui.form;
            //监听提交
            form.on('submit(submitBut)', function(data) {
                var me = data;
                $.ajax({
                    url:basePath+"/administratorController/selectAccount/"+data.field.account,
                    type:"get",
                    success:function (data) {
                        if(data.num==0){
                            $.ajax({
                                url:basePath+"/administratorController/create",
                                type:'post',
                                data:$.toJSON(me.field),
                                contentType:'application/json',
                                success:function (data) {
                                    if(data.data){
                                        layer.msg("添加成功",{time: 2000,icon: 1});
                                    }else{
                                        layer.alert("添加失败！",{icon:5,title:"警告"});
                                    }
                                },
                                error:function () {
                                    layer.alert("添加失败！ajax发送出现错误",{icon:5,title:"error"});

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
    </script>

</div>
</body>
</html>
