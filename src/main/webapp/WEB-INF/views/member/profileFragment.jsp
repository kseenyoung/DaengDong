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

<!-- edit-profile버튼 클릭 -> 닉네임 수정 모달 -->
<div class="modal fade" id="editNicknameModal" tabindex="-1" aria-labelledby="editNicknameModalLabel"
     aria-hidden="true">
    <div id="editNicknameModal-dialog" class="modal-dialog">
        <div id="editNicknameModal-modal-content" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editNicknameModalLabel">프로필 사진 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editNicknameForm" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="currentPhoto" class="form-label">현재 프로필 이미지</label>
                        <div id="currentPhotoContainer">
                            <img id="currentPhoto" src="${selectMember.member_profile_photo}"
                                 alt="Current Profile Image" class="img-thumbnail">
                        </div>
                    </div>
                    <div class="custom-profile-container">
                        <label for="file" class="custom-profile-label">사진 선택하기</label>
                        <input type="file" id="file" name="file" class="custom-profile-input"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="confirm-update-profile" class="btn btn-primary"
                            onclick="uploadFile(`${path}`)">저장
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

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
<span id="my-pet">나의 반려동물</span>
<c:forEach items="${petList}" var="petList">
    <div class="profile-pet">
        <div class="pet-detail">
            <img class="pet-image" src="${path}/img/${petList.pet_profile_photo}" alt="Pet Picture">
            <span>${petList.pet_name}</span>
            <div class="popover">이름: ${petList.pet_name}<br>나이: ${petList.pet_age}살<br>견종: ${petList.pet_species}</div>
        </div>
    </div>
</c:forEach>

<script src="${path}/js/uploadFile.js"></script>


<%--모달이미지 등 닉네임 수정할 scirpt--%>
<%--<script>--%>
<%--  // 이미지 확대--%>
<%--  function showModal(imgElement) {--%>
<%--    const modal = document.getElementById("imageModal");--%>
<%--    const modalImg = document.getElementById("modalImage");--%>
<%--    modalImg.src = imgElement.src;--%>
<%--    modal.style.display = "flex";--%>
<%--  }--%>

<%--  //확대된 이미지 닫기 모달 버튼모양--%>
<%--  function closeModal() {--%>
<%--    const modal = document.getElementById("imageModal");--%>
<%--    modal.style.display = "none";--%>
<%--  }--%>

<%--  //닉네임 수정하는 ajax--%>
<%--  $(document).ready(function () {--%>
<%--    // 닉네임 수정 폼 제출 처리--%>
<%--    $("#editNicknameForm").off("submit").on("submit", function (event) {--%>
<%--      event.preventDefault();--%>

<%--      const newNickname = $("#newNickname").val();--%>
<%--      const memberEmail = $("#memberEmail").val();--%>

<%--      if (newNickname.trim() === "") {--%>
<%--        alert("닉네임을 입력해주세요.");--%>
<%--        return;--%>
<%--      }--%>

<%--      // AJAX 요청--%>
<%--      $.ajax({--%>
<%--        url: `${path}/auth/modifyNickname.do`,--%>
<%--        type: "POST",--%>
<%--        contentType: "application/json",--%>
<%--        data: JSON.stringify({--%>
<%--          member_email: memberEmail,--%>
<%--          member_nickname: newNickname--%>
<%--        }),--%>
<%--        success: function (response) {--%>
<%--          alert("닉네임이 성공적으로 변경되었습니다!");--%>
<%--          $(".profile-username").text(newNickname);--%>

<%--          // 모달 닫기--%>
<%--          const modal = bootstrap.Modal.getInstance(document.getElementById('editNicknameModal'));--%>
<%--          if (modal) {--%>
<%--            modal.hide();--%>

<%--            // backdrop 제거는 모달이 완전히 닫힌 후에 실행--%>
<%--            $('#editNicknameModal').one('hidden.bs.modal', function () {--%>
<%--              $('.modal-backdrop').remove();--%>
<%--              $('body').removeClass('modal-open');--%>
<%--            });--%>
<%--          }--%>
<%--        },--%>
<%--        error: function (err) {--%>
<%--          console.error("닉네임 변경 중 오류가 발생했습니다.", err);--%>
<%--          alert("닉네임 변경 중 오류가 발생했습니다.");--%>
<%--        }--%>
<%--      });--%>
<%--    });--%>
<%--    $('#editNicknameModal').on('shown.bs.modal', function () {--%>
<%--      $('#newNickname').val('').focus();--%>
<%--    });--%>
<%--  });--%>
<%--</script>--%>
