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
                    <input id="name" type="text" name="name" placeholder="输入商品名称" autocomplete="off" class="layui-input">
                </div>

                <div class="layui-input-inline">
                    <select name="categoryCode" lay-filter="firstType" id="firstType">
                        <option value="">--一级类别--</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="typeCode" id="secondType" lay-filter="secondType">
                        <option value="">--二级类别--</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <input id="brand" type="text" name="brand" placeholder="输入商品品牌" autocomplete="off" class="layui-input">
                </div>
                <%--<div class="layui-input-inline">
                    <input id="stock" type="number" name="stock" placeholder="输入商品库存" autocomplete="off" class="layui-input">
                </div>--%>
                <button class="layui-btn" lay-submit lay-filter="formDemo">检索</button>
                <button class="layui-btn" lay-submit lay-filter="searchStock">检索需补货商品</button>
            </div>
        </form>
    </div>

    <table id="goods-table" class="layui-table" lay-filter="goodsTable">
    </table>

</div>
<script type="text/html" id="operate">
    <a class="layui-btn layui-btn-xs" lay-event="modify">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="userAvatar">
    {{#  if(d.avatar==null ||d.avatar==""){ }}
    <img height="40px" width="40px" src="${img}user/default.png">
    {{#  } else { }}
    <img height="40px" width="40px" src="${img}goods/{{d.categoryCode}}/{{d.typeCode}}/{{d.id}}/avatar/{{d.avatar}}">
    {{#  } }}
</script>
<script type="text/html" id="stockOperate">
    {{d.stock}}<a href="javascript:void(0)" onclick=operateStock('{{d.id}}','{{d.stock}}') class="layui-table-link "> 补货</a>
</script>
<script type="text/html" id="userAddress">
    <a href="${ctx}/goods/goodsDetail/{{d.id}}"  target="view_window" class="layui-table-link">查看</a>
</script>
<script>
    var basePath = '${ctx}';
    var tableIns = null;
    var userId = "";
    var queryParam = {};

    $(function () {
        //获取一级类目
        $.ajax({
            url: basePath + "/category/findListFirst",
            type: 'get',
            success: function (data) {
                $.each(data.data, function (index, item) {
                    $("#firstType").append(new Option(item.name, item.code));
                })
                layui.form.render("select");
            }
        });
    })

    layui.use(['table','form'],function () {
        var table = layui.table;
        var form = layui.form;

        tableIns = table.render({
            elem:"#goods-table",
            url:basePath+'/goods/queryList',
            method:'post',
            contentType:'application/json',
            page:true,
            limit:3,
            limits:[3,6,9,12],
            cols:[[
                {field:'name',title:'名称',width:80},
                {field:'avatar',title:'商品图片',width:100,templet:'#userAvatar'},
                {field:'categoryCodeName',title:'一级类别',width:100},
                {field:'typeCodeName',title:'二级类别',width:100},
                {field:'price',title:'价格',width:150,sort:true},
                {field:'discount',title:'折扣',width:150},
                {field:'brand',title:'品牌',width:150},
                {field:'stock',title:'库存',width:100, templet: "#stockOperate"},
                {title:'详情',width:100,toolbar:'#userAddress'},
                {fixed: 'right', title:'操作', toolbar: '#operate', width:150}
            ]],
            toolbar: true
        });
        //点击一级类目后，获取二级类目
        form.on('select(firstType)', function (data) {
            var code = data.value;
            if (code == "") {
                code = 0;
            }
            $.ajax({
                url: basePath + "/category/findListSecond/" + code,
                type: 'get',
                success: function (data) {
                    $("#secondType option").not(":first").remove();
                    $.each(data.data, function (index, item) {
                        $("#secondType").append(new Option(item.name, item.code));
                    })
                    form.render("select");
                }
            });
        });
        //监听提交
        form.on('submit(formDemo)', function(data) {
            tableIns.reload({
                page:{
                    curr:1
                },
                where:{
                    goods:{
                        name:$.trim(data.field.name),
                        categoryCode:data.field.categoryCode,
                        typeCode:data.field.typeCode,
                        brand:$.trim(data.field.brand)
                        /*stock:data.field.stock*/
                    }
                }
            })
            return false;
        });
        //监听提交
        form.on('submit(searchStock)', function(data) {
            tableIns.reload({
                page:{
                    curr:1
                },
                where:{
                    goods:{
                        stock:10
                    }
                }
            })
            return false;
        });
        table.on('sort(goodsTable)',function (obj) {
            tableIns.reload({
                initSort:obj,
                page:{
                    curr:1
                },
                where:{
                    order:obj.field,
                    sort:obj.type,
                    goods:{
                        name:$.trim($('#name').val()),
                        categoryCode:$('#firstType').val(),
                        typeCode:$('#secondType').val(),
                        brand:$.trim($('#brand').val()),
                        /*stock:$('#stock').val()*/
                    }
                }
            });
        });
        table.on('tool(goodsTable)',function (obj) {
            var data = obj.data;
            if(obj.event=="del"){
                layer.confirm("你确定要删除这个商品吗？",function (index) {
                    $.ajax({
                        url:basePath+"/goods/remove/"+data.id,
                        type:'get',
                        success:function (data) {
                            if(data.msg=="success"){
                                layer.msg("删除成功",{time: 2000,icon: 1});
                                tableIns.reload();
                            }
                        },
                        error:function () {
                            layer.alert("删除商品失败！ajax发送出现错误",{icon:5,title:"error"});
                        }

                    });
                })
            }else if(obj.event=='modify'){
                window.location.href = "edit.jsp?"+"id="+data.id;
            }else if(obj.event=='addr'){
                //TODO:查看详情页
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
    });
    function getUserId() {
        return userId;
    }
    function operateStock(id,stock){
        layer.prompt({
            formType: 0,
            value: stock,
            title: '请输入值',
            area: ['400px', '100px'] //自定义文本域宽高
        }, function(value, index, elem){
            $.ajax({
                url:basePath+"/goods/updateStock",
                type:"post",
                data:$.toJSON({id:id,stock:value}),
                contentType:"application/json",
                success:function (data) {
                    if(data=="success"){
                        layer.close(index);
                        tableIns.reload();
                        layer.msg("修改成功",{time: 2000,icon:1});
                    }
                }
            });

        });
    }
</script>
</body>
</html>
