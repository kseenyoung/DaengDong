$(document).ready(function () {
  $(document).on("click", "#sendButton", sendMessage);
  $(document).on("keypress", "#messageInput", pressEnter)
  const planId = 1;
  connectWebSocket(planId)

  let ws;

  function connectWebSocket(planID) {
    ws = new WebSocket("ws://localhost:5555/chat-ws?planId=" + planID);

    ws.onopen = function () {
      console.log("WebSocket 연결됨");
    };

    ws.onmessage = function (event) {
      const message = event.data;
      displayRecivedMessage(message)
    };

    ws.onclose = function () {
      console.log("WebSocket 연결이 종료되었습니다.");
    };

    ws.onerror = function (err) {
      console.log("WebSocket오류: " + err);
    };
  }

  function sendMessage() {
    const messageInput = $("#messageInput");
    const message = messageInput.value.trim();

    if (message) {
      ws.send(message);
      displaySentMessage(message);
      messageInput.value = "";
    }
  }

  function displaySentMessage(message) {
    const chatMassages = $("#chatMessages");

    const messageElement = `
      <div class="message sent">
        <div class="message-content">
          <p class="message-detail">${message}</p>
        </div>
      </div>
    `;

    chatMassages.innerHTML += messageElement;
    scrollToBottom(chatMassages);
  }

  function displayReceivedMessage(message) {
    const chatMessage = document.getElementById("chatMessages");

    const messageElement = `
      <div class="message received">
        <img src="${path}/img/kessnyoungProfile.jped" alt="user"/>
        <div class="message-content">
          <p class="message-detail">${message}</p>
        </div>
      </div>
      `;

    chatMessage.innerHTML += messageElement;
    scrollToBottom(chatMessage);
  }

  function scrollToBottom(element) {
    element.scrollTop = element.scrollHeight;
  }

  function pressEnter(e) {
    if (e.key === "Enter") {
      e.preventDefault();
      sendMessage();
    }
  }
});