<%--
  Created by IntelliJ IDEA.
  User: ksy
  Date: 12/18/24
  Time: 2:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../common/header.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${path}/css/signUp.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker.min.css" integrity="sha512-34s5cpvaNG3BknEWSuOncX28vz97bRI59UnVtEEpFX536A7BtZSJHsDyFoCl8S7Dt2TPzcrCEoHBGeM4SUBDBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="${path}/js/signUp.js"></script>
</head>

<body>
<div class="container">
    <div class="input-form-backgroud row">
        <div class="input-form col-md-11 mx-auto">
            <h4 class="mb-3">회원가입</h4>
            <form class="validation-form" novalidate>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="name">이름</label>
                        <input type="text" class="form-control" id="name" placeholder="" value="" required>
                        <div class="invalid-feedback">
                            이름을 입력해주세요.
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="nickname">별명</label>
                        <input type="text" class="form-control" id="nickname" placeholder="" value="">
                        <div class="invalid-feedback">
                            별명을 입력해주세요.
                        </div>
                    </div>
                </div>
                <hr>
                <h5>🐶 반려 동물</h5>
                <div class="row me-3" id="pets">
                </div>
                <button class="d-block btn btn-secondary" onclick="f_add_pet()">추가</button>

                <hr class="mb-4">
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="aggrement" required>
                    <label class="custom-control-label" for="aggrement">개인정보 수집 및 이용에 동의합니다.</label>
                </div>
                <div class="mb-4"></div>
                <button class="btn btn-primary btn-lg btn-block" type="submit">회원가입</button>
            </form>
        </div>
    </div>
    <footer class="my-3 text-center text-small">
        <p class="mb-1">떡잎 방범대</p>
    </footer>
</div>
</body>

</html>
