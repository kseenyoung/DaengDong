const socket = new WebSocket("ws://localhost:5555/websocket/plan");

socket.onmessage = function(event) {
    const data = JSON.parse(event.data);
    // 받은 데이터를 바탕으로 화면 업데이트
    updateUI(data);
};

function updateUI(data) {
    // 데이터에 따라 DOM을 변경하거나, 일정 정보를 갱신합니다.
    console.log(data);
    // 예시: 동행자 리스트 UI 갱신
    if (data.type === "updateCompanions") {
        const companionList = document.getElementById("companionList");
        companionList.innerHTML = ""; // 기존 리스트 초기화
        data.companions.forEach(email => {
            const listItem = document.createElement("li");
            listItem.textContent = email;
            companionList.appendChild(listItem);
        });
    }
}