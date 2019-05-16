<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <%
    String ctx = request.getContextPath();
    request.setAttribute("ctx",ctx);
    String img = "http://localhost:81/img/";
    request.setAttribute("img",img);
%>
<head>
    <link rel="shortcut icon" href="${ctx}/assets/managePage/images/favicon.ico"/>
    <link rel="bookmark" href="${ctx}/assets/managePage/images/favicon.ico"/>
    <!--bootstrap css-->
    <link rel="stylesheet" href="${ctx}/assets/css/bootstrap.min.css">
    <!-- 引入JQuery -->
    <script type="text/javascript" src="${ctx}/assets/script/jquery.min2.js"></script>
    <script type="text/javascript" src="${ctx}/assets/script/jquery-ui.min.js"></script>

    <script type="text/javascript" src="${ctx}/assets/script/jquery.json.min.js"></script>
    <!--bootstrap-->
    <script type="text/javascript" src="${ctx}/assets/script/bootstrap.min.js"></script>

    <script type="text/javascript" src="${ctx}/assets/script/slide.js"></script>

    <link href="${ctx}/assets/css/fore/style.css" rel="stylesheet">

    <!--vue-->
    <script type="text/javascript" src="${ctx}/assets/script/vue.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/assets/managePage/layui/css/layui.css">
    <script src="${ctx}/assets/managePage/layui/layui.js"></script>

    <link rel="stylesheet" type="text/css" href="${ctx}/assets/css/user-login/reset.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/assets/css/user-login/main.css">
    <script>
        function formatMoney(num){
            num = num.toString().replace(/\$|\,/g,'');
            if(isNaN(num))
                num = "0";
            sign = (num == (num = Math.abs(num)));
            num = Math.floor(num*100+0.50000000001);
            cents = num%100;
            num = Math.floor(num/100).toString();
            if(cents<10)
                cents = "0" + cents;
            for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
                num = num.substring(0,num.length-(4*i+3))+','+
                    num.substring(num.length-(4*i+3));
            return (((sign)?'':'-') + num + '.' + cents);
        }
        function checkEmpty(id, name){
            var value = $("#"+id).val();
            if(value.length==0){

                $("#"+id)[0].focus();
                return false;
            }
            return true;
        }


        $(function(){


            $("a.productDetailTopReviewLink").click(function(){
                $("div.productReviewDiv").show();
                $("div.productDetailDiv").hide();
            });
            $("a.productReviewTopPartSelectedLink").click(function(){
                $("div.productReviewDiv").hide();
                $("div.productDetailDiv").show();
            });

            $("span.leaveMessageTextareaSpan").hide();
            $("img.leaveMessageImg").click(function(){

                $(this).hide();
                $("span.leaveMessageTextareaSpan").show();
                $("div.orderItemSumDiv").css("height","100px");
            });

            $("div#footer a[href$=#nowhere]").click(function(){
                alert("模仿天猫的连接，并没有跳转到实际的页面");
            });


            $("a.wangwanglink").click(function(){
                alert("模仿旺旺的图标，并不会打开旺旺");
            });
            $("a.notImplementLink").click(function(){
                alert("这个功能没做，蛤蛤~");
            });


        });

    </script>
</head>

<body>

