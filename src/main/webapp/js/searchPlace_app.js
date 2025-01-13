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
    initWebSocket(planId);

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
                id: kakaoPlaceId
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
    placeOverlay = new kakao.maps.CustomOverlay({zIndex:1});
    contentNode = document.createElement('div');
    contentNode.className = 'placeinfo_wrap';
    placeOverlay.setContent(contentNode);

    //kakao.maps.event.addListener(map, "idle", searchCategoryMarkers);

    // 지도에 클릭하면 핀 추가
    //kakao.maps.event.addListener(map, "click", (mouseEvent) => {
        //addPin(mouseEvent.latLng);
    //});

    // 선 그리기 이벤트
    //kakao.maps.event.addListener(map, 'click', handleMapClick);
    //kakao.maps.event.addListener(map, 'mousemove', handleMapMouseMove);
    //kakao.maps.event.addListener(map, 'rightclick', handleMapRightClick);
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
const socketId = `client-${Math.random().toString(36).substring(7)}`;
let webSocket = null;
function initWebSocket(planId) {
    const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
    const host = window.location.host;
    const webSocketUrl = `${protocol}//${host}/daengdong/shareMap-ws?planId=${planId}`;
    console.log("WebSocket 연결 시도:", webSocketUrl);

    webSocket = new WebSocket(webSocketUrl);

    webSocket.onopen = () => {
        console.log("WebSocket 연결 성공");
    };

    webSocket.onerror = (err) => {
        console.error("WebSocket 오류:", err);
    };

    webSocket.onclose = () => {
        console.log("WebSocket 종료");
    };

    webSocket.onmessage = (evt) => {
        const msg = JSON.parse(evt.data);

        // 본인이 보낸 메시지인지 확인 (고유 sender ID 사용)
        if (msg.sender === "host") {
            console.log("본인이 보낸 메시지입니다. 이미 처리했으므로 동작하지 않습니다.");
            return;
        }

        if (msg.type === "deletePlace") {
            const { kakaoPlaceId, day } = msg.data;
            console.log("받은 삭제 데이터:", msg.data);

            // 해당 일차의 dayPlans에서 장소 제거
            if (dayPlans[day]) {
                dayPlans[day] = dayPlans[day].filter(place => place.id !== kakaoPlaceId);
            }

            // 지도에서 마커 제거
            const markerIndex = customMarkers.findIndex(m => m.title === kakaoPlaceId);
            if (markerIndex !== -1) {
                customMarkers[markerIndex].customMarker.setMap(null);
                customMarkers.splice(markerIndex, 1);
            }

            // UI 업데이트
            displayDayPlan(day);
            alert("다른 사용자가 장소를 삭제했습니다!");
        }

        if(msg.type === "shareMap") {
            const place = msg.data;
            console.log("받은 장소 데이터:", place);

            const {
                kakaoPlaceName, kakaoRoadAddressName,
                kakaoX, kakaoY,
                kakaoPlaceId, selectedDay
            } = place;

            // 이미 dayPlans 구조가 있으므로, 받은 데이터를 로컬 일정에 추가
            addPlaceToPlan(kakaoPlaceName, kakaoRoadAddressName, kakaoPlaceId, kakaoX, kakaoY, selectedDay);
            alert("다른 사람이 장소를 추가했습니다!");
        }
    };
}

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
        const { title, address, x, y, id } = item;

        const li = document.createElement("li");
        li.classList.add("place-item");

        const numSpan = document.createElement("span");
        numSpan.classList.add("placeNumber");
        numSpan.textContent = (index+1)+". ";

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

            // WebSocket으로 삭제 정보 전송
            if (webSocket && webSocket.readyState === WebSocket.OPEN) {
                webSocket.send(JSON.stringify({
                    type: "deletePlace",
                    sender: "host",
                    planId: window.G_planId,
                    data: {
                        kakaoPlaceId: id, // 삭제할 장소의 kakaoPlaceId
                        day: day          // 삭제할 장소의 n일차
                    }
                }));
            }
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
    // const placeData = {
    //     planId: window.G_planId,
    //     kakaoPlaceId,
    //     day
    // }
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

        //li.textContent = comp.nickname+"("+comp.memberEmail+")";
        li.textContent = comp.memberEmail;
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
    if(!keyword) keyword="홍대 맛집";

    ps.keywordSearch(keyword, placesSearchCB);
}

// placesSearchCB
function placesSearchCB(data, status, pagination){
    if(status === kakao.maps.services.Status.OK){
        displayPlaces(data);
        displayPagination(pagination);
    } else if(status === kakao.maps.services.Status.ZERO_RESULT){
        alert("검색결과가 없습니다.");
    } else {
        alert("검색 중 오류 발생");
    }
}

// 검색 결과 목록 표시
function displayPlaces(places){
    const listEl = document.getElementById("placesList");
    const menuEl = document.getElementById("menu_wrap");
    if(!listEl || !menuEl) return;

    removeAllChildNods(listEl);
    removeMarker();

    let bounds = new kakao.maps.LatLngBounds();

    places.forEach((place, i)=>{
        const placePosition = new kakao.maps.LatLng(place.y, place.x);

        const marker = addMarker(placePosition, i, place.place_name, place);
        bounds.extend(placePosition);

        // 목록 li
        const li = document.createElement("li");
        li.classList.add("place-item");

        const h4 = document.createElement("h4");
        h4.textContent=place.place_name;
        li.appendChild(h4);

        const p = document.createElement("p");
        p.textContent=place.address_name || "(주소 없음)";
        li.appendChild(p);

        const btn = document.createElement("button");
        btn.className="add-btn";
        btn.textContent="+ 내 일정에 추가";

        // data
        btn.dataset.placeName = place.place_name;
        btn.dataset.placeAddress = place.address_name;
        btn.dataset.placePhone = place.phone;
        btn.dataset.placeUrl = place.place_url;
        btn.dataset.placeX = place.x;
        btn.dataset.placeY = place.y;
        btn.dataset.placeId= place.id;

        li.appendChild(btn);
        listEl.appendChild(li);
    });

    menuEl.scrollTop=0;
    map.setBounds(bounds);
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
        const placeId = btn.dataset.placeId;

        // 1) 로컬에 일정 추가
        addPlaceToPlan(placeName, placeAddress, placeId, x, y);

        // 2) DB 저장 (카카오 장소 관련 값들을 JSON으로 전송)
        const regionId = placeAddress.split(" ")[0]; // '서울', '경기' 등 지역 추출
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

        fetch('/daengdong/place/savePlace', {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(placeDTO)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("실패 save place");
                }
                return response.text();
            })
            .then(data => {
                console.log("DB 저장 성공:", data);
            })
            .catch(error => {
                console.error("DB 저장 오류:", error);
            });

        // 웹소켓 전송
        if(webSocket && webSocket.readyState===WebSocket.OPEN){
            webSocket.send(JSON.stringify({
                type: "shareMap",
                sender: "host",
                planId: window.G_planId,
                data: {
                    kakaoPlaceName: placeName,
                    kakaoRoadAddressName: placeAddress,
                    kakaoPhone: placePhone,
                    kakaoX: x,
                    kakaoY: y,
                    kakaoPlaceUrl: placeUrl,
                    kakaoPlaceId: placeId,
                    selectedDay: getSelectedDay()
                }
            }));
        }
        alert("장소가 공유되었습니다!");
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
    const sidebar = document.getElementById("sidebar");
    const template = document.getElementById("sidebar-template");
    if(!sidebar || !template) return;

    sidebar.innerHTML = template.innerHTML;

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
            addPlaceToPlan(place.place_name, place.address_name, place.id, place.x, place.y);
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
    const imageSrc = "/img/red_marker.png"; // 실제 경로
    const imageSize = new kakao.maps.Size(24,35);
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

// 폴리라인
function deleteClickLine(){
    if(clickLine){
        clickLine.setMap(null);
        clickLine=null;
    }
}
function showDistance(content, position){
    if(distanceOverlay){
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
    } else {
        distanceOverlay = new kakao.maps.CustomOverlay({
            map,
            content,
            position,
            xAnchor:0,
            yAnchor:0,
            zIndex:3
        });
    }
}
function deleteDistnce(){
    if(distanceOverlay){
        distanceOverlay.setMap(null);
        distanceOverlay=null;
    }
}
function displayCircleDot(position, distance){
    let circleOverlay = new kakao.maps.CustomOverlay({
        content:'<span class="dot"></span>',
        position,
        zIndex:1
    });
    circleOverlay.setMap(map);

    let distanceOverlay_=null;
    if(distance>0){
        distanceOverlay_= new kakao.maps.CustomOverlay({
            content:`<div class="dotOverlay">거리 <span class="number">${distance}</span>m</div>`,
            position,
            yAnchor:1,
            zIndex:2
        });
        distanceOverlay_.setMap(map);
    }
    dots.push({circle: circleOverlay, distance: distanceOverlay_});
}
function deleteCircleDot(){
    for(let i=0;i<dots.length;i++){
        if(dots[i].circle) dots[i].circle.setMap(null);
        if(dots[i].distance) dots[i].distance.setMap(null);
    }
    dots=[];
}
function getTimeHTML(distance){
    let walkTime = Math.floor(distance/67);
    let bikeTime = Math.floor(distance/227);

    let walkHour="", walkMin = (walkTime%60)+"분";
    if(walkTime>60) walkHour=(Math.floor(walkTime/60)+"시간 ");
    let bikeHour="", bikeMin=(bikeTime%60)+"분";
    if(bikeTime>60) bikeHour=(Math.floor(bikeTime/60)+"시간 ");

    let content = `
    <ul class="dotOverlay distanceInfo">
      <li><span class="label">총거리</span><span class="number">${distance}</span>m</li>
      <li><span class="label">도보</span>${walkHour}${walkMin}</li>
      <li><span class="label">자전거</span>${bikeHour}${bikeMin}</li>
    </ul>`;
    return content;
}

// 폴리라인 업데이트
function updatePolyline(){
    if(line){
        line.setMap(null);
    }
    if(markerPositions.length<2) return;
    line = new kakao.maps.Polyline({
        map,
        path: markerPositions,
        strokeWeight:3,
        strokeColor:'#db4040',
        strokeOpacity:1,
        strokeStyle:'solid'
    });
}
function updateDistanceAndTime(){
    if(!line || markerPositions.length<2){
        if(distanceOverlay){
            distanceOverlay.setMap(null);
            distanceOverlay=null;
        }
        return;
    }
    let totalDistance = Math.round(line.getLength());
    let walkTime = Math.floor(totalDistance/67);
    let bikeTime = Math.floor(totalDistance/227);

    let content=`
    <ul class="dotOverlay distanceInfo">
      <li><span class="label">총거리</span><span class="number">${totalDistance}</span>m</li>
      <li><span class="label">도보</span>${Math.floor(walkTime/60)}시간 ${walkTime%60}분</li>
      <li><span class="label">자전거</span>${Math.floor(bikeTime/60)}시간 ${bikeTime%60}분</li>
    </ul>`;

    if(!distanceOverlay){
        distanceOverlay=new kakao.maps.CustomOverlay({
            map,
            position: markerPositions[markerPositions.length-1],
            content,
            xAnchor:0,
            yAnchor:0,
            zIndex:3
        });
    } else {
        distanceOverlay.setContent(content);
        distanceOverlay.setPosition(markerPositions[markerPositions.length-1]);
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
        // li.textContent=`${c.nickname}(${c.memberEmail})`;
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
