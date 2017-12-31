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
    <script src="pages/js/bootstrap.min.js"></script>
    <script src="pages/js/jqPaginator.js"></script>
    <title>员工管理</title>
</head>
<body>
<div class="well" style="font-size: 20px">员工管理</div>

<!--员工的头,包含搜索,添加等功能-->
<div class="emp_top">
    <div class="emp_serch">
        <form action="/empolyee/search" class="form-inline" method="post">
            <input type="text" class="form-control" placeholder="请输入员工名称" name="emp_name" value="${emp_name}">
            <input type="submit" value="查询" class="btn btn-success" style="width: 100px">
            <a href="javascript:void (0)" class="btn btn-info" onclick="addEmp()">添加员工</a>
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
                    <a href="javascript:void (0)" class="btn btn-sm" onclick="deleteEmpById(${list.id})">删除</a>
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
                <a href="${requestUri}?page=${pageInfo.pageNum-1}&emp_name=${emp_name}" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
                </li>
            </c:if>
            <c:if test="${pageInfo.pageNum > 1}">
                <li>
                    <a href="${requestUri}?page=${pageInfo.pageNum-1}&emp_name=${emp_name}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>

            <c:forEach items="${pageInfo.navigatepageNums}" var="p">
                <c:if test="${p == pageInfo.pageNum}">
                    <li class="disabled"><a href="${requestUri}?page=${p}&emp_name=${emp_name}">${p}</a></li>
                </c:if>
                <c:if test="${p != pageInfo.pageNum}">
                    <li><a href="${requestUri}?page=${p}&emp_name=${emp_name}">${p}</a></li>
                </c:if>
            </c:forEach>

            <c:if test="${pageInfo.pageNum >= pageInfo.pages}">
                <li class="disabled">
                    <a href="${requestUri}?page=${pageInfo.pageNum+1}&emp_name=${emp_name}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${pageInfo.pageNum < pageInfo.pages}">
                <li>
                    <a href="${requestUri}?page=${pageInfo.pageNum+1}&emp_name=${emp_name}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<%--添加员工modal--%>
<div class="modal fade" id="myAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myUpdateModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="add_emp_name">员工姓名</label>
                    <input type="text" class="form-control" id="add_emp_name" placeholder="请输入员工姓名">
                </div>
                <div class="form-group">
                    <label for="add_emp_age">员工年龄</label>
                    <input type="text" class="form-control" id="add_emp_age" placeholder="请输入员工年龄">
                </div>
                <div class="form-group">
                    <label for="add_emp_sex">员工性别</label>
                    <select id="add_emp_sex" class="form-control">
                        <option value="1">男</option>
                        <option value="2">女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="add_emp_tel">员工电话</label>
                    <input type="text" class="form-control" id="add_emp_tel" placeholder="请输入员工电话">
                </div>
                <div class="form-group">
                    <label for="add_emp_dep">所属部门</label>
                    <%--<input type="text" class="form-control" id="add_dep_tel" placeholder="请输入员工电话">--%>
                    <select class="form-control" id="add_emp_dep">
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addEmp_btn" onclick="addEmpHandle()">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>

<script>

    //删除员工
    function deleteEmpById(id){
        if (window.confirm("确认要删除员工么?")){
            window.location = "/empolyee/delete?id=" + id;
        }
    }

    //添加员工
    function addEmp() {
        $('#myAddModal').modal('show');
        //获取所有的部门
        $.get(
            '/department/getAllDepsByJson',
            function (result) {
                var jsonResult = jQuery.parseJSON(result);
                if (jsonResult.status == 'success'){
                    //添加元素
                    for (var i=0;i<jsonResult.data.length;i++){
                        var dep = jsonResult.data[i];
                        var sele = '<option value=\"'+dep.id+'\">'+dep.dep_name+'</option>';
                        $('#add_emp_dep').append(sele);
                    }
                }else {
                    alert(jsonResult.message);
                }
            }
        )
    }

    //添加员工的执行方法
    function addEmpHandle() {
        var emp_name = $('#add_emp_name').val();
        var emp_age = $('#add_emp_age').val();
        var emp_sex = $('#add_emp_sex').val();
        var emp_tel = $('#add_emp_tel').val();
        var dep_id = $('#add_emp_dep').val();

        if (emp_name == null || emp_name == ''){
            alert('请输入员工姓名');
            return;
        }

        if (emp_age == null || emp_age > 120 || emp_age < 16){
            alert('请输入正确的员工姓名');
            return;
        }

        if (emp_sex != '1' && emp_sex != '2'){
            alert('请选择正确的员工性别' + emp_sex);
            return;
        }

        if (emp_tel.length != 11){
            alert('请输入正确的手机号码');
            return;
        }

        if (dep_id == null || dep_id == ''){
            alert('请选择员工所属部门');
            return;
        }

        $.post(
            '/empolyee/addEmp',
            {
                'emp_name':emp_name,
                'emp_age':emp_age,
                'emp_sex':emp_sex,
                'emp_tel':emp_tel,
                'dep_id':dep_id
            },
            function (result) {
                var jsonResult = jQuery.parseJSON(result);
                if (jsonResult.status == 'success'){
                    alert('添加成功');
                    $('#myAddModal').modal('hide');
                    window.location = '/empolyee/index';
                }else {
                    alert(jsonResult.message);
                }
            }
        )
    }

</script>
