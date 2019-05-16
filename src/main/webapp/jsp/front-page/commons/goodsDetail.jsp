<%--
  User: LiQingsong
  Date: 2019/5/15
  Time: 8:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="imgAndInfo">

    <div class="imgInimgAndInfo">
        <img src="${img}goods/${detailPageGoods.categoryCode}/${detailPageGoods.typeCode}/${detailPageGoods.id}/avatar/${detailPageGoods.avatar}" class="bigImg">
        <div class="smallImageDiv">

        </div>
        <div class="img4load hidden"></div>
    </div>


    <div class="infoInimgAndInfo">

        <div class="productTitle">
            ${detailPageGoods.name}
        </div>


        <div class="productPrice">
            <div class="juhuasuan">
                <span class="juhuasuanBig">物美价廉</span>
                <span>此商品为官方推荐商品，请放心购买</span>
            </div>


            <div class="productPriceDiv">
                <div class="originalDiv">
                    <span class="originalPriceDesc">价格</span>
                    <span class="originalPriceYuan">¥</span>
                    <span class="originalPrice">
                        <fmt:formatNumber type="number" value="${detailPageGoods.price}" minFractionDigits="2"/>
                    </span>
                </div>

                <div class="promotionDiv">
                    <span class="promotionPriceDesc">促销价 </span>
                    <span class="promotionPriceYuan">¥</span>
                    <span class="promotionPrice">
                        <fmt:formatNumber type="number" value="${detailPageGoods.price}" minFractionDigits="2"/>
                    </span>
                </div>
            </div>
        </div>

        <div class="productSaleAndReviewNumber">
            <div>销量 <span class="redColor boldWord"> 0</span></div>
            <div>累计评价 <span class="redColor boldWord"> 0</span></div>
        </div>
        <div class="productNumber">
            <span>数量</span>
            <span>
                <span class="productNumberSettingSpan">
                <input class="productNumberSetting" id="number" type="text" value="1">
                </span>
                <span class="arrow">
                    <a href="#nowhere" class="increaseNumber">
                    <span class="updown">
                            <img src="${ctx}/assets/img/site/increase.png">
                    </span>
                    </a>

                    <span class="updownMiddle"> </span>
                    <a href="#nowhere" class="decreaseNumber">
                    <span class="updown">
                            <img src="${ctx}/assets/img/site/decrease.png">
                    </span>
                    </a>

                </span>

            件</span>
            <span>库存${detailPageGoods.stock}件</span>
        </div>
        <div class="serviceCommitment">
            <span class="serviceCommitmentDesc">服务承诺</span>
            <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
        </div>

        <div class="buyDiv">
            <a class="buyLink" href="#">
                <button id="buyButton" class="buyButton">立即购买</button>
            </a>
            <a href="#nowhere" class="addCartLink">
                <button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button>
            </a>
        </div>
    </div>

    <div style="clear:both"></div>

</div>

<div class="productReviewDiv" >
    <div class="productReviewTopPart">
        <a  href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>
        <a  href="#nowhere" class="selected">累计评价 <span class="productReviewTopReviewLinkNumber">0</span> </a>
    </div>


    <div class="productReviewContentPart">
        <c:forEach items="${reviews}" var="r">
            <div class="productReviewItem">

                <div class="productReviewItemDesc">
                    <div class="productReviewItemContent">
                            ${r.content }
                    </div>
                    <div class="productReviewItemDate"><fmt:formatDate value="${r.createDate}" pattern="yyyy-MM-dd"/></div>
                </div>
                <div class="productReviewItemUserInfo">

                        ${r.user.anonymousName}<span class="userInfoGrayPart">（匿名）</span>
                </div>

                <div style="clear:both"></div>

            </div>
        </c:forEach>
    </div>

</div>

<div class="productDetailDiv" >
    <div class="productDetailTopPart">
        <a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
        <a href="#nowhere" class="productDetailTopReviewLink">累计评价 <span class="productDetailTopReviewLinkNumber">0</span> </a>
    </div>


    <div class="productParamterPart">
        <div class="productParamter">产品参数：</div>

        <div class="productParamterList">
            <span>规格: ${detailPageGoodsDetail.specification} </span>
            <span>保质期: ${detailPageGoodsDetail.shelfLife} </span>
        </div>
        <div style="clear:both"></div>
    </div>

    <div class="productDetailImagesPart">
        <c:forEach items="${goodsImgList}" var="pic">
            <img src="${img}goods/${detailPageGoods.categoryCode}/${detailPageGoods.typeCode}/${detailPageGoods.id}/imgs/${pic}">
        </c:forEach>
    </div>
</div>

</body>
<script>
    var basePath = '${ctx}';
    $(function () {
        var stock = ${detailPageGoods.stock};
        $(".productNumberSetting").keyup(function () {
            var num = $(".productNumberSetting").val();
            num = parseInt(num);
            if (isNaN(num))
                num = 1;
            if (num <= 0)
                num = 1;
            if (num > stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });
        $("#buyButton").click(function () {

            var page = "${ctx}/user/checkLogin";
            $.get(
                page,
                function (data) {
                    if ("success" == data.result) {
                        var number = $("#number").val();
                        var goodsId = '${detailPageGoods.id}'
                        window.location.href="${ctx}/order/buyOne/"+goodsId+"/"+number;
                    } else {
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });
        $(".increaseNumber").click(function () {
            var num = $(".productNumberSetting").val();
            num++;
            if (num > stock)
                num = stock;
            $(".productNumberSetting").val(num);
        });
        $(".decreaseNumber").click(function () {
            var num = $(".productNumberSetting").val();
            --num;
            if (num <= 0)
                num = 1;
            $(".productNumberSetting").val(num);
        });

        $(".addCartButton").removeAttr("disabled");
        $(".addCartLink").click(function () {
            var page = "${ctx}/user/checkLogin";
            $.get(
                page,
                function (data) {
                    if ("success" == data.result) {
                        var pid = '${detailPageGoods.id}';
                        var num = $(".productNumberSetting").val();
                        $.ajax({
                            url:basePath+"/cart/addCart",
                            data:$.toJSON({goodsId:pid,number:num,userId:data.userId}),
                            type:'post',
                            contentType:'application/json',
                            success:function(data){
                                if ("success" == data.msg) {
                                    $(".addCartButton").html("已加入购物车");
                                    $(".addCartButton").attr("disabled", "disabled");
                                    $(".addCartButton").css("background-color", "lightgray");
                                    $(".addCartButton").css("border-color", "lightgray");
                                    $(".addCartButton").css("color", "black");

                                } else {
                                    alert("加入购物车失败，数据发生错误。")
                                }
                            },
                            error:function () {
                                alert("加入购物车失败，ajax发生错误。")
                            }
                        });
                    } else {
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });
        $(".buyLink").click(function () {
            var page = "forecheckLogin";
            $.get(
                page,
                function (result) {
                    if ("success" == result) {
                        var num = $(".productNumberSetting").val();
                        location.href = $(".buyLink").attr("href") + "&num=" + num;
                    } else {
                        $("#loginModal").modal('show');
                    }
                }
            );
            return false;
        });

        $("button.loginSubmitButton").click(function () {
            var name = $("#name").val();
            var password = $("#password").val();

            if (0 == name.length || 0 == password.length) {
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
            $.ajax({
                url : basePath+'/user/verifyLogin',
                type : 'post',
                data : $.toJSON({account:name,password:password}),
                contentType: 'application/json;charset=UTF-8',
                success: function(data) {
                    if(data.isTrue){
                        location.reload();
                    }else{
                        $("span.errorMessage").html("账号密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                },
                error:function () {
                    alert("登录失败，ajax反生错误，在goodsDetail.jsp的272行");
                }

            });

            return true;
        });

        $("img.smallImage").mouseenter(function () {
            var bigImageURL = $(this).attr("bigImageURL");
            $("img.bigImg").attr("src", bigImageURL);
        });

        $("img.bigImg").load(
            function () {
                $("img.smallImage").each(function () {
                    var bigImageURL = $(this).attr("bigImageURL");
                    img = new Image();
                    img.src = bigImageURL;

                    img.onload = function () {
                        $("div.img4load").append($(img));
                    };
                });
            }
        );
    });

</script>

</html>
