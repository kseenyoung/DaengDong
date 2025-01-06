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
<link rel="stylesheet" href="${path}/css/chat/chat.css"/>
<script src="${path}/js/Chat.js"></script>
<div class="chat-container">
    <!-- 메시지 표시 영역 -->
    <div class="chat-messages" id="chatMessages">
        <!-- 예제 메시지: 내가 보낸 메시지 (오른쪽 정렬) -->
        <div class="message sent">
            <div class="message-content">
                <p class="message-detail">얘들아 여기 어때?</p>
            </div>
        </div>
        <span class="timestamp" hidden="hidden">10:30 AM</span>

        <!-- 예제 메시지: 받은 메시지 (왼쪽 정렬) -->
        <div class="message received">
            <img src="${path}/img/kseenyoungProfile.jpeg" alt="User">
            <div class="message-content">
                <p class="message-detail">와 우리 댕댕이도 데려가고싶다!!</p>
            </div>
        </div>
        <span class="timestamp" hidden="hidden">10:31 AM</span>
    </div>

    <!-- 입력란 -->
    <div class="chat-input">
        <input type="text" id="messageInput" placeholder="Type a message here..." />
        <button id="sendButton">Send</button>
    </div>
</div>