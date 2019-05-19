<%--
  User: LiQingsong
  Date: 2019/5/15
  Time: 17:13
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="search_bar clearfix">
    <a href="${ctx}/index.jsp" class="logo fl"><img src="${ctx}/assets/img/logo3.png"></a>
</div>

<div class="main_con clearfix">
    <div class="left_menu_con clearfix">
        <h3>用户中心</h3>
        <ul>
            <li><a href="userManagePage.jsp">· 个人信息</a></li>
            <li><a href="userAddressPage.jsp">· 收货地址</a></li>
            <li><a href="userPasswordPage.jsp"  class="active">· 修改密码</a></li>
        </ul>
    </div>
    <div class="right_content clearfix">
        <div class="info_con clearfix">
            <h3 class="common_title2">基本信息</h3>
        </div>
        <form class="form-horizontal">
            <div class="form-group">
                <label for="oldPwd" class="col-sm-2 control-label">原始密码</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control " id="oldPwd" placeholder="原始密码">
                </div>
            </div>
            <div class="form-group">
                <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control "  placeholder="新密码" id="newPwd" >
                </div>
            </div>
            <div class="form-group">
                <label for="newPwd2" class="col-sm-2 control-label">确认密码</label>
                <div class="col-sm-4">
                    <input type="password"  placeholder="确认密码" class="form-control " id="newPwd2" >
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-3">
                    <button type="button" id="updatePwd" class="btn btn-success center-block">修改</button>
                </div>
            </div>
        </form>

    </div>
</div>
</body>
<script>
    var basePath = "${ctx}";
    layui.use(['table','form'],function () {

    })
    $(function () {
        $("#updatePwd").click(function () {
            var oldPwd = $("#oldPwd").val();
            var newPwd2 = $("#newPwd2").val();
            var newPwd = $("#newPwd").val();
            if (oldPwd==""||newPwd2 == "" || newPwd == "") {
                layer.alert("密码不能为空", {icon: 5, title: "error"});
                return false;
            }
            if(newPwd!=newPwd2){
                layer.alert("两次密码输入不一致", {icon: 5, title: "error"});
                return false;
            }
            $.ajax({
                url:basePath+"/user/updateUserPassword",
                type:"post",
                data:$.toJSON({oldPwd:oldPwd,newPwd:newPwd}),
                contentType:"application/json",
                success:function (data) {
                    if("success"==data){
                        layer.msg("修改成功")
                        window.location.href = basePath+"/jsp/front-page/login.jsp";
                    }else if("notTrue"==data){
                        layer.alert("原始密码输入错误", {icon: 5, title: "error"});
                    }
                },
                error:function () {
                    alert("修改失败 ajax失败")
                }
            });
        })
    })
</script>
</html>
