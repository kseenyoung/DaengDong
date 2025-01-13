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
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<%--<link rel="stylesheet" href="${path}/css/member/profileFragment.css"/>--%>
<!-- jQuery 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS !!!-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${path}/css/member/followModal.css"/>

<%@ include file="userProfileImageModal.jsp" %>
<%@ include file="petProfileModal.jsp" %>
<div class="profile-header">
    <img id="my-image" class="profile-image" src="${selectMember.member_profile_photo}" alt="Profile Image">
    <div class="username-container">
        <h1 class="profile-username">${selectMember.member_nickname}</h1>
        <img id="view-edit-nickname" class="edit-icon"
             src="https://daengdong-bucket.s3.amazonaws.com/b3bb95b7-cc85-421c-9083-edcfa3855c75_edit.png"
             alt="editNickName" data-member-nickname="${selectMember.member_nickname}"/>
    </div>
    <p class="profile-id">${selectMember.member_name}</p>
    <input type="hidden" id="memberEmail" name="member_email" value="${selectMember.member_email}"/>
</div>

<%--이미지 클릭시 모달 닫기 버튼--%>
<%--<div id="imageModal" class="modalimg" onclick="closeModal()" >--%>
<%--    <img class="modalimg-content" id="modalImage">--%>
<%--</div>--%>

<%--edit-profile버튼--%>
<button id="edit-profile" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editNicknameModal">Edit
    Profile
</button>

<%--팔로우 팔로워 기능--%>
<div class="profile-follow-info">
    <span id="follower">${countFollower} followers</span> · <span id="following">${countFollowing} following</span>
</div>

<%--저장될 반려동물 이미지 정보등--%>
<%--todo: 반려동물 정보 수정--%>
<span id="my-pet">나의 반려동물</span>
<c:forEach items="${petList}" var="pet">
    <div class="profile-pet">
        <div class="pet-detail">
            <img
                    id="pet-image-${pet.pet_id}" class="pet-image"
                    src="${pet.pet_profile_photo}"
                    alt="Pet Picture"
                    data-pet-id="${pet.pet_id}"
                    data-name="${pet.pet_name}"
                    data-age="${pet.pet_age}"
                    data-species="${pet.pet_species}"
                    data-photo="${pet.pet_profile_photo}"
                    data-blood-type="${pet.pet_blood_type}"/>
            <span id="pet-name-${pet.pet_id}">${pet.pet_name}</span>
            <div class="popover">
                이름: ${pet.pet_name}<br>
                나이: ${pet.pet_age}살<br>
                견종: ${pet.pet_species}
            </div>
        </div>
    </div>
</c:forEach>

<script src="${path}/js/uploadFile.js"></script>