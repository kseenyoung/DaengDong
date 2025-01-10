<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/9/25
  Time: 12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<div class="edit-nickname-container">
    <span class="edit-nickname-label"></span>
    <input id="edit-nickname-input" type="text" name="nickName" class="edit-nickname-input" placeholder="새 닉네임 입력" />
    <button id="edit-nickname-success" class="edit-nickname-success">
        <i class="fas fa-check"></i>
    </button>
    <button id="edit-nickname-cancel" class="edit-nickname-cancel">
        <i class="fas fa-times"></i>
    </button>
</div>