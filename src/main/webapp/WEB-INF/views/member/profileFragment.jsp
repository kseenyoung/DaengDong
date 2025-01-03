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
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${path}/css/member/followModal.css"/>


<div class="profile-header">
    <img class="profile-image" src="${path}/img/kseenyoungProfile.jpeg" alt="Profile Image" onclick="showModal(this)">
    <h1 class="profile-username">${selectMember.member_nickname}</h1>
    <p class="profile-id">${selectMember.member_name}</p>
    <input type="hidden" id="memberEmail" name="member_email" value="${selectMember.member_email}" />
</div>

<%--이미지 클릭시 모달 닫기 버튼--%>
<%--<div id="imageModal" class="modalimg" onclick="closeModal()" >--%>
<%--    <img class="modalimg-content" id="modalImage">--%>
<%--</div>--%>

<%--edit-profile버튼--%>
<button id="edit-profile" class="btn btn-primary" data-toggle="modal" data-target="#editNicknameModal">Edit Profile</button>

<!-- edit-profile버튼 클릭 ->  닉네임 수정 모달 -->
<div class="modal fade" id="editNicknameModal" tabindex="-1" aria-labelledby="editNicknameModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <%--Model Header--%>
            <div class="modal-header">
                <h5 class="modal-title" id="editNicknameModalLabel">닉네임 수정</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <%--Model body--%>
                <form id="editNicknameForm">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="currentNickname" class="form-label">닉네임</label>
                        <input type="text" id="currentNickname" class="form-control" value="${selectMember.member_nickname}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="newNickname" class="form-label">새로운 닉네임</label>
                        <input type="text" id="newNickname" class="form-control" placeholder="새 닉네임 입력" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">저장</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" aria-label="Close">취소</button>
                </div>
                </form>
        </div>
    </div>
</div>

<%--팔로우 팔로워 기능--%>
<div class="profile-follow-info">
    <span id="follower">34 followers</span> · <span id="following">49 following</span>
</div>

<%--저장될 반려동물 이미지 정보등--%>
<span id="my-pet">나의 반려동물</span>
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

<%--모달이미지 등 닉네임 수정할 scirpt--%>
<script>
    // 이미지 확대
    function showModal(imgElement) {
        const modal = document.getElementById("imageModal");
        const modalImg = document.getElementById("modalImage");
        modalImg.src = imgElement.src;
        modal.style.display = "flex";
    }
    //확대된 이미지 닫기 모달 버튼모양
    function closeModal() {
        const modal = document.getElementById("imageModal");
        modal.style.display = "none";
    }

    //닉네임 수정하는 ajax
    $(document).ready(function () {
        // 닉네임 수정 폼 제출 처리
        $("#editNicknameForm").on("submit", function (event) {
            event.preventDefault();

            const newNickname = $("#newNickname").val();
            const memberEmail = $("#memberEmail").val();

            if (newNickname.trim() === "") {
                alert("닉네임을 입력해주세요.");
                return;
            }

            // AJAX 요청
            $.ajax({
                url: `${path}/auth/modifyNickname.do`,
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({
                    member_email: memberEmail,
                    member_nickname: newNickname
                }),
                success: function (response) {
                    alert("닉네임이 성공적으로 변경되었습니다!");
                    $(".profile-username").text(newNickname); // 화면에 새로운 닉네임 반영
                    $("#editNicknameModal").modal("hide"); // 모달 닫기

                    $('#editNicknameModal').on('hidden.bs.modal', function () {
                        $('.modal-backdrop').remove(); // 백드롭 제거
                        $(this).removeData('bs.modal'); // 모달 데이터 초기화
                    });



                },
                error: function (err) {
                    console.error("닉네임 변경 중 오류가 발생했습니다.", err);
                    alert("닉네임 변경 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
