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
        <li class="action-item" id="my-planning">계획중</li>
        <li class="action-item" id="my-traveling">여행중</li>
        <li class="action-item" id="my-travel-complete">여행완료</li>
    </ul>
</div>