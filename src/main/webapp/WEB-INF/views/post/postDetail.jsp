<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2025-01-08
  Time: 오전 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <c:set var="path" value="${pageContext.servletContext.contextPath}"/>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js"></script>
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>

    <title>Document</title>
    <link
      href="
    https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
    "
      rel="stylesheet"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@400;700&family=Rubik+Bubbles&family=Rubik+Gemstones&family=Song+Myung&family=Sunflower:wght@300&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@400;700&family=Rubik+Bubbles&family=Rubik+Gemstones&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${path}/css/post/main.css" />
    <link rel="stylesheet" href="${path}/css/post/post.css" />
    <link rel="stylesheet" href="${path}/css/post/postDetail.css" />
    <link
      rel="stylesheet"
      type="text/css"
      href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"
    />

    <script
      type="text/javascript"
      src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"
    ></script>
	</head> 
	  <div id="container">
          <header id="header">
            <div id="header_box">
              <h1 id="logo">댕동</h1>
              <div id="header_right">
                <a href=""
                  ><img src="./images/community.png" alt="" width="30" height="30"
                /></a>
                <a href=""
                  ><img src="./images/plan.png" alt="" width="30" height="30"
                /></a>
                <a href=""
                  ><img src="./images/user.png" alt="" width="30" height="30"
                /></a>
              </div>
            </div>
          </header>
          <section id="post_detail">
            <div class="post_top">
              <div class="post_top_left">
                <img src="${path}/img/${post.memberProfilePhoto}" alt="" />
                <div>
                  <p>${post.memberNickName}</p>
                  <p>${post.postTitle}</p>
                </div>
              </div>
              <div class="post_top_right">
                <button>팔로우</button>
                <img src="${path}/img/more.png" alt="" />
              </div>
            </div>
            <div class="single-item">
               <c:forEach var="postURL" items="${post.imageUrls}">
                  <img class="like-img" src="${path}/upload/${postURL}" data-post-id="${post.postId}" alt="like">
               </c:forEach>
            </div>
            <div class="post_bottom">
              <div class="post_bottom_top">
                <div>
                  <img src="${path}/img/Like.png" alt="하트" width="25" />
                  <span>20</span>
                </div>
                <img id="commentToggle" src="${path}/img/comment.png" alt="댓글" width="30" />
              </div>
              <div class="comment_list" style="display:none;"></div>
              <div class="comment" style="display:none;">
                <img src="${path}/images/user.png" alt="프로필" />
                <form action="">
                  <input type="text" placeholder="댓글을 남기세요." />
                </form>
              </div>
            </div>
          </section>
        </div>
      </body>

      <script type="text/javascript">
      console.log(`${post}`)
        $(".single-item").slick({
          infinite: false, // 무한 스크롤 비활성화
          prevArrow: '<button type="button" class="slick-prev"></button>',
          nextArrow: '<button type="button" class="slick-next"></button>',
          //   responsive: [
          //     {
          //       breakpoint: 768, // 반응형 처리
          //       settings: {
          //         arrows: false,
          //       },
          //     },
          //   ],
        });

        // 첫 번째와 마지막 슬라이드에서 버튼 숨김 처리
        $(".single-item").on("afterChange", function (event, slick, currentSlide) {
          $(".slick-prev").toggle(currentSlide !== 0); // 첫 슬라이드에서 이전 버튼 숨기기
          $(".slick-next").toggle(currentSlide !== slick.slideCount - 1); // 마지막 슬라이드에서 다음 버튼 숨기기
        });

        // 초기 상태 버튼 처리
        $(".single-item").trigger("afterChange", [
          $(".single-item").slick("getSlick"),
          0,
        ]);

        // 댓글 토글 버튼 (댓글 이미지)
            const commentToggleButton = document.getElementById('commentToggle');

            // 댓글 목록을 감싸는 div
            const commentList = document.querySelector('.comment_list');
            const comment = document.querySelector('.comment');

            // 댓글 이미지 클릭 시
            commentToggleButton.addEventListener('click', function () {
                // 댓글 목록의 display 속성 토글
                if (commentList.style.display === 'none' || commentList.style.display === '') {
                    commentList.style.display = 'block';  // 댓글 목록 보이기
                    comment.style.display = 'flex';  // 댓글 목록 보이기
                } else {
                    commentList.style.display = 'none';  // 댓글 목록 숨기기
                    comment.style.display = 'none';  // 댓글 목록 숨기기
                }
            });
      </script>
</html>