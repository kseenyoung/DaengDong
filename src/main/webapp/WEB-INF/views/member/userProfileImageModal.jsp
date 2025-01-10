<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/10/25
  Time: 09:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!-- edit-profile버튼 클릭 -> 유저 프로필사진 수정 모달 -->
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
                    <button id="profile-uploadButton" class="btn btn-primary" type="button" disabled style="display: none;">
                        <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>
                        <span role="status">저장</span>
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
