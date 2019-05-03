<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改密码</title>
    <jsp:include page="common.jsp"></jsp:include>
</head>
<body>
<div class="cBody">
    <form id="addForm" class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">原始密码</label>
            <div class="layui-input-inline shortInput">
                <input type="password" name="oldpassword" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-inline shortInput">
                <input type="password" name="password" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认新密码</label>
            <div class="layui-input-inline shortInput">
                <input type="password" name="password2" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="submitBut">确认修改</button>
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
                if (data.field.password != data.field.password2){
                    layer.alert("两次密码输入不一致",{icon:5,title:"警告"});
                    return false;
                }
                var me = data;
                $.ajax({
                    url:basePath+"/administratorController/verifyPassword",
                    type:'post',
                    data:$.toJSON({password:data.field.oldpassword}),
                    contentType:'application/json',
                    success:function (data) {
                        if(!data.isTrue){
                            layer.alert("原始密码输入错误！",{icon:5,title:"警告"});
                            return false;
                        }else{
                            $.ajax({
                                url:basePath+"/administratorController/modifyPassword",
                                type:'post',
                                data:$.toJSON({password:me.field.password}),
                                contentType:'application/json',
                                success:function (data) {
                                    if(data.data){
                                        layer.msg("修改成功");
                                        window.parent.location.reload();
                                    }else{
                                        layer.alert("修改密码失败！",{icon:5,title:"警告"});
                                    }
                                },
                                error:function () {
                                    layer.alert("修改密码失败！ajax发送出现错误",{icon:5,title:"error"});
                                }

                            });
                        }
                    },
                    error:function () {
                        layer.alert("验证密码失败！ajax发送出现错误",{icon:5,title:"error"});
                    }

                });
                layer.msg(JSON.stringify(data.field.password));
                return false;
            });
        });
    </script>

</div>
</body>
</html>
