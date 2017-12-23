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
        ${lists}
        <c:forEach items="${pageInfo.list}" var="list">
            <tr>
                <td>${list.id}</td>
                <td>${list.emp_name}</td>
                <td>${list.emp_sex}</td>
                <td>${list.emp_age}</td>
                <td>${list.emp_tel}</td>
                <td>
                    <a href="javascript:void (0)" class="btn btn-sm">编辑</a>
                    <a href="javascript:void (0)" class="btn btn-sm">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<!-- 分页按钮 -->
<div style="width: 400px; margin: 10px auto">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${pageInfo.pageNum <= 1}">
                <li class="disabled">
                <a href="/empolyee/index?page=${pageInfo.pageNum-1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
                </li>
            </c:if>
            <c:if test="${pageInfo.pageNum > 1}">
                <li class="disabled">
                    <a href="/empolyee/index?page=${pageInfo.pageNum-1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>

            <c:forEach items="${pageInfo.navigatepageNums}" var="p">
                <c:if test="${p == pageInfo.pageNum}">
                    <li class="disabled"><a href="/empolyee/index?page=${p}">${p}</a></li>
                </c:if>
                <c:if test="${p != pageInfo.pageNum}">
                    <li><a href="/empolyee/index?page=${p}">${p}</a></li>
                </c:if>
            </c:forEach>

            <c:if test="${pageInfo.pageNum >= pageInfo.pages}">
                <li class="disabled">
                    <a href="/empolyee/index?page=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${pageInfo.pageNum < pageInfo.pages}">
                <li>
                    <a href="/empolyee/index?page=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</body>
</html>

<script>

</script>
