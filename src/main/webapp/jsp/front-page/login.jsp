<%--
  User: LiQingsong
  Date: 2019/5/12
  Time: 20:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>Title</title>
   <jsp:include page="commons/loginAndRegisterCom.jsp"></jsp:include>
</head>
<body>
<div class="login_top clearfix">
    <a href="index.html" class="login_logo"><img src="../../assets/img/logo2.png"></a>
</div>

<div class="login_form_bg">
    <div class="login_form_wrap clearfix">
        <div class="login_banner fl"></div>
        <div class="slogan fl">日夜兼程 · 急速送达</div>
        <div class="login_form fr">
            <div class="login_title clearfix">
                <h1>用户登录</h1>
                <a href="register.jsp">立即注册</a>
            </div>
            <div class="form_input">
                <form>
                    <input id="username" type="text" name="username" class="name_input" placeholder="请输入用户名 | 手机号 | 邮箱">
                    <div class="user_error">用户名不能为空</div>
                    <input id="password" type="password" name="pwd" class="pass_input" placeholder="请输入密码">
                    <div class="pwd_error">密码不能为空</div>
                    <div class="more_input clearfix">
                        <input type="checkbox" name="">
                        <label>记住用户名</label>
                        <a href="forgetPwd.jsp">忘记密码</a>
                    </div>
                    <input type="button" name="" value="登录" id="login" class="input_submit">
                </form>
            </div>
            <span id="errmsg" style="color: red;display:none">用户名或者密码错误</span>
        </div>
    </div>
</div>

<div class="footer no-mp">
    <div class="foot_link">
        <a href="#">关于我们</a>
        <span>|</span>
        <a href="#">联系我们</a>
        <span>|</span>
        <a href="#">招聘人才</a>
        <span>|</span>
        <a href="#">友情链接</a>
    </div>
    <p>CopyRight © 2019 青松毕设作业 All Rights Reserved</p>
    <p>电话：155*****161   京ICP备*******8号</p>
</div>
</body>
<script>
    var basePath = '${ctx}';
    var username = "";
    var password = "";
    $(function () {
        $("#username").blur(function () {
            var data = $.trim($("#username").val());
            if(data==null||data==""){
               $(".user_error").css("display","block");
            }else{
                $(".user_error").css("display","none");
                username = data;
            }
        });
        $("#password").blur(function () {
            var data = $.trim($("#password").val());
            if(data==null||data==""){
                $(".pwd_error").css("display","block");
            }else{
                $(".pwd_error").css("display","none");
                password = data;
            }
        });
        $("#login").click(function () {
            if(username!=""&&password!=""){
                $.ajax({
                    url : basePath+'/user/verifyLogin',
                    type : 'post',
                    data : $.toJSON({account:username,password:password}),
                    contentType: 'application/json;charset=UTF-8',
                    success: function(data) {
                        if(data.isTrue){
                            $("#errmsg").css("display","none");
                            window.location.href =basePath+"/index.jsp";
                        }else{
                            $("#errmsg").css("display","block");
                        }
                    },
                    error:function () {
                        alert(4)
                    }

                });
            }
        });

    });
   /* function verifyLogin() {

        if(username!=""&&password!=""){
            $.ajax({
                url : basePath+'/user/verifyLogin',
                type : 'post',
                data : $.toJSON({account:username,password:password}),
                contentType: 'application/json;charset=UTF-8',
                success: function(data) {
                    if(data.isTrue){
                        $("#errmsg").css("display","none");
                        window.location.href =basePath+"/index.jsp";
                    }else{
                        $("#errmsg").css("display","block");
                    }
                },
                error:function () {
                   alert("验证登录失败，ajax发生错误")
                }

            });
        }
        return false;
    }*/
</script>
</html>
