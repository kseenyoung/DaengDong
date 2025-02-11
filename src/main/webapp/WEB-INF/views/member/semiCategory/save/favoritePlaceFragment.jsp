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
<c:forEach var="favoritePlaceList" items="${favoritePlaceList}">
    <div class="announcement">
        <img id="placeImg" src="${favoritePlaceList.imageUrl}" alt="placeImg"
             onerror="this.src=`${path}/img/kseenyoungProfile`"/>
        <div class="text-container">
            <h2 class="place-title">
                <a href="${favoritePlaceList.kakao_place_url}">${favoritePlaceList.kakao_place_name}</a>
            </h2>
            <div class="place-address-container">
                <span class="place-address">${favoritePlaceList.region_name}</span>
                <span class="place-address">${favoritePlaceList.kakao_road_address_name}</span>
                <span class="place-address">${favoritePlaceList.kakao_phone}</span>
            </div>
        </div>
        <div class="button-container">
            <button class="delete-favoritePlace" data-star-id="${favoritePlaceList.star_id}">
                <img id="delete-favoritePlace" class="hoverable-star" src="${path}/img/star.png" alt="delete_place">
            </button>
        </div>
    </div>
</c:forEach>