<%--
  Created by IntelliJ IDEA.
  User: Gary Wong
  Date: 2017/11/19
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script>
    window.onload = function () {

        alert(1);

        if(window.confirm(${info})){
            window.location.href = "${url}";
        }else {
            window.location.href = "${url}";
        }
    }
</script>
<html>
<head>
    <title>操作提示</title>
    <base href="<%=basePath%>">
</head>
<body>

</body>
</html>
