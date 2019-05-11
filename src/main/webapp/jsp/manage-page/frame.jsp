<%@ page import="cn.lqs.administrator.bean.Administrator" %><%--
  User: LiQingsong
  Date: 2019/5/1
  Time: 14:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台管理</title>
    <jsp:include page="common.jsp"></jsp:include>
    <link rel="shortcut icon" href="${ctx}/assets/managePage/images/favicon.ico"/>
    <link rel="bookmark" href="${ctx}/assets/managePage/images/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/assets/managePage/css/frameStyle.css">
    <script type="text/javascript" src="${ctx}/assets/managePage/framework/frame.js"></script>

</head>
<body>
<!-- 左侧菜单 - 开始 -->
<div class="frameMenu">
    <div class="logo">
        <img src="${ctx}/assets/managePage/images/logo.png"/>
        <div class="logoText">
            <h1>菜市场管理系统</h1>
            <p>liqingsongzuopin</p>
        </div>
    </div>
    <div class="menu">
        <ul>
            <li>
                <a class="menuFA" href="javascript:void(0)" onclick="menuCAClick('tgls/qdAPI.html',this)"><i
                        class="iconfont icon-zhishi left"></i>实时状况</a>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)" onclick="menuCAClick('tgls/iconfont.html',this)"><i
                        class="iconfont icon-huojian left"></i>iconfont字体库</a>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)"><i
                        class="iconfont icon-liuliangyunpingtaitubiao03 left"></i>用户管理<i
                        class="iconfont icon-dajiantouyou right"></i></a>
                <dl>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('user/list.jsp',this)">用户列表</a>
                    </dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('user/analysis.jsp',this)">用户分析</a>
                    </dt>
                </dl>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)"><i class="iconfont icon-shangpin left"></i>商品管理<i
                        class="iconfont icon-dajiantouyou right"></i></a>
                <dl>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('tgls/goodsManage/goodsType_list.html',this)">分类列表</a>
                    </dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('goods/list.jsp',this)">商品列表</a>
                    </dt>
                    <dt><a href="javascript:void(0)"
                           onclick="menuCAClick('goods/add.jsp',this)">添加商品</a></dt>
                </dl>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)"><i class="iconfont icon-yunying left"></i>用户管理<i
                        class="iconfont icon-dajiantouyou right"></i></a>
                <dl>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('user/list.jsp',this)">用户列表</a>
                    </dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('user/analysis.jsp',this)">用户统计</a>
                    </dt>
                    <dt><a href="javascript:void(0)"
                           onclick="menuCAClick('tgls/base/base_customList.html',this)">可新增的列表</a></dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('tgls/base/base_customNewList.html',this)">可新增的列表(手写)</a>
                    </dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('tgls/base/pages.html',this)">页签切换Table</a>
                    </dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('tgls/base/maintain.html',this)">维护中页面</a>
                    </dt>
                </dl>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)"><i class="iconfont icon-icon left"></i>打印模板<i
                        class="iconfont icon-dajiantouyou right"></i></a>
                <dl>
                    <dt><a href="javascript:void(0)"
                           onclick="menuCAClick('tgls/print/outPrintData.html',this)">入库单打印模版</a></dt>
                </dl>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)"><i class="iconfont icon-caiwu left"></i>财务管理</a>
            </li>
            <li>
                <a class="menuFA" href="javascript:void(0)"><i class="iconfont icon-ai-wallet left"></i>员工管理<i
                        class="iconfont icon-dajiantouyou right"></i></a>
                <dl>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('admin/list.jsp',this)">员工列表</a>
                    </dt>
                    <dt><a href="javascript:void(0)" onclick="menuCAClick('admin/add.jsp',this)">新增员工</a>
                    </dt>
                </dl>
            </li>
        </ul>
    </div>
</div>
<!-- 左侧菜单 - 结束 -->

<div class="main">
    <!-- 头部栏 - 开始 -->
    <div class="frameTop">
        <img class="jt" src="${ctx}/assets/managePage/images/top_jt.png"/>
        <div class="topMenu">
            <ul>
                <li><a href="javascript:void(0)" onclick="menuCAClick('admin-detail.jsp',this)"><i class="iconfont icon-yonghu1"></i>${admin.account}</a></li>
                <li><a href="javascript:void(0)" onclick="menuCAClick('edit-password.jsp',this)"><i class="iconfont icon-xiugaimima"></i>修改密码</a></li>
                <li><a href="${ctx}/administratorController/signOut"><i class="iconfont icon-084tuichu"></i>注销</a></li>
            </ul>
        </div>
    </div>
    <!-- 头部栏 - 结束 -->

    <!-- 核心区域 - 开始 -->
    <div class="frameMain">
        <div class="title" id="frameMainTitle">
            <span><i class="iconfont icon-xianshiqi"></i>后台首页</span>
        </div>
        <div class="con">
            <iframe id="mainIframe" src="index.jsp" scrolling="no"></iframe>
        </div>
    </div>
    <!-- 核心区域 - 结束 -->
</div>
</body>
</html>
