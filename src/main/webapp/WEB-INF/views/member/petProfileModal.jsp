<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/10/25
  Time: 09:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!-- 반려동물 정보 수정 모달 -->
<div class="modal fade" id="editPetModal" tabindex="-1" aria-labelledby="editPetModalLabel" aria-hidden="true">
    <div id="editPetDetailModal-dialog" class="modal-dialog">
        <div id="editPetDetailModal-content" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPetModalLabel">${petName} 정보 수정</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3 text-center">
                    <!-- 이미지 클릭 시 파일 선택 트리거 -->
                    <img id="currentPetPhoto" src="" alt="Pet Photo" class="img-thumbnail" style="max-width: 200px; cursor: pointer">
                    <div class="custom-profile-container" style="display: none;">
                        <label for="petFile" class="custom-profile-label">사진 선택하기</label>
                        <input type="file" id="petFile" name="file" class="custom-profile-input" onchange="petProfilePreviewImage(this)">
                    </div>
                </div>
                <form id="editPetForm">
                    <input id="petId" name="pet_id" hidden="hidden" class="form-control" value=""/>
                    <div class="mb-3">
                        <label for="petName" class="form-label">이름</label>
                        <input type="text" id="petName" name="pet_name" class="form-control" value="">
                    </div>
                    <div class="mb-3">
                        <label for="petAge" class="form-label">나이</label>
                        <input type="number" id="petAge" name="pet_age" class="form-control" value="" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="petSpecies" class="form-label">견종</label>
                        <div class="mb-3">
                            <input type="text" id="petSpecies" name="pet_species" class="form-control"
                                   value="${petSpecies}" placeholder="견종을 입력하거나 선택하세요" readonly>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="petBloodType" class="form-label">혈액형</label>
                        <div class="form-group">
                            <select class="form-control" id="petBloodType" name="pet_blood_type">
                                <option value="DEA-1" <c:if test="${petBloodType == 'DEA-1'}">selected</c:if>>DEA-1</option>
                                <option value="DEA1.1" <c:if test="${petBloodType == 'DEA1.1'}">selected</c:if>>DEA1.1</option>
                                <option value="DEA1.2" <c:if test="${petBloodType == 'DEA1.2'}">selected</c:if>>DEA1.2</option>
                                <option value="DEA3" <c:if test="${petBloodType == 'DEA3'}">selected</c:if>>DEA3</option>
                                <option value="DEA4" <c:if test="${petBloodType == 'DEA4'}">selected</c:if>>DEA4</option>
                                <option value="DEA5" <c:if test="${petBloodType == 'DEA5'}">selected</c:if>>DEA5</option>
                                <option value="DEA6" <c:if test="${petBloodType == 'DEA6'}">selected</c:if>>DEA6</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="confirm-update-petDetail" type="button" class="btn btn-primary">저장
                </button>
                <button id="uploadButton" class="btn btn-primary" type="button" disabled style="display: none;">
                    <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>
                    <span role="status">저장</span>
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>