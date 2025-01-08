<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/1/25
  Time: 07:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>

<!-- 부트스트랩 모달 -->
<div id="review-modal" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div id="review-modal-dialog" class="modal-dialog">
        <div id="review-modal-content" class="modal-content">
            <div class="modal-body">
                <!-- Profile Section -->
                <div class="text-center mb-4">
                    <img id="placeImg" src="${imageUrl}" alt="placeImg"
                         class="rounded-circle" width="120" height="120"/>
                    <div id="kakao-place-name-display" class="mt-2 text-muted">${kakaoPlaceName}</div>
                </div>

                <!-- Form Section -->
                <form>
                    <div class="form-group">
                        <input type="hidden" id="review-id" value="${reviewId}">
                        <label for="review-content">리뷰 내용</label>
                        <textarea type="text" class="form-control" id="review-content"
                                  placeholder="리뷰 내용">${reviewContent}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="review-rating">별점</label>
                        <select id="review-rating" class="form-control">
                            <option value="1" <c:if test="${reviewRating == 1}">selected</c:if>>1</option>
                            <option value="2" <c:if test="${reviewRating == 2}">selected</c:if>>2</option>
                            <option value="3" <c:if test="${reviewRating == 3}">selected</c:if>>3</option>
                            <option value="4" <c:if test="${reviewRating == 4}">selected</c:if>>4</option>
                            <option value="5" <c:if test="${reviewRating == 5}">selected</c:if>>5</option>
                        </select>
                    </div>
                </form>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close-modal">Close</button>
                <button type="button" class="btn btn-primary" id="confirm-update">Update</button>
            </div>
        </div>
    </div>
</div>
