<%--
  User: LiQingsong
  Date: 2019/5/14
  Time: 13:07
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<a href="${contextPath}">
    <img id="logo" src="${ctx}/assets/img/logo2.png" class="logo">
</a>

<form action="foresearch" method="post" >
    <div class="searchDiv">
        <input name="keyword" type="text" value="${param.keyword}" placeholder="香蕉  白菜 ">
        <button  type="submit" class="searchButton">搜索</button>
        <div class="searchBelow">
            <c:forEach items="${cs}" var="c" varStatus="st">
                <c:if test="${st.count>=5 and st.count<=8}">
						<span>
							<a href="forecategory?cid=${c.id}">
                                    ${c.name}
                            </a>
							<c:if test="${st.count!=8}">
                                <span>|</span>
                            </c:if>
						</span>
                </c:if>
            </c:forEach>
        </div>
    </div>
</form>
