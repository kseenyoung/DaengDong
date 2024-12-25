<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 02:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>

<div class="profile-header">
    <img class="profile-image" src="${path}/img/kseenyoungProfile.jpeg" alt="Profile Image">
    <h1 class="profile-username">userNickName</h1>
    <p class="profile-id">@memberId</p>
</div>
<button id="edit-profile">Edit profile</button>
<div class="profile-bio">
    <p>흰 천과 바람만 있다면 어디든 갈 수 있어</p>
</div>
<div class="profile-follow-info">
    <span>34 followers</span> · <span>49 following</span>
</div>
<h3>나의 반려동물</h3>
<div class="profile-pet">
    <div class="pet-detail">
        <img class="pet-image" src="${path}/img/daengdong_dog.jpeg" alt="Pet Picture">
        <span>쪼꼬미</span>
    </div>
    <div class="pet-detail">
        <img class="pet-image" src="${path}/img/daengdong_dog.jpeg" alt="Pet Picture">
        <span>쪼꼬미</span>
    </div>
</div>
