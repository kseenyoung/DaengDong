<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js"></script>
<script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>

<title>Document</title>
<link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@400;700&family=Rubik+Bubbles&family=Rubik+Gemstones&family=Song+Myung&family=Sunflower:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${path}/css/post/main.css" />
<link rel="stylesheet" href="${path}/css/post/post.css" />

<div class="post">
    <a href="${path}/post/${post.postId}">
        <div class="post_relative">
            <img class="post_img" src="${post.imageUrl}" alt="">
            <c:if test="${post.category == '꿀팁'}">
                <div class="honeytip">💡Tip</div>
            </c:if>
            <div class="post_content">
                <c:if test="${post.category == '꿀팁'}">
                    <h2>${post.postTitle}</h2>
                    <p>${post.postContent}</p>
                </c:if>
            </div>
        </div>
    </a>
    <div class="post_info">
        <div class="post_info_left">
            <img src="${post.memberProfilePhoto}" alt="userprofile">
            <span>${post.memberNickName}</span>
        </div>
        <div class="post_info_right">
            <c:set var="found" value="false" />
            <!-- 좋아요 확인 -->
            <c:forEach var="likePostId" items="${myLike}">
                <c:if test="${likePostId == post.postId}">
                    <c:set var="found" value="true" />
                    <!-- 좋아요를 누른 경우 -->
                    <img class="like-img" src="${path}/img/Likefull.png" data-post-id="${post.postId}" alt="like">
                    <span>${post.likeCount}</span>
                </c:if>
            </c:forEach>
            <!-- 좋아요를 누르지 않은 경우 -->
            <c:if test="${not found}">
                <img class="like-img" src="${path}/img/Like.png" data-post-id="${post.postId}" alt="like">
                <span>${post.likeCount}</span>
            </c:if>
        </div>
    </div>
    <c:if test="${post.category != '꿀팁'}">
        <div class="post_bottom">${post.postContent}</div>
    </c:if>
</div>

<script>
$(document).on("click", ".like-img", function() {
    const postId = $(this).data("post-id");  // 클릭한 게시글의 postId 가져오기
    const imgElement = $(this);
    const likeCountElement = imgElement.siblings("span");  // 해당 게시글의 like count 표시 요소
    let currentLikeCount = parseInt(likeCountElement.text());  // 현재 좋아요 수

    $.ajax({
        url: `${path}/post/like`,
        type: "POST",
        data: {
            postId: postId,
        },
        success: function(response) {
            if (imgElement.attr("src") === `${path}/img/Likefull.png`) {
                imgElement.attr("src", `${path}/img/Like.png`);
                currentLikeCount--;
            } else {
                imgElement.attr("src", `${path}/img/Likefull.png`);
                currentLikeCount++;
            }
            likeCountElement.text(currentLikeCount);
        },
        error: function(err) {
            console.error(err);
        }
    });
});
</script>
