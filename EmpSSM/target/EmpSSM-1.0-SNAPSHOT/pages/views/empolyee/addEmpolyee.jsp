<%--
  Created by IntelliJ IDEA.
  User: Gary Wong
  Date: 2017/11/16
  Time: 21:58
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>添加员工</title>
</head>
<body>
<div class="well alert-info" style="font-size: 20px">添加员工</div>
<div class="container">
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="col-sm-2 control-label">员工名称</label>
                    <input type="text" placeholder="请输入员工名称" class="form-control" id="emp_name">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="col-sm-2 control-label">员工性别</label>
                    <select class="form-control" id="emp_sex">
                        <option>男</option>
                        <option>女</option>
                    </select>
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="col-sm-2 control-label">员工年龄</label>
                    <input type="text" class="form-control" placeholder="请输入员工年龄" id="emp_age">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="control-label col-sm-2">联系方式</label>
                    <input type="text" class="form-control col-sm-10" placeholder="请输入电话号码" id="emp_tel">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="control-label col-sm-2">部门</label>
                    <select class="form-control" id="dep_id">
                        <c:forEach items="${lists}" var="list">
                            <option value="${list.id}">${list.dep_name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <br>
        <div class="form-inline">
            <input type="submit" value="添加员工" class="btn btn-success" id="addEmp">
            <input type="button" value="放弃添加" class="btn btn-danger" id="abandAdd">
        </div>
</div>
</body>
</html>

<script>
    $(document).ready(function () {
        //添加员工
        $("#addEmp").click(function () {
            var emp_name = $("#emp_name").val();
            var emp_sex = $("#emp_sex").val();
            var emp_age = $("#emp_age").val();
            var emp_tel = $("#emp_tel").val();
            var dep_id = $("#dep_id").val();

            $.post(
                "empolyeeAdd",
                {
                    emp_name:emp_name,
                    emp_sex:emp_sex,
                    emp_age:emp_age,
                    emp_tel:emp_tel,
                    dep_id:dep_id
                },
            function (result) {
                    var data = jQuery.parseJSON(result);
                    if (data.code == 'success'){
                        alert("添加成功");
                        window.location.href = "empolyeeByPage?page=1";
                    }else {
                        alert(data.messageInfo);
                        $("#emp_name").val(emp_name);
                        $("#emp_sex").val(emp_sex);
                        $("#emp_age").val(emp_age);
                        $("#emp_tel").val(emp_tel);
                        $("#dep_id").val(dep_id);
                    }
            });

        })

        //放弃编辑,返回上一页
        $("#abandAdd").click(function () {
            if(window.confirm("放弃添加么?")){
                window.history.back();
            }
        })
    })
</script>