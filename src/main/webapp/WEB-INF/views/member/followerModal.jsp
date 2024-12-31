<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/30/24
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<link rel="stylesheet" href="${path}/css/member/followModal.css"/>
<body>
<div id="followModal" class="modal fade" tabindex="-1" aria-labelledby="shareProjectLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="shareProjectLabel">팔로워</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="mb-3">
                    <c:forEach var="followerList" items="${followerList}">
                        <div class="d-flex justify-content-between align-items-center mb-2 follower-list">
                            <div>
                                <img src="${path}/img/${followerList.member_profile_photo}"
                                     alt="${followerList.member_profile_photo}" class="rounded-circle" width="40"
                                     height="40">
                                <span class="ml-2">${followerList.member_nickname}</span>
                            </div>
                            <c:if test="${followerList.is_following_back == 0}">
                                <button class="btn btn-primary btn-sm insert-follower">팔로우</button>
                            </c:if>
                            <c:if test="${followerList.is_following_back == 1}">
                                <button id="delete-follow" class="btn btn-primary btn-sm delete-following"
                                        data-to-email="${followerList.member_email}">팔로잉
                                </button>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Trigger Button -->
<button id="modal-trigger-button" type="button" class="btn btn-primary" data-toggle="modal" data-target="#followModal"
        hidden="hidden">
    Open Share Modal
</button>

</body>
</html>