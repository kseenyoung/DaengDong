<!DOCTYPE html>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

  <%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <meta charset="utf-8">
  <title>장소검색</title>

  <!-- JavaScript 라이브러리 -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

  <!-- CSS파일 -->
  <link rel="stylesheet" href="/daengdong/css/header.css">
  <link rel="stylesheet" href="/daengdong/css/plan/addCompanion.css">
  <link rel="stylesheet" href="/daengdong/css/plan/searchPlace.css">

  <!-- 외부 JSP 파일 -->
  <%@ include file="/WEB-INF/views/member/header.jsp" %>

</head>
<body>

<div id="myModal" class="modal">
  <div class="modal-content">
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
  <div id="map" style="top:60px;left:450px;width:70%;height:65%;position:relative;overflow:hidden;"></div>
  <!-- 채팅방 접속하기 버튼 -->
  <button id="btnChat">채팅방 접속하기</button>
  <!--<button id = "pinbutton" onclick="deleteAllPins()">핀 일괄 삭제하기</button>-->
  <div id="menu_wrap" class="bg_white">
    <button id="closeMenu" class="close-btn">✖</button>
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    <input type="text" value="홍대 맛집" id="keyword" size="80" class="search-input" >
                    <button type="submit">검색하기</button>
                </form>
            </div>
        </div>
        <hr>
       <div class="container">
           <div id="category-container">
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
      <!-- "+" 버튼 (모달 열기) -->
      <button id="openCompanionModalBtn">+</button>
    </div>

    <%-- 화면공유 --%>
    <%-- <div id="shareMapContainer" style="position: relative;">
      <div id="shareMap" style="width: 100%; height: 400px;"></div>
      <button id="shareScreenBtn" style="position: absolute; bottom: 10px; right: 10px; z-index: 1000;">
        화면 공유
      </button>
    </div> --%>

    <!-- 동행자 리스트 -->
    <ul id="companionList"></ul>

  </div>

  <!-- 동행자 추가 모달 -->
  <div id="companionModal" class="modal">
    <div class="modal-content">
      <!-- 모달 닫기 버튼 -->
      <span id="closeCompanionModalBtn" class="close">&times;</span>

      <h3>동행자 추가</h3>

      <!-- 동행자 추가 폼 -->
      <form id="companionForm">
        <label for="companionEmail">동행자 이메일:</label>
        <input type="email" id="companionEmail" name="companionEmail" placeholder="example@domain.com" required>
        <button type="submit" id="addCompanionBtn">추가</button>
      </form>

      <!-- 동행자 제출 버튼 -->
      <button id="submitCompanionsBtn">동행자 제출</button>
    </div>
  </div>

  <div id="daysSection">
    <div id="day">
    </div>
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
<%-- <script> --%>
<%--   const planId = "<%= session.getAttribute("planId") %>"; --%>
<%--   console.log("planId : ", planId); --%>
<%--   const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:'; --%>
<%--   const host = window.location.host; --%>
<%--   const webSocketUrl = protocol + '//' + host + '/daengdong/shareMap-ws?planId=' + planId; --%>

<%--   const webSocket = new WebSocket(webSocketUrl); --%>
<%-- </script> --%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=62bd6cc1e013b8a659ae61760dc9fd7f&libraries=services"></script>
<script>
  // 마커를 담을 배열입니다
  var markers = [];


    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places();

    // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({zIndex:1});

    // 키워드로 장소를 검색합니다
    searchPlaces();

    var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
    var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
    var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
    var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
    var dots = {};
    var markerPositions = [];
    var line;

    // 키워드 검색을 요청하는 함수입니다
    function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB);
  }
  // 장소검색이 완료됐을 때 호출되는 콜백함수
  function placesSearchCB(data, status, pagination) {
    console.log("data: ", data);
    if (status === kakao.maps.services.Status.OK) {

      // 정상적으로 검색이 완료됐으면
      // 검색 목록과 마커를 표출합니다
      displayPlaces(data);

      // 페이지 번호를 표출합니다
      displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

      alert('검색 결과가 존재하지 않습니다.');
      return;

    } else if (status === kakao.maps.services.Status.ERROR) {

      alert('검색 결과 중 오류가 발생했습니다.');
      return;

    }
  }

  // 검색 결과 목록과 마커를 표출하는 함수입니다
  function displayPlaces(places) {
    var listEl = document.getElementById('placesList'),
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds();

    // 검색 결과 목록 초기화
    removeAllChildNods(listEl);

    for (var i = 0; i < places.length; i++) {
      var place = places[i];

      var placePosition = new kakao.maps.LatLng(place.y, place.x),
          marker = addMarker(placePosition, i, place.place_name, place);

      var itemEl = document.createElement("li");
      itemEl.classList.add("place-item");

      var titleEl = document.createElement("h4");
      titleEl.textContent = place.place_name || "정보 없음";

      titleEl.setAttribute("data-place-x", place.x);
      titleEl.setAttribute("data-place-y", place.y);
      itemEl.appendChild(titleEl);

      var addressEl = document.createElement("p");
      addressEl.textContent = place.address_name || "주소 없음";
      itemEl.appendChild(addressEl);

      // 버튼 생성 및 추가
      var button = document.createElement("button");
      button.className = "add-btn";
      button.textContent = "+ 내 일정에 추가";

      // `data-*` 속성에 장소 이름과 주소 저장
      button.setAttribute("data-place-name", place.place_name);
      button.setAttribute("data-place-address", place.address_name);
      button.setAttribute("data-place-phone", place.phone);
      button.setAttribute("data-place-x", place.x);
      button.setAttribute("data-place-y", place.y);
      button.setAttribute("data-place-url", place.place_url);
      button.setAttribute("data-id", place.id);

      //button.setA

            itemEl.appendChild(button);
            fragment.appendChild(itemEl);

            bounds.extend(placePosition);

        // 마커 이벤트 설정
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function () {
                displayInfowindow(marker, title);
            });
            kakao.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
            });
        })(marker, place.place_name);
    }

    // 검색 결과를 목록에 추가
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    map.setBounds(bounds);
}
    function addPlaceAndSave(eventTarget) {
        const placeName = eventTarget.getAttribute("data-place-name");
        const placeAddress = eventTarget.getAttribute("data-place-address");
        const placePhone = eventTarget.getAttribute("data-place-phone");
        const xValue = parseFloat(eventTarget.getAttribute("data-place-x"));
        const yValue = parseFloat(eventTarget.getAttribute("data-place-y"));
        const placeURL = eventTarget.getAttribute("data-place-url");
        const id = eventTarget.getAttribute("data-id");
        const selectedDay = document.querySelector(".day-btn.selected")?.getAttribute("data-day");

        const regionId = placeAddress.split(" ")[0]; // '서울', '경기' 등 추출
        const place = {
            kakaoPlaceName: placeName,
            kakaoRoadAddressName: placeAddress,
            kakaoPhone: placePhone,
            kakaoX: xValue,
            kakaoY: yValue,
            kakaoPlaceUrl: placeURL,
            kakaoPlaceId: id,
            regionId: regionId
        };

        const final_place = {
            planId: planId,
            kakaoPlaceId: id,
            day: selectedDay
        };

        // 로컬 메모리에 저장
        tempMemoryPlaces.push(final_place);
        console.log("tempMemoryPlaces: ", tempMemoryPlaces);

        // 마커 생성
        const placePosition = new kakao.maps.LatLng(yValue, xValue);
        addCustomMarker(placePosition, placeName);

        // 일정에 장소 추가
        addPlaceToPlan(placeName, placeAddress);

        // 서버에 장소 데이터 저장
        fetch('/daengdong/place/savePlace', {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(place)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Failed to save place");
                }
                return response.text();
            })
            .catch(error => {
                console.error("Error:", error);
            });

        // 웹소켓으로 데이터 전송
        webSocket.send(JSON.stringify({
            type: "shareMap",
            data: place
        }));

        alert("장소가 공유되었습니다!");
    }
// 동적으로 생성된 버튼
document.addEventListener("click", function (event) {
    if (event.target && event.target.classList.contains("add-btn")) {
        addPlaceAndSave(event.target);
    }
});

  // 검색결과 항목을 Element로 반환하는 함수입니다
  function getListItem(index, places) {

    var el = document.createElement('li'),
        itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
            '<div class="info">' +
            '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
      itemStr += '    <span>' + places.road_address_name + '</span>' +
          '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
      itemStr += '    <span>' +  places.address_name  + '</span>';
    }

    itemStr += '  <span class="tel">' + places.phone  + '</span>' +
        '</div>';

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
  }

var customMarkers = [];

function addCustomMarker(position, title) {
    var imageSrc = '<%= request.getContextPath() %>/img/red_marker.png';

    var imageSize = new kakao.maps.Size(24, 35); // 마커 이미지 크기
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    // 마커 생성
    var customMarker = new kakao.maps.Marker({
        position: position,
        image: markerImage,
        map: map
    });

    customMarkers.push({ customMarker, title });

    // 마커에 제목 저장
    kakao.maps.event.addListener(customMarker, 'mouseover', function () {
        displayInfowindow(customMarker, title);
    });
    kakao.maps.event.addListener(customMarker, 'mouseout', function () {
        infowindow.close();
    });
    // 좌표를 배열에 저장
    markerPositions.push(position);

    // 폴리라인 업데이트
    updatePolyline();

    // 거리와 시간 표시 업데이트
    updateDistanceAndTime();
    return customMarker;
}
function removeCustomMarker(title) {
    for (var i = 0; i < customMarkers.length; i++) {
        if (customMarkers[i].title === title) {
            customMarkers[i].customMarker.setMap(null);
            customMarkers.splice(i, 1);
            break;
        }
    }
}

markerPositions.forEach((position, index) => {
    console.log(`Position ${index}:`, position);
    if (!(position instanceof kakao.maps.LatLng)) {
        console.error(`Position ${index} is not a valid LatLng object.`);
    }
});


function updatePolyline() {
    if (line) {
        line.setMap(null);
    }

    if (markerPositions.length < 2){
        console.error("Insufficient positions to create a polyline");
        return;
    }

    // Polyline 생성
    const polylinePath = markerPositions.map(pos => new kakao.maps.LatLng(pos.Ma, pos.La));
    line = new kakao.maps.Polyline({
        map: map,
        path: polylinePath,
        strokeWeight: 3,
        strokeColor: '#db4040',
        strokeOpacity: 1,
        strokeStyle: 'solid'
    });
    console.log("Polyline created with path:", line.getPath());
    console.log("Polyline Length:", line.getLength());
}
function updateDistanceAndTime() {
    if (markerPositions.length < 2) {
        if (distanceOverlay) {
            distanceOverlay.setMap(null); // Overlay 숨김
            distanceOverlay = null;
        }
        return;
    }

    var totalDistance = Math.round(line.getLength());

    // 도보와 자전거 시간 계산
    var walkTime = Math.floor(totalDistance / 67); // 도보 시간 (67m/min)
    var bikeTime = Math.floor(totalDistance / 227); // 자전거 시간 (227m/min)

    var content =
        '<ul class="dotOverlay distanceInfo">' +
            '<li><span class="label">총거리</span><span class="number">' + totalDistance + '</span>m</li>' +
            '<li><span class="label">도보</span>' + Math.floor(walkTime / 60) + '시간 ' + (walkTime % 60) + '분</li>' +
            '<li><span class="label">자전거</span>' + Math.floor(bikeTime / 60) + '시간 ' + (bikeTime % 60) + '분</li>' +
        '</ul>';


    // 거리 정보를 표시할 커스텀 오버레이 생성 또는 업데이트
    if (!distanceOverlay) {
        distanceOverlay = new kakao.maps.CustomOverlay({
            map: map,
            position: markerPositions[markerPositions.length - 1], // 마지막 마커 위치
            content: content,
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3
        });
    } else {
        distanceOverlay.setContent(content);
        distanceOverlay.setPosition(markerPositions[markerPositions.length - 1]); // 마지막 마커 위치로 이동
        distanceOverlay.setMap(map);
    }
}
function removeCustomMarker(title) {
    var markerIndex = customMarkers.findIndex(marker => marker.title === title);
    if (markerIndex !== -1) {
        customMarkers[markerIndex].customMarker.setMap(null);
        markerPositions.splice(markerIndex, 1);
        customMarkers.splice(markerIndex, 1);

        updatePolyline();
        updateDistanceAndTime();
    }
}

    function addMarker(position, idx, title, place) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
            imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
            imgOptions =  {
                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

    marker.setMap(map);
    markers.push(marker);

    // 마커에 클릭 이벤트 등록
    kakao.maps.event.addListener(marker, 'click', function () {
      const sidebar = document.getElementById("sidebar");
      const template = document.getElementById("sidebar-template");

      // 템플릿 내용을 복사하여 삽입
      sidebar.innerHTML = template.innerHTML;

      console.log(place);

      // 템플릿 내부 요소에 데이터 삽입
      sidebar.querySelector("#place-title").textContent = place.place_name || "정보 없음";
      sidebar.querySelector("#place-category_name").textContent = place.category_name || "정보 없음";
      sidebar.querySelector("#place-road_address_name").textContent = place.road_address_name || "도로명 주소 없음";
      sidebar.querySelector("#place-address_name").textContent = place.address_name || "주소 없음";
      sidebar.querySelector("#place-phone").textContent = place.phone || "전화번호 없음";



      // 링크 업데이트 및 모달로 URL 표시
      let mapLink = sidebar.querySelector("#map-link");
      let placeUrl = place && place.place_url; // 안전한 참조

      // 모달 DOM 요소 가져오기
      const modal = document.getElementById("myModal");
      const modalIframe = document.getElementById("modalIframe");
      const closeModalBtn = document.querySelector(".close");

      if (placeUrl) {
        // 링크 클릭 시 모달 열기
        mapLink.href = "#"; // 기존 링크 기능 제거
        mapLink.addEventListener("click", function (e) {
          e.preventDefault(); // 기본 링크 동작 방지

          // 모달에 URL 로드
          modalIframe.src = placeUrl;

          // 모달 열기
          modal.style.display = "block";
        });
      } else {
        mapLink.style.display = "none"; // 유효한 URL이 없으면 링크 숨기기
      }

      // 모달 닫기 버튼 이벤트 등록
      closeModalBtn.addEventListener("click", function () {
        modal.style.display = "none";
        modalIframe.src = ""; // 모달 닫힐 때 iframe 초기화
      });

      // 모달 외부 클릭 시 닫기
      window.addEventListener("click", function (event) {
        if (event.target === modal) {
          modal.style.display = "none";
          modalIframe.src = ""; // 모달 닫힐 때 iframe 초기화
        }
      });

      // 사이드바 표시
      sidebar.style.display = "flex";

      const addPlanBtn = document.getElementById("addPlanBtn");

            // addPlaceToPlan 함수 호출
            addPlanBtn.addEventListener("click", function () {

              // `data-*` 속성에 장소 이름과 주소 저장
              addPlanBtn.setAttribute("data-place-name", place.place_name);
              addPlanBtn.setAttribute("data-place-address", place.address_name);
              addPlanBtn.setAttribute("data-place-phone", place.phone);
              addPlanBtn.setAttribute("data-place-x", place.x);
              addPlanBtn.setAttribute("data-place-y", place.y);
              addPlanBtn.setAttribute("data-place-url", place.place_url);
              addPlanBtn.setAttribute("data-id", place.id);

                var placePosition = new kakao.maps.LatLng(placeY, placeX);
                addCustomMarker(placePosition, placeTitle);

                // 일정에 추가
                addPlaceToPlan(placeTitle, placeAddress);

            });

            // 닫기 버튼 이벤트 등록
            sidebar.querySelector("#closeSidebar").addEventListener("click", function () {
                sidebar.style.display = "none";
            });
      });
      return marker;
    }

    const dateDifference = <%= session.getAttribute("travelDays") %>;
    console.log("총 여행 일수:", dateDifference);

    function displayDayPlan(day, place) {
        const placeList = document.getElementById("placeList");
        placeList.innerHTML = ""; // 기존 리스트 초기화

        // 선택된 일차에 해당하는 장소 표시
        dayPlans[day].forEach(({ title, address, x, y , id}, index) => {
        const markerPosition = new kakao.maps.LatLng(y, x);

            const newItem = document.createElement("li");
            newItem.classList.add("place-item");

            // 번호 추가
            const numberElement = document.createElement("span");
            numberElement.classList.add("placeNumber");
            numberElement.textContent = (index + 1) + ". "; // 번호 설정

            const titleElement = document.createElement("h4");
            titleElement.classList.add("placeTitle");
            titleElement.textContent = title;

            const addressElement = document.createElement("p");
            addressElement.classList.add("placeAddress");
            addressElement.textContent = address;

            const deleteButton = document.createElement("button");
            deleteButton.classList.add("delete-btn");
            deleteButton.textContent = "삭제";

            // 삭제 버튼 클릭 이벤트
            deleteButton.addEventListener("click", function () {
                newItem.remove(); // 리스트 항목 삭제
                dayPlans[day] = dayPlans[day].filter(item => item.title !== title); // 데이터에서 제거

            // tempMemoryPlaces에서 해당 항목 삭제
            tempMemoryPlaces = tempMemoryPlaces.filter(item => {
              return !(String(item.day) === String(day) && item.kakaoPlaceId === id);
            });
                // 번호 다시 매기기
            updatePlaceNumbers();

            removeCustomMarker(title);

        });


            newItem.addEventListener("click", function () {
              const sidebar = document.getElementById("sidebar");
              const template = document.getElementById("sidebar-template");

              // 템플릿 내용을 복사하여 삽입
              sidebar.innerHTML = template.innerHTML;


              // 템플릿 내부 요소에 데이터 삽입
              sidebar.querySelector("#place-title").textContent = place.place_name || "정보 없음";
              sidebar.querySelector("#place-category_name").textContent = place.category_name || "정보 없음";
              sidebar.querySelector("#place-road_address_name").textContent = place.road_address_name || "도로명 주소 없음";
              sidebar.querySelector("#place-address_name").textContent = place.address_name || "주소 없음";
              sidebar.querySelector("#place-phone").textContent = place.phone || "전화번호 없음";
                const marker = customMarkers.find(item => item.title === title);
                if (marker) {
                    const markerPosition = marker.customMarker.getPosition();
                    map.setCenter(markerPosition);
                    map.setLevel(2);
                } else {
                    console.error(`해당 마커를 찾을 수 없습니다`);
                }
            });

            newItem.appendChild(numberElement);
            newItem.appendChild(titleElement);
            newItem.appendChild(addressElement);
            newItem.appendChild(deleteButton);
            placeList.appendChild(newItem);
        });

        // 번호 다시 매기기 호출
        updatePlaceNumbers();
    }


    // 번호 다시 매기기 함수
    function updatePlaceNumbers() {
        const placeItems = document.querySelectorAll(".place-item");

        placeItems.forEach((item, index) => {
            const numberElement = item.querySelector(".placeNumber");
            if (numberElement) {
                numberElement.textContent = (index + 1) + ". "; // 번호 갱신
            }
        });
    }

  // 기존 addPlaceToPlan 수정
  function addPlaceToPlan(placeTitle, placeAddress, id) {
    const selectedDay = document.querySelector(".day-btn.selected")?.getAttribute("data-day");
    console.log("일자 선택 (나의 번호는?) : ", selectedDay); // 콘솔 찍어봐라 숫자 1,2,3 나오나 그 후에 finalSend 수정해야한다.
    if (!selectedDay) {
      alert("일차를 선택해주세요!");
      return;
    }

    // 선택된 일차에 장소 추가
    dayPlans[selectedDay].push({ title: placeTitle, address: placeAddress, id: id });
    displayDayPlan(selectedDay); // 업데이트된 리스트 표시

    console.log("새로운 일정 추가됨:", placeTitle, placeAddress, id, "on Day", selectedDay);
  }


    function removeMarker() {
        for ( var i = 0; i < markers.length; i++ ) {
            markers[i].setMap(null);
        }
        markers = [];
    }

    // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
    function displayPagination(pagination) {
        var paginationEl = document.getElementById('pagination'),
            fragment = document.createDocumentFragment(),
            i;

        // 기존에 추가된 페이지번호를 삭제합니다
        while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild (paginationEl.lastChild);
        }

        for (i=1; i<=pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i===pagination.current) {
                el.className = 'on';
            } else {
                el.onclick = (function(i) {
                    return function() {
                        pagination.gotoPage(i);
                    }
                })(i);
            }

            fragment.appendChild(el);
        }
        paginationEl.appendChild(fragment);
    }

    // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
    // 인포윈도우에 장소명을 표시합니다
    function displayInfowindow(marker, title) {
        var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
        infowindow.setContent(content);
        infowindow.open(map, marker);
    }

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
    function removeAllChildNods(el) {
        while (el.hasChildNodes()) {
            el.removeChild (el.lastChild);
        }
    }
    var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
        contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
        categoryMarkers = [], // 마커를 담을 배열입니다
        currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

    // 장소 검색 객체를 생성합니다
    var ps = new kakao.maps.services.Places(map);
    // 지도에 idle 이벤트를 등록합니다
    kakao.maps.event.addListener(map, 'idle', searchCategoryMarkers);

    // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다
    contentNode.className = 'placeinfo_wrap';

    // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
    // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다
    addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
    addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

    // 커스텀 오버레이 컨텐츠를 설정합니다
    placeOverlay.setContent(contentNode);

    // 각 카테고리에 클릭 이벤트를 등록합니다
    addCategoryClickEvent();

    // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
    function addEventHandle(target, type, callback) {
        if (target.addEventListener) {
            target.addEventListener(type, callback);
        } else {
            target.attachEvent('on' + type, callback);
        }
    }

    function searchCategoryMarkers() {
        if (!currCategory) {
            return;
        }

        // 커스텀 오버레이를 숨깁니다
        placeOverlay.setMap(null);

        // 기존 마커를 제거합니다
        removeCategoryMarkers(categoryMarkers);

        // 새로운 카테고리 검색 요청
        ps.categorySearch(currCategory, categoryMarkersSearchCB, { useMapBounds: true });
    }

    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
    function categoryMarkersSearchCB(data, status, pagination) {
        if (status === kakao.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
            displayCategoryMarkers(data);
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

        } else if (status === kakao.maps.services.Status.ERROR) {
            // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

        }
    }

    // 지도에 마커를 표출하는 함수입니다
    function displayCategoryMarkers(places) {

        // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
        // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
        var order = document.getElementById(currCategory).getAttribute('data-order');



        for ( var i=0; i<places.length; i++ ) {

            // 마커를 생성하고 지도에 표시합니다
            var marker = addCategoryMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

            // 마커와 검색결과 항목을 클릭 했을 때
            // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
            (function(marker, place) {
                kakao.maps.event.addListener(marker, 'click', function() {
                    displayCategoryMarkerInfo(place);
                });
            })(marker, places[i]);
        }
    }
    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
    function addCategoryMarker(position, order) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
            imgOptions =  {
                spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            },
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
        categoryMarkers.push(marker);  // 배열에 생성된 마커를 추가합니다

        return marker;
    }
    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
    function removeCategoryMarkers(markerArray) {
        for ( var i = 0; i < markerArray.length; i++ ) {
            markerArray[i].setMap(null);
        }
        markerArray.length = 0;
    }

    // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
    // url 팝업으로 열기
    function displayCategoryMarkerInfo (place) {
        var content = '<div class="placeinfo">' +
            '   <a class="title" href="' + place.place_url + '" onclick="openPopup(\'' + place.place_url + '\'); return false;" title="' + place.place_name + '">' + place.place_name + '</a>';
        if (place.road_address_name) {
            content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
                '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
        }  else {
            content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
        }

        content += '    <span class="tel">' + place.phone + '</span>' +
            '</div>' +
            '<div class="after"></div>';

        contentNode.innerHTML = content;
        placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
        placeOverlay.setMap(map);
    }

    function openPlaceModal(url) {
        // 모달과 관련된 DOM 요소 가져오기
        const modal = document.getElementById("myModal");
        const iframe = document.getElementById("modalIframe");
        const closeBtn = document.querySelector(".close");

        // iframe에 URL 설정
        iframe.src = url;

        // 모달 열기
        modal.style.display = "block";

        // 닫기 버튼 클릭 이벤트 추가
        closeBtn.addEventListener("click", function () {
            modal.style.display = "none";
            iframe.src = ""; // iframe 내용 초기화
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener("click", function (event) {
            if (event.target === modal) {
                modal.style.display = "none";
                iframe.src = "";
            }
        });
    }



    // 각 카테고리에 클릭 이벤트를 등록합니다
    function addCategoryClickEvent() {
        var category = document.getElementById('category'),
            children = category.children;

        for (var i=0; i<children.length; i++) {
            children[i].onclick = onClickCategory;
        }
    }
    // 카테고리를 클릭했을 때 호출되는 함수입니다
    function onClickCategory() {
        var id = this.id,
            className = this.className;

        placeOverlay.setMap(null);

        if (className === 'on') {
            currCategory = '';
            changeCategoryClass();
            removeCategoryMarkers(categoryMarkers);
        } else {
            currCategory = id;
            changeCategoryClass(this);
            searchCategoryMarkers();
        }
    }
    function changeCategoryClass(el) {
        var category = document.getElementById('category'),
            children = category.children,
            i;

        for ( i=0; i<children.length; i++ ) {
            children[i].className = '';
        }

        if (el) {
            el.className = 'on';
        }
    }
    //function addToPlan(place){
    //     console.log('Adding to Plan:', place); // 디버깅용 콘솔 로그
    //
    //        const planModal = document.getElementById('planModal');
    //       planModal.style.display = 'block';
    //}

    document.getElementById('closeModalBtn').addEventListener('click',()=>{document.getElementById('planModal').style.display='none';});
    document.getElementById('selectPlanBtn').addEventListener('click', () => {
        const selectedPlan = document.querySelector('input[name="plan"]:checked');
        if (selectedPlan) {
            const planId = selectedPlan.value;
            alert(`선택된 Plan ID: ${planId}`);
            document.getElementById('planModal').style.display = 'none'; // 모달 닫기
        } else {
            alert('Plan을 선택하세요.');
        }
    });

    // 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

        // 마우스로 클릭한 위치입니다
        var clickPosition = mouseEvent.latLng;

        // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
        if (!drawingFlag) {

            // 상태를 true로, 선이 그리고있는 상태로 변경합니다
            drawingFlag = true;

            // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
            deleteClickLine();

            // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
            deleteDistnce();

            // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
            deleteCircleDot();

            // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
            clickLine = new kakao.maps.Polyline({
                map: map, // 선을 표시할 지도입니다
                path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
                strokeWeight: 3, // 선의 두께입니다
                strokeColor: '#db4040', // 선의 색깔입니다
                strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
            });

            // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
            moveLine = new kakao.maps.Polyline({
                strokeWeight: 3, // 선의 두께입니다
                strokeColor: '#db4040', // 선의 색깔입니다
                strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid' // 선의 스타일입니다
            });

            // 클릭한 지점에 대한 정보를 지도에 표시합니다
            displayCircleDot(clickPosition, 0);


        } else { // 선이 그려지고 있는 상태이면

            // 그려지고 있는 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();

            // 좌표 배열에 클릭한 위치를 추가합니다
            path.push(clickPosition);

            // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
            clickLine.setPath(path);

            var distance = Math.round(clickLine.getLength());
            displayCircleDot(clickPosition, distance);
        }
    });

    // 지도에 마우스무브 이벤트를 등록합니다
    // 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
    kakao.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

        // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
        if (drawingFlag){

            // 마우스 커서의 현재 위치를 얻어옵니다
            var mousePosition = mouseEvent.latLng;

            // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();

            // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
            var movepath = [path[path.length-1], mousePosition];
            moveLine.setPath(movepath);
            moveLine.setMap(map);

            var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
                content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다

            // 거리정보를 지도에 표시합니다
            showDistance(content, mousePosition);
        }
    });

    // 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
    // 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
    kakao.maps.event.addListener(map, 'rightclick', function (mouseEvent) {

        // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
        if (drawingFlag) {

            // 마우스무브로 그려진 선은 지도에서 제거합니다
            moveLine.setMap(null);
            moveLine = null;

            // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
            var path = clickLine.getPath();

            // 선을 구성하는 좌표의 개수가 2개 이상이면
            if (path.length > 1) {

                // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
                if (dots[dots.length-1].distance) {
                    dots[dots.length-1].distance.setMap(null);
                    dots[dots.length-1].distance = null;
                }

                var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                    content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다

                // 그려진 선의 거리정보를 지도에 표시합니다
                showDistance(content, path[path.length-1]);

            } else {

                // 선을 구성하는 좌표의 개수가 1개 이하이면
                // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
                deleteClickLine();
                deleteCircleDot();
                deleteDistnce();

            }

            // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
            drawingFlag = false;
        }
    });

    // 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
    function deleteClickLine() {
        if (clickLine) {
            clickLine.setMap(null);
            clickLine = null;
        }
    }

    // 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
    // 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
    function showDistance(content, position) {

        if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면

            // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
            distanceOverlay.setPosition(position);
            distanceOverlay.setContent(content);

        } else { // 커스텀 오버레이가 생성되지 않은 상태이면

            // 커스텀 오버레이를 생성하고 지도에 표시합니다
            distanceOverlay = new kakao.maps.CustomOverlay({
                map: map, // 커스텀오버레이를 표시할 지도입니다
                content: content,  // 커스텀오버레이에 표시할 내용입니다
                position: position, // 커스텀오버레이를 표시할 위치입니다.
                xAnchor: 0,
                yAnchor: 0,
                zIndex: 3
            });
        }
    }

    // 그려지고 있는 선의 총거리 정보와
    // 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
    function deleteDistnce () {
        if (distanceOverlay) {
            distanceOverlay.setMap(null);
            distanceOverlay = null;
        }
    }

    // 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여
    // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
    function displayCircleDot(position, distance) {

        // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
        var circleOverlay = new kakao.maps.CustomOverlay({
            content: '<span class="dot"></span>',
            position: position,
            zIndex: 1
        });

        // 지도에 표시합니다
        circleOverlay.setMap(map);

        if (distance > 0) {
            // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
            var distanceOverlay = new kakao.maps.CustomOverlay({
                content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
                position: position,
                yAnchor: 1,
                zIndex: 2
            });

            // 지도에 표시합니다
            distanceOverlay.setMap(map);
        }

        // 배열에 추가합니다
        dots.push({circle:circleOverlay, distance: distanceOverlay});
    }

    // 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
    function deleteCircleDot() {
        var i;

        for ( i = 0; i < dots.length; i++ ){
            if (dots[i].circle) {
                dots[i].circle.setMap(null);
            }

            if (dots[i].distance) {
                dots[i].distance.setMap(null);
            }
        }

        dots = [];
    }

    // 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여
    // 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
    // HTML Content를 만들어 리턴하는 함수입니다
    function getTimeHTML(distance) {

        // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
        var walkkTime = distance / 67 | 0;
        var walkHour = '', walkMin = '';

        // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
        if (walkkTime > 60) {
            walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
        }
        walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

        // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
        var bycicleTime = distance / 227 | 0;
        var bycicleHour = '', bycicleMin = '';

        // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
        if (bycicleTime > 60) {
            bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
        }
        bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

        // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
        var content = '<ul class="dotOverlay distanceInfo">';
        content += '    <li>';
        content += '        <span class="label">총거리</span><span class="number">' + distance + '</span>m';
        content += '    </li>';
        content += '    <li>';
        content += '        <span class="label">도보</span>' + walkHour + walkMin;
        content += '    </li>';
        content += '    <li>';
        content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
        content += '    </li>';
        content += '</ul>'

        return content;
    }

    // 클릭한 위치에 마커를 표시합니다
    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
        addPin(mouseEvent.latLng, map);
    });

    var pins = [];

    var pinPositions = [];

    function addPin(position, map){
        var pin = new kakao.maps.Marker({
            position: position
        });

        pin.setMap(map);

        pinPositions.push(position);

        // 핀 클릭 시 삭제 이벤트를 추가합니다
        kakao.maps.event.addListener(pin, 'click', function () {
            pin.setMap(null);

            var index = pins.indexOf(pin);
            if (index > -1) {
                pins.splice(index, 1);
                pinPositions.splice(index, 1);
            }

        });
        pins.push(pin);
    }

  // "핀 일괄 삭제하기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
  function deleteAllPins() {
    for (var i = 0; i < pins.length; i++) {
      pins[i].setMap(null);
    }
    pins = [];
    pinPositions = [];
    deleteClickLine();

    if (moveLine) {
      moveLine.setMap(null);
      moveLine = null;
    }

        deleteDistnce();
        deleteCircleDot();

        // 전역 변수 초기화
        drawingFlag = false;
        dots = [];
    }

  document.addEventListener("DOMContentLoaded", function () {
    let places = JSON.parse(localStorage.getItem("places")) || [];
    const placeList = document.getElementById("placeList");

    // 장소 목록 렌더링 함수
    function renderPlaceList() {
      const placeList = document.getElementById("placeList");
      placeList.innerHTML = "";

      places.forEach((place, index) => {
        const li = document.createElement("li");
        li.className = "place-item";
        li.id = `place-${index}`;
        li.innerHTML = `
                <span>${place.place_name} - ${place.address_name}</span>
                <button class="delete-btn" data-index="${index}">삭제</button>
            `;

        li.querySelector(".delete-btn").addEventListener("click", function () {
          deletePlace(index);
        });

        placeList.appendChild(li);
      });
    }
  });
  // 장소 삭제 함수
  function deletePlace(index) {
    places.splice(index, 1);
    localStorage.setItem("places", JSON.stringify(places));
    renderPlaceList();
  }

  function deletePlace(index) {
    const confirmed = confirm("정말 삭제하시겠습니까?");
    if (confirmed) {
      places.splice(index, 1); // 해당 항목 삭제
      console.log(`place-${index} 삭제 완료`);

      renderPlaceList(); // 목록 갱신
    }
  }



  document.addEventListener("DOMContentLoaded", function () {
    const menuWrap = document.getElementById("menu_wrap");
    const modalOverlay = document.createElement("div");
    modalOverlay.id = "modalOverlay";
    document.body.appendChild(modalOverlay);

    const openMenuBtn = document.getElementById("addPlaceBtn");
    const closeMenuBtn = document.getElementById("closeMenu");

    const placeListCoontainer = document.getElementById("placeListContainer");

    // 모달 열기
    openMenuBtn.addEventListener("click", function () {
      menuWrap.classList.add("show");
      modalOverlay.classList.add("show");
    });

    // 모달 닫기
    closeMenuBtn.addEventListener("click", function () {
      menuWrap.classList.remove("show");
      modalOverlay.classList.remove("show");
    });

    // 배경 클릭 시 모달 닫기
    modalOverlay.addEventListener("click", function () {
      menuWrap.classList.remove("show");
      modalOverlay.classList.remove("show");
    });
  });

  const dayPlans = {};

  // n일차 버튼
  function createDayButtons(dateDifference){
    const dayContainer = document.getElementById("day");

    dayContainer.innerHTML="";

    for (let i = 1; i <= dateDifference; i++) {
      const dayBtn = document.createElement("button");
      dayBtn.textContent = i + "일차"
      dayBtn.classList.add("day-btn");
      dayBtn.setAttribute("data-day", i);

            if (i===1){
                dayBtn.classList.add("selected");
            }

            dayContainer.appendChild(dayBtn);

      if (!dayPlans[i]){
        dayPlans[i] = [];
      }
    }

    }
    document.getElementById("day").addEventListener("click", function (event) {
        if (event.target && event.target.classList.contains("day-btn")) {
            const previousSelected = document.querySelector(".day-btn.selected");
            if (previousSelected) {
                previousSelected.classList.remove("selected");
            }

            event.target.classList.add("selected");

      const selectedDay = event.target.getAttribute("data-day");
      //console.log("선택된 일차:", selectedDay);
      displayDayPlan(selectedDay);
    }
  });

    createDayButtons(dateDifference);
    // 초기 상태 설정 (1일차 고정)
    document.addEventListener("DOMContentLoaded", () => {
        // 기본적으로 일정(1일차)을 표시
        companionSection.style.display = "none";
        daysSection.style.display = "block";

        // 1일차를 강조 표시
        const firstDayBtn = document.querySelector(".day-btn[data-day='1']");
        if (firstDayBtn) {
            firstDayBtn.classList.add("selected");
        }
    });

    // 버튼 누르는거에 따른 동행자, 일정 보여주기
    const showCompanionBtn = document.getElementById("showCompanion");
    const showDaysBtn = document.getElementById("showDays");

    const companionSection = document.getElementById("companionSection");
    const daysSection = document.getElementById("daysSection");

    showCompanionBtn.addEventListener("click", () => {
        companionSection.style.display = "block";
        daysSection.style.display = "none";
    });

    // 일정 버튼 클릭 시
    showDaysBtn.addEventListener("click", () => {
        companionSection.style.display = "none";
        daysSection.style.display = "block";
    });

    const planTitleFromDB = "내 인생 첫 여행";

    document.getElementById("planTitle").textContent = planTitleFromDB;

</script>

<%-- <script src="<%= request.getContextPath() %>/js/addPlan.js"></script> --%>
<script src="/daengdong/js/addCompanion.js"></script>
<script src="/daengdong/js/websocket.js"></script>
<script src="/daengdong/js/finalSend.js"></script>
<script>
  // 서버에서 전달받은 planId를 전역 변수로 설정
  planId = '<%= session.getAttribute("currentPlanId") %>';
  console.log("JSP에서 전달된 planId:", planId);

  <%--// WebSocket URL 생성--%>
  <%--const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';--%>
  <%--const host = window.location.host;--%>
  <%--const webSocketUrl = `${protocol}//${host}/daengdong/shareMap-ws?planId=${planId}`;--%>

  <%--// WebSocket 연결--%>
  <%--const webSocket = new WebSocket(webSocketUrl);--%>

  <%--webSocket.onopen = () => console.log("WebSocket 연결 성공:", webSocketUrl);--%>
  <%--webSocket.onerror = (err) => console.error("WebSocket 오류:", err);--%>
  <%--webSocket.onmessage = (event) => console.log("수신된 메시지:", event.data);--%>
</script>
</body>
</html>