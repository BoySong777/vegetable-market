<%--
  User: LiQingsong
  Date: 2019/5/15
  Time: 14:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="buyPageDiv">
    <form action="forecreateOrder" method="post">

        <div class="buyFlow">
            <img class="pull-left" src="${ctx}/assets/img/logo2.png">
            <img class="pull-right" src="${ctx}/assets/img/site/buyflow.png">
            <div style="clear:both"></div>
        </div>
        <%--<div class="address">
            <div class="addressTip">输入收货地址</div>
            <div>

                <table class="addressTable">
                    <tr>
                        <td class="firstColumn">详细地址<span class="redStar">*</span></td>

                        <td><textarea name="address" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌好吗，楼层和房间号等信息"></textarea></td>
                    </tr>
                    <tr>
                        <td>邮政编码</td>
                        <td><input name="post" placeholder="如果您不清楚邮递区号，请填写000000" type="text"></td>
                    </tr>
                    <tr>
                        <td>收货人姓名<span class="redStar">*</span></td>
                        <td><input name="receiver" placeholder="长度不超过25个字符" type="text"></td>
                    </tr>
                    <tr>
                        <td>手机号码 <span class="redStar">*</span></td>
                        <td><input name="mobile" placeholder="请输入11位手机号码" type="text"></td>
                    </tr>
                </table>
            </div>
        </div>--%>
        <table class="table table-bordered">
            <tr>
                <th class="panel">收货信息</th>
            </tr>
            <tr>
                <th>
                    <div class="col-md-8 address-left">
                        <br>
                        <ul>
                            <li><span>收货人：</span><span id="recipient">${sessionScope.defaultAddress.recipient}</span></li>
                            <li><span>联系方式：</span><span id="phone">${sessionScope.defaultAddress.phone}</span></li>
                            <li>
                                <span>收货地址：</span>
                                <span id="deliveryAddress">${sessionScope.defaultAddress.provinceName} ${sessionScope.defaultAddress.areaName} ${sessionScope.defaultAddress.streetName} ${sessionScope.defaultAddress.detail}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-2 address-right">
                        <c:if test="${not empty addressList}">
                            <p><a href="#" style="margin-left: 10px;color: #69c;font-size: small" data-toggle="modal" data-target="#myModal"> 地址切换</a></p>
                        </c:if>
                        <c:if test="${empty addressList}">
                            <button type="button" class="change-address"><a href="${ctx}/portal/address/add.jsp?isOrder=1"
                                                                            style="color: #000000;font-size: small;text-decoration: none">新建地址</a>
                            </button>
                        </c:if>

                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="myModalLabel">选择地址</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div id="list">



                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                        <button type="button" class="btn btn-primary change-address change" data-dismiss="modal">提交更改</button>
                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal -->
                        </div>
                    </div>
                </th>
            </tr>
        </table>




        <div class="productList">
            <div class="productListTip">确认订单信息</div>


            <table class="productListTable">
                <thead>
                <tr>
                    <th colspan="2" class="productListTableFirstColumn">
                        <img class="tmallbuy" src="img/site/tmallbuy.png">
                        <a class="marketLink" href="#nowhere">店铺：天猫店铺</a>
                        <a class="wangwanglink" href="#nowhere"> <span class="wangwangGif"></span> </a>
                    </th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody class="productListTableTbody">
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD"><img class="orderItemImg"
                                                          src="${img}goods/${buyOneGoods.categoryCode}/${buyOneGoods.typeCode}/${buyOneGoods.id}/avatar/${buyOneGoods.avatar}">
                        </td>
                        <td class="orderItemProductInfo">
                            <a href="${ctx}/goods/goodsDetail/${buyOneGoods.id}" class="orderItemProductLink">
                                    ${buyOneGoods.name}
                            </a>

                        </td>
                        <td>

                            <span class="orderItemProductPrice">￥<fmt:formatNumber type="number"
                                                                                   value="${buyOneGoods.price}"
                                                                                   minFractionDigits="2"/></span>
                        </td>
                        <td>
                            <span class="orderItemProductNumber">${buyOneNumber}</span>
                        </td>
                        <td><span class="orderItemUnitSum">
						￥<fmt:formatNumber type="number" value="${buyOnetotalPrice}"
                                           minFractionDigits="2"/>
						</span></td>
                            <td rowspan="5" class="orderItemLastTD">
                                <label class="orderItemDeliveryLabel">
                                    <input type="radio" value="" checked="checked">
                                    普通配送
                                </label>

                                <select class="orderItemDeliverySelect" class="form-control">
                                    <option>快递 免邮费</option>
                                </select>

                            </td>

                    </tr>
                </tbody>

            </table>
            <div class="orderItemSumDiv">

                <span class="pull-right">合计(含运费): ￥<fmt:formatNumber type="number" value="${buyOnetotalPrice}"
                                                                       minFractionDigits="2"/></span>
            </div>


        </div>

        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${buyOnetotalPrice}"
                                                                       minFractionDigits="2"/></span>
            </div>
        </div>

        <div class="submitOrderDiv">
            <button id="submitOrder" type="button" class="submitOrderButton">提交订单</button>
        </div>
    </form>
</div>
<script>

    $(function () {
        var addressId = '${defaultAddress.id}';
        $.ajax({
            url:'${ctx}/address/queryListByUser/'+'${user.id}',
            type:'get',
            success:function (data) {
                if(data.data.length>0){
                    $.each(data.data,function (i,address) {
                        var id = address.id;
                        var name = address.recipient;
                        var mobile = address.phone;
                        var detailAddress = address.provinceName+address.areaName+address.streetName+address.detail;
                        $('#list').append('<div id="'+id+'" class="list-style changeAddress">' +
                            '<ul>' +
                            '<li><span>收货人：</span>' +name+ '</li>' +
                            '<li><span>联系方式：</span>' +mobile+ '</li>' +
                            '<li><span>收货地址：</span>' +detailAddress+ '</li>'+
                            '</ul>' +
                            '</div>');
                    })
                }

            }
        });

        $(document).on('click', '.changeAddress', function () {
            addressId = $(this).attr('id');
            $('.changeAddress').css("background", "");
            $(this).css("background", "#4444");
        });
        $(document).on('click', '.change', function () {
            $.ajax({
                url:'${ctx}/address/queryById/'+addressId,
                type:'get',
                success:function (data) {
                    var addr = data.data;
                    if(data.msg=="success"){
                        $('#recipient').text(addr.recipient);
                        $('#phone').text(addr.phone);
                        $('#deliveryAddress').text(addr.provinceName+addr.areaName+addr.streetName+addr.detail);
                    }
                }
            });
        });
        $(document).on('click', '#submitOrder', function () {
            if(addressId==null||addressId==""){
                layer.alert("您还没有选择地址",{icon:5,title:"error"})
                return false;
            }else{
                window.location.href = '${ctx}/order/createOneGoodsOrder/'+addressId;
            }
        });
    });

</script>