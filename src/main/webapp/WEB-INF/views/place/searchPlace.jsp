<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>장소검색</title>

    <!-- JavaScript 라이브러리 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- CSS파일 -->
    <link rel="stylesheet" href="${path}/css/header.css">
    <%-- <link rel="stylesheet" href="${path}/css/plan/addCompanion.css"> --%>
    <%-- <link rel="stylesheet" href="${path}/css/plan/searchPlace.css"> --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- 외부 JSP 파일 -->
    <%@ include file="/WEB-INF/views/member/header.jsp" %>

    <!-- 채팅 기능 -->
    <script src="${path}/js/chat/chat.js"></script>

    <!-- 세션에서 값 가져오기 -->
    <script>
        const path = "${pageContext.servletContext.contextPath}";
        const memberEmail = "${sessionScope.member.member_email}";
        const memberName = "${sessionScope.member.member_name}";
        const memberNickname = "${sessionScope.member.member_nickname}";
        const profilePhoto = "${sessionScope.member.member_profile_photo}";
        const currentPlanId = "${sessionScope.currentPlanId}";

        console.log("세션에서 가져온 currentPlanId:", currentPlanId);
        // 필요한 경우: 호스트인지 동행자인지 구분도 세션에서 가져와서 isHost = true/false 로 쓸 수 있음.
    </script>

</head>
<body>

<!-- 모달/사이드바 등 HTML 구조는 그대로 -->
<div id="myModal" class="modal">
    <!-- ... -->
</div>

<div id="planModal">
    <!-- ... -->
</div>

<div id="sidebar"></div>
<div id="sidebar-template" style="display: none;">
    <!-- ... -->
</div>

<div class="map_wrap">
    <div id="map" style="top:60px;left:450px;width:70%;height:65%;position:relative;overflow:hidden;"></div>
    <!-- 채팅방 접속하기 버튼 -->
    <button id="btnChat" class="btn btn-primary position-relative">
        <i id="chat-icon" class="bi bi-chat-fill"></i>
        <span id="unreadBadge" style="display: none;">●</span>
    </button>
    <div id="chatModal" class="chat-modal">
        <div id="chatContent"></div>
        <button id="closeChatModal" class="close-btn">✖</button>
    </div>
    <button id="pinbutton" onclick="deleteAllPins()">핀 일괄 삭제하기</button>

    <div id="menu_wrap" class="bg_white">
        <button id="closeMenu" class="close-btn">✖</button>
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    <input type="text" value="홍대 맛집" id="keyword" size="80" class="search-input">
                    <button type="submit">검색하기</button>
                </form>
            </div>
        </div>
        <hr>
        <div class="container">
            <div id="category-container">
                <ul id="category">
                    <!-- 카테고리들 -->
                    <li id="BK9" data-order="0">은행</li>
                    <li id="MT1" data-order="1">마트</li>
                    <li id="PM9" data-order="2">약국</li>
                    <li id="OL7" data-order="3">주유소</li>
                    <li id="CE7" data-order="4">카페</li>
                    <li id="CS2" data-order="5">편의점</li>
                </ul>
            </div>
            <ul id="placesList"></ul>
            <div id="pagination"></div>
        </div>
    </div>
</div>

<div id="list_wrap">
    <div id="planTitle"></div>
    <div id="mainControls">
        <button id="showDays">일정</button>
        <button id="showCompanion">동행자</button>
    </div>

    <!-- 동행자 섹션 -->
    <div id="companionSection">
        <h2>동행자 관리</h2>
        <div id="together">
            <button id="openCompanionModalBtn">+</button>
        </div>
        <ul id="companionList"></ul>
    </div>

    <!-- 동행자 추가 모달 -->
    <div id="companionModal" class="modal">
        <div class="modal-content">
            <!-- 닫기버튼 -->
            <button id="closeCompanionModalBtn">닫기</button>

            <h3>동행자 추가</h3>
            <input type="email" id="companionEmail" placeholder="동행자 이메일 직접 입력" />

            <h4>팔로잉 목록</h4>
            <ul id="followingList"></ul>

            <h4>팔로워 목록</h4>
            <ul id="followerList"></ul>

            <button id="submitCompanionsBtn">동행자 등록</button>
        </div>
    </div>

    <div id="daysSection">
        <div id="day"></div>
        <div class="button">
            <button id="addPlaceBtn">장소 추가</button>
            <div class="line"></div>
        </div>
        <ul id="placeList"></ul>
    </div>
</div>

<div>
    <button id="finalizePlanBtn">최종 완료</button>
</div>

<!-- 카카오맵 SDK -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62bd6cc1e013b8a659ae61760dc9fd7f&libraries=services"></script>

<!-- 아래 스크립트: 실제 동작 코드 -->
<script src="/daengdong/js/searchPlace_app.js"></script>
<script src="/daengdong/js/addCompanion.js"></script>
<%-- <script src="/daengdong/js/finalSend.js"></script> --%>

<script>
    // planId를 서버에서도 받을 수 있지만, 세션이 없다면 URL path에서 추출
    let planId = '<%= session.getAttribute("currentPlanId") %>';
    if(!planId) {
        // 만약 JSP 세션에 없다면, fallback
        planId = window.location.pathname.split("/").filter(Boolean).pop();
    }
    console.log("최종 planId:", planId);

    // JS 전역변수에 할당해서 searchPlace_app.js에서 사용
    window.G_planId = planId;

    const userEmail = "${memberEmail}";
    console.log("Logged-in user email:", userEmail);
    window.G_userEmail = userEmail;
</script>

</body>
</html>