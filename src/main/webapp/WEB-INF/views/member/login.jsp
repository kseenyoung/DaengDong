<%--
  Created by IntelliJ IDEA.
  User: ksy
  Date: 12/14/24
  Time: 2:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Properties" %>
<%@ include file="../common/header.jsp" %>

<html>
<header>
    <script>
        <%--function f_kakao_login(){--%>
        <%--    $.ajax({--%>
        <%--        url : "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${rest_api_key}&redirect_uri=${redirect_uri}",--%>
        <%--        success : function (result){--%>
        <%--            alert(result)--%>
        <%--        },--%>
        <%--        error : function (){}--%>
        <%--    })--%>
        <%--}--%>
    </script>
</header>
<body>
login page
<img src="${path}/img/kakao_login.png" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${rest_api_key}&redirect_uri=${redirect_uri}'">
</body>
</html>
