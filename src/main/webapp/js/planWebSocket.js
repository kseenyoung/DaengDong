$(function () {
    const socket = new WebSocket("ws://localhost:5555/daengdong/place-ws");

    // 사용자 이벤트 추적 및 전송
    function trackEvents() {
        // 마우스 움직임 이벤트
        $(document).on("mousemove", function (event) {
            const data = {
                type: "mousemove",
                x: event.clientX,
                y: event.clientY
            };
            socket.send(JSON.stringify(data));
        });

        // 클릭 이벤트
        $(document).on("click", function (event) {
            const data = {
                type: "click",
                x: event.clientX,
                y: event.clientY,
                target: event.target.tagName
            };
            socket.send(JSON.stringify(data));
        });

        // 키보드 입력 이벤트
        $(document).on("keypress", function (event) {
            const data = {
                type: "keypress",
                key: event.key
            };
            socket.send(JSON.stringify(data));
        });
    }

    // WebSocket 연결 성공 시 이벤트 추적(마우스, 키보드, 버튼) 시작
    socket.onopen = function () {
        console.log("WebSocket 연결 성공");
        trackEvents();
    };

    // 서버에서 받은 데이터를 기반으로 화면 업데이트
    socket.onmessage = function (event) {
        const data = JSON.parse(event.data);
        console.log("수신된 데이터:", data); // 로그 추가

        if (data.type === "mousemove") {
            updateMouseCursor(data.x, data.y);
        } else if (data.type === "click") {
            highlightElement(data.x, data.y);
        } else if (data.type === "keypress") {
            console.log(`키 입력: ${data.key}`);
        }
    };

    // 마우스 커서 업데이트
    function updateMouseCursor(x, y) {
        let $cursor = $("#remoteCursor");
        if ($cursor.length === 0) {
            $cursor = $("<div>")
                .attr("id", "remoteCursor")
                .css({
                    position: "absolute",
                    width: "10px",
                    height: "10px",
                    "background-color": "blue",
                    "border-radius": "50%"
                });
            $("body").append($cursor);
        }
        $cursor.css({left: x, top: y});
    }

    // 클릭된 요소 강조
    function highlightElement(x, y) {
        const $highlight = $("<div>")
            .css({
                position: "absolute",
                left: x,
                top: y,
                width: "20px",
                height: "20px",
                "background-color": "rgba(255, 0, 0, 0.5)",
                "border-radius": "50%",
                "pointer-events": "none",
                "z-index": 9999
            });
        $("body").append($highlight);

        // 강조 효과 제거
        setTimeout(() => $highlight.remove(), 500);
    }

    socket.onclose = function () {
        console.log("WebSocket 연결 종료");
    };

    socket.onerror = function (error) {
        console.error("WebSocket 에러:", error);
    };
});