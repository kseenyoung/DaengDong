<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/7/25
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<div class="semiCategories">
    <ul>
        <li class="action-item" id="locked-card">보유한 카드</li>
        <li class="action-item" id="unlocked-card">보유하지 못한 카드</li>
    </ul>
</div>