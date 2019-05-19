<%--
  User: LiQingsong
  Date: 2019/5/16
  Time: 16:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    var deleteOrderItem = false;
    var deleteOrderItemid = 0;
    $(function () {

        $("a.deleteOrderItem").click(function () {
            deleteOrderItem = false;
            var cartGoodsId = $(this).attr("cartGoodsId")
            deleteOrderItemid = cartGoodsId;
            $("#deleteConfirmModal").modal('show');
        });
        $("button.deleteConfirmButton").click(function () {
            deleteOrderItem = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if (deleteOrderItem) {
                var page = "removeCartGoods";
                $.post(
                    page,
                    {"cartGoodsId": deleteOrderItemid},
                    function (result) {
                        if ("success" == result) {
                            $("tr.cartProductItemTR[cartGoodsId=" + deleteOrderItemid + "]").hide();
                        } else {
                            location.href = "${ctx}/jsp/front-page/login.jsp";
                        }
                    }
                );

            }
        })

        $("img.cartProductItemIfSelected").click(function () {
            var selectit = $(this).attr("selectit")
            if ("selectit" == selectit) {
                $(this).attr("src", "${ctx}/assets/img/cartNotSelected.png");
                $(this).attr("selectit", "false")
                $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
            } else {
                $(this).attr("src", "${ctx}/assets/img/cartSelected.png");
                $(this).attr("selectit", "selectit")
                $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
            }
            syncSelect();
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();
        });
        $("img.selectAllItem").click(function () {
            var selectit = $(this).attr("selectit")
            if ("selectit" == selectit) {
                $("img.selectAllItem").attr("src", "${ctx}/assets/img/cartNotSelected.png");
                $("img.selectAllItem").attr("selectit", "false")
                $(".cartProductItemIfSelected").each(function () {
                    $(this).attr("src", "${ctx}/assets/img/cartNotSelected.png");
                    $(this).attr("selectit", "false");
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
                });
            } else {
                $("img.selectAllItem").attr("src", "${ctx}/assets/img/cartSelected.png");
                $("img.selectAllItem").attr("selectit", "selectit")
                $(".cartProductItemIfSelected").each(function () {
                    $(this).attr("src", "${ctx}/assets/img/cartSelected.png");
                    $(this).attr("selectit", "selectit");
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
                });
            }
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();


        });

        $(".orderItemNumberSetting").keyup(function () {
            var cartGoodsGoodsId = $(this).attr("cartGoodsGoodsId");
            var stock = $("span.orderItemStock[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").text();
            var price = $("span.orderItemPromotePrice[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").text();

            var num = $(".orderItemNumberSetting[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").val();
            num = parseInt(num);
            if (isNaN(num))
                num = 1;
            if (num <= 0)
                num = 1;
            if (num > stock)
                num = stock;

            syncPrice(cartGoodsGoodsId, num, price);
        });

        $(".numberPlus").click(function () {
            var cartGoodsGoodsId = $(this).attr("cartGoodsGoodsId");
            var stock = $("span.orderItemStock[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").text();
            var price = $("span.orderItemPromotePrice[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").text();
            var num = $(".orderItemNumberSetting[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").val();

            num++;
            if (num > stock)
                num = stock;
            syncPrice(cartGoodsGoodsId, num, price);
        });
        $(".numberMinus").click(function () {
            var cartGoodsGoodsId = $(this).attr("cartGoodsGoodsId");
            var price = $("span.orderItemPromotePrice[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").text();

            var num = $(".orderItemNumberSetting[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").val();
            --num;
            if (num <= 0)
                num = 1;
            syncPrice(cartGoodsGoodsId, num, price);
        });

        $("button.createOrderButton").click(function () {
            var cartIdList = [];
            $(".cartProductItemIfSelected").each(function () {
                if ("selectit" == $(this).attr("selectit")) {
                    var cartGoodsId = $(this).attr("cartGoodsId");
                    cartIdList.push(cartGoodsId);
                }
            });
            $.ajax({
                type:'POST',
                url: '${ctx}/cart/createOrder',
                contentType : "application/json" ,
                data : JSON.stringify(cartIdList),
                success : function(data) {
                    if(data == "success"){
                        window.location.href = "${ctx}/jsp/front-page/goods/orderPage.jsp";
                    }
                }
            });
        });


    })

    function syncCreateOrderButton() {
        var selectAny = false;
        $(".cartProductItemIfSelected").each(function () {
            if ("selectit" == $(this).attr("selectit")) {
                selectAny = true;
            }
        });

        if (selectAny) {
            $("button.createOrderButton").css("background-color", "#C40000");
            $("button.createOrderButton").removeAttr("disabled");
        } else {
            $("button.createOrderButton").css("background-color", "#AAAAAA");
            $("button.createOrderButton").attr("disabled", "disabled");
        }

    }

    function syncSelect() {
        var selectAll = true;
        $(".cartProductItemIfSelected").each(function () {
            if ("false" == $(this).attr("selectit")) {
                selectAll = false;
            }
        });

        if (selectAll)
            $("img.selectAllItem").attr("src", "${ctx}/assets/img/cartSelected.png");
        else
            $("img.selectAllItem").attr("src", "${ctx}/assets/img/cartNotSelected.png");


    }

    function calcCartSumPriceAndNumber() {
        var sum = 0;
        var totalNumber = 0;
        $("img.cartProductItemIfSelected[selectit='selectit']").each(function () {
            var cartGoodsId = $(this).attr("cartGoodsId");
            var price = $(".cartProductItemSmallSumPrice[cartGoodsId=" + cartGoodsId + "]").text();
            price = price.replace(/,/g, "");
            price = price.replace(/￥/g, "");
            sum += new Number(price);

            var num = $(".orderItemNumberSetting[cartGoodsId=" + cartGoodsId + "]").val();
            totalNumber += new Number(num);

        });

        $("span.cartSumPrice").html("￥" + formatMoney(sum));
        $("span.cartTitlePrice").html("￥" + formatMoney(sum));
        $("span.cartSumNumber").html(totalNumber);
    }

    function syncPrice(cartGoodsGoodsId, num, price) {
        $(".orderItemNumberSetting[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").val(num);
        var cartProductItemSmallSumPrice = formatMoney(num * price);
        $(".cartProductItemSmallSumPrice[cartGoodsGoodsId=" + cartGoodsGoodsId + "]").html("￥" + cartProductItemSmallSumPrice);
        calcCartSumPriceAndNumber();

        var page = "forechangeOrderItem";
        $.post(
            page,
            {"goodsId": cartGoodsGoodsId, "number": num},
            function (result) {
                if ("success" != result) {
                    location.href = "${ctx}/jsp/front-page/login.jsp";
                }
            }
        );

    }
</script>

<title>购物车</title>
<div class="cartDiv">
    <div class="cartTitle pull-right">
        <span>已选商品  (不含运费)</span>
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" disabled="disabled">结 算</button>
    </div>


    <div class="cartProductList">
        <table class="cartProductTable">
            <thead>
            <tr>
                <th class="selectAndImage">
                    <img selectit="false" class="selectAllItem" src="${ctx}/assets/img/cartNotSelected.png">
                    全选

                </th>
                <th>商品信息</th>
                <th>单价</th>
                <th>数量</th>
                <th width="120px">金额</th>
                <th class="operation">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${cartGoodsList}" var="cartGoods">
                <tr cartGoodsId="${cartGoods.id}" class="cartProductItemTR">
                    <td>
                        <img selectit="false" cartGoodsId="${cartGoods.id}" class="cartProductItemIfSelected"
                             src="${ctx}/assets/img/cartNotSelected.png">
                        <a style="display:none" href="#nowhere"><img src="${ctx}/assets/img/cartSelected.png"></a>
                        <img class="cartProductImg"
                             src="${img}goods/${cartGoods.categoryCode}/${cartGoods.typeCode}/${cartGoods.goodsId}/avatar/${cartGoods.avatar}">
                    </td>
                    <td>
                        <div class="cartProductLinkOutDiv">
                            <a href="foreproduct?cartGoodsGoodsId=${cartGoods.goodsId}" class="cartProductLink">${cartGoods.goodsName}</a>
                            <div class="cartProductLinkInnerDiv">
                            </div>
                        </div>

                    </td>
                    <td>
                        <span class="cartProductItemOringalPrice">￥${cartGoods.goodsPrice}</span>
                        <span class="cartProductItemPromotionPrice">￥${cartGoods.goodsPrice}</span>

                    </td>
                    <td>

                        <div class="cartProductChangeNumberDiv">
                            <span class="hidden orderItemStock " cartGoodsGoodsId="${cartGoods.goodsId}">${goodsStockMap[cartGoods.goodsId]}</span>
                            <span class="hidden orderItemPromotePrice "
                                  cartGoodsGoodsId="${cartGoods.goodsId}">${cartGoods.goodsPrice}</span>
                            <a cartGoodsGoodsId="${cartGoods.goodsId}" class="numberMinus" href="#nowhere">-</a>
                            <input cartGoodsGoodsId="${cartGoods.goodsId}" cartGoodsId="${cartGoods.id}" class="orderItemNumberSetting"
                                   autocomplete="off" value="${cartGoods.number}">
                            <a stock="${goodsStockMap[cartGoods.goodsId]}" cartGoodsGoodsId="${cartGoods.goodsId}" class="numberPlus"
                               href="#nowhere">+</a>
                        </div>

                    </td>
                    <td>
							<span class="cartProductItemSmallSumPrice" cartGoodsId="${cartGoods.id}" cartGoodsGoodsId="${cartGoods.goodsId}">
							￥<fmt:formatNumber type="number" value="${cartGoods.goodsPrice*cartGoods.number}"
                                               minFractionDigits="2"/>
							</span>

                    </td>
                    <td>
                        <a class="deleteOrderItem" cartGoodsId="${cartGoods.id}" href="#nowhere">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>

    <div class="cartFoot">
        <img selectit="false" class="selectAllItem" src="${ctx}/assets/img/cartNotSelected.png">
        <span>全选</span>
        <!-- 		<a href="#">删除</a> -->

        <div class="pull-right">
            <span>已选商品 <span class="cartSumNumber">0</span> 件</span>

            <span>合计 (不含运费): </span>
            <span class="cartSumPrice">￥0.00</span>
            <button class="createOrderButton" disabled="disabled">结 算</button>
        </div>

    </div>

</div>
