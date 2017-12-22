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
    <form action="/department/searchDeps" class="form-inline" method="get">
        <input type="text" placeholder="请输入部门名称" class="form-control" name="name" value="${searchName}">
        <input type="submit" value="搜索" class="btn btn-success">
        <a href="javascript:void (0)" class="btn btn-info" data-toggle="modal" data-target="#myModal">添加部门</a>
    </form>
</div>
<p style="color: red">${error}</p>
<div class="well alert-info" style="margin-top: 20px">部门信息一览 <span>总共有${pageInfo.total}个数据</span></div>
<!--部门信息表-->
<div class="container">
    <table class="table table-hover table-bordered">
        <tr>
            <th>部门编号</th>
            <th>部门名称</th>
            <th>部门描述</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="l">
            <tr>
                <td>${l.id}</td>
                <td>${l.dep_name}</td>
                <td>${l.dep_des}</td>
                <td>
                    <a href="javascript:void (0)" class="btn btn-sm"
                       onclick="updateDep('${l.id}','${l.dep_name}','${l.dep_des}')">编辑</a>
                    <a href="javascript: void (0)" class="btn btn-sm"
                       onclick="deleDepById(${l.id},${pageInfo.pageNum},'${l.dep_name}')">删除</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<!-- 分页按钮 -->
<%--<ul class="pagination" id="pagination" style="width: 450px;display: block;position: relative;margin: 0 auto;"></ul>--%>
<div style="width: 400px; margin: 10px auto">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <c:if test="${pageInfo.pageNum <= 1}">
                <li class="disabled"
                ">
                <a href="/department/deps?pg=${pageInfo.pageNum-1}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
                </li>
            </c:if>
            <c:if test="${pageInfo.pageNum > 1}">
                <li class="disabled">
                    <a href="/department/deps?pg=${pageInfo.pageNum-1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>

            <c:forEach items="${pageInfo.navigatepageNums}" var="p">
                <c:if test="${p == pageInfo.pageNum}">
                    <li class="disabled"><a href="/department/deps?pg=${p}">${p}</a></li>
                </c:if>
                <c:if test="${p != pageInfo.pageNum}">
                    <li><a href="/department/deps?pg=${p}">${p}</a></li>
                </c:if>
            </c:forEach>

            <c:if test="${pageInfo.pageNum >= pageInfo.pages}">
                <li class="disabled">
                    <a href="/department/deps?pg=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${pageInfo.pageNum < pageInfo.pages}">
                <li>
                    <a href="/department/deps?pg=${pageInfo.pageNum+1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<%--添加 部门modal--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加部门</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="dep_name">部门名称</label>
                    <input type="text" class="form-control" id="dep_name" placeholder="部门名称">
                </div>
                <div class="form-group">
                    <label for="dep_des">部门描述</label>
                    <input type="text" class="form-control" id="dep_des" placeholder="部门描述">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addDep">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<%--编辑部门--%>
<div class="modal fade" id="myUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myUpdateModalLabel">添加部门</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="dep_name">部门名称</label>
                    <input type="text" class="form-control" id="update_dep_name" placeholder="部门名称">
                </div>
                <div class="form-group">
                    <label for="dep_des">部门描述</label>
                    <input type="text" class="form-control" id="update_dep_des" placeholder="部门描述">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateDep">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<p style="color: red">${updateInfo}</p>
</body>
</html>

<script>

    //通过id异步删除部门
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
                        window.location.href = "/department/deps?name=" + name;
                    } else {
                        alert('删除失败');
                        return;
                    }
                }
            )
        }
    }

    //添加部门的操作
    $("#addDep").click(function () {
        var dep_name = $("#dep_name").val();
        var dep_des = $("#dep_des").val();

        if (dep_name == '') {
            alert('请输入部门名称');
            return;
        }

        if (dep_des == '') {
            alert('请输入部门描述');
            return;
        }

        $('#myModal').modal('hide');

        $.post(
            '/department/addDepReturnJson',
            {
                'dep_name': dep_name,
                'dep_des': dep_des
            },
            function (result) {
                var jsonResult = jQuery.parseJSON(result);
                if (jsonResult.status == 'success') {
                    alert('添加成功');
                    window.location = "/department/deps";
                } else {
                    alert('添加失败' + jsonResult.message);
                }
            }
        )
    })

    //编辑部门信息
    function updateDep(dep_id, dep_name, dep_des) {
        $('#myUpdateModal').modal('show');
        $('#update_dep_name').val(dep_name);
        $('#update_dep_des').val(dep_des);

        $('#updateDep').click(function () {
            if ($('#update_dep_name').val() == dep_name && $('#update_dep_des').val() == dep_des) {
                alert('您没有修改信息');
                $('#myUpdateModal').modal('hide');
                return;
            }

            $.post(
                '/department/updateDepReturnJson',
                {
                    'dep_id': dep_id,
                    'dep_name': $('#update_dep_name').val(),
                    'dep_des': $('#update_dep_des').val()
                },
                function (result) {
                    var jsonResult = jQuery.parseJSON(result);
                    if (jsonResult.status == 'success') {
                        alert('修改成功');
                        $('#myUpdateModal').modal('hide');
                        window.location = '/department/deps';
                    } else {
                        alert(jsonResult.message);
                    }
                }
            )
        })
    }

</script>
