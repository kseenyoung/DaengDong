<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>WBS - 새로운 프로젝트 생성 기능</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<button id="btnCreatePlan">새로운 여행 계획 만들기</button>
<script>
$(function () {
    $("#btnCreatePlan").on("click", function () {
        window.location.href = "/daengdong/plan/create";
    });
});
</script>

</body>
</html>