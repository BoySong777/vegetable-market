<%--
  User: LiQingsong
  Date: 2019/5/3
  Time: 15:36
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工详情</title>
    <jsp:include page="common.jsp"></jsp:include>
</head>
<body>
<div class="cBody">
    <form id="addForm" class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline shortInput">
                <input type="text" id="account" name="account" value="${admin.account}" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">职位</label>
            <div class="layui-input-inline shortInput">
                <input type="text" name="position" value="${admin.position}" required lay-verify="required" autocomplete="off" class="layui-input" disabled>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">手机号</label>
            <div class="layui-input-inline shortInput">
                <input type="text" id="phone" name="phone" value="${admin.phone}" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="submitBut">确定</button>
                <button class="layui-btn layui-btn-normal">取消</button>
            </div>
        </div>
    </form>

    <script>
        var basePath = '${ctx}';
        var account = '${sessionScope.admin.account}';
        var phone = '${sessionScope.admin.phone}'
        layui.use('form', function() {
            var form = layui.form;
            //监听提交
            form.on('submit(submitBut)', function(data) {
                var pattern = /^1[34578]\d{9}$/;
                if(!pattern.test(data.field.phone)){
                   layer.alert("手机号格式错误！",{icon:5,title:"警告"});
                   return false;
                }
                if(account!=data.field.account || phone!=data.field.phone){
                    layer.confirm('您确定要修改个人信息？', {
                        btn: ['确定','取消'] //按钮
                    }, function(){
                        $.ajax({
                            url:basePath+"/administratorController/modify",
                            type:'post',
                            data:$.toJSON(data.field),
                            contentType:'application/json',
                            success:function (data) {
                                if(data.data){
                                    layer.msg("修改成功",{time: 2000,icon: 1});
                                }else{
                                    layer.alert("修改信息失败！",{icon:5,title:"警告"});
                                }
                            },
                            error:function () {
                                layer.alert("修改信息失败！ajax发送出现错误",{icon:5,title:"error"});

                            }
                        });
                    }, function(){
                        $("#account").val(account);
                        $("#phone").val(phone);
                    });
                }
                return false;
            });
        });
    </script>

</div>
</body>
</html>
