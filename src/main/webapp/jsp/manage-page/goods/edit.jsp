<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改商品</title>
    <jsp:include page="../common.jsp"></jsp:include>
    <script src="${ctx}/assets/managePage/framework/jquery.mCustomScrollbar.concat.min.js"></script>
    <style>
        .layui-form-label {
            width: 100px;
        }

        .layui-input-block {
            margin-left: 130px;
        }

        .layui-form {
            margin-right: 30%;
        }
    </style>
</head>
<body>
<div class="content mCustomScrollbar">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>修改商品</legend>
    </fieldset>
    <form id="goodsForm" lay-filter="editForm" class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">商品名</label>
            <div class="layui-input-block">
                <input type="text" name="name" required lay-verify="required" autocomplete="off" placeholder="请输入商品名"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类别</label>
            <div class="layui-input-inline">
                <select name="categoryCode" required lay-verify="required" lay-filter="firstType" id="firstType" disabled>
                    <option value="">--一级类别--</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="typeCode" required lay-verify="required" id="secondType" lay-filter="secondType" disabled>
                    <option value="">--二级类别--</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">价格</label>
            <div class="layui-input-inline">
                <input type="number" name="price" required lay-verify="required" autocomplete="off" placeholder="请输入价格"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">商品特征</label>
            <div class="layui-input-inline">
                <select name="feature" required lay-verify="required" id="feature" lay-filter="feature" disabled>
                    <option value="0">无设置</option>
                    <option value="1">价格便宜型</option>
                    <option value="2">经济实惠型</option>
                    <option value="3">新鲜上市型</option>
                </select>
            </div>
        </div>
        <%--<div class="layui-form-item">
            <label class="layui-form-label"></label>
            <div class="layui-upload">
                 
                <button type="button" class="layui-btn" id="test1">上传图片</button>
                 
                <div class="layui-upload-list">
                        <img class="layui-upload-img" id="demo1" style="margin-left: 100px" height="130px" width="130px">
                        <p id="demoText"></p>
                     
                </div>
            </div>
             
        </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">商品图片</label>
            <div class="layui-upload-drag" id="goodsImg">
                <img class="layui-upload-img" id="demo1" height="130px" width="130px">
                <p><i class="layui-icon">&#xe67c;</i><br>点击上传，或将文件拖拽到此处</p>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">品牌</label>
            <div class="layui-input-block">
                <input type="text" name="brand" required lay-verify="required" autocomplete="off" placeholder="请输入商品品牌"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">规格</label>
            <div class="layui-input-block">
                <input type="text" name="specification" required lay-verify="required" autocomplete="off"
                       placeholder="请输入商品规格"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">库存</label>
            <div class="layui-input-inline">
                <input type="number" name="stock" required lay-verify="required" autocomplete="off" placeholder="请输入库存"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">保质期(天)</label>
            <div class="layui-input-inline">
                <input type="number" name="shelfLife" required lay-verify="required" autocomplete="off" placeholder="请输入保质期"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">使用方法</label>
            <div class="layui-input-block">
                <input type="text" name="edibleMethod" required lay-verify="required" autocomplete="off"
                       placeholder="请输入商品使用方法"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
                    <label class="layui-form-label">商品图片上传</label>
                   
            <div class="layui-input-block">
                           
                <button type="button" class="layui-btn" id="detailImgs" >
                                    <i class="layui-icon">&#xe67c;</i>选择
                               
                </button>
                           
                <button type="button" class="layui-btn" id="test9">上传</button>
                           
                <button type="button" class="layui-btn" id="cleanImgs">清空预览
                </button>
                       
            </div>
                   
            <blockquote class="layui-elem-quote layui-quote-nm" style="margin-right:10%">
                            预览图：
                           
                <div style="margin-left: 130px" class="layui-upload-list" id="demo2"></div>
                       
            </blockquote>
               
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="submitBut">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
    <div>
        <br>
        <br>
        <br>
        <br>
        <br>
    </div>
</div>
<script>
    var basePath = '${ctx}';
    var avatar = "";//用于记录上传图片的名称

    var success=0;
    var fail=0;
    var imgurls="";
    var goodsId = "";
    var goodsDetailId = "";
    $(function ($) {
        $("#cleanImgs").click(cleanImgsPreview);
        $(".content").attr("style", "overflow-x:hidden;overflow-y:scroll;");
        $(window).on("load", function () {
            $(".content").delegate("a[href='top']", "click", function (e) {
                e.preventDefault();
                $(".content").mCustomScrollbar("scrollTo", $(this).attr("href"));
            });
        });
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
        var loc = location.href;
        var n1 = loc.length;
        var n2 = loc.indexOf("=");
        goodsId = decodeURI(loc.substr(n2+1, n1-n2));
    })
    layui.use(['form', 'upload'], function () {
        var form = layui.form;
        var upload = layui.upload; //得到 upload 对象
        //给表单赋初始值
        $.ajax({
            url:basePath+"/goods/queryDetail/"+goodsId,
            type:"get",
            success:function (data) {
                if (data.msg=="success") {
                    goodsDetailId = data.goodsDetail.id;
                    $.ajax({
                        url: basePath + "/category/findListSecond/" + data.goods.categoryCode,
                        type: 'get',
                        success: function (d) {
                            $("#secondType option").not(":first").remove();
                            $.each(d.data, function (index, item) {
                                $("#secondType").append(new Option(item.name, item.code));
                            })
                            form.render("select");
                            form.val('editForm',{
                                "name":data.goods.name,
                                "categoryCode":data.goods.categoryCode,
                                "typeCode":data.goods.typeCode,
                                "price":data.goods.price,
                                "feature":data.goods.feature,
                                "brand":data.goods.brand,
                                "stock":data.goods.stock,
                                "specification":data.goodsDetail.specification,
                                "shelfLife":data.goodsDetail.shelfLife,
                                "edibleMethod":data.goodsDetail.edibleMethod
                            });
                        }
                    });

                    //显示商品详情图片
                    var imgs = data.goodsDetail.imgs;
                    var imgsList = imgs.split(',');
                    for(var i=0;i<imgsList.length-1;i++){
                        $('#demo2').append('<img src="${img}goods/' + data.goods.categoryCode+'/'+data.goods.typeCode+'/'+data.goods.id+'/imgs/'+imgsList[i]+'"'
                            + ' height="92px" width="92px" class="layui-upload-img uploadImgPreView">')
                    }
                    //显示商品头像
                    $('#demo1').attr('src', "${img}goods/"+data.goods.categoryCode+"/"+data.goods.typeCode+"/"+data.goods.id+"/avatar/"+data.goods.avatar);
                }
            },
            error:function () {

            }
        });

        form.on('submit(submitBut)', function(data) {
            var me = data;
            $.ajax({
                url:basePath+"/goods/update",
                type:'post',
                data:$.toJSON({
                    goods:{
                        id:goodsId,
                        name:me.field.name,
                        categoryCode:me.field.categoryCode,
                        typeCode:me.field.typeCode,
                        price:me.field.price,
                        discount:me.field.discount,
                        avatar:avatar,
                        brand:me.field.brand,
                        stock:me.field.stock
                    },
                    goodsDetail:{
                        id:goodsDetailId,
                        imgs:imgurls,
                        specification:me.field.specification,
                        shelfLife:me.field.shelfLife,
                        edibleMethod:me.field.edibleMethod,
                        details:me.field.details,
                        description:me.field.description
                    }
                }),
                contentType:'application/json',
                success:function (data) {
                    if(data.msg=="success"){
                        layer.msg("修改成功",{time: 2000,icon: 1});
                        setTimeout("window.location.href = 'list.jsp'",2000);
                    }else{
                        layer.alert("修改失败！",{icon:5,title:"警告"});
                    }
                },
                error:function () {
                    layer.alert("修改失败！ajax发送出现错误",{icon:5,title:"error"});

                }
            });
            return false;
        });
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
        //执行实例
        var uploadInst = upload.render({
            elem: '#goodsImg' //绑定元素
            , method: 'POST'
            , url: basePath + '/goods/uploadImg' //上传接口
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                if (res.code == 0) {
                    avatar = res.data;
                }
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: ' +
                    '#FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
        upload.render({
            elem: '#detailImgs',
            url: basePath + '/goods/uploadImg',
            multiple: true,
            auto:false,
//			上传的单个图片大小
            size:10240,
//			最多上传的数量
            number:20,
//			MultipartFile file 对应，layui默认就是file,要改动则相应改动
            field:'file',
            bindAction: '#test9',
            before: function(obj) {
                //预读本地文件示例，不支持ie8
                cleanImgsPreview();
                obj.preview(function(index, file, result) {
                    $('#demo2').append('<img src="' + result
                        + '" alt="' + file.name
                        +'"height="92px" width="92px" class="layui-upload-img uploadImgPreView">')
                });
            },
            done: function(res, index, upload) {
                //每个图片上传结束的回调，成功的话，就把新图片的名字保存起来，作为数据提交
                console.log(res.code);
                if(res.code!=0){
                    fail++;
                }else{
                    success++;
                    imgurls=imgurls+""+res.data+",";
                }
            },
            allDone:function(obj){
                layer.msg("总共要上传图片总数为："+(fail+success)+"\n"
                    +"其中上传成功图片数为："+success+"\n"
                    +"其中上传失败图片数为："+fail
                )
            }
        });

    });
    /**
     * 清空预览的图片及其对应的成功失败数
     * 原因：如果已经存在预览的图片的话，再次点击上选择图片时，预览图片会不断累加
     * 表面上做上传成功的个数清0，实际后台已经上传成功保存了的，只是没有使用，以最终商品添加的提交的为准
      */
    function cleanImgsPreview(){
        success=0;
        fail=0;
        $('#demo2').html("");
        $('#imgUrls').val("");
    }
</script>
</body>
</html>
