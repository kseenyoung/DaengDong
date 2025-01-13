//let planId = window.G_planId || "0";

// if (!planId || isNaN(planId)) {
//     console.error("URL에 planId가 포함되지 않았습니다.");
//     // 필요시 기본값 설정 또는 사용자 알림 추가
// }
//let planId = [];
// console.log("JSP에서 전달된 planId:", planId);
// const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
// const host = window.location.host;
// const webSocketUrl = `${protocol}//${host}/daengdong/shareMap-ws?planId=${planId}`;

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

        const { kakaoPlaceName, kakaoRoadAddressName, kakaoPhone, kakaoX, kakaoY, kakaoPlaceUrl, kakaoPlaceId, regionId, dateDifference, selectedDay } = place;
        // const dateDifference = place.dateDifference;
        createDayButtons(dateDifference);

        // UI에 장소 추가
        addPlaceToPlan(kakaoPlaceName, kakaoRoadAddressName, kakaoPlaceId,kakaoX, kakaoY, selectedDay);

        // 해당 날짜의 일정 업데이트
        displayDayPlan(selectedDay, place);

        alert("호스트가 맵 화면을 공유했습니다.");
    }

};

webSocket.onerror = function (error) {
    console.error("WebSocket 오류:", error);
};

webSocket.onclose = function () {
    console.log("WebSocket 연결이 종료되었습니다.");
};