<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
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
                    <select name="position" id="position" lay-filter="position">
                        <option value="">--请选择--</option>
                        <option value="管理员">管理员</option>
                        <option value="高级管理员">高级管理员</option>
                    </select>
                </div>

                <button class="layui-btn" lay-submit lay-filter="formDemo">检索</button>
            </div>
        </form>
    </div>

    <table id="admin-table" class="layui-table" lay-filter="adminTable">
    </table>

</div>
<script>
    var basePath = '${ctx}';
    var tableIns = null;
    var id = "";

    layui.use(['table','form'],function () {
        var table = layui.table;
        var form = layui.form;

        tableIns = table.render({
            elem:"#admin-table",
            url:basePath+'/administratorController/queryList',
            method:'post',
            contentType:'application/json',
            page:true,
            limit:3,
            limits:[3,6,9,12],
            cols:[[
                {field:'account',title:'用户名',width:80},
                {field:'position',title:'职位',width:100},
                {field:'phone',title:'手机号',width:150},
                {title:'操作',width:200,templet:function (d) {
                        var id = d.id;
                        id = "'"+id+"'";
                        return '<div id="operateButton">\n' +
                            '        <button class="layui-btn layui-btn-xs" lay-submit lay-filter="updateModel" onclick="updateModel('+id+')" > <i class="layui-icon">&#xe642;</i> 修改</button>\n' +
                            '        <button class="layui-btn layui-btn-xs" lay-submit lay-filter="deleteModel" onclick="deleteModel('+id+')"><i class="layui-icon">&#xe640;</i>删除</button>\n' +
                            '    </div>'
                    }}
            ]]
        });
        //监听提交
        form.on('submit(formDemo)', function(data) {
            tableIns.reload({
                page:{
                    curr:1
                },
                where:{
                    administrator:{
                        account:$.trim(data.field.account),
                        position:data.field.position
                    }
                }
            })
            return false;
        });

    });
    function updateModel(d) {
        id = d;
        layer.open({
            type: 2,
            title: "编辑页面",
            area: ['630px', '360px'],
            shadeClose: true,
            content:'edit.jsp',
            end:function () {
                tableIns.reload();
            }
        })
    }
    function deleteModel(d) {
        layer.confirm('您确定要删除该员工，删除后不可恢复', {
            btn: ['删除','取消'] //按钮
        },function(){
            $.ajax({
                url:basePath+"/administratorController/remove",
                type:"post",
                data:$.toJSON({id:d}),
                contentType:'application/json',
                success:function (data) {
                    if(data.isDelete){
                        if(data.isOwn){
                            parent.location.reload();
                        }
                        layer.msg("删除成功",{time: 2000,icon: 1});
                        tableIns.reload();
                    }
                },
                error:function () {
                    layer.alert("删除员工失败！ajax发送出现错误",{icon:5,title:"error"});
                }
            });
        }, function(){

        });

    }
    function getId() {
        return id;
    }
</script>
</body>
</html>
