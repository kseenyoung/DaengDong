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
<body>
<div id="followModal" class="modal fade" tabindex="-1" aria-labelledby="shareProjectLabel" aria-hidden="true">
    <div id="followModal-dialog" class="modal-dialog">
        <div id="followModal-content" class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="shareProjectLabel">팔로잉</h5>
                <button class="follow-modal-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <div class="mb-3">
                    <c:forEach var="followingList" items="${followingList}">
                        <div class="d-flex justify-content-between align-items-center mb-2 following-list">
                            <div>
                                <img src="${path}/img/${followingList.member_profile_photo}"
                                     alt="${followingList.member_profile_photo}" class="rounded-circle" width="40"
                                     height="40">
                                <span class="ml-2">${followingList.member_nickname}</span>
                            </div>
                            <button id="delete-follow" class="btn btn-primary btn-sm delete-following"
                                    data-to-email="${followingList.member_email}">팔로잉
                            </button>
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