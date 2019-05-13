<%--
  User: LiQingsong
  Date: 2019/5/13
  Time: 16:46
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="commons/base.jsp"></jsp:include>
<html>
<head>
    <title>Title</title>
    <style>
        .form-horizontal{
            margin-right: 40%;
            margin-left: 30%;
            margin-top: 10%;
        }
    </style>
</head>
<body>
<form class="form-horizontal">
    <img class="img-responsive center-block" src="${ctx}/assets/img/logo2.png">
    <h3 class="text-center" style="margin-bottom: 30px">修改密码</h3>
    <div class="form-group">
        <label for="newPassword" class="col-sm-3 control-label">新密码</label>
        <div class="col-sm-9">
            <input type="password" class="form-control" id="newPassword" placeholder="新密码">
        </div>
    </div>
    <div class="form-group">
        <label for="newPassword2" class="col-sm-3 control-label">确认密码</label>
        <div class="col-sm-9">
            <input type="password" class="form-control" id="newPassword2" placeholder="确认密码">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <button id="modifyBut" type="button" class="btn btn-success btn-block" style="margin: 20px auto;display: table;">确认修改</button>
        </div>
        <div id="err_msg" class="text-center" style="color: red; display: none">111</div>
    </div>
</form>
</body>
<script>
    $(function () {
        $("#modifyBut").click(function () {
            var pwd1 = $("#newPassword").val();
            var pwd2 = $("#newPassword2").val();
            var userId = '${userId}';

            if(pwd1==""||pwd2==""){
                $("#err_msg").html("密码不能为空");
                $("#err_msg").show();
            }else if(pwd2!=pwd1){
                $("#err_msg").html("两次输入不一致");
                $("#err_msg").show();
            }else{
                $("#err_msg").hide();
                if(userId!=null&&userId!=""){
                    $.ajax({
                        url:"${ctx}/user/updatePwd",
                        type:'post',
                        data:$.toJSON({id:userId,password:pwd1}),
                        contentType:'application/json',
                        success:function (data) {
                            if(data.msg =="success"){
                                window.location.href = "${ctx}/jsp/front-page/login.jsp";
                            }else{
                                alert("未更改成功，返回数据出现错误！")
                            }
                        },
                        error:function () {
                            alert("修改密码失败，ajax出现错误！")
                        }
                    });
                }
            }
        })
    })
</script>
</html>
