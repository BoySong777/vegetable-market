<%--
  User: LiQingsong
  Date: 2019/4/29
  Time: 10:38
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网上菜市场</title>
    <jsp:include page="../../commons/base.jsp"></jsp:include>
    <link rel="shortcut icon" href="${ctx}/assets/managePage/images/favicon.ico"/>
    <link rel="bookmark" href="${ctx}/assets/managePage/images/favicon.ico"/>
    <script type="text/javascript" src="${ctx}/assets/script/vue-router.js"></script>
    <link href="${ctx}/assets/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/assets/css/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="root" class="page">
    <div class="loginwarrp">
        <div class="logo">管理员登陆</div>
        <div class="login_form">
                <li class="login-item">
                    <input type="text" id="account" name="account" placeholder="账户" v-model="params.account"  class="login_input" >
                </li>
                <li class="login-item">
                    <input type="password" id="password" placeholder="密码" v-model="params.password" name="password" class="login_input">
                </li>

                <div class="clearfix"></div>
                <li class="login-sub">
                    <input type="button" name="Submit" value="登录" @click="verifyLogin"/>
                </li>

                <div id="login_tip">
                    <span id="login_err" style="color: red;" class="sty_txt2">{{loginErr}}</span>
                </div>
        </div>

    </div>
</div>

<script type="text/javascript">
    var basePath = '${ctx}';
    new Vue({
        el:"#root",
        data:{
            params:{
                account:"admin",
                password:"1"
            },
            loginErr:""
        },
        methods:{
            verifyLogin:function(){
                if(this.params.account==null || this.params.account==""){
                    this.loginErr = "用户名不能为空";
                    return false;
                }
                if(this.params.password==null || this.params.password==""){
                    this.loginErr = "密码不能为空";
                    return false;
                }
                var me = this;
                $.ajax({
                    url : basePath+'/administratorController/verifyAccountAndPwd',
                    type : 'post',
                    data : $.toJSON(me.params),
                    contentType: 'application/json;charset=UTF-8',
                    success: function(data) {
                        if(data.isTrue){
                            me.loginErr = "";
                            window.location.href =basePath+"/jsp/manage-page/frame.jsp";
                        }else{
                            me.loginErr = "账户或密码错误！";
                        }
                    },
                    error:function () {
                        this.loginErr = "登录失败";
                    }

                });

            },
        }
    });
</script>

</body>
</html>
