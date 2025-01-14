<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 1/7/25
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<link rel="stylesheet" href="${path}/css/member/myPlan.css">
<c:forEach var="completePlan" items="${completePlan}">
    <div class="announcement-plan" data-plan-id="${completePlan.planId}">
        <img id="placeImg" src="" alt="placeImg">
        <div class="text-container">
            <h2 class="place-title">
                <a>${completePlan.planName}</a>
            </h2>
            <div class="place-address-container">
                <span class="place-address">${completePlan.startDate} ~ ${completePlan.endDate}</span>
                <c:if test="${completePlan.planState == 1}">
                    <span class="place-address">공개</span>
                </c:if>
                <c:if test="${completePlan.planState == 0}">
                    <span class="place-address">비공개</span>
                </c:if>
            </div>
        </div>
        <div class="button-container">
            <button class="delete-plan" data-plan-id="${completePlan.planId}">삭제</button>
        </div>
    </div>
</c:forEach>
