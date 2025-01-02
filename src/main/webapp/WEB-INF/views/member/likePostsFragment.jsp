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
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${path}/css/member/likePosts.css">
<c:forEach var="likePostsList" items="${likePostsList}">
    <div class="announcement">
        <img id="placeImg" src="${path}/img/${likePostsList.image_url}" alt="placeImg"/>
        <div class="text-container">
            <h2 class="place-title">
                <a href="">${likePostsList.post_title}</a>
            </h2>
            <div class="place-address-container">
                <span class="place-address">작성자: ${likePostsList.member_nickname}</span>
            </div>
        </div>
        <div class="button-container">
            <button class="delete-likePosts" data-post-id="${likePostsList.post_id}">
                <img id="delete-likePosts" class="hoverable-star" src="${path}/img/like_icon.png" alt="delete_posts">
            </button>
        </div>
    </div>
</c:forEach>