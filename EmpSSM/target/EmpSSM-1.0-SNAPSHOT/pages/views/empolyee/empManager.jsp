<%--
  Created by IntelliJ IDEA.
  User: Gary Wong
  Date: 2017/11/16
  Time: 22:01
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
    <script src="pages/js/jqPaginator.js"></script>
    <title>员工管理</title>
</head>
<body>
<div class="well" style="font-size: 20px">员工管理</div>

<!--员工的头,包含搜索,添加等功能-->
<div class="emp_top">
    <div class="emp_serch">
        <form action="empolyeeQuery" class="form-inline" method="post">
            <input type="text" class="form-control" placeholder="请输入员工名称" name="emp_name" value="${emp_name}">
            <input type="submit" value="查询" class="btn btn-success" style="width: 100px">
            <a href="gotoAddEmp" style="position: relative;width: 100px" class="btn btn-info">添加</a>
        </form>
        <span style="color: red">${errorInfo}</span>
    </div>
</div>

<!--员工的列表展示-->
<div class="well alert-info" style="margin-top: 20px">员工信息一览 <span>${totalCountInfo}</span></div>
<div class="container">
    <table class="table table-hover table-bordered">
        <tr>
            <th>员工编号</th>
            <th>员工姓名</th>
            <th>员工性别</th>
            <th>员工年龄</th>
            <th>联系方式</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${lists}" var="list">
            <tr>
                <td>${list.id}</td>
                <td>${list.emp_name}</td>
                <td>${list.emp_sex}</td>
                <td>${list.emp_age}</td>
                <td>${list.emp_tel}</td>
                <td>
                    <a href="gotoEditEmp?id=${list.id}" class="btn btn-sm">编辑</a>
                    <a href="javascript:void (0)" class="btn btn-sm" onclick="doDel(${list.id})">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<!-- 分页按钮 -->
<ul class="pagination" id="pagination" style="width: 450px;display: block;position: relative;margin: 0 auto;"></ul>
</body>
</html>

<script>
    //分页
    $('#pagination').jqPaginator({
        totalPages: ${pages},
        visiblePages: 5,
        currentPage: ${currentPage},

        first: '<li class="first"><a href="empolyeeByPage?page=1">首页</a></li>',
        prev: '<li class="prev"><a href="empolyeeByPage?page=${currentPage-1==0?1:currentPage-1}">上一页</a></li>',
        next: '<li class="next"><a href="empolyeeByPage?page=${currentPage==pages?currentPage:currentPage+1}">下一页</a></li>',
        last: '<li class="last"><a href="empolyeeByPage?page={{totalPages}}">尾页</a></li>',
        page: '<li class="page"><a href="empolyeeByPage?page={{page}}">{{page}}</a></li>',
        onPageChange: function (num) {
//            window.location.href = "empolyeeByPage?page=" +  num;
        }
    });

    //删除某一个员工
    function doDel(id) {
        if (window.confirm("确定要删除么?")){
            $.post(
                "deleEmp",
                {
                    "id":id
                },
                function (result) {
                    var data = jQuery.parseJSON(result);

                    if (data.code == "success"){
                        alert("删除成功");
                        window.location.href = "empolyeeByPage?page=1";
                    }else {
                        alert(result.message);
                    }
                }
            )
        }
    }

</script>
