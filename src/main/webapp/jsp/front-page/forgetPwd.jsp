<%--
  User: LiQingsong
  Date: 2019/5/12
  Time: 20:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <title>找回密码</title>
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
                <a href="login.jsp">返回登录</a>
            </div>
            <div class="form_input">
                <form>
                    <input id="email" type="text" name="email" class="name_input" placeholder="请输入注册使用的邮箱">
                    <div class="email_error">邮箱不能为空</div>

                    <input type="button" name="" value="发送邮箱验证" id="forgetPwd" class="input_submit">
                </form>
            </div>
            <span id="msg" style="color: green;display:none">已发送，请注意查收</span>
            <span style="color: red">${timeOutMessage}</span>
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
    var email = "";
    $(function () {
        $("#email").blur(function () {
            var data = $.trim($("#email").val());
            if(data==null||data==""){
                $(".email_error").css("display","block");
            }else{
                var re = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
                if(re.test($('#email').val()))
                {
                    $.ajax({
                        url : basePath+'/user/verifyEmail/'+data+'/email',
                        type : 'get',
                        success: function(data) {
                            if(data.num==1){
                               email = $.trim($("#email").val());
                                $(".email_error").css("display","none");
                            }else{
                                $(".email_error").html('此邮箱未注册过账户');
                                $(".email_error").css("display","block");

                            }
                        },
                        error:function () {
                            alert("验证邮箱时出错，ajax发送失败")
                        }

                    });
                }
            }
        });

        $("#forgetPwd").click(function () {
            if(email!=""){
                $.ajax({
                    url : basePath+'/mail/send/'+email+'/email',
                    type : 'get',
                    success: function(data) {
                        if(data.isTrue){
                            $("#msg").css("display","block");
                        }else{
                            alert("返回的数据不正确。")
                        }
                    },
                    error:function () {
                        alert("发送失败，ajax发生错误！")
                    }

                });
            }
        });

    });

</script>
</html>
