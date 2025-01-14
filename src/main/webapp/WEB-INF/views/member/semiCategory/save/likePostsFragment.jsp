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
<link rel="stylesheet" href="${path}/css/member/myPost.css"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<div class="post-container">
    <c:forEach var="likePostsList" items="${likePostsList}">
        <div class="post-card" data-post-id="${likePostsList.post_id}">
            <span class="badge ${likePostsList.category_id}">
                <!-- 조건에 따라 아이콘 클래스 변경 -->
                <i class="<c:choose>
                            <c:when test='${likePostsList.category_id == "여행중"}'>fas fa-plane</c:when>
                            <c:when test='${likePostsList.category_id == "여행완료"}'>fas fa-check-circle</c:when>
                            <c:when test='${likePostsList.category_id == "사진"}'>fas fa-camera</c:when>
                            <c:when test='${likePostsList.category_id == "꿀팁"}'>fas fa-lightbulb</c:when>
                            <c:otherwise>fas fa-info-circle</c:otherwise>
                         </c:choose>"></i>
                ${likePostsList.category_id}
            </span>
            <img class="post-image" src="${likePostsList.image_url}" alt="Post Image">
            <div class="post-info">
                <h3 class="post-title">${likePostsList.post_title}</h3>
                <p class="post-user">@${likePostsList.member_nickname}</p>
                <div class="button-container">
                    <button class="delete-likePosts hoverable-heart" data-post-id="${likePostsList.post_id}">
                        ❤️
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
</div>