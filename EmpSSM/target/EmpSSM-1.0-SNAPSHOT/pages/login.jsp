<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <title>登录</title>
    <base href="<%=basePath%>">
</head>
<body>
<div class="well" style="font-size: 20px">后台管理系统</div>
<div class="login">
    <form action="index.jsp">
        <div class="input-group">
            <label class="input-group-addon" for="accout">账号</label>
            <input type="text" placeholder="请输入账号" class="form-control" id="accout" name="username">
        </div>
        <br>
        <div class="input-group">
            <label for="password" class="input-group-addon">密码</label>
            <input type="password" placeholder="请输入密码" class="form-control" id="password" name="password">
        </div>
        <br>
        <input type="submit" value="登录" class="btn btn-success" style="width: 300px">
    </form>
</div>
</body>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>