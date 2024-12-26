<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 02:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My page</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
      $(document).ready(function () {
        $.ajax({
          url: `${path}/auth/getProfileFragment.do`,
          type: "get",
          success: function (response) {
            $("#left-section").html(response);
          },
          error: function (err) {
            console.log(err)
          }
        });

        $("#myTripFragment").on("click", moveToMyTrip);
        $("#mySaveFragment").on("click", getSemiSaveCategory);
        $("#semiCategories").on("click", ".action-item", injectAction);

        // $("#myFavoritePlace").on("click", getFavoritePlace)

        function moveToMyTrip() {
          $.ajax({
            url: `${path}/auth/getSemiSaveCategory.do`,
            type: "get",
            success: function (response) {
              console.log("success")
              $("#myTripFragment").css("color", "#0AB75B")
              $("#myPhotoCardFragment").css("color", "#8a8a8a")
              $("#mySaveFragment").css("color", "#8a8a8a")
              $("#semiCategories").html(response);
            },
            error: function (err) {
              console.log(err);
            }
          });
        }

        function getSemiSaveCategory() {
          $.ajax({
            url: `${path}/auth/getSemiSaveCategory.do`,
            type: "get",
            success: function (response) {
              $("#myTripFragment").css("color", "#8a8a8a")
              $("#myPhotoCardFragment").css("color", "#8a8a8a")
              $("#mySaveFragment").css("color", "#0AB75B")
              $("#semiCategories").html(response);
            },
            error: function (err) {
              console.log(err);
            }
          });
        }

        function injectAction(eventName) {
          let eventId = $(eventName.target).attr("id");

          switch (eventId) {
            case "myFavoritePlace":
              getFavoritePlace();
              break;
            case "myReview":
              getReview();
              break;
            case "myLikes":
              getLikes();
              break;
            case "myPosts":
              getPosts();
              break;
          }
        }

        function getFavoritePlace() {
          $.ajax({
            url: `${path}/auth/getFavoritePlace.do`,
            type: "get",
            success: function (response) {
              console.log(response);
              $("#myFavoritePlace").css("color", "#0AB75B")
              $("#myReview").css("color", "#8a8a8a")
              $("#myLikes").css("color", "#8a8a8a")
              $("#myPosts").css("color", "#8a8a8a")
              $("#announcement-box").html(response);
            },
            error: function (err) {
              console.log(err);
            }
          });
        }

        function getReview() {
          $.ajax({
            url: `${path}/auth/getFavoritePlace.do`,
            type: "get",
            success: function (response) {
              console.log(response);
              $("#myFavoritePlace").css("color", "#8a8a8a")
              $("#myReview").css("color", "#0AB75B")
              $("#myLikes").css("color", "#8a8a8a")
              $("#myPosts").css("color", "#8a8a8a")
              $("#announcement-box").html(response);
            },
            error: function (err) {
              console.log(err);
            }
          });
        }

        function getLikes() {
          $.ajax({
            url: `${path}/auth/getFavoritePlace.do`,
            type: "get",
            success: function (response) {
              console.log(response);
              $("#myFavoritePlace").css("color", "#8a8a8a")
              $("#myReview").css("color", "#8a8a8a")
              $("#myLikes").css("color", "#0AB75B")
              $("#myPosts").css("color", "#8a8a8a")
              $("#announcement-box").html(response);
            },
            error: function (err) {
              console.log(err);
            }
          });
        }

        function getPosts() {
          $.ajax({
            url: `${path}/auth/getFavoritePlace.do`,
            type: "get",
            success: function (response) {
              console.log(response);
              $("#myFavoritePlace").css("color", "#8a8a8a")
              $("#myReview").css("color", "#8a8a8a")
              $("#myLikes").css("color", "#8a8a8a")
              $("#myPosts").css("color", "#0AB75B")
              $("#announcement-box").html(response);
            },
            error: function (err) {
              console.log(err);
            }
          });
        }
      });
    </script>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="grid-container">
    <!-- Left Section -->
    <aside id="left-section" class="profile-fragment">

    </aside>

    <!-- Right Section -->
    <div class="right-section">
        <!-- 상단 카테고리 -->
        <div class="categories">
            <ul>
                <li id="myTripFragment">내 여행</li>
                <li id="myPhotoCardFragment">포토카드</li>
                <li id="mySaveFragment">내 저장</li>
            </ul>
        </div>

        <!-- 아래 컨텐츠 영역 -->
        <div id="content" class="content">
            <div id="semiCategories" class="semiCategories">
            </div>
            <div id="announcement-box">
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" href="${path}/css/member/mypage.css">
</body>
</html>