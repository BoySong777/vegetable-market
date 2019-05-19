<%--
  User: LiQingsong
  Date: 2019/5/16
  Time: 12:50
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">我的订单</a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
        </table>

    </div>

    <div class="orderListItem">
        <c:forEach items="${orderList}" var="order">
            <table class="orderListItemTable" orderStatus="${order.status}" orderId="${order.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                        <b><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                        <span>订单号: ${order.id}</span>
                    </td>
                    <td  colspan="2">网上菜市场</td>
                    <td colspan="1">

                    </td>
                    <td class="orderItemDeleteTD">
                        <a class="deleteOrderLink" orderId="${order.id}" href="#nowhere">
                            <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </td>
                </tr>

                <c:forEach items="${orderGoodsMapperList[order.id]}" var="orderGoods" varStatus="st">
                    <tr class="orderItemProductInfoPartTR" >
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="${img}goods/${orderGoods.categoryCode}/${orderGoods.typeCode}/${orderGoods.goodsId}/avatar/${orderGoods.avatar}"></td>
                        <td class="orderItemProductInfoPartTD" width="452" height="80">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="${ctx}/goods/goodsDetail/${orderGoods.goodsId}">${orderGoods.goodsName}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                    <span>${order.userInfo}</span>
                                </div>
                            </div>
                        </td>
                        <td  class="orderItemProductInfoPartTD" width="100px">


                            <div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${orderGoods.goodsPrice}" minFractionDigits="2"/> * ${orderGoods.number}</div>


                        </td>
                        <c:if test="${st.count==1}">

                            <td valign="top" rowspan="${fn:length(orderGoodsMapperList[order.id])}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                <span class="orderListItemNumber">${orderGoods.number}</span>
                            </td>
                            <td valign="top" rowspan="${fn:length(orderGoodsMapperList[order.id])}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                                <div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${order.totalPrice}"/></div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td valign="top" rowspan="${fn:length(o.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
                                <c:if test="${order.status==0 }">
                                    <a href="${ctx}/order/confirmPay/${order.id}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>
                                </c:if>
                                <c:if test="${order.status==2 }">
                                    <a href="#">
                                        <button class="orderListItemConfirm"  orderId="${order.id}" id="receipt">确认收货</button>
                                    </a>
                                </c:if>

                                <c:if test="${order.status==1 }">
                                    <span>待发货</span>
                                    <button class="btn btn-info btn-sm ask2delivery" orderId="${order.id}" link="#">催卖家发货</button>

                                </c:if>

                                <c:if test="${order.status==3 }">
                                    <a href="#">
                                        <br>
                                        <span>已完成</span>
                                        <%--<button  class="orderListItemReview">评价</button>--%>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>

            </table>
        </c:forEach>

    </div>

</div>

<script>
    var deleteOrder = false;
    var deleteOrderid = 0;
    layui.use(['table','form'],function () {

    })
    $(function(){
        $("a[orderStatus]").click(function(){
            var orderStatus = $(this).attr("orderStatus");
            if('all'==orderStatus){
                $("table[orderStatus]").show();
            }
            else{
                $("table[orderStatus]").hide();
                $("table[orderStatus="+orderStatus+"]").show();
            }

            $("div.orderType div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
        });

        $("a.deleteOrderLink").click(function(){
            deleteOrderid = $(this).attr("orderId");
            deleteOrder = false;
            $("#deleteConfirmModal").modal("show");
        });

        $("button.deleteConfirmButton").click(function(){
            deleteOrder = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrder){
                var page="${ctx}/order/deleteOrder";
                $.post(
                    page,
                    {"orderId":deleteOrderid},
                    function(result){
                        if("success"==result){
                            $("table.orderListItemTable[orderId="+deleteOrderid+"]").hide();
                        }
                        else{
                            alert(11);
                            location.href = "${ctx}/jsp/front-page/login.jsp";
                        }
                    }
                );

            }
        })

        $(".ask2delivery").click(function(){
            var orderId = $(this).attr("orderId");
            var page="${ctx}/order/setUrge";
            $.post(
                page,
                {"orderId":orderId},
                function(result){
                    if("success"==result){
                        layer.msg("已经提醒卖家发货",{time: 2000,icon: 1});
                    }
                    else{
                        alert(11);
                        location.href = "${ctx}/jsp/front-page/login.jsp";
                    }
                }
            );
        });

        $("#receipt").click(function(){
            var orderId = $(this).attr("orderId");
            var page="${ctx}/order/receipt";
            $.post(
                page,
                {"orderId":orderId},
                function(result){
                    if("success"==result){
                        window.location.reload();
                    }
                    else{
                        alert(11);
                        location.href = "${ctx}/jsp/front-page/login.jsp";
                    }
                }
            );
        });
    });

</script>