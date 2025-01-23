/***************************************************
 * 전역 변수 (초기화)
 ***************************************************/
// 서버로부터 불러올 plan 정보
let travelDays = 0;           // ex) 3
let dayPlans = {};                // {1: [...], 2: [...], 3: [...]}
let companions = [];            // 동행자 목록 (선택사항)
let placeList = []; // 예전 일정 리스트

// kakao map
let map, ps, infowindow;
let markers = [];       // 파란 검색 마커
let customMarkers = []; // 빨간 일정 마커
let markerPositions = []; // 폴리라인 경로
let line = null;
let distanceOverlay = null;

let pins = [];
let pinPositions = [];

let drawingFlag = false;
let moveLine, clickLine;
let dots = [];

let currCategory = "";
let categoryMarkers = [];
let placeOverlay;
let contentNode;

const placeListCoontainer = document.getElementById("placeListContainer");
/***************************************************
 * 페이지 로드 시 최초 실행
 ***************************************************/
document.addEventListener("DOMContentLoaded", async function () {
    console.log("[searchPlace_app.js] DOMContentLoaded");

    // planId를 전역에서 가져옴 (JSP에서 window.G_planId 세팅)
    const planId = window.G_planId || "0";
    console.log("planId from window:", planId);

    // 1) 백엔드에서 plan 정보 불러오기 (travelDays, dayPlans, companions 등)
    //   실제론 서버에 fetch or axios:
    //   ex) GET /daengdong/api/plan/{planId}
    //   여기서는 임시로 mock
    await loadPlanDataFromServer(planId);

    // 2) 카카오맵 초기화
    initKakaoMap();

    // 3) 동행자/일정 UI 설정
    initPlanUI();

    // 4) WebSocket 연결
    //initWebSocket(planId);

    // 5) 기본 검색 실행 (키워드)
    searchPlaces();
});

/***************************************************
 * (A) 서버에서 plan 정보 불러오기 (mock/fetch)
 ***************************************************/
async function loadPlanDataFromServer(planId) {
    try {
        // 실제:
        let res = await fetch(`/daengdong/plan/detailsByPlanId?planId=${planId}`);
        if(!res.ok) throw new Error("Fail to load plan");
        let data = await res.json();
        // e.g. { planTitle:"...", travelDays:3, placeList: [...], companions: [...] }

        console.log("API 응답:", data); // API 응답 확인
        // 데모/mock 데이터 예시:
        /*let data = {
            travelDays: 3,
            dayPlans: {
                1: [
                    // {title: "이미 저장된 장소", address: "...", x:127.0, y:37.5, id: "kakaoId123"}
                ],
                2: [],
                3: []
            },
            companions: [
                // { nickname: "Alice", email: "alice@ex.com" },
                // { nickname: "Bob", email: "bob@ex.com" }
            ],
            planTitle: "내 인생 첫 여행(서버에서 불러옴)"
        };*/

        // 서버에서 받은 값 채워넣기
        travelDays = data.travelDays;
        console.log("travelDays:", travelDays);
        // 만약 placeList를 dayPlans 형태로 변환하려면,
        // data.placeList.forEach(...) 해서 dayPlans[day].push(...) 로직 수행
        // dayPlans = data.dayPlans;
        // console.log("dayPlans:", dayPlans);
        companions = data.companions || [];
        console.log("companions:", companions);
        placeList = data.placeList || [];
        console.log("placeList:", placeList);

        // placeList를 dayPlans로 변환
        placeList.forEach(place => {
            const { day, kakaoPlaceName, kakaoRoadAddressName, kakaoPlaceId } = place;
            if (!dayPlans[day]) dayPlans[day] = [];
            dayPlans[day].push({
                title: kakaoPlaceName,
                address: kakaoRoadAddressName,
                id: kakaoPlaceId,
            });
        });
        console.log("변환된 dayPlans:", dayPlans);

        // 제목 표시
        const planTitleEl = document.getElementById("planTitle");
        if (planTitleEl) {
            planTitleEl.textContent = data.planTitle || "제목 없는 여행";
        }

        // n일차 버튼 생성
        createDayButtons(travelDays);

        // 1일차 표시
        displayDayPlan(1);

        // 동행자 목록 표시
        renderCompanionList();

    } catch (err) {
        console.error(err);
        alert("일정 정보를 불러오는 중 오류가 발생했습니다.");
    }
}

/***************************************************
 * (B) 카카오맵 초기화
 ***************************************************/
function initKakaoMap() {
    let mapContainer = document.getElementById("map");
    if(!mapContainer) {
        console.error("#map not found");
        return;
    }

    let mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567),
        level: 3
    };
    map = new kakao.maps.Map(mapContainer, mapOption);

    ps = new kakao.maps.services.Places();
    infowindow = new kakao.maps.InfoWindow({zIndex:1});

    // 카테고리 검색용
var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
    contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
    categoryMarkers = [], // 마커를 담을 배열입니다
    currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

    kakao.maps.event.addListener(map, "idle", searchCategoryMarkers);

     //지도에 클릭하면 핀 추가
    kakao.maps.event.addListener(map, "click", (mouseEvent) => {
        addPin(mouseEvent.latLng);
    });

     //선 그리기 이벤트
    kakao.maps.event.addListener(map, 'click', handleMapClick);
    kakao.maps.event.addListener(map, 'mousemove', handleMapMouseMove);
    kakao.maps.event.addListener(map, 'rightclick', handleMapRightClick);
}

/***************************************************
 * (C) 동행자/일정 UI 초기화
 ***************************************************/
function initPlanUI() {
    // 초기: 동행자 영역 숨김, 일정 영역 보이기
    const companionSection = document.getElementById("companionSection");
    const daysSection = document.getElementById("daysSection");
    if(companionSection && daysSection){
        companionSection.style.display="none";
        daysSection.style.display="block";
    }

    // 일정/동행자 탭 버튼
    const showCompanionBtn = document.getElementById("showCompanion");
    const showDaysBtn = document.getElementById("showDays");
    if(showCompanionBtn && showDaysBtn && companionSection && daysSection){
        showCompanionBtn.onclick = () =>{
            companionSection.style.display="block";
            daysSection.style.display="none";
        };
        showDaysBtn.onclick = () =>{
            companionSection.style.display="none";
            daysSection.style.display="block";
        };
    }
}

/***************************************************
 * (D) WebSocket 초기화
 ***************************************************/
// let webSocket = null;
// function initWebSocket(planId) {
//     const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
//     const host = window.location.host;
//     const webSocketUrl = `${protocol}//${host}/daengdong/shareMap-ws?planId=${planId}`;
//     console.log("WebSocket 연결 시도:", webSocketUrl);
//
//     webSocket = new WebSocket(webSocketUrl);
//
//     webSocket.onopen = () => {
//         console.log("WebSocket 연결 성공");
//     };
//
//     webSocket.onerror = (err) => {
//         console.error("WebSocket 오류:", err);
//     };
//
//     webSocket.onclose = () => {
//         console.log("WebSocket 종료");
//     };
//
//     webSocket.onmessage = (evt) => {
//         const msg = JSON.parse(evt.data);
//         if(msg.type === "shareMap") {
//             const place = msg.data;
//             console.log("받은 장소 데이터:", place);
//
//             const {
//                 kakaoPlaceName, kakaoRoadAddressName,
//                 kakaoX, kakaoY,
//                 kakaoPlaceId, selectedDay
//             } = place;
//
//             // 이미 dayPlans 구조가 있으므로, 받은 데이터를 로컬 일정에 추가
//             addPlaceToPlan(kakaoPlaceName, kakaoRoadAddressName, kakaoPlaceId, kakaoX, kakaoY, selectedDay);
//             alert("다른 사람이 장소를 추가했습니다!");
//         }
//     };
// }

/***************************************************
 * (E) 일정 관련 함수
 ***************************************************/
// (E-1) n일차 버튼 생성
function createDayButtons(travelDays){
    const dayContainer = document.getElementById("day");
    if(!dayContainer) return;

    dayContainer.innerHTML="";
    for(let i=1; i<=travelDays; i++){
        const btn = document.createElement("button");
        btn.textContent = i+"일차";
        btn.classList.add("day-btn");
        btn.setAttribute("data-day", i);
        if(i===1) btn.classList.add("selected");

        // dayPlans 초기화
        if(!dayPlans[i]) dayPlans[i] = [];

        dayContainer.appendChild(btn);
    }

    // 클릭이벤트 (단 1번만 등록)
    dayContainer.onclick = function(e){
        if(e.target && e.target.classList.contains("day-btn")){
            const prev = document.querySelector(".day-btn.selected");
            if(prev) prev.classList.remove("selected");
            e.target.classList.add("selected");

            const day = e.target.getAttribute("data-day");
            displayDayPlan(day);
        }
    };
}

// (E-2) 일정 표시
function displayDayPlan(day) {
    console.log("displayDayPlan for day:", day);
    const placeList = document.getElementById("placeList");
    if(!placeList) return;
    placeList.innerHTML="";

    if(!dayPlans[day]) {
        console.warn("dayPlans에 해당 day가 없음:", day);
        dayPlans[day] = [];
    }

    dayPlans[day].forEach((item, index)=>{
        if (!item) return;
        const { title, address, x, y, id } = item;

        const li = document.createElement("li");
        li.classList.add("place-item");
        li.draggable = true;
        li.dataset.index = index;

        const numSpan = document.createElement("span");
        numSpan.classList.add("placeNumber");
        numSpan.textContent = (index+1)+". ";
        numSpan.style.display = "none";

        const h4 = document.createElement("h4");
        h4.classList.add("placeTitle");
        h4.textContent = title || "(no title)";

        const addrEl = document.createElement("p");
        addrEl.classList.add("placeAddress");
        addrEl.textContent = address || "(no address)";

        const delBtn = document.createElement("button");
        delBtn.classList.add("delete-btn");
        delBtn.textContent="삭제";
        delBtn.onclick = () => {
            // 삭제 로직
            dayPlans[day] = dayPlans[day].filter((p,idx)=> idx !== index);
            removeCustomMarker(title);
            displayDayPlan(day);
        };

        // 목록 클릭 -> 지도이동
        li.onclick = () =>{
            // 마커 위치로 이동
            const found = customMarkers.find(cm => cm.title === title);
            if(found && found.customMarker){
                map.setCenter(found.customMarker.getPosition());
                map.setLevel(2);
            }
        };

        li.addEventListener("dragstart", (e) => {
            e.dataTransfer.setData("text/plain", index);
            li.classList.add("dragging");
        });

        li.addEventListener("dragend", () => {
            li.classList.remove("dragging");
        });
        li.addEventListener("dragover", (e) => {
            e.preventDefault();
        });
        li.addEventListener("drop", (e) => {
            e.preventDefault();
            const draggedIndex = parseInt(e.dataTransfer.getData("text/plain"),10);
            const targetIndex = parseInt(li.dataset.index, 10);

            // 리스트 순서 변경
            if (draggedIndex !== targetIndex) {
                const draggedItem = dayPlans[day][draggedIndex];
                dayPlans[day].splice(draggedIndex, 1); // 드래그된 항목 제거
                dayPlans[day].splice(targetIndex, 0, draggedItem); // 드롭된 위치에 삽입
                displayDayPlan(day); // UI 업데이트
            }
        });

        li.appendChild(numSpan);
        li.appendChild(h4);
        li.appendChild(addrEl);
        li.appendChild(delBtn);
        placeList.appendChild(li);
    });
    // 번호 재정렬
    updatePlaceNumbers();
}

// (E-3) 번호 재정렬
function updatePlaceNumbers(){
    const items = document.querySelectorAll(".place-item");
    items.forEach((item, idx)=>{
        const num = item.querySelector(".placeNumber");
        if(num) num.textContent = (idx+1)+". ";
    });
}

// (E-4) 일정에 장소 추가
function addPlaceToPlan(placeTitle, placeAddress, kakaoPlaceId, x, y, forcedDay) {
    // 현재 선택된 일차
    let selectedDayBtn = document.querySelector(".day-btn.selected");
    let day = forcedDay || selectedDayBtn?.getAttribute("data-day");

    if (!day) {
        alert("일차를 선택하세요!");
        return;
    }

    if (!dayPlans[day]) dayPlans[day] = [];

    dayPlans[day].push({
        title: placeTitle,
        address: placeAddress,
        id: kakaoPlaceId,
        x, y
    });

    console.log(`추가된 장소 (${day}일차):`, dayPlans[day]);

    // 지도 마커도 추가 (빨간색)
    if (x && y) {
        const position = new kakao.maps.LatLng(y, x);
        addCustomMarker(position, placeTitle);
    }

    // 일정 UI 갱신
    displayDayPlan(day);

    console.log("[addPlaceToPlan] day=", day, " / dayPlans:", dayPlans);

    // 장소를 서버 DB에 저장
    const placeData = {
        planId: window.G_planId,
        kakaoPlaceId,
        day
    }
}

// (E-5) "최종 완료" 버튼 이벤트
function finalizePlan() {
    let planPlaces = [];
    for (const dayStr in dayPlans) {
        const dayNum = parseInt(dayStr, 10);
        console.log("dayNum: ", dayNum);
        dayPlans[dayStr].forEach(item => {
            planPlaces.push({
                planId: window.G_planId,  // JSP 또는 URL에서 가져온 planId
                kakaoPlaceId: item.id,    // 장소 ID
                day: dayNum               // n일차
            });
        });
    }
    console.log("[finalizePlan] 전송할 planPlaces=", JSON.stringify(planPlaces));

    // 서버로 데이터 전송
    fetch("/daengdong/place/finalPlanPlaces", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(planPlaces)
    })
        .then(res => {
            if (!res.ok) throw new Error("일정 저장 실패");
            return res.text();
        })
        .then(msg => {
            alert("최종 일정이 저장되었습니다!");
            console.log("서버 응답:", msg);

            // 저장이 정상 완료된 후 /daengdong/ 로 이동
            location.href = "/daengdong";
        })
        .catch(err => {
            console.error("일정 저장 오류:", err);
        });
}

/***************************************************
 * (F) 동행자 렌더링
 ***************************************************/
function renderCompanionList(){
    const companionListUl = document.getElementById("companionList");
    if(!companionListUl) return;
    companionListUl.innerHTML="";

    companions.forEach(comp => {
        const li = document.createElement("li");
        li.textContent = +comp.memberEmail;

        companionListUl.appendChild(li);
    });
}

/***************************************************
 * (G) 검색 관련
 ***************************************************/
// 키워드 검색
function searchPlaces(){
    const kwInput = document.getElementById("keyword");
    if(!kwInput) return;
    let keyword = kwInput.value.trim();
    keyword += " 애견"
    if(!keyword) keyword="카페";


    ps.keywordSearch(keyword, placesSearchCB);
}

// placesSearchCB
function placesSearchCB(data, status, pagination) {
    console.log("data: ", data);
    if (status === kakao.maps.services.Status.OK) {
        // '동물 동반' 키워드를 포함한 장소만 필터링
        var filteredData = data.filter(function (place) {
            return (
                (place.place_name && place.place_name.indexOf("동물 동반") !== -1) ||
                (place.category_name && place.category_name.indexOf("동물 동반") !== -1) ||
                (place.place_name && place.place_name.indexOf("애견") !== -1) ||
                (place.category_name && place.category_name.indexOf("애견") !== -1) ||
                (place.place_name && place.place_name.indexOf("반려") !== -1) ||
                (place.category_name && place.category_name.indexOf("반려") !== -1)
            );
        });
      // 정상적으로 검색이 완료됐으면
      // 검색 목록과 마커를 표출합니다
      displayPlaces(data);

      // 페이지 번호를 표출합니다
      displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

      return;

    } else if (status === kakao.maps.services.Status.ERROR) {

      alert('검색 결과 중 오류가 발생했습니다.');
      return;

    }
}

function displayPlaces(places, startIndex = 0) {
    var listEl = document.getElementById('placesList'),
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds();

    // 검색 결과 목록 초기화
    removeAllChildNods(listEl);

    for (var i = 0; i < places.length; i++) {
        var place = places[i];

        // 페이지별 시작 `index` 조정
        var adjustedIndex = startIndex + i;

        var placePosition = new kakao.maps.LatLng(place.y, place.x),
            marker = addMarker(placePosition, adjustedIndex, place.place_name, place);

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

        // `data-*` 속성에 장소 데이터 저장
        button.setAttribute("data-place-name", place.place_name);
        button.setAttribute("data-place-address", place.address_name);
        button.setAttribute("data-place-phone", place.phone);
        button.setAttribute("data-place-x", place.x);
        button.setAttribute("data-place-y", place.y);
        button.setAttribute("data-place-url", place.place_url);
        button.setAttribute("data-id", place.id);
        button.setAttribute("data-starid", place.star_id || "");


        var detailLink = document.createElement("a");
        detailLink.className = "map-link";
        detailLink.textContent = "자세히 보기";
        detailLink.href = place.place_url || "#"; // URL이 없으면 기본값 설정
        detailLink.target = "_blank";

        detailLink.addEventListener("click", function (e) {
            e.preventDefault();
            openModal(place.place_url);
        });

        itemEl.appendChild(button);
        itemEl.appendChild(detailLink);
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
function openModal(url) {
    const modal = document.getElementById("myModal");
    const modalIframe = document.getElementById("modalIframe");
    const closeModalBtn = document.querySelector(".close");

    if (!url) {
        alert("유효한 URL이 없습니다.");
        return;
    }

    // 모달 열기
    modalIframe.src = url; // URL 로드
    modal.style.display = "block";

    // 닫기 버튼 이벤트 등록
    closeModalBtn.addEventListener("click", function () {
        modal.style.display = "none";
        modalIframe.src = ""; // iframe 초기화
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
            modalIframe.src = ""; // iframe 초기화
        }
    });
}

// 페이지네이션
function displayPagination(pagination){
    const paginationEl = document.getElementById("pagination");
    if(!paginationEl) return;

    while(paginationEl.hasChildNodes()){
        paginationEl.removeChild(paginationEl.lastChild);
    }

    for(let i=1; i<=pagination.last; i++){
        let a = document.createElement("a");
        a.href="#";
        a.innerHTML=i;
        if(i===pagination.current){
            a.className="on";
        } else {
            a.onclick=(function(i){
                return function(){
                    pagination.gotoPage(i);
                }
            })(i);
        }
        paginationEl.appendChild(a);
    }
}

// 마커(파란색) 지우기
function removeMarker(){
    markers.forEach(m=>m.setMap(null));
    markers=[];
}
function removeAllChildNods(el){
    while(el && el.hasChildNodes()){
        el.removeChild(el.lastChild);
    }
}

/***************************************************
 * (H) 마커 (검색결과 파란 마커)
 ***************************************************/
function addMarker(position, idx, title, place){
    const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
    const imageSize = new kakao.maps.Size(36, 37);
    const imgOptions = {
        spriteSize: new kakao.maps.Size(36,691),
        spriteOrigin: new kakao.maps.Point(0, (idx*46)+10),
        offset: new kakao.maps.Point(13,37)
    };
    const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);

    const marker = new kakao.maps.Marker({
        position,
        image: markerImage,
        map
    });
    markers.push(marker);

    kakao.maps.event.addListener(marker, "mouseover", ()=>{
        displayInfowindow(marker, title);
    });
    kakao.maps.event.addListener(marker, "mouseout", ()=>{
        infowindow.close();
    });

    // 클릭 -> 사이드바 표시
    kakao.maps.event.addListener(marker, "click", ()=>{
        showSidebar(place);
    });

    return marker;
}

function displayInfowindow(marker, title){
    let content = `<div style="padding:5px;">${title}</div>`;
    infowindow.setContent(content);
    infowindow.open(map, marker);
}

/***************************************************
 * (I) "내 일정에 추가" 버튼 (동적)
 ***************************************************/
document.addEventListener("click", function(evt){

    if(evt.target && evt.target.classList.contains("add-btn")){
        const btn = evt.target;
        const placeName = btn.dataset.placeName;
        const placeAddress = btn.dataset.placeAddress;
        const placePhone = btn.dataset.placePhone;
        const placeUrl = btn.dataset.placeUrl;
        const x = parseFloat(btn.dataset.placeX);
        const y = parseFloat(btn.dataset.placeY);
        const placeId = btn.dataset.id;
        console.log("placeAddress:", btn.dataset.placeAddress);

        if (!placeAddress) {
            return; // 추가 실행 방지
        }

        // 1) 로컬에 일정 추가
        addPlaceToPlan(placeName, placeAddress, placeId, x, y);

        // 2) 공통 함수 호출 -> DB 저장 (카카오 장소 관련 값들을 JSON으로 전송)
        savePlaceToDB(placeName, placeAddress, placeId, x, y, placePhone, placeUrl)
            .then(data => {
                console.log("DB 저장 성공:", data);
            })
            .catch(error => {
                console.error("DB 저장 오류:", error);
            });

        // 웹소켓 전송
        // if(webSocket && webSocket.readyState===WebSocket.OPEN){
        //     webSocket.send(JSON.stringify({
        //         type: "shareMap",
        //         data: {
        //             kakaoPlaceName: placeName,
        //             kakaoRoadAddressName: placeAddress,
        //             kakaoPhone: placePhone,
        //             kakaoX: x,
        //             kakaoY: y,
        //             kakaoPlaceUrl: placeUrl,
        //             kakaoPlaceId: placeId,
        //             selectedDay: getSelectedDay()
        //         }
        //     }));
        // }
        // alert("장소가 공유되었습니다!");
    }
});

function getSelectedDay(){
    const sel = document.querySelector(".day-btn.selected");
    if(!sel) return null;
    return sel.getAttribute("data-day");
}

/***************************************************
 * (J) 사이드바 표시
 ***************************************************/
function showSidebar(place){
    console.log("showSidebar -> place =", place);
    console.log("showSidebar -> place.id =", place.id); // 확인
    const sidebar = document.getElementById("sidebar");
    const template = document.getElementById("sidebar-template");
    if(!sidebar || !template) return;

    sidebar.innerHTML = template.innerHTML;

    const favoriteBtn = sidebar.querySelector("#favoriteBtn")

    favoriteBtn.setAttribute("data-id", place.id);

    sidebar.querySelector("#place-title").textContent = place.place_name || "정보 없음";
    sidebar.querySelector("#place-category_name").textContent = place.category_name || "정보 없음";
    sidebar.querySelector("#place-road_address_name").textContent = place.road_address_name || "도로명주소 없음";
    sidebar.querySelector("#place-address_name").textContent = place.address_name || "주소 없음";
    sidebar.querySelector("#place-phone").textContent = place.phone || "전화번호 없음";

    // 자세히보기 -> 모달
    let mapLink = sidebar.querySelector("#map-link");
    if(place.place_url){
        mapLink.onclick=(e)=>{
            e.preventDefault();
            openPlaceModal(place.place_url);
        };
    } else {
        mapLink.style.display="none";
    }

    // + 내 일정에 추가 버튼
    let addPlanBtn = sidebar.querySelector("#addPlanBtn");
    if(addPlanBtn){
        addPlanBtn.onclick = ()=>{

            // 1) 일정 추가
            addPlaceToPlan(place.place_name, place.address_name, place.id, place.x, place.y);

            // 2) DB 저장 (공통함수)
            savePlaceToDB(place.place_name, place.address_name, place.id, place.x, place.y, place.phone, place.place_url)
                .then(data => {
                    console.log("DB 저장 성공 (sidebar):", data);
                })
                .catch(err => {
                    console.error("DB 저장 오류 (sidebar):", err);
                });
        };
    }

    // 닫기
    let closeSidebarBtn = sidebar.querySelector("#closeSidebar");
    if(closeSidebarBtn){
        closeSidebarBtn.onclick = ()=>{
            sidebar.style.display="none";
        }
    }

    // 사이드바 열기
    sidebar.style.display="flex";
}

/***************************************************
 * (K) 빨간 마커 (일정에 추가된 마커)
 ***************************************************/
function addCustomMarker(position, title){
    const imageSrc = "https://maps.gstatic.com/mapfiles/ms2/micons/red-dot.png"; // 실제 경로
    const imageSize = new kakao.maps.Size(50, 45); // 마커 이미지 크기 (가로 50px, 세로 50px)
    const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    const customMarker = new kakao.maps.Marker({
        position,
        image: markerImage,
        map
    });
    customMarkers.push({ customMarker, title });

    // mouseover
    kakao.maps.event.addListener(customMarker, "mouseover", function(){
        displayInfowindow(customMarker, title);
    });
    kakao.maps.event.addListener(customMarker, "mouseout", function(){
        infowindow.close();
    });

    markerPositions.push(position);
    updatePolyline();
    updateDistanceAndTime();

    return customMarker;
}

function removeCustomMarker(title){
    let idx = customMarkers.findIndex(cm=> cm.title===title);
    if(idx!==-1){
        customMarkers[idx].customMarker.setMap(null);
        customMarkers.splice(idx,1);
        markerPositions.splice(idx,1);
        updatePolyline();
        updateDistanceAndTime();
    }
}

/***************************************************
 * (L) 핀 찍기 / 일괄 삭제
 ***************************************************/
function addPin(position){
    let pin = new kakao.maps.Marker({
        position
    });
    pin.setMap(map);
    pins.push(pin);
    pinPositions.push(position);

    kakao.maps.event.addListener(pin, "click", ()=>{
        pin.setMap(null);
        let index = pins.indexOf(pin);
        if(index>-1){
            pins.splice(index,1);
            pinPositions.splice(index,1);
        }
    });
}

function deleteAllPins(){
    pins.forEach(p=> p.setMap(null));
    pins=[];
    pinPositions=[];
    deleteClickLine();

    if(moveLine){
        moveLine.setMap(null);
        moveLine=null;
    }
    deleteDistnce();
    deleteCircleDot();

    drawingFlag=false;
    dots=[];
}



/***************************************************
 * (M) 선그리기 (거리계산)
 ***************************************************/
function handleMapClick(mouseEvent){
    let clickPosition = mouseEvent.latLng;
    if(!drawingFlag){
        // start
        drawingFlag=true;
        deleteClickLine();
        deleteDistnce();
        deleteCircleDot();

        clickLine = new kakao.maps.Polyline({
            map,
            path: [clickPosition],
            strokeWeight:3,
            strokeColor:"#db4040",
            strokeOpacity:1,
            strokeStyle:"solid"
        });
        moveLine = new kakao.maps.Polyline({
            strokeWeight:3,
            strokeColor:"#db4040",
            strokeOpacity:0.5,
            strokeStyle:"solid"
        });
        displayCircleDot(clickPosition,0);
    } else {
        // continue
        let path = clickLine.getPath();
        path.push(clickPosition);
        clickLine.setPath(path);

        let distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition,distance);
    }
}

function handleMapMouseMove(mouseEvent){
    if(!drawingFlag) return;
    let mousePosition = mouseEvent.latLng;
    let path = clickLine.getPath();
    let movepath = [ path[path.length-1], mousePosition ];

    moveLine.setPath(movepath);
    moveLine.setMap(map);

    let distance = Math.round(clickLine.getLength() + moveLine.getLength());
    let content = `<div class="dotOverlay distanceInfo">총거리 <span class="number">${distance}</span>m</div>`;
    showDistance(content, mousePosition);
}

function handleMapRightClick(){
    if(!drawingFlag) return;
    moveLine.setMap(null);
    moveLine=null;

    let path = clickLine.getPath();
    if(path.length>1){
        if(dots[dots.length-1].distance){
            dots[dots.length-1].distance.setMap(null);
            dots[dots.length-1].distance=null;
        }
        let distance = Math.round(clickLine.getLength());
        let content = getTimeHTML(distance);
        showDistance(content, path[path.length-1]);
    } else {
        deleteClickLine();
        deleteCircleDot();
        deleteDistnce();
    }
    drawingFlag=false;
}

// 폴리라인 삭제
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);
        clickLine = null;
    }
}

// 거리 정보 오버레이 표시
function showDistance(content, position) {
    if (distanceOverlay) {
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
    } else {
        distanceOverlay = new kakao.maps.CustomOverlay({
            map,
            content,
            position,
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3
        });
    }
}

// 거리 정보 오버레이 삭제
function deleteDistnce() {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 지도에 원형 마커 표시
function displayCircleDot(position, distance) {
    let circleOverlay = new kakao.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position,
        zIndex: 1
    });
    circleOverlay.setMap(map);

    let distanceOverlay_ = null;
    if (distance > 0) {
        let distanceText = distance >= 1000
            ? `${(distance / 1000).toFixed(1)}km`
            : `${distance}m`;

        distanceOverlay_ = new kakao.maps.CustomOverlay({
            content: `<div class="dotOverlay">거리 <span class="number">${distanceText}</span></div>`,
            position,
            yAnchor: 1,
            zIndex: 2
        });
        distanceOverlay_.setMap(map);
    }
    dots.push({ circle: circleOverlay, distance: distanceOverlay_ });
}

// 지도에서 원형 마커 삭제
function deleteCircleDot() {
    for (let i = 0; i < dots.length; i++) {
        if (dots[i].circle) dots[i].circle.setMap(null);
        if (dots[i].distance) dots[i].distance.setMap(null);
    }
    dots = [];
}

// 거리 및 시간 HTML 생성
function getTimeHTML(distance) {
    let distanceText = distance >= 1000
        ? `${(distance / 1000).toFixed(1)}km`
        : `${distance}m`;

    // 도보 시간 계산
    let walkTime = Math.floor(distance / 67);
    let walkHour = Math.floor(walkTime / 60);
    let walkMin = walkTime % 60;
    let walkTimeText = walkHour > 0
        ? `${walkHour}시간 ${walkMin}분`
        : `${walkMin}분`;

    // 자전거 시간 계산
    let bikeTime = Math.floor(distance / 227);
    let bikeHour = Math.floor(bikeTime / 60);
    let bikeMin = bikeTime % 60;
    let bikeTimeText = bikeHour > 0
        ? `${bikeHour}시간 ${bikeMin}분`
        : `${bikeMin}분`;

    return `
    <ul class="dotOverlay distanceInfo">
      <li><span class="label">총거리</span><span class="number">${distanceText}</span></li>
      <li><span class="label">도보</span>${walkTimeText}</li>
      <li><span class="label">자전거</span>${bikeTimeText}</li>
    </ul>`;
}

// 폴리라인 업데이트
function updatePolyline() {
    if (line) {
        line.setMap(null);
    }
    if (markerPositions.length < 2) return;

    line = new kakao.maps.Polyline({
        map,
        path: markerPositions,
        strokeWeight: 3,
        strokeColor: '#db4040',
        strokeOpacity: 1,
        strokeStyle: 'solid'
    });
}

// 거리 및 시간 업데이트
function updateDistanceAndTime() {
    if (!line || markerPositions.length < 2) {
        if (distanceOverlay) {
            distanceOverlay.setMap(null);
            distanceOverlay = null;
        }
        return;
    }

    let totalDistance = Math.round(line.getLength());
    let content = getTimeHTML(totalDistance);

    if (!distanceOverlay) {
        distanceOverlay = new kakao.maps.CustomOverlay({
            map,
            position: markerPositions[markerPositions.length - 1],
            content,
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3
        });
    } else {
        distanceOverlay.setContent(content);
        distanceOverlay.setPosition(markerPositions[markerPositions.length - 1]);
        distanceOverlay.setMap(map);
    }
}

/***************************************************
 * (N) 모달 열기
 ***************************************************/
function openPlaceModal(url){
    const modal = document.getElementById("myModal");
    const iframe = document.getElementById("modalIframe");
    if(!modal || !iframe) return;

    iframe.src=url;
    modal.style.display="block";

    const closeBtn = modal.querySelector(".close");
    if(closeBtn){
        closeBtn.onclick=()=>{
            modal.style.display="none";
            iframe.src="";
        };
    }
    window.onclick=(e)=>{
        if(e.target===modal){
            modal.style.display="none";
            iframe.src="";
        }
    };
}

/***************************************************
 * (O) 동행자 목록 표시 (예시)
 ***************************************************/
function renderCompanionList(){
    const companionList = document.getElementById("companionList");
    if(!companionList) return;

    companionList.innerHTML="";
    companions.forEach((c)=>{
        const li = document.createElement("li");
        li.textContent=`${c.memberEmail}`;
        companionList.appendChild(li);
    });
}

/***************************************************
 * (P) 최종 완료 버튼 이벤트
 ***************************************************/
document.addEventListener("DOMContentLoaded", function () {
    const finalizePlanBtn = document.getElementById("finalizePlanBtn");
    if (finalizePlanBtn) {
        console.log("최종 완료 버튼이 로드되었습니다.");
        finalizePlanBtn.addEventListener("click", finalizePlan);
    } else {
        console.error("최종 완료 버튼을 찾을 수 없습니다.");
    }
});
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

/***************************************************
 * (Q) 카테고리 마커 표시
 ***************************************************/

// 지도에 idle 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', searchPlaces);

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

// 카테고리 검색을 요청하는 함수입니다
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
        removeMarker();
    } else {
        currCategory = id;
        changeCategoryClass(this);
        searchPlaces();
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

/***************************************************
 * (R) 장소 추가 공통 함수
 ***************************************************/
function savePlaceToDB(placeName, placeAddress, placeId, x, y, placePhone, placeUrl) {
    let regionId = placeAddress.split(" ")[0];
    const placeDTO = {
        kakaoPlaceId: placeId,
        kakaoPlaceName: placeName,
        kakaoRoadAddressName: placeAddress,
        kakaoPhone: placePhone,
        kakaoX: x,
        kakaoY: y,
        kakaoPlaceUrl: placeUrl,
        regionId: regionId
    };

    return fetch('/daengdong/place/savePlace', {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(placeDTO)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error("실패 save place");
            }
            return response.text();
        });
}