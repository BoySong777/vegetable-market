<%--
  User: LiQingsong
  Date: 2019/5/2
  Time: 12:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加商品</title>
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
        <legend>添加商品</legend>
    </fieldset>
    <form id="goodsForm" class="layui-form" action="">
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
                <select name="categoryCode" required lay-verify="required" lay-filter="firstType" id="firstType">
                    <option value="">--一级类别--</option>
                </select>
            </div>
            <div class="layui-input-inline">
                <select name="typeCode" required lay-verify="required" id="secondType" lay-filter="secondType">
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
            <label class="layui-form-label">折扣</label>
            <div class="layui-input-inline">
                <input type="number" name="discount" autocomplete="off" placeholder="请输入折扣"
                       class="layui-input">
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
            <label class="layui-form-label">描述</label>
            <div class="layui-input-block">
                <input type="text" name="description"  autocomplete="off"
                       placeholder="请输入商品描述，可不写"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
                    <label class="layui-form-label">商品图片上传</label>
                   
            <div class="layui-input-block">
                           
                <button type="button" class="layui-btn" id="detailImgs" style="margin: 10px">
                                    <i class="layui-icon">&#xe67c;</i>选择图片
                               
                </button>
                           
                <button type="button" class="layui-btn" id="test9">开始上传</button>
                           
                <button type="button" class="layui-btn" id="cleanImgs">清空预览图片
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
    var imgurls=""
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
    })
    layui.use(['form', 'upload'], function () {
        var form = layui.form;
        //form.render("select");
        var upload = layui.upload; //得到 upload 对象
        form.on('submit(submitBut)', function(data) {
            var me = data;
            $.ajax({
                url:basePath+"/goods/create",
                type:'post',
                data:$.toJSON({
                    goods:{
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
                    if(data.code==0){
                        layer.msg("添加成功",{time: 2000,icon: 1});
                        setTimeout("location.reload()",2000);
                       // window.location.reload();
                    }else{
                        layer.alert("添加失败！",{icon:5,title:"警告"});
                    }
                },
                error:function () {
                    layer.alert("添加失败！ajax发送出现错误",{icon:5,title:"error"});

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
