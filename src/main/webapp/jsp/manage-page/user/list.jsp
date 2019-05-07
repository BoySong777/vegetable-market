<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户列表</title>
    <jsp:include page="../../../commons/base.jsp"></jsp:include>
    <jsp:include page="../common.jsp"></jsp:include>
</head>
<body>
<div class="cBody" id="root">
    <div class="console">
        <form class="layui-form" action="">
            <div class="layui-form-item">
                <div class="layui-input-inline">
                    <input type="text" name="account" placeholder="输入用户名" autocomplete="off" class="layui-input">
                </div>

                <div class="layui-input-inline">
                    <select name="sex" id="sex" lay-filter="sex">
                        <option value="">--请选择--</option>
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                </div>

                <div class="layui-input-inline">
                    <input type="text" name="phone" placeholder="输入手机号" autocomplete="off" class="layui-input">
                </div>

                <div class="layui-input-inline">
                    <input type="text" name="email" placeholder="输入邮箱" autocomplete="off" class="layui-input">
                </div>

                <button class="layui-btn" lay-submit lay-filter="formDemo">检索</button>
            </div>
        </form>
    </div>

    <table id="admin-table" class="layui-table" lay-filter="adminTable">
    </table>

</div>
<script type="text/html" id="operate">
    <a class="layui-btn layui-btn-xs" lay-event="reset">重置密码</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="userAvatar">
    {{#  if(d.avatar==null ||d.avatar==""){ }}
    <img src="${img}user/default.png">
    {{#  } else { }}
    <img src="${img}user/{{d.avatar}}.png">
    {{#  } }}
</script>
<script type="text/html" id="userAddress">
    <a class="layui-table-link" lay-event="addr">详情</a>
</script>
<script>
    var basePath = '${ctx}';
    var tableIns = null;
    var userId = "";

    layui.use(['table','form'],function () {
        var table = layui.table;
        var form = layui.form;

        tableIns = table.render({
            elem:"#admin-table",
            url:basePath+'/user/queryList',
            method:'post',
            contentType:'application/json',
            page:true,
            limit:3,
            limits:[3,6,9,12],
            cols:[[
                {field:'account',title:'用户名',width:80},
                {field:'avatar',title:'头像',width:100,templet:'#userAvatar'},
                {field:'sexName',title:'性别',width:100},
                {field:'phone',title:'手机号',width:150},
                {field:'email',title:'邮箱',width:150},
                {title:'地址',width:100,toolbar:'#userAddress'},
                {fixed: 'right', title:'操作', toolbar: '#operate', width:150}
            ]],
            toolbar: true
        });
        //监听提交
        form.on('submit(formDemo)', function(data) {
            tableIns.reload({
                where:{
                    user:{
                        account:$.trim(data.field.account),
                        sex:data.field.sex,
                        phone:$.trim(data.field.phone),
                        email:$.trim(data.field.email),
                    }
                }
            })
            return false;
        });
        table.on('tool(adminTable)',function (obj) {
            var data = obj.data;
            if(obj.event=="del"){
                layer.confirm("你确定要删除"+data.account+"吗？",function (index) {
                    $.ajax({
                        url:basePath+"/user/remove/"+data.id,
                        type:'get',
                        success:function (data) {
                            if(data.msg=="success"){
                                layer.msg("删除成功",{time: 2000,icon: 1});
                                tableIns.reload();
                            }
                        },
                        error:function () {
                            layer.alert("删除用户失败！ajax发送出现错误",{icon:5,title:"error"});
                        }

                    });
                })
            }else if(obj.event=='reset'){
                layer.confirm("你确定要重置"+data.account+"的密码吗？",function (index) {
                    $.ajax({
                        url:basePath+"/user/resetPwd/"+data.id,
                        type:'get',
                        success:function (data) {
                            if(data.msg=="success"){
                                layer.msg("重置密码成功，默认密码为123",{time: 2000,icon: 1});
                                tableIns.reload();
                            }
                        },
                        error:function () {
                            layer.alert("重置密码失败！ajax发送出现错误",{icon:5,title:"error"});
                        }

                    });
                })
            }else if(obj.event=='addr'){
                userId = data.id;
                layer.open({
                    type: 2,
                    title: "地址列表",
                    area: ['800px', '560px'],
                    shadeClose: true,
                    content:'addressDetail.jsp',
                    end:function () {
                        tableIns.reload();
                    }
                })
            }
        })
    });// 1 1 120000  120101 01001000 111
    function getUserId() {
        return userId;
    }
</script>
</body>
</html>
