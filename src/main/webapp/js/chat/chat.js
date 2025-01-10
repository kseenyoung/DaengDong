$(document).ready(function () {
  $(document).off("click", "#sendButton")
    .off("keypress", "#messageInput")
    .off("click", "#closeChatModal");

  $(document).on("click", "#sendButton", sendMessage);
  $(document).on("keypress", "#messageInput", pressEnter);
  $(document).on("click", "#closeChatModal", closeChatModal);

  const chatHistory = [];
  const planId = currentPlanId;
  console.log(planId);
  let ws;
  connectWebSocket(planId)

  const chatModal = document.getElementById("chatModal");
  const btnChat = document.getElementById("btnChat");
  const chatContent = document.getElementById("chatContent");

  // 채팅 모달 열기
  btnChat.addEventListener("click", function () {
    console.log("listener: " + planId);
    // AJAX로 chatFragment.jsp를 로드
    fetch(`${path}/chat/room/${planId}`)
      .then(response => response.text())
      .then(data => {
        chatContent.innerHTML = data; // 로드된 콘텐츠 삽입
        $("#chatModal").fadeIn(); // jQuery로 fadeIn 효과

        setTimeout(() => {
          loadChatHistory();
          hideUnreadBadge();
        }, 0);
      })
      .catch(error => console.error("Error loading chatFragment:", error));
  });

  function closeChatModal() {
    $("#chatModal").fadeOut();
  }

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

      if (message.sender === currentUser) return;

      const chatModal = document.getElementById("chatModal");
      if (chatModal.style.display === "none" || chatModal.style.display === "") {
        showUnreadBadge();
      }

      // 채팅방이 열려 있으면 메시지 표시
      if (chatModal.style.display === "block") {
        displayReceivedMessage(message.content, message.sender, message.profilePhoto);
      }
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

  // 뱃지 표시 함수
  function showUnreadBadge() {
    const unreadBadge = document.getElementById("unreadBadge");
    unreadBadge.style.display = "inline";
  }

// 뱃지 숨기기 함수 (채팅방 열릴 때 호출)
  function hideUnreadBadge() {
    const unreadBadge = document.getElementById("unreadBadge");
    unreadBadge.style.display = "none";
  }

  function sendMessage() {
    if (ws.readyState !== WebSocket.OPEN) {
      console.log("WebSocket이 연결되지 않았습니다.")
      return;
    }

    const messageInput = $("#messageInput");

    const message = {
      type: "CHAT",
      sender: memberNickname || memberName || "Anonymous",
      content: messageInput.val().trim(),
      profilePhoto: profilePhoto
    };

    if (message.content) {
      chatHistory.push(message);
      console.log(chatHistory);
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

  function loadChatHistory() {
    const chatMessages = $("#chatMessages");
    chatMessages.empty(); // 기존 DOM 초기화

    // 이전 메시지 렌더링
    chatHistory.forEach((message) => {
      if (message.sender === (memberNickname || memberName || "Anonymous")) {
        displaySentMessage(message.content);
      } else {
        displayReceivedMessage(message.content, message.sender, message.profilePhoto);
      }
    });
  }

  // 모달 닫기
  $("#closeChatModal").on("click", function () {
    $("#chatModal").fadeOut(); // 모달 닫기
  });
});