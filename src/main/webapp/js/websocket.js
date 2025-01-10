//let planId = window.location.pathname.split("/").filter(Boolean).pop();

// if (!planId || isNaN(planId)) {
//     console.error("URL에 planId가 포함되지 않았습니다.");
//     // 필요시 기본값 설정 또는 사용자 알림 추가
// }
planId = window.planId;
const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
const host = window.location.host;
const webSocketUrl = `${protocol}//${host}/daengdong/shareMap-ws?planId=${planId}`;

const webSocket = new WebSocket(webSocketUrl);

webSocket.onopen = function () {
    console.log("WebSocket 연결 성공");
};

webSocket.onmessage = function (event) {
    const message = JSON.parse(event.data);
    //console.log("받은 데이터:", message);

    if (message.type === "shareMap") {
        const place = message.data;
        console.log(place);

        // 로컬 메모리에 추가
        //inMemoryPlaces.push(place);

        // 화면 업데이트
        //addPlaceToUI(place);
        //console.log("받은 장소 데이터:", place);

        alert("호스트가 맵 화면을 공유했습니다.");
    }
};

// 화면에 장소를 추가하는 함수
// function addPlaceToUI(place) {
//     const list = document.getElementById("placeList");
//     const listItem = document.createElement("li");
//
//     // 장소 정보를 HTML로 렌더링
//     listItem.innerHTML = `
//         <strong>${place.name}</strong><br>
//         좌표: (${place.x}, ${place.y})<br>
//         <a href="${place.url}" target="_blank">상세보기</a>
//     `;
//
//     list.appendChild(listItem);
// }

webSocket.onerror = function (error) {
    console.error("WebSocket 오류:", error);
};

webSocket.onclose = function () {
    console.log("WebSocket 연결이 종료되었습니다.");
};