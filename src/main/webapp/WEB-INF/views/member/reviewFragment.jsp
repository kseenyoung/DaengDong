<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/23/24
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<link rel="stylesheet" href="${path}/css/member/reviews.css">
<div id="view-review-modal-placeholder"></div>
<c:forEach var="reviewList" items="${reviewList}">
    <div class="announcement">
        <img id="placeImg" src="${reviewList.imageUrl}" alt="placeImg"
             onerror="this.src=`${path}/img/kseenyoungProfile`"/>
        <div class="text-container">
            <h2 class="place-title">
                <a>${reviewList.review_content}</a>
            </h2>
            <div class="place-address-container">
                <span class="place-address">${reviewList.region_name}</span>
                <span class="place-address">${reviewList.kakao_place_name}</span>
                <div class="star-rating">
                    <c:forEach var="star" begin="1" end="${reviewList.review_rating}">
                        <img id="star" src="${path}/img/star.png" alt="star_rating"/>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="button-container">
            <button
                    class="update-review"
                    data-toggle="modal"
                    data-target="#bootstrap-modal"
                    data-review-id="${reviewList.review_id}"
                    data-review-content="${reviewList.review_content}"
                    data-review-rating="${reviewList.review_rating}"
                    data-kakao-place-name="${reviewList.kakao_place_name}"
                    data-kakao-image-url="${reviewList.imageUrl}">
                수정
            </button>
            <button class="delete-review" data-review-id="${reviewList.review_id}">삭제</button>
        </div>
    </div>
</c:forEach>
