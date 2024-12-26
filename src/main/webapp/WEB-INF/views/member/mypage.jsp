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
              $("#mySaveFragment").removeClass("active");
              $("#myPhotoCardFragment").removeClass("active");
              $("#myTripFragment").addClass("active"); // '내 여행' 활성화
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
              $("#myTripFragment").removeClass("active");
              $("#myPhotoCardFragment").removeClass("active");
              $("#mySaveFragment").addClass("active"); // '내 여행' 활성화
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
            url: `${path}/auth/getReviewFragment.do`,
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
=======
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My page</title>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script>
    $(document).ready(function () {
      $.ajax({
        url: `${path}/auth/viewProfileFragment.do`,
        type: "get",
        success: function (response) {
          $("#left-section").html(response);
        },
        error: function (err) {
          console.log(err)
        }
      });
    });
  </script>
</head>
<body>
<%@ include file="header.jsp"%>
<div class="grid-container">
  <!-- Left Section -->
  <aside id="left-section" class="profile-fragment">

  </aside>

  <!-- Right Section -->
  <div class="right-section">
    <!-- 상단 카테고리 -->
    <div class="categories">
      <ul>
        <li>내 여행</li>
        <li>포토카드</li>
        <li>내 저장</li>
      </ul>
    </div>

    <!-- 아래 컨텐츠 -->
    <div class="content">
      <div class="announcement">
        <h3>A whole new Twitter is coming</h3>
        <p>
          New features and a fresh look are launching soon. Stay tuned to learn more
          about switching, scheduling tweets, and what’s happening even faster.
        </p>
      </div>

      <div class="additional-content">
        <p>Here is more content you can add to this section...</p>
      </div>
    </div>
  </div>

<%--  <main class="main-content">--%>
<%--    <section class="about-me">--%>
<%--      <h2>Sinyoung's Page</h2>--%>
<%--      <p>Backend Developer</p>--%>
<%--      <h3>🌱 About Me</h3>--%>
<%--      <ul>--%>
<%--        <li>🌟 SSAFY 10기 서울캠퍼스</li>--%>
<%--        <li>🎓 광운대학교 경영학과 & 소프트웨어학과 졸업</li>--%>
<%--        <li>🏅 멋쟁이 사자처럼 10th</li>--%>
<%--        <li>🎖️ 서울장학재단 서울우수인재장학생 1기/ 3기</li>--%>
<%--        <li>🏆 SAP ERP ABAP/MM 취득</li>--%>
<%--        <li>🏅 비전공자 프로그래밍 전시회 우수상</li>--%>
<%--      </ul>--%>
<%--    </section>--%>
<%--    <section class="tech-stack">--%>
<%--      <h3>👨‍💻 Tech Stack</h3>--%>
<%--      <div class="stack">--%>
<%--        <span class="badge">Python</span>--%>
<%--        <span class="badge">Java</span>--%>
<%--        <span class="badge">SpringBoot</span>--%>
<%--        <span class="badge">DJango</span>--%>
<%--        <span class="badge">MySQL</span>--%>
<%--        <span class="badge">Git</span>--%>
<%--        <span class="badge">Ubuntu</span>--%>
<%--      </div>--%>
<%--    </section>--%>
<%--  </main>--%>
</div>
<link rel="stylesheet" href="${path}/css/member/mypage.css">
</body>
</html>