<%--
  Created by IntelliJ IDEA.
  User: ksy
  Date: 12/18/24
  Time: 2:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${path}/js/signUp.js"></script>

    <!-- DatePicker CSS (반려동물 추가 용도라면 필요에 따라 유지) -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css"
          integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <!-- 커스텀 CSS -->
    <link rel="stylesheet" href="${path}/css/signUp.css">
    <link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="sign-up-container">
    <!-- Left: Image Section -->
    <div class="sign-up-image">
        <img src="https://daengdong-bucket.s3.amazonaws.com/b0ddd4fa-dc52-4ec7-9da7-58d128b83378_464268698_938266368183079_4858682267198802677_n.jpg"
             alt="Signup Illustration" class="responsive-image">
    </div>

    <!-- Right: Form Section -->
    <div class="sign-up-form">
        <h4 id="sign-up-title" class="mb-3">회원가입</h4>
        <form class="validation-form" novalidate>
            <!-- 이름, 별명 -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="member_name" hidden="hidden">이름</label>
                    <input type="text" class="form-control" id="member_name" placeholder="이름" required>
                    <div class="invalid-feedback">
                        이름을 입력해주세요.
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="member_nickname" hidden="hidden">별명</label>
                    <input type="text" class="form-control" id="member_nickname" placeholder="별명">
                    <div class="invalid-feedback">
                        별명을 입력해주세요.
                    </div>
                </div>
            </div>

            <!-- 반려동물 추가 -->
            <h5 id="insert-pets-title" class="mt-4">🐶 반려 동물</h5>
            <div id="pets" class="row me-3"></div>
            <button type="button" class="btn btn-secondary" onclick="f_add_pet()">추가</button>
            <%@ include file="petCreateProfileModal.jsp" %>
            <hr class="mb-4">
            <div id="pets-detail">

            </div>

            <!-- 개인정보 수집 동의 -->
            <div class="custom-control custom-checkbox mb-3">
                <input type="checkbox" class="custom-control-input" id="aggrement" required>
                <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
            </div>

            <!-- 회원가입 버튼(녹색) -->
            <button type="submit" class="btn btn-primary btn-lg btn-block mt-3" id="btn-signup">회원가입</button>
        </form>
    </div>
</div>

<!-- 필요 시 JS 파일 -->
<script src="${path}/js/signUp.js"></script>
</body>
</html>