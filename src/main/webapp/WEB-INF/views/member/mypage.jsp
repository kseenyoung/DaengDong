<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 02:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      const path = "${pageContext.servletContext.contextPath}";
    </script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My page</title>
    <script src="${path}/js/mypage.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<div id="share-placeholder"></div>
<div class="grid-container">
    <!-- Left Section -->
    <aside id="left-section" class="profile-fragment">

    </aside>

    <!-- Right Section -->
    <div class="right-section">
        <!-- 상단 카테고리 -->
        <div class="categories">
            <ul>
                <li id="myTripFragment">내 여행</li>
                <li id="myPhotoCardFragment">포토카드</li>
                <li id="mySaveFragment">내 저장</li>
            </ul>
        </div>

        <!-- 아래 컨텐츠 -->
        <div id="content" class="content">
            <div id="semiCategories" class="semiCategories">
            </div>
            <div id="announcement-box">
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" href="${path}/css/member/mypage.css">
</body>
</html>