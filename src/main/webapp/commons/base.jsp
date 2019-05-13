<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctx = request.getContextPath();
    request.setAttribute("ctx",ctx);
    String img = "http://localhost:81/img/";
    request.setAttribute("img",img);
%>

<!--bootstrap css-->
<link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css">
<!-- easyUI css-->
<link rel="stylesheet" href="${ctx}/assets/easyUI/themes/default/easyui.css">
<!-- 引入EasyUI的图标样式文件-->
<link rel="stylesheet" href="${ctx}/assets/easyUI/themes/icon.css" type="text/css"/>
<!-- 引入JQuery -->
<script type="text/javascript" src="${ctx}/assets/easyUI/jquery.min.js"></script>
<!--jQuery-json-->
<script type="text/javascript" src="${ctx}/assets/script/jquery.json.min.js"></script>
<!-- 引入EasyUI -->
<script type="text/javascript" src="${ctx}/assets/easyUI/jquery.easyui.min.js"></script>
<!-- 引入EasyUI的中文国际化js，让EasyUI支持中文 -->
<script type="text/javascript" src="${ctx}/assets/easyUI/locale/easyui-lang-zh_CN.js"></script>
<!--bootstrap-->
<script type="text/javascript" src="${ctx}/assets/script/bootstrap.min.js"></script>
<!--vue-->
<script type="text/javascript" src="${ctx}/assets/script/vue.js"></script>
<!--font-awesome图标库-->
<link rel="stylesheet" href="${ctx}/assets/font-awesome/css/font-awesome.min.css">