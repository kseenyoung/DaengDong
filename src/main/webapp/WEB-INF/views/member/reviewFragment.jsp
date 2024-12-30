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
<head>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${path}/css/member/reviews.css">
</head>
<div id="bootstrap-wrapper">
    <!-- 부트스트랩 모달 -->
    <div id="bootstrap-modal" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <!-- Profile Section -->
                    <div class="text-center mb-4">
                        <img id="placeImg" src="" alt="placeImg"
                              class="rounded-circle" width="120" height="120"/>
                        <div id="kakao-place-name-display" class="mt-2 text-muted"></div>
                    </div>

                    <!-- Form Section -->
                    <form>
                        <div class="form-group">
                            <input type="hidden" id="review-id">
                            <label for="review-content">리뷰 내용</label>
                            <textarea type="text" class="form-control" id="review-content"
                                      placeholder="리뷰 내용"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="review-rating">별점</label>
                            <select id="review-rating" class="form-control">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                        </div>
                    </form>
                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="confirm-update">Update</button>
                </div>
            </div>
        </div>
    </div>
</div>
<c:forEach var="reviewList" items="${reviewList}">
    <div class="announcement">
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
