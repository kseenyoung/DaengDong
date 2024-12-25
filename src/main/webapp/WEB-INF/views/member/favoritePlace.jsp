<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 14:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<link rel="stylesheet" href="${path}/css/member/favoritePlace.css">
<div class="announcement">
    <img id="placeImg" src="${path}/img/kseenyoungProfile.jpeg" alt="placeImg"/>
    <div class="text-container">
        <h2 class="place-title">강릉여행</h2>
        <p class="participants">참여자: evan, 푸른곰팡이, 말하는감자, 띠보, 성후이, 쿠로미</p>
    </div>
</div>