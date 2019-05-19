<%--
  User: LiQingsong
  Date: 2019/5/19
  Time: 17:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="searchResult">

    <div class="searchResultDiv">

        <div class="searchProducts">

            <div class="list_title clearfix" style="height: 20px;">
                <c:if test="${not empty searchFirstCategory}">
                    <a style="display:inlint-block;" href="javascript:void(0)">${searchFirstCategory}/${searchSecondCategory}&nbsp;&nbsp;</a>
                </c:if>
                <a style="display:inlint-block;">默认排序&nbsp;&nbsp;</a>
            </div>

            <c:forEach items="${searchGoodsList}" var="goods">
            <div class="productUnit" price="${goods.price}">
                <a href="${ctx}/goods/goodsDetail/${goods.id}">
                    <img class="productImage"
                         src="${img}goods/${goods.categoryCode}/${goods.typeCode}/${goods.id}/avatar/${goods.avatar}">
                </a>
                <span class="productPrice">¥<fmt:formatNumber type="number" value="${goods.price}"
                                                              minFractionDigits="2"/></span>
                <a class="productLink" href="${ctx}/goods/goodsDetail/${goods.id}">
                        ${fn:substring(goods.name, 0, 50)}
                </a>

                    <%--
                         <div class="show1 productInfo">
                             <span class="monthDeal ">月成交 <span class="productDealNumber">${goods.saleCount}笔</span></span>
                             <span class="productReview">评价<span class="productReviewNumber">${goods.reviewCount}</span></span>
                             <span class="wangwang"><img src="img/site/wangwang.png"></span>
                         </div>--%>

            </div>
            </c:forEach>
            <c:if test="${empty searchGoodsList}">
            <div class="noMatch">没有满足条件的产品
                <div>
                    </c:if>

                    <div style="clear:both"></div>

                </div>

            </div>