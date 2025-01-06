$(document).ready(function () {
  $(document).on("click", "#sendButton", sendMessage);
  $(document).on("keypress", "#messageInput", pressEnter)
  const planId = 1;
  let ws;
  connectWebSocket(planId)

  function connectWebSocket(planID) {
    const wsUrl = `ws://localhost:5555/daengdong/chat-ws?planId=${planID}`;

    // const wsUrl = `${window.location.protocol === 'https:' ? 'wss:' : 'ws:'}
    // //${window.location.host}/daengdong/chat-ws?planId=${planID}`;
    ws = new WebSocket(wsUrl);

    ws.onopen = function () {
      console.log("WebSocket 연결됨");
    };

    ws.onmessage = function (event) {
      const message = JSON.parse(event.data);
      const currentUser = `${sessionScope.member.member_nickname}`

      if (message.sender === currentUser) {
        return;
      }

      displayReceivedMessage(message.content, message.sender);
    };

    ws.onclose = function () {
      console.log("WebSocket 연결이 종료되었습니다.");
    };

    ws.onerror = function (err) {
      console.error("WebSocket 연결 오류:", err);
      // 재연결 로직 추가
      setTimeout(() => {
        console.log("WebSocket 재연결 시도...");
        connectWebSocket(planID);
      }, 3000);    };
  }

  function sendMessage() {
    const messageInput = $("#messageInput");
    const message = {
      type: "CHAT",
      sender: `${sessionScope.member.member_email}`,
      content: messageInput.val().trim()
    };

    if (message.content) {
      ws.send(JSON.stringify(message));
      displaySentMessage(message.content);
      messageInput.val("");
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
        <img src="${path}/img/kseenyoungProfile.jpeg" alt="user"/>
        <div class="message-content">
          <span class="sender-anme">${sender}</span>
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