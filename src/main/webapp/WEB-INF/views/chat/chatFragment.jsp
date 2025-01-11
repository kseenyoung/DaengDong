<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/5/25
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const path = "${pageContext.servletContext.contextPath}";
  const memberEmail = "${sessionScope.member.member_email}";
  const memberName = "${sessionScope.member.member_name}";
  const memberNickname = "${sessionScope.member.member_nickname}";
  const profilePhoto = "${sessionScope.member.member_profile_photo}";
</script>
<link rel="stylesheet" href="${path}/css/chat/chat.css"/>

<div class="chat-container">
    <!-- 제목 영역 -->
    <div class="chat-header">
        <span class="chat-title">채팅방</span>
        <button id="closeChatModal" class="close-btn">✖</button>
    </div>

    <!-- 메시지 표시 영역 -->
    <div class="chat-messages" id="chatMessages"></div>

    <!-- 입력란 -->
    <div class="chat-input">
        <input type="text" id="messageInput" placeholder="Type a message here..." />
        <button id="sendButton">Send</button>
    </div>
</div>