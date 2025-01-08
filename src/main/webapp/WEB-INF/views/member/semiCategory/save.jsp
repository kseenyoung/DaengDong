<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 12:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<div class="semiCategories">
    <ul>
        <li class="action-item" id="myFavoritePlace">즐겨찾기</li>
        <li class="action-item" id="myReview">내가 쓴 리뷰</li>
        <li class="action-item" id="myLikes">좋아요</li>
        <li class="action-item" id="myPosts">내가 쓴 게시글</li>
    </ul>
</div>