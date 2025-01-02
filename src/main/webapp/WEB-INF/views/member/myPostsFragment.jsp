<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<link rel="stylesheet" href="${path}/css/member/myPost.css"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<div class="post-container">
    <c:forEach var="postsList" items="${postsList}">
        <div class="post-card">
            <span class="badge ${postsList.category_id}">
                <!-- 조건에 따라 아이콘 클래스 변경 -->
                <i class="<c:choose>
                            <c:when test='${postsList.category_id == "여행중"}'>fas fa-plane</c:when>
                            <c:when test='${postsList.category_id == "여행완료"}'>fas fa-check-circle</c:when>
                            <c:when test='${postsList.category_id == "사진"}'>fas fa-camera</c:when>
                            <c:when test='${postsList.category_id == "꿀팁"}'>fas fa-lightbulb</c:when>
                            <c:otherwise>fas fa-info-circle</c:otherwise>
                         </c:choose>"></i>
                ${postsList.category_id}
            </span>
            <img class="post-image" src="${path}/img/${postsList.image_url}" alt="Post Image">
            <div class="post-info">
                <h3 class="post-title">${postsList.post_title}</h3>
                <p class="post-user">${postsList.post_content}</p>
                <p class="post-likes">❤️ ${postsList.total_likes}</p>
            </div>
        </div>
    </c:forEach>
</div>