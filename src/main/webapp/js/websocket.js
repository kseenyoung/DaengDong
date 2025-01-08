// const planId = 91; // 실제 플랜 ID를 동적으로 할당해야 합니다.
// const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
// const host = window.location.host;
// const webSocketUrl = `${protocol}//${host}/daengdong/shareMap-ws?planId=${planId}`;
//
// const webSocket = new WebSocket(webSocketUrl);

webSocket.onopen = function () {
    console.log("WebSocket 연결 성공");
};

webSocket.onmessage = function (event) {
    const message = JSON.parse(event.data);
    console.log(event.data); // 웹소켓 메시지 확인

    if (message.type === "shareMap") {
        const bounds = new kakao.maps.LatLngBounds(
            new kakao.maps.LatLng(message.bounds.swLat, message.bounds.swLng),
            new kakao.maps.LatLng(message.bounds.neLat, message.bounds.neLng)
        );

        const center = new kakao.maps.LatLng(message.center.lat, message.center.lng);

        map.setBounds(bounds);
        map.setCenter(center);

        alert("호스트가 맵 화면을 공유했습니다.");
    }
};

webSocket.onerror = function (error) {
    console.error("WebSocket 오류:", error);
};

webSocket.onclose = function () {
    console.log("WebSocket 연결이 종료되었습니다.");
};

document.getElementById("shareScreenBtn").addEventListener("click", function () {
    const mapBounds = map.getBounds();
    const mapCenter = map.getCenter();

    const mapData = {
        type: "shareMap",
        data: {
            bounds: {
                swLat: mapBounds.getSouthWest().getLat(),
                swLng: mapBounds.getSouthWest().getLng(),
                neLat: mapBounds.getNorthEast().getLat(),
                neLng: mapBounds.getNorthEast().getLng()
            },
            center: {
                lat: mapCenter.getLat(),
                lng: mapCenter.getLng()
            }
        }
    };

    webSocket.send(JSON.stringify(mapData));
    alert("맵 화면이 공유되었습니다.");
});