document.addEventListener("DOMContentLoaded", function () {
  const chatModal = document.getElementById("chatModal");
  const btnChat = document.getElementById("btnChat");
  const closeChatModal = document.getElementById("closeChatModal");
  const chatContent = document.getElementById("chatContent");

  // 채팅 모달 열기
  btnChat.addEventListener("click", function () {
    // AJAX로 chatFragment.jsp를 로드
    fetch(`${path}/plan/viewChatRoom.do`)
      .then(response => response.text())
      .then(data => {
        chatContent.innerHTML = data; // 로드된 콘텐츠 삽입
        chatModal.style.display = "block"; // 모달 보이기
      })
      .catch(error => console.error("Error loading chatFragment:", error));
  });

  // 채팅 모달 닫기
  closeChatModal.addEventListener("click", function () {
    chatModal.style.display = "none"; // 모달 숨기기
  });
});