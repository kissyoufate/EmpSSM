<%--
  Created by IntelliJ IDEA.
  User: Gary Wong
  Date: 2017/11/12
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="pages/js/jquery-3.2.1.min.js"></script>
    <title>首页</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/test?username=1111">点击跳转</a>
<a href="${pageContext.request.contextPath}/upload.jsp">上传文件</a>

<p>模拟ajax</p>
<input type="text" name="username" id="username" placeholder="请输入用户名模拟ajax">
<p id="info" style="color: red;"></p>

<hr>

<%--模拟返回json--%>
<input type="submit" id="jsonButton" value="点击获取json">
<p id="jsoninfo"></p>
<hr>
<a href="gotoManager">进入管理平台</a>


<%--登录--%>
<form action="login" method="post">
    用户名:<input type="text" name="username">
    <br>
    密码 :<input type="password" name="password">
    <br>
    <input type="submit" value="登录进入">
</form>

<p style="color: red">${info}</p>

</body>
</html>

<script>
    $(document).ready(function () {

        //当元素失去焦点时执行方法
        $("#username").blur(function () {
            var username = $(this).val();
            if (username.length > 0) {
                $.post("ajaxtest", {username: username}, function (result) {
                    $("#info").html(result);
                })
            }
        })

        //当元素被点击时
        $("#jsonButton").click(function () {
            $.post("jsontest", {}, function (result) {
                $("#jsoninfo").html(result.data);

                $.each(result.data, function (i, item) {
                    $("#jsoninfo").append(
                        "<div>" + i + item + "</div>"
                    );
                })


            })
        })
    })
</script>
