$(document).ready(function () {
  $(document).off("click", "#sendButton")
  $(document).off("keypress", "#messageInput")

  $(document).on("click", "#sendButton", sendMessage);
  $(document).on("keypress", "#messageInput", pressEnter)

  const planId = 1;
  let ws;
  connectWebSocket(planId)

  function connectWebSocket(planId) {
    const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
    const host = window.location.host;
    const wsUrl = `${protocol}//${host}/daengdong/chat-ws?planId=${planId}`

    ws = new WebSocket(wsUrl);

    ws.onopen = function () {
      console.log("WebSocket 연결됨");
    };

    ws.onmessage = function (e) {
      const message = JSON.parse(e.data);
      let currentUser = memberNickname || memberName || "Anonymous";

      if (message.sender === currentUser) {
        return;
      }
      displayReceivedMessage(message.content, message.sender, message.profilePhoto);
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
      }, 3000);
    };
  }

  function sendMessage() {
    if (ws.readyState !== WebSocket.OPEN) {
      console.log("WebSocket이 연결되지 않았습니다.")
      return;
    }

    const messageInput = $("#messageInput");
    // let messageSender = memberNickname || memberName || "Anonymous";

    // console.log("메세지 발신자>>sendMessage sender: " + messageSender)

    const message = {
      type: "CHAT",
      sender: memberNickname || memberName || "Anonymous",
      content: messageInput.val().trim(),
      profilePhoto: profilePhoto
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

    chatMassages.append(messageElement);
    scrollToBottom(chatMassages[0]);
  }

  function displayReceivedMessage(message, sender, photo) {
    const chatMessage = $("#chatMessages");

    const messageElement = `
      <div class="message received">
        <img src="${photo || `${path}/img/kseenyoungProfile.jpeg`}" alt="user"/>
        <div class="message-wrapper">
          <span class="sender-name">${sender}</span>
          <span class="message-content">${message}</span>
        </div>
      </div>
      `;

    chatMessage.append(messageElement);
    scrollToBottom(chatMessage[0]);
  }

  function scrollToBottom(element) {
    if (element) {
      element.scrollTop = element.scrollHeight;
    }
  }

  function pressEnter(e) {
    if (e.key === "Enter") {
      e.preventDefault();
      sendMessage();
    }
  }
});