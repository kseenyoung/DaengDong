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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
  <head>



  <c:set var="path" value="${pageContext.servletContext.contextPath}"/>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- jQuery -->



       <link rel="stylesheet" href="${path}/css/post/main.css" />
    <link rel="stylesheet" href="${path}/css/post/post.css" />
    <link rel="stylesheet" href="${path}/css/post/postDetail.css" />

	</head>
	  <div id="container">
          <%@include file="../member/header.jsp" %>
          <section id="post_detail">
            <div class="post_top">
              <div class="post_top_left">
                <img src="${post.memberProfilePhoto}" alt="" />
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
             <div class="PostCategory">
              <div>${post.category}</div>
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
                  <span>${post.likeCount}</span>
                </div>
                <img id="commentToggle" src="${path}/img/comment.png" alt="댓글" width="30" />
              </div>
              <div class="comment_list" style="display:none;">
                 <div class="post_content" style="white-space: pre-line;">🤓🩶🩵🩶🤎
                  ${post.postContent}#라스트챌린지 #스타일컬렉터모집 #2025코디 #요즘코디 #신년선물 #선물추천 #KREAM #OVERDUEFLAIR #크림 #오버듀플레어 #가디건코디
                 </div>
                 <div class="comment_list2">
                     <c:forEach var="comment" items="${comments}">


                      <div class="comment_box">
                          <img src="${comment.memberProfilePhoto}" alt="" width="30">

                          <div class="comment_box2">
                            <div class="comment">
                              <span>${comment.memberNickName}</span>
                              <p>${comment.comment}</p>
                            </div>
                            <div class="comment_date">

                        <fmt:formatDate value="${comment.createAt}" pattern="yyyy-MM-dd" var="createAtDate" />
                        <c:set var="today" value="<%= new java.text.SimpleDateFormat(\"yyyy-MM-dd\").format(new java.util.Date()) %>" />


                                <c:if test="${createAtDate == today}">
                                    오늘
                                </c:if>
                                <c:if test="${createAtDate != today}">
                                    <fmt:formatDate value="${comment.createAt}" pattern="yyyy-MM-dd" />
                                </c:if>
                            </div>

                          </div>
                        </div>


                   </c:forEach>

                </div>
              </div>
              <div class="commentForm" style="display:none;">
                <img src="${path}/images/user.png" alt="프로필" />
                <form action="">
                  <input id="commentInput" type="text" placeholder="댓글을 남기세요." />
                </form>
              </div>
            </div>
          </section>
        </div>
      </body>
    <link
      rel="stylesheet"
      type="text/css"
      href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"
    />

    <script
      type="text/javascript"
      src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"
    ></script>
      <script type="text/javascript">
      console.log(`${post}`)
      console.log(`${my}`)
      console.log(`${comments}`)
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
            const commentForm = document.querySelector('.commentForm');
            const container = document.querySelector('#container');
            const post_bottom_top = document.querySelector('.post_bottom_top');
            const comment_list = document.querySelector('.comment_list');


            // 댓글 이미지 클릭 시
            commentToggleButton.addEventListener('click', function () {
                // 댓글 목록의 display 속성 토글
                if (commentList.style.display === 'none' || commentList.style.display === '') {
                    commentList.style.display = 'block';  // 댓글 목록 보이기
                    commentForm.style.display = 'flex';  // 댓글 목록 보이기

                    container.style.backgroundColor = '#000000af';  // 댓글 목록 보이기

                } else {
                    commentList.style.display = 'none';  // 댓글 목록 숨기기
                    commentForm.style.display = 'none';  // 댓글 목록 숨기기
                      container.style.backgroundColor = '';  // 댓글 목록 보이기

                }
            });


             const postId =  `${post.postId}`/* 서버로부터 받아온 postId */;

                 // 댓글 추가 (엔터 키로)
                 $(document).on('keydown', '#commentInput', function (e) {


                     if (e.key === 'Enter' && !e.shiftKey) {
                            e.preventDefault();
                            e.stopPropagation();

                         const content = $(this).val().trim();
                         if (!content) {
                             alert("댓글을 입력하세요.");
                             return;
                         }

                         const requestData = {
                             postId: parseInt(postId),
                             comment: content
                         };

                         $.ajax({
                             url: '${path}/post/comment',
                             type: 'POST',
                             contentType: 'application/json',
                             data: JSON.stringify(requestData),
                             success: function (response) {
                                 // 성공 시 새로운 댓글 추가
                                 console.log(response)
                              const newComment =
                                  '<div class="comment_box">' +
                                  '<img src="http://img1.kakaocdn.net/thumb/R640x640.q70/?fname=http://t1.kakaocdn.net/account_images/default_profile.jpeg" alt="" width="30">' +
                                  '<div class="comment_box2">' +
                                  '<div class="comment">' +
                                  '<span> sweet home</span>' +
                                  '<p>' + response.comment + '</p>' +
                                  '</div>' +
                                  '<div class="comment_date">지금</div>' +
                                  '</div>' +
                                  '</div>';
                                 $('.comment_list2').append(newComment);
                                 $('#commentInput').val(''); // 입력 필드 초기화
                             },
                             error: function () {
                                 alert("댓글 추가 중 오류가 발생했습니다.");
                             }
                         });
                     }
                 });
      </script>
</html>