<%--
  Created by IntelliJ IDEA.
  User: Gary Wong
  Date: 2017/11/16
  Time: 22:07
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <script src="pages/js/jqPaginator.js"></script>
    <title>部门管理</title>
</head>
<body>
<div class="well" style="font-size: 20px">部门管理</div>
<!--部门管理头,包含搜索部门 添加部门-->
<div class="emp_serch">
    <form action="/department/index" class="form-inline" method="get">
        <input type="text" placeholder="请输入部门名称" class="form-control" name="name" value="${name}">
        <input type="submit" value="搜索" class="btn btn-success">
        <a href="/department/addDep" class="btn btn-info">添加部门</a>
    </form>
</div>
<div class="well alert-info" style="margin-top: 20px">部门信息一览 <span>总共有${count}个数据</span></div>
<!--部门信息表-->
<div class="container">
    <table class="table table-hover table-bordered">
        <tr>
            <th>部门编号</th>
            <th>部门名称</th>
            <th>部门描述</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${lists}" var="l">
            <tr>
                <td>${l.id}</td>
                <td>${l.dep_name}</td>
                <td>${l.dep_des}</td>
                <td>
                    <a href="depUpdate?id=${l.id}" class="btn btn-sm">编辑</a>
                    <a href="javascript: void (0)" class="btn btn-sm"
                       onclick="deleDepById(${l.id},${page},'${l.dep_name}')">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<!-- 分页按钮 -->
<ul class="pagination" id="pagination" style="width: 450px;display: block;position: relative;margin: 0 auto;"></ul>

<p style="color: red">${updateInfo}</p>
</body>
</html>

<script>
    //分页
    $('#pagination').jqPaginator({
        totalPages: ${pages},
        visiblePages: 5,
        currentPage: ${page},

        first: '<li class="first"><a href="/department/index?name=${name}&page=1">首页</a></li>',
        prev: '<li class="prev"><a href="/department/index?name=${name}&page=${page-1==0?1:page-1}">上一页</a></li>',
        next: '<li class="next"><a href="/department/index?name=${name}&page=${page==pages?page:page+1}">下一页</a></li>',
        last: '<li class="last"><a href="/department/index?name=${name}&page={{totalPages}}">尾页</a></li>',
        page: '<li class="page"><a href="/department/index?name=${name}&page={{page}}">{{page}}</a></li>',
        onPageChange: function (num) {
//            window.location.href = "empolyeeByPage?page=" +  num;
        }
    });

    function deleDepById(id, page, name) {
        var b = window.confirm("确定要删除" + name + "么?");
        if (b) {
            $.post(
                "/department/delete",
                {
                    "id": id,
                    "page": page,
                    "name": name
                },
                function (result) {
                    var jsonResult = jQuery.parseJSON(result);
                    if (jsonResult.status == 'success') {
                        alert('删除成功');
                        window.location.href = "/department/index?name=${name}&page=" + jsonResult.data;
                    } else {
                        alert('删除失败');
                        window.location.href = "/department/index?name=${name}&page=${page}";
                    }
                }
            )
        }
    }
</script>
