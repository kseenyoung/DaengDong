<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta charset="utf-8">
    <title>장소검색</title>
    <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:930px;}
#menu_wrap {
    position: fixed;
    max-height: 100%;
    overflow-y: auto;
    top: 0;
    left: 10%;
    transform: translate(0, 0);
    display: none;
    bottom: 0;
    width: 80%;
    margin: 10px 0 30px 10px;
    padding: 15px;
    overflow: visible;
    background: linear-gradient(to bottom, rgba(255, 255, 255, 0.9), rgba(240, 240, 240, 0.9));
    z-index: 1000;
    font-size: 13px;
    border-radius: 15px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    border: 1px solid #ddd;
}
#menu_wrap.show {
    display: block;
}

#menu_wrap.hidden {
    display: none;
}

#modalOverlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 999;
    display: none;
}

#modalOverlay.show {
    display: block;
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
.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: transparent;
    border: none;
    font-size: 40px;
    font-weight: bold;
    color: #333;
    cursor: pointer;
    z-index: 1001;
    transition: color 0.3s ease, transform 0.2s ease;
}

.close-btn:hover {
    color: #ff5252;
    transform: scale(1.2);
}

.close-btn:focus {
    outline: none;
}

#pinbutton {
    position: absolute;
    padding: 0.8vw 1.8vw;
    font-size: 1.5vw;
    top: 10px;
    left: 450px;
    z-index: 100;
    margin-left: 5px;
    font-weight: bold;
    color: #fff;
    background-color: #4CAF50;
    border: 2px solid #000;
    border-radius: 5px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: background-color 0.3s ease, transform 0.2s ease;
}
#pinbutton:hover {
    background-color: #45A049;
}

#menu_wrap .option button {
    margin: 5px;
    padding: 10px 20px;
    font-size: 14px;
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
#category li {float:left;list-style: none;width:50px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
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
    flex-direction: column;
    align-items: center;
    width: 100%;
}

#category-container {
width: 100%;
    margin-bottom: 40px;
}

#category {
    display: flex;
    justify-content: center;
    list-style: none;
    padding: 0;
    margin: 0;
}

#category li {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 200px;
    margin: 0px;
    cursor: pointer;
}

#placesList {
    width: 90%;
    max-height: 400px;
    overflow-y: auto;
    padding: 20px;
    background: linear-gradient(to bottom right, #ffffff, #e3f2fd);
    border: 1px solid #ccc;
    border-radius: 10px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    list-style: none;
}

#placesList li {
    display: flex;
    align-items: center;
    height: 50px;
    padding: 10px;
    margin-bottom: 10px;
    background: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: background-color 0.3s ease, transform 0.2s ease;
    cursor: pointer;
}

#placesList li:hover {
    background: #e3f2fd;
    transform: translateY(-3px);
}

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

/* 사이드바 */
body, h4, p, button, a {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

#sidebar {
    display: none;
    position: fixed;
    top: 20px;
    right: 20px;
    width: 350px;
    background: linear-gradient(to bottom right, #ffffff, #e3f2fd);
    border-radius: 10px;
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
    padding: 20px;
    overflow: hidden;
    z-index: 500;
}

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

#sidebar .sidebar-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
    text-align: center;
}

#sidebar .sidebar-info {
    font-size: 14px;
    color: #666;
    margin: 10px 0;
    line-height: 1.6;
    border-bottom: 1px dashed #ddd;
    padding-bottom: 5px;
}

#sidebar .add-btn {
    background: #4caf50;
    border: none;
    margin: 20px 0;
    cursor: pointer;
}

#sidebar .map-link {
    background: #2196f3;
    text-decoration: none;
    margin-top: 30px;
}

#sidebar .button {
    display: block;
    width: 100%;
    padding: 12px;
    color: white;
    font-size: 16px;
    font-weight: bold;
    text-align: center;
    border-radius: 8px;
    box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
    transition: background-color 0.3s ease, transform 0.2s ease;
}

#sidebar .add-btn:hover {
    background-color: #388e3c;
    transform: translateY(-2px);
}

#sidebar .map-link:hover {
    background-color: #1e88e5;
    transform: translateY(-2px);
}
/* 자세히보기 장소 모달 */
#planModal {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1000;
    display: none;
    justify-content: center;
    align-items: center;
    animation: fadeIn 0.3s ease-in-out;
}

.modal-content {
    position: fixed;
    background: linear-gradient(135deg, #e3f2fd, #bbdefb);
    padding: 20px;
    width: 400px;
    border-radius: 15px;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    text-align: center;
    z-index: 1000;
    animation: scaleIn 0.3s ease-in-out;
    justify-content: center;
    align-items: center;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.modal-content h3 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #0d47a1; /* 메인 텍스트 색상 */
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2); /* 텍스트 그림자 */
}

#planList {
    max-height: 200px;
    overflow-y: auto;
    margin-bottom: 15px;
    padding: 10px;
    background: #ffffff;
    border: 1px solid #ddd;
    border-radius: 10px;
    box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1); /* 안쪽 그림자 */
}

#selectPlanBtn, #closeModalBtn {
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin: 5px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 버튼 그림자 */
    transition: background-color 0.3s ease, transform 0.2s ease; /* 호버 효과 */
}

#selectPlanBtn {
    background: #4caf50;
    color: white;
}

#selectPlanBtn:hover {
    background: #45a049;
    transform: scale(1.05); /* 약간 확대 */
}

#closeModalBtn {
    background: #f44336;
    color: white;
}

#closeModalBtn:hover {
    background: #e53935;
    transform: scale(1.05); /* 약간 확대 */
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

@keyframes scaleIn {
    from {
        transform: scale(0.9);
        opacity: 0;
    }
    to {
        transform: scale(1);
        opacity: 1;
    }
}

//선과 거리
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}

/* 장소추가 */
#addPlace{
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

.button{
    display: flex;
    flex-direction: column;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}
.line {
    border: 0;
    border-bottom: 1px solid #ddd;
    margin: 0px 0;
}

/* 모달 */

.modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.modal-content {
  top : 20%;
  background-color: #fff;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  border-radius: 10px;
  width: 80%;
  max-width: 1200px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
  cursor: pointer;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
}



#list_wrap {
            position: absolute;
            top: 50px;
            left: 0;
            bottom: 0;
            width: 400px;
            margin: 10px 0 30px 10px;
            padding: 15px;
            overflow-y: auto;
            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.9), rgba(240, 240, 240, 0.9));
            z-index: 500;
            font-size: 13px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: 1px solid #ddd;
            overflow: visible;
            flex-direction: column;
        }


        #addPlaceBtn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
            z-index : 1050;
            position: absolute;
            right: 15px;
        }

        #addPlaceBtn:hover, .delete-btn:hover {
            background-color: #45a049;
        }

        .search-input {
            width: 80%;
            max-width: 600px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            outline: none;
            transition: box-shadow 0.2s ease;
        }

        .search-input:focus {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-color: #007BFF;
        }

#placeList{
    list-style:none;
    padding:0;
    margin:0;
    margin-top: 50px;
}


        .place-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            color: black;
            font-size: 16px;
            font-family: Arial, sans-serif;
            z-index: 1050;
            position: relative
        }
                .delete-btn {
                            background-color: #4CAF50;
                            color: white;
                            padding: 10px 20px;
                            font-size: 16px;
                            font-weight: bold;
                            border: none;
                            border-radius: 5px;
                            cursor: pointer;
                            margin: 5px;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                            transition: background-color 0.3s ease, transform 0.2s ease;
                            z-index : 1050;
                            position: absolute;
                            right: 10px;
                            top: 40%;
                            transform: translateY(-50%);
                        }


#day {
    display: flex; /* 버튼을 한 줄에 배치 */
    gap: 10px; /* 버튼 간격 */
    overflow-x: auto; /* 가로 스크롤 활성화 */
    white-space: nowrap; /* 버튼 줄 바꿈 방지 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid #ccc; /* 컨테이너 테두리 (테스트용) */
    border-radius: 5px; /* 컨테이너 둥근 모서리 */
}

.day-btn {
    display: inline-block;
    background-color: #4CAF50;
    color: white;
    border: 1px solid gray;
    padding: 10px 15px;
    font-size: 16px;
    text-align: center;
    border-radius: 5px;
    cursor: pointer;
}



</style>
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
    <button id = "addPlanBtn" class="add-btn button">+ 내 일정에 추가</button>
    <a id="map-link" href="#" target="_blank" class="map-link button">자세히 보기</a>
</div>

<div class="map_wrap">
    <div id="map" style="top:60px;left:450px;width:70%;height:65%;position:relative;overflow:hidden;"></div>
    <button id = "pinbutton" onclick="deleteAllPins()">핀 일괄 삭제하기</button>
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
    <div id="day">
    </div>
    <div class="button">
        <button id="addPlaceBtn">장소 추가</button>
        <div class="line"></div>
    </div>
    <ul id="placeList"></ul>
</div>

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

        itemEl.appendChild(button);

        // 검색 결과 항목을 fragment에 추가
        fragment.appendChild(itemEl);

        // 지도 영역 확장
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

    // 지도 범위 재설정
    map.setBounds(bounds);
}
document.getElementById("placesList").addEventListener("click", function (event) {
    if (event.target && event.target.classList.contains("add-btn")) {
        const placeName = event.target.getAttribute("data-place-name");
        const placeAddress = event.target.getAttribute("data-place-address");

        addPlaceToPlan(placeName, placeAddress);
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

        // 사이드바 표시
        sidebar.style.display = "block";

        const addPlanBtn = document.getElementById("addPlanBtn");

        // addPlaceToPlan 함수 호출
        addPlanBtn.addEventListener("click", function () {
            const placeTitle = document.getElementById("place-title").textContent;
            const placeAddress = document.getElementById("place-address_name").textContent;

            addPlaceToPlan(placeTitle, placeAddress);
        });

        // 닫기 버튼 이벤트 등록
        sidebar.querySelector("#closeSidebar").addEventListener("click", function () {
            sidebar.style.display = "none";
        });
    });
    return marker;
}

function addPlaceToPlan(placeTitle, placeAddress) {
    const placeList = document.getElementById("placeList");
    const newItem = document.createElement("li");
    newItem.classList.add("place-item");

    const titleElement = document.createElement("h4");
    titleElement.classList.add("placeTitle");
    titleElement.textContent = placeTitle;

    const addressElement = document.createElement("p");
    addressElement.classList.add("placeAddress");
    addressElement.textContent = placeAddress;

    const deleteButton = document.createElement("button");
    deleteButton.classList.add("delete-btn");
    deleteButton.textContent = "삭제";

    // 삭제 버튼 클릭 이벤트
    deleteButton.addEventListener("click", function () {
        newItem.remove(); // 클릭 시 해당 항목 삭제
        console.log(`${placeTitle} 삭제됨`);
    });

    newItem.appendChild(titleElement);
    newItem.appendChild(addressElement);
    newItem.appendChild(deleteButton);

    placeList.appendChild(newItem);
    console.log("새로운 일정 추가됨:", placeTitle, placeAddress);
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

        // 전역 변수들 초기화
        drawingFlag = false;
        pins = [];
        pinPositions = [];
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

// n일차 버튼
function createDayButtons(dateDifference){
    const dayContainer = document.getElementById("day");

console.log("dayContainer:", dayContainer);

    dayContainer.innerHTML="";

for (let i = 1; i <= dateDifference; i++) {
        const dayBtn = document.createElement("button");

        dayBtn.textContent = i + "일차"

        dayBtn.classList.add("day-btn");
        dayBtn.setAttribute("data-day", i);

        dayContainer.appendChild(dayBtn);
    }

}
document.getElementById("day").addEventListener("click", function (event) {
    if (event.target && event.target.classList.contains("day-btn")) {
        const selectedDay = event.target.getAttribute("data-day");
    }
});

// 예제 실행 (DB에서 받아온 날짜 차이)
const dateDifference = 6; // DB에서 가져온 데이터
createDayButtons(dateDifference);

</script>

//<script src="<%= request.getContextPath() %>/js/addPlan.js"></script>
</body>
</html>