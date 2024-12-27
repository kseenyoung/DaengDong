<%--
  Created by IntelliJ IDEA.
  User: minyoung
  Date: 24. 12. 23.
  Time: 오후 12:20
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta charset="utf-8">
    <title>장소검색</title>
    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:800px;}
#menu_wrap {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    width: 400px;
    margin: 10px 0 30px 10px;
    padding: 15px;
    overflow-y: auto;
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0.9), rgba(240, 240, 240, 0.9));
    z-index: 1;
    font-size: 13px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    border: 1px solid #ddd;
}

.bg_white {
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

#menu_wrap hr {
    display: block;
    height: 1px;
    border: 0;
    border-top: 2px solid #5F5F5F;
    margin: 10px 0;
}

#menu_wrap .option {
    text-align: center;
}

#menu_wrap .option p {
    margin: 10px 0;
    font-size: 14px;
    color: #333;
}

#menu_wrap .option button {
    margin-left: 5px;
    padding: 8px 15px; /* 버튼 크기 조정 */
    font-weight: bold;
    color: #fff;
    background-color: #4CAF50;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: background-color 0.3s ease, transform 0.2s ease;
}

#menu_wrap .option button:hover {
    background-color: #45A049;
    transform: translateY(-2px);
}

#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}

//카테고리
#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
#category li.on {background: #eee;}
#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
#category li:last-child{margin-right:0;border-right:0;}
#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
#category li .bank {background-position: -10px 0;}
#category li .mart {background-position: -10px -36px;}
#category li .pharmacy {background-position: -10px -72px;}
#category li .oil {background-position: -10px -108px;}
#category li .cafe {background-position: -10px -144px;}
#category li .store {background-position: -10px -180px;}
#category li.on .category_bg {background-position-x:-46px;}
.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
.container {
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    align-items: center; /* 가운데 정렬 */
    width: 100%; /* 부모 컨테이너 크기 */
}

#category-container {
    margin-bottom: 20px; /* 카테고리와 목록 사이의 간격 */
}

#category {
    display: flex;
    justify-content: center; /* 가로로 중앙 정렬 */
    list-style: none;
    padding: 0;
    margin: 0;
}

#category li {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 65px;
    margin: 0px;
    cursor: pointer;
}

#placesList {
    width: 90%;
    max-height: 500px;
    overflow-y: auto;
    padding: 20px;
    background: linear-gradient(to bottom right, #ffffff, #e3f2fd);
    border: 1px solid #ccc;
    border-radius: 10px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    list-style: none;
}

/* 개별 목록 항목 스타일 */
#placesList li {
    display: flex;
    align-items: center;
    height: 50px;
    padding: 10px;
    margin-bottom: 10px;
    background: #ffffff; /* 목록 항목 배경 */
    border: 1px solid #ddd; /* 항목 테두리 */
    border-radius: 8px; /* 항목 모서리 둥글게 */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 항목 그림자 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 호버 효과 */
    cursor: pointer;
}

/* 항목 호버 효과 */
#placesList li:hover {
    background: #e3f2fd; /* 호버 시 배경색 */
    transform: translateY(-3px); /* 약간 위로 올라감 */
}

/* 텍스트 스타일 */
#placesList li h5 {
    font-size: 16px;
    font-weight: bold;
    margin: 0;
    color: #333;
}

#placesList li p {
    font-size: 14px;
    color: #555;
    margin: 5px 0 0;
}


/* 전체적인 스타일 초기화 */
body, h4, p, button, a {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

/* 사이드바 스타일 */
#sidebar {
    display: none;
    position: fixed;
    top: 20px; /* 화면 상단에서 20px 아래 */
    right: 20px; /* 화면 오른쪽에서 20px 안쪽 */
    width: 350px;
    background: linear-gradient(to bottom right, #ffffff, #e3f2fd);
    border-radius: 10px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    padding: 20px;
    overflow: hidden;
}

/* 닫기 버튼 스타일 */
#sidebar .close-btn {
    display: block;
    background: #ff6b6b;
    color: white;
    border: none;
    font-size: 16px;
    font-weight: bold;
    padding: 10px 15px;
    border-radius: 50%;
    cursor: pointer;
    position: absolute;
    top: 10px;
    right: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    transition: transform 0.2s ease, background-color 0.3s ease;
}

#sidebar .close-btn:hover {
    background-color: #e53935;
    transform: scale(1.1);
}

/* 제목 스타일 */
#sidebar .sidebar-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
    text-align: center;
}

/* 정보 텍스트 스타일 */
#sidebar .sidebar-info {
    font-size: 14px;
    color: #666;
    margin: 10px 0;
    line-height: 1.6;
    border-bottom: 1px dashed #ddd;
    padding-bottom: 5px;
}

/* 추가 버튼 스타일 */
#sidebar .add-btn {
    display: block;
    width: 100%;
    padding: 12px;
    background: #4caf50;
    color: white;
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    border: none;
    border-radius: 8px;
    margin: 20px 0;
    cursor: pointer;
    box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
    transition: background-color 0.3s ease, transform 0.2s ease;
}

#sidebar .add-btn:hover {
    background-color: #388e3c;
    transform: translateY(-2px);
}

/* 링크 버튼 스타일 */
#sidebar .map-link {
    display: block;
    text-align: center;
    margin-top: 15px;
    padding: 12px;
    background: #2196f3;
    color: white;
    text-decoration: none;
    font-size: 16px;
    font-weight: bold;
    border-radius: 8px;
    box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
    transition: background-color 0.3s ease, transform 0.2s ease;
}

#sidebar .map-link:hover {
    background-color: #1e88e5;
    transform: translateY(-2px);
}

</style>

</head>
<body>
<div id="sidebar" style="
    width: 320px;
    height: 400px;
    overflow-y: auto;
    padding: 20px;
    border-left: 1px solid #ccc;
    display: none;
    position: fixed;
    right: 0;
    top: 0;
    background-color: #f9f9f9;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    box-sizing: border-box;
    z-index: 1000;
    border-radius: 8px 0 0 8px;
">
</div>

<div id="sidebar-template" style="display: none;">
    <button id="closeSidebar" class="close-btn">✖</button>
    <h4 id="place-title" class="sidebar-title"></h4>
    <p class="sidebar-info"><strong>카테고리:</strong> <span id="place-category_name"></span></p>
    <p class="sidebar-info"><strong>도로명주소:</strong> <span id="place-road_address_name"></span></p>
    <p class="sidebar-info"><strong>주소:</strong> <span id="place-address_name"></span></p>
    <p class="sidebar-info"><strong>전화번호:</strong> <span id="place-phone"></span></p>
    <button id="add" class="add-btn">+ 내 일정에 추가</button>
    <a id="map-link" href="#" target="_blank" class="map-link">자세히 보기</a>
</div>


<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    검색어 : <input type="text" value="홍대 맛집" id="keyword" size="30">
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


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e0559b7888458bf024586f6213185e7b&libraries=services"></script>
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

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB);
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
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
    bounds = new kakao.maps.LatLngBounds(),
    listStr = '';

    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();

    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i, places[i].place_name,  places[i]),
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

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


// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title, place) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
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

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다


    // 마커에 클릭 이벤트 등록
    kakao.maps.event.addListener(marker, 'click', function () {
        const x = position.getLat();
        const y = position.getLng();
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



        // 링크 업데이트
        // url 팝업으로 열기
        let mapLink = sidebar.querySelector("#map-link");
        let placeUrl = place && place.place_url; // 안전한 참조

        // placeUrl이 유효한 경우에만 링크를 팝업창으로 열기
        if (placeUrl) {
            mapLink.href = "#"; // 기존 링크 기능 제거
            mapLink.addEventListener("click", function (e) {
                e.preventDefault(); // 기본 링크 동작 방지
                let popupWidth = 1200; // 팝업창 너비
                let popupHeight = 900; // 팝업창 높이
                let popupX = (window.screen.width / 2) - (popupWidth / 2); // 화면 중앙 위치 (X좌표)
                let popupY = (window.screen.height / 2) - (popupHeight / 2); // 화면 중앙 위치 (Y좌표)

                window.open(
                    placeUrl,
                    `width=${popupWidth},height=${popupHeight},left=${popupX},top=${popupY},resizable=yes`,
                    "placeInfoPopup"
                );
            });
        } else {
            mapLink.style.display = "none"; // 유효한 URL이 없으면 링크 숨기기
        }



        // 사이드바 표시
        sidebar.style.display = "block";

        // 닫기 버튼 이벤트 등록
        sidebar.querySelector("#closeSidebar").addEventListener("click", function () {
            sidebar.style.display = "none";
        });
    });


    return marker;
}




// 지도 위에 표시되고 있는 마커를 모두 제거합니다
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

function openPopup(url) {

    let popupWidth = 1200; // 팝업창 너비
    let popupHeight = 900; // 팝업창 높이
    let popupX = (window.screen.width / 2) - (popupWidth / 2); // 화면 중앙 위치 (X좌표)
    let popupY = (window.screen.height / 2) - (popupHeight / 2); // 화면 중앙 위치 (Y좌표)


    window.open(url, `width=${popupWidth},height=${popupHeight},left=${popupX},top=${popupY},resizable=yes`,"placeInfoPopup");
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
// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
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


</script>
</body>
</html>