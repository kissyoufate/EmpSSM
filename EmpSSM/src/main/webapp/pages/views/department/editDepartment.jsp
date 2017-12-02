<%--
  Created by IntelliJ IDEA.
  User: Gary Wong
  Date: 2017/11/16
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="pages/css/bootstrap.min.css">
    <link rel="stylesheet" href="pages/css/style.css">
    <script src="pages/js/jquery-3.2.1.min.js"></script>
    <script src="pages/js/bootstrap.min.js"></script>
    <title>编辑部门</title>
</head>
<body>
<div class="well alert-info" style="font-size: 20px">编辑部门</div>
<div class="container">
    <form action="depUpdate" method="post">
        <div class="row">
            <div class="col-sm-8">
                <div class="form-group">
                    <label for="" class="col-sm-2 label-info">部门名称</label>
                    <input type="text" placeholder="请输入部门名称" class="col-sm-10 form-control" name="dep_name" value="${dep.dep_name}">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-group">
                    <label for="" class="col-sm-2 label-info">部门描述</label>
                    <textarea class="form-control col-sm-10" rows="5" placeholder="请输入部门描述" name="dep_des">${dep.dep_des}</textarea>
                </div>
            </div>
        </div>
        <br>
        <%--隐藏的id--%>
        <input type="hidden" name="id" value="${dep.id}">
        <div class="form-inline">
            <input type="submit" value="保存编辑" class="btn btn-success">
            <a href="javascript:void (0)" class="btn btn-danger" onclick="abandUpdate()">放弃编辑</a>
        </div>
    </form>
</div>
<p style="color: red">'${info}'</p>
</body>
</html>

<script>
    function abandUpdate() {
        window.history.back();
    }
</script>
