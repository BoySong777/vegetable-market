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
            <li><a href="userManagePage.jsp" class="active">· 个人信息</a></li>
            <li><a href="userAddressPage.jsp">· 收货地址</a></li>
            <li><a href="userPasswordPage.jsp">· 修改密码</a></li>
        </ul>
    </div>
    <div class="right_content clearfix">
        <div class="info_con clearfix">
            <h3 class="common_title2">基本信息</h3>
        </div>
        <form class="form-horizontal">
            <div class="form-group">
                <label for="recipient" class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-4">
                    <input type="text" disabled="disabled" class="form-control " value="${user.account}" id="account" placeholder="">
                </div>
            </div>
            <div class="form-group">
                <label for="sex" class="col-sm-2 control-label">性别</label>
                <div class="col-sm-2">
                    <input type="text" value="${user.sexName}" class="form-control " id="sex">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">手机号</label>
                <div class="col-sm-4">
                    <input type="text" value="${user.phone}" class="form-control " id="phone" >
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2 control-label">邮箱</label>
                <div class="col-sm-4">
                    <input type="text" disabled="disabled" value="${user.email}" class="form-control " id="email" >
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-3">
                    <button type="button" id="updateUser" class="btn btn-success center-block">修改</button>
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
        $("#updateUser").click(function () {
            var sex = $("#sex").val();
            var phone = $("#phone").val();
            if (!(sex==""||sex == "男" || sex == "女")) {
                layer.alert("性别只能输入‘男’ 或 ‘女’", {icon: 5, title: "error"});
                return false;
            } else {
                if (sex == "男") {
                    sex = 1;
                } else {
                    sex = 0;
                }
            }
            var pattern = /^1[34578]\d{9}$/;
            if(phone=="" && sex==""){
                return false;
            }
            if(phone!=""&&!pattern.test(phone)){
                layer.alert("手机号格式不正确",{icon:5,title:"error"});
                return false;
            }
            $.ajax({
                url:basePath+"/user/updateUser",
                type:"post",
                data:$.toJSON({sex:sex,phone:phone}),
                contentType:"application/json",
                success:function (data) {
                    if("success"==data){
                        layer.msg("修改成功")
                    }else{
                        alert("未登录！");
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
