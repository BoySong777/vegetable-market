<%--
  User: LiQingsong
  Date: 2019/5/16
  Time: 8:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="aliPayPageDiv">
    <div class="aliPayPageLogo">
        <img class="pull-left" src="${ctx}/assets/img/logo2.png">
        <div style="clear:both"></div>
    </div>

    <div>
        <span class="confirmMoneyText">扫一扫付款（元）</span>
        <span class="confirmMoney">
		￥<fmt:formatNumber type="number" value="${totalGoodsPrice}" minFractionDigits="2"/></span>

    </div>
    <div>
        <img class="aliPayImg" src="${ctx}/assets/img/alipay2wei.png">
    </div>


    <div>
        <a href="${ctx}/order/payed/${orderId}"><button class="confirmPay">确认支付</button></a>
    </div>

</div>
