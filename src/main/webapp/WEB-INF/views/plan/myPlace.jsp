<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>여행 계획 작성</title>
    <!-- 여행 프로젝트 제목 수정 기능 모달 부트스트랩 CSS-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #remoteCursor {
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: blue;
            border-radius: 50%;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<p style="margin-top:-12px"></p>
<div id="map" style="width:100%;height:350px;"></div>

<button>테스트 버튼</button>
<input type="text" placeholder="입력해보세요"/>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=966367b869ca03bbb23b1bd402ffe833"></script>
<%-- <script src="${pageContext.request.contextPath}/js/planWebSocket.js"></script> --%>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 10 // 지도의 확대 레벨
        };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
    if (navigator.geolocation) {

        // GeoLocation을 이용해서 접속 위치를 얻어옵니다
        navigator.geolocation.getCurrentPosition(function (position) {

            var lat = position.coords.latitude, // 위도
                lon = position.coords.longitude; // 경도

            var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

            // 마커와 인포윈도우를 표시합니다
            displayMarker(locPosition, message);

        });

    } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

        var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
            message = 'geolocation을 사용할수 없어요..'

        displayMarker(locPosition, message);
    }

    // 지도에 마커와 인포윈도우를 표시하는 함수입니다
    function displayMarker(locPosition, message) {

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: locPosition
        });

        var iwContent = message, // 인포윈도우에 표시할 내용
            iwRemoveable = true;

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: iwContent,
            removable: iwRemoveable
        });

        // 인포윈도우를 마커위에 표시합니다
        infowindow.open(map, marker);

        // 지도 중심좌표를 접속위치로 변경합니다
        map.setCenter(locPosition);
    }
</script>

<!-- 공개된 여행 계획 리스트 -->
<h2>공개된 여행 계획</h2>
<ul>
    <c:forEach var="plan" items="${plans}">
        <li>${plan.planName}</li>
    </c:forEach>
</ul>

<%-- 여행 프로젝트 제목 수정 기능 --%>
<h2>여행 제목 수정</h2>
<ul>
    <c:forEach var="plan" items="${plans}">
        <li>
            <span>${plan.planName}</span>
            <!-- 수정 버튼 -->
            <button type="button"
                    class="edit-btn"
                    data-bs-toggle="modal"
                    data-bs-target="#editModal"
                    data-id="${plan.planId}"
                    data-name="${plan.planName}">
                수정
            </button>
        </li>
    </c:forEach>
</ul>
<!-- 여행 프로젝트 제목 수정 모달 창 부트스트랩-->
<div class="modal fade" id="editModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="editModalLabel">여행 제목 수정</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editForm" method="post" action="/daengdong/plan/planName">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="currentPlanName" class="form-label">현재 여행 제목</label>
                        <input type="text" id="currentPlanName" class="form-control" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="newPlanName" class="form-label">새로운 여행 제목</label>
                        <input type="text" id="newPlanName" name="planName" class="form-control" placeholder="새 제목 입력">
                    </div>
                    <input type="hidden" name="planId" id="modalPlanId">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 여행 프로젝트 제목 수정 부트스트랩 및 jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    $(function () {
        // 모달이 표시되기 전에 데이터 채우기
        $('#editModal').on('show.bs.modal', function (event) {
            const button = $(event.relatedTarget); // 버튼
            const planId = button.data('id');
            const planName = button.data('name');

            // 모달에 데이터 설정
            $('#currentPlanName').val(planName);
            $('#modalPlanId').val(planId);
        });
    });
</script>

</body>
</html>