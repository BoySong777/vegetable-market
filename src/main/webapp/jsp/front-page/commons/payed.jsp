<%--
  User: LiQingsong
  Date: 2019/5/16
  Time: 9:06
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="payedDiv">
    <div class="payedTextDiv">
        <img src="${ctx}/assets/img/paySuccess.png">
        <span>您已成功付款</span>

    </div>
    <div class="payedAddressInfo">
        <ul>
            <li>收货地址：${userInfo}</li>
            <li>实付款：<span class="payedInfoPrice">
			￥<fmt:formatNumber type="number" value="${totalGoodsPrice}" minFractionDigits="2"/>
            </li>
            <li>预计3小时后送达	</li>
        </ul>

        <div class="paedCheckLinkDiv">
            您可以
            <a class="payedCheckLink" href="${ctx}/order/myOrder">查看订单</a>
        </div>

    </div>

    <div class="payedSeperateLine">
    </div>

    <div class="warningDiv">
        <img src="${ctx}/assets/img/warning.png">
        <b>安全提醒：</b>下单后，<span class="redColor boldWord">用QQ给您发送链接办理退款的都是骗子！</span>本系统不存在系统升级，订单异常等问题，谨防假冒客服电话诈骗！
    </div>

</div>