<%--
  Created by IntelliJ IDEA.
  User: ksy
  Date: 12/14/24
  Time: 2:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.Properties" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="${path}/css/member/login.css"/>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<div class="login-container">
    <!-- Left: Login Form -->
    <div class="login-form">
        <h1>지금 바로 신나는 여행을</h1>
        <h1>계획해볼까요?</h1>
<%--        <div class="social-login d-flex justify-content-start mb-4">--%>
<%--        </div>--%>
<%--        <form>--%>
            <img class="social-login" src="${path}/img/kakao_login.png" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${rest_api_key}&redirect_uri=${redirect_uri}'">
<%--        </form>--%>
<%--        <p class="mt-3">Already have an account? <a href="#">Log in</a></p>--%>
    </div>

    <!-- Right: Image with overlay -->
    <div class="login-image">
        <img src="${path}/img/login.png" alt="loginImg" class="responsive-image"/>
        <div class="overlay">
            <p class="location">한옥마을<br>전주</p>
            <p class="distance">우리 강아지와 함께 새해 여행으로 전주 어떠신가요?</p>
        </div>
    </div>
</div>
</body>
</html>