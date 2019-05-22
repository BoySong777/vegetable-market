<%--
  User: LiQingsong
  Date: 2019/5/14
  Time: 17:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="vueRoot">
    <img src="assets/img/site/catear.png" id="catear" class="catear"/>
    <div class="categoryWithCarousel">
        <div class="headbar show1">
            <div class="head ">
                <span style="margin-left:10px" class="glyphicon glyphicon-th-list"></span>
                <span style="margin-left:10px">商品分类</span>
            </div>

            <div class="rightMenu">

                <c:forEach items="${fistCategory}" var="c">
                    <span>
                        <a href="${ctx}/goods/searchFirstCategory/${c.code}">
                                ${c.name}
                        </a>
                    </span>
                </c:forEach>
            </div>

        </div>

        <%--
            <%@include file="carousel.jsp" %>--%>
        <div class="carouselBackgroundDiv">
        </div>
    </div>

    <div class="center_con clearfix">
        <ul class="subnav fl">
            <li><a href="#a1007" class="fruit">新鲜水果</a></li>
            <li><a href="#a1003" class="seafood">海鲜水产</a></li>
            <li><a href="#a1002" class="meet">猪牛羊肉</a></li>
            <li><a href="#a1002" class="egg">禽类蛋品</a></li>
            <li><a href="#a1001" class="vegetables">新鲜蔬菜</a></li>
            <li><a href="#a1010" class="ice">当日熟食</a></li>
        </ul>
        <div class="slide fl">
            <ul class="slide_pics">
                <li><a href="${ctx}/goods/clickAdPic/${mainAd}/1"><img src="${img}ad/${mainAd}/carousel/slide.jpg" alt="幻灯片"></a></li>
                <li><a href="${ctx}/goods/clickAdPic/${mainAd}/2"><img src="${img}ad/${mainAd}/carousel/slide02.jpg" alt="幻灯片"></a></li>
                <li><a href="${ctx}/goods/clickAdPic/${mainAd}/3"><img src="${img}ad/${mainAd}/carousel/slide03.jpg" alt="幻灯片"></a></li>
                <li><a href="${ctx}/goods/clickAdPic/${mainAd}/4"><img src="${img}ad/${mainAd}/carousel/slide04.jpg" alt="幻灯片"></a></li>
            </ul>
            <div class="prev"></div>
            <div class="next"></div>
            <ul class="points"></ul>
        </div>
        <div class="adv fl">
            <a href="${ctx}/goods/clickAdPic/${secAd}/5"><img src="${img}ad/${secAd}/recommend/adv01.jpg"></a>
            <a href="${ctx}/goods/clickAdPic/${thrAd}/5"><img src="${img}ad/${thrAd}/recommend/adv02.jpg"></a>
        </div>
    </div>
    <c:forEach items="${categoryList}" var="category">
        <div class="list_model">
            <div class="list_title clearfix">
                <h3 class="fl" id="a${category.code}">${category.name}</h3>
                <div class="subtitle fl">
                    <span>|</span>
                    <c:forEach items="${typeListMap[category.code]}" var="type">
                        <a href="${ctx}/goods/searchSecondCategory/${category.code}/${type.code}">${type.name}</a>
                    </c:forEach>
                </div>
                <a href="${ctx}/goods/searchFirstCategory/${category.code}" class="goods_more fr" id="fruit_more">查看更多 ></a>
            </div>

            <div class="goods_con clearfix">
                <div class="goods_banner fl"><img src="${img}/banner/${category.code}.jpg"></div>
                <ul class="goods_list fl">
                    <c:forEach items="${goodsListMap[category.code]}" var="goods">
                        <li>
                            <h4><a href="${ctx}/goods/goodsDetail/${goods.id}">${goods.name}</a></h4>
                            <a href="${ctx}/goods/goodsDetail/${goods.id}"><img
                                    src="${img}goods/${goods.categoryCode}/${goods.typeCode}/${goods.id}/avatar/${goods.avatar}"></a>
                            <div class="prize">${goods.price}</div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

    </c:forEach>


</div>
</body>
<script>
    /*var basePath =
    var categoryList = null;
    var typeListMap = null;
    var goodsListMap = null;
    $(function () {
        $.ajax({
            url: basePath + "/goods/homePage",
            type: 'get',
            success: function (data) {
                if (data.code == 0) {
                    categoryList = data.categoryList;
                    typeListMap = data.typeListMap;
                    goodsListMap = data.goodsListMap;
                    alert(JSON.stringify(goodsListMap));
                } else {
                    alert("返回数据发生错误")
                }
            },
            error: function () {
                alert("获取数据失败，获取ajax失败");
            }

        });
    })
    new Vue({
        el: "#vueRoot",
        data: {},
        ready: function () {

        }
    });*/
</script>
</html>
