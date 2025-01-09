<%--
  Created by IntelliJ IDEA.
  User: ksy
  Date: 12/17/24
  Time: 11:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>로그인 완료!</h1>
<p>환영합니다</p>
<a href="${path}/chat/room/1">채팅방입장하기</a>
<p>${member.member_email}</p>
<p>${member.member_name}</p>
<p>${member.member_nickname}</p>
<img src="${member.member_profile_photo}" alt="memberImage"/>
<a href="${path}/auth/viewMypage.do">마이페이지 보러 가기</a>
</body>
</html>
