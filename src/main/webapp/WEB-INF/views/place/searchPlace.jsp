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
  <link rel="stylesheet" href="${path}/css/plan/addCompanion.css">
  <link rel="stylesheet" href="${path}/css/plan/searchPlace.css">
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

<div id="myModal" class="modal">
  <div class="info-modal-content">
    <span class="close">&times;</span>
    <iframe id="modalIframe" style="width: 100%; height: 80vh; border: none;"></iframe>
  </div>
</div>

<div id="planModal">
  <div class="modal-content">
    <h3>Plan 선택</h3>
    <div id="planList">
    </div>
    <button id="selectPlanBtn">확인</button>
    <button id="closeModalBtn">닫기</button>
  </div>
</div>

<div id="sidebar"></div>

<div id="sidebar-template" style="display: none;">
  <button id="closeSidebar" class="close-btn">✖</button>
  <h4 id="place-title" class="sidebar-title"></h4>
  <button id = "favoriteBtn" class="favoriteBtn">⭐</button>
  <div class="divider"></div>
  <div class="content-container">
  <p class="sidebar-info"><strong>카테고리</strong> <br> <span id="place-category_name"></span></p>
  <p class="sidebar-info"><strong>도로명주소</strong> <br> <span id="place-road_address_name"></span></p>
  <p class="sidebar-info"><strong>주소</strong> <br> <span id="place-address_name"></span></p>
  <p class="sidebar-info"><strong>전화번호</strong> <br> <span id="place-phone"></span></p>
  <button id = "addPlanBtn" class="add-btn button">+ 내 일정에 추가</button>
  <a id="map-link" href="#" target="_blank" class="map-link button">자세히 보기</a>
  </div>
</div>
<div class="map_wrap">
  <div id="map"></div>
  <!-- 채팅방 접속하기 버튼 -->
  <button id="btnChat" class="btn btn-primary position-relative">
    <i id="chat-icon" class="bi bi-chat-fill"></i> <!-- 채워진 대화 아이콘 -->
    <span id="unreadBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="display: none;">
    ●
  </span>
  </button>
  <!-- 채팅 모달 -->
  <div id="chatModal" class="chat-modal">
    <div id="chatContent"></div>
    <button id="closeChatModal" class="close-btn">✖</button>
  </div>
  <div id = "mainBtn">
      <button id = "pinbutton" onclick="deleteAllPins()">핀 일괄 삭제하기</button>
      <button id="finalizePlanBtn">여정 저장하기</button>
  </div>
  <div id="menu_wrap" class="bg_white">
    <button id="closeMenu" class="close-btn">✖</button>
    <div class="option">
        <div>
            <form onsubmit="searchPlaces(); return false;">
                <input type="text" value="" id="keyword" size="80" class="search-input" >
                <button type="submit">검색하기</button>
            </form>
        </div>
    </div>
    <hr>
        <div class="container">
           <!--<div id="category-container">
               <ul id="category">
                   <li id="BK9" data-order="0">
                       <span class="category_bg bank"></span>
                       은행
                   </li>
                   <li id="MT1" data-order="1">
                       <span class="category_bg mart"></span>
                       마트
                   </li>
                   <li id="PM9" data-order="2">
                       <span class="category_bg pharmacy"></span>
                       약국
                   </li>
                   <li id="OL7" data-order="3">
                       <span class="category_bg oil"></span>
                       주유소
                   </li>
                   <li id="CE7" data-order="4">
                       <span class="category_bg cafe"></span>
                       카페
                   </li>
                   <li id="CS2" data-order="5">
                       <span class="category_bg store"></span>
                       편의점
                   </li>
               </ul>
           </div>-->
           <ul id="placesList"></ul>
           <div id="pagination"></div>
        </div>
    </div>
</div>


<div id="list_wrap">
  <p>펫과 함께 하는</p>
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
<!-- 카카오맵 SDK -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62bd6cc1e013b8a659ae61760dc9fd7f&libraries=services"></script>


<!-- 아래 스크립트: 실제 동작 코드 -->
<script src="${path}/js/searchPlace_app.js"></script>
<script src="${path}/js/addCompanion.js"></script>
<%-- <script src="${path}/js/finalSend.js"></script> --%>

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


    document.addEventListener("DOMContentLoaded", () => {
        document.body.addEventListener("click", (event) => {
            if (event.target.classList.contains("favoriteBtn") && !event.target.classList.contains("favorited")) {
                addFavorite(event.target); // 즐겨찾기 추가 처리
            }
        });

        // 이벤트 위임: 즐겨찾기 삭제
        document.body.addEventListener("click", (event) => {
            if (event.target.classList.contains("favoriteBtn") && event.target.classList.contains("favorited")) {
                deleteFavorite(event.target); // 즐겨찾기 삭제 처리
            }
        });
    });
    const stars = {};
    // 즐겨찾기 추가 처리 함수
    function addFavorite(button) {
        console.log("즐겨찾기버튼눌림");
        const placeId = button.dataset.id;
        console.log("placeId:" + placeId);
        fetch("${path}/auth/favorite/add", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ "kakao_place_id": placeId })
        })
        .then(response => {
            if (!response.ok) throw new Error("HTTP error " + response.status);
            return response.text();
        })
        .then(data => {
            alert("즐겨찾기에 추가되었습니다!"); // 성공 메시지 출력
            stars[placeId] = data.star_id;
            button.setAttribute("data-starid", data.star_id);
            button.classList.add("favorited");
            console.log("star_id 저장 완료:", data.star_id);
        })
        .catch(err => {
            console.error("Add favorite error:", err);
            alert("즐겨찾기 추가 중 오류가 발생했습니다.");
        });
    }

    // 즐겨찾기 삭제 처리 함수
    function deleteFavorite(button) {
        const placeId = button.dataset.id;
        const starId = stars[placeId];

        console.log("삭제할 starId:" + starId);
        fetch("${path}/auth/favorite/delete", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ star_id: starId })
        })
        .then(response => {
            if (!response.ok) throw new Error("HTTP error " + response.status);
            return response.text();
        })
        .then(message => {
            delete stars[placeId];
            button.classList.remove("favorited"); // 즐겨찾기 상태 제거
            button.removeAttribute("data-starid");
            alert("즐겨찾기가 해제되었습니다!"); // 성공 메시지 출력
       })
        .catch(err => {
            console.error("Delete favorite error:", err);
            alert("즐겨찾기 삭제 중 오류가 발생했습니다.");
        });
    }
</script>
</body>
</html>