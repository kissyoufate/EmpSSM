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
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>编辑员工</title>
</head>
<body>
<div class="well alert-info" style="font-size: 20px">编辑员工</div>
<div class="container">
    <form action="#" method="post">
        <input type="hidden" name="id" value="${empolyee.id}" id="emp_id">
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="col-sm-2 control-label">员工名称</label>
                    <input type="text" placeholder="请输入员工名称" class="form-control" name="emp_name"
                           value="${empolyee.emp_name}" id="emp_name">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label class="col-sm-2 control-label">员工性别</label>
                    <c:if test="${empolyee.emp_sex == '男'}">
                        <select id="emp_sex" class="form-control">
                            <option name="emp_sex" value="男" selected="selected">男</option>
                            <option name="emp_sex" value="女">女</option>
                        </select>
                    </c:if>
                    <c:if test="${empolyee.emp_sex == '女'}">
                        <select id="emp_sex" class="form-control">
                            <option name="emp_sex" value="男">男</option>
                            <option name="emp_sex" value="女" selected="selected">女</option>
                        </select>
                    </c:if>
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="col-sm-2 control-label">员工年龄</label>
                    <input type="text" class="form-control" placeholder="请输入员工年龄" name="emp_age"
                           value="${empolyee.emp_age}" id="emp_age">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label for="" class="control-label col-sm-2">联系方式</label>
                    <input type="text" class="form-control col-sm-10" placeholder="请输入电话号码" name="emp_tel"
                           value="${empolyee.emp_tel}" id="emp_tel">
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-sm-9">
                <div class="form-inline">
                    <label class="col-sm-2 control-label">员工部门</label>
                    <select id="emp_dep" class="form-control">
                        <c:forEach items="${allDeps}" var="dep">
                            <c:if test="${dep.id == empolyee.dep_id}">
                                <option name="dep_id" value="${dep.id}" selected="selected">${dep.dep_name}</option>
                            </c:if>

                            <c:if test="${dep.id != empolyee.dep_id}">
                                <option name="dep_id" value="${dep.id}">${dep.dep_name}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
            </div>
        </div>
        <br>
        <div class="form-inline">
            <input type="button" value="保存编辑" class="btn btn-success" id="sureEdit">
            <a href="javascript:void (0)" class="btn btn-danger" id="abandEdit">放弃编辑</a>
        </div>
    </form>
</div>
</body>
</html>

<script>
    $(document).ready(function () {
        //当前的部门id 和 部门名字
        var dep_id = $("#emp_dep").val();
        var dep_name = $("#emp_dep").find("option:selected").text;

        //放弃修改页面
        $("#abandEdit").click(function () {
            if (window.confirm("确认要重置么?")) {
                <%--$("#emp_id").val("${empolyee.id}");--%>
                $("#emp_name").val("${empolyee.emp_name}");
                $("#emp_sex").val("${empolyee.emp_sex}");
                $("#emp_age").val("${empolyee.emp_age}");
                $("#emp_tel").val("${empolyee.emp_tel}");
                $("#emp_dep").val(dep_id);
                $("#emp_dep").find("option[value=dep_id]").attr("selected",true);
            }
        })

        //确认修改
        $("#sureEdit").click(function () {

            var id = $("#emp_id").val();
            var emp_name = $("#emp_name").val();
            var emp_sex = $("#emp_sex").val();
            var emp_age = $("#emp_age").val();
            var emp_tel = $("#emp_tel").val();
            var dep_id = $("#emp_dep").val();

            $.post(
                "editEmp",
                {
                    "id": id,
                    "emp_name": emp_name,
                    "emp_sex": emp_sex,
                    "emp_age": emp_age,
                    "emp_tel": emp_tel,
                    "dep_id":dep_id
                },
                function (result) {
                    var data = jQuery.parseJSON(result);
                    if (data.code == "success"){
                        alert("修改成功");
                        window.location.href = data.path;
                    }else {
                        alert(data.info);
                    }
                }
            )
        })
    })
</script>
