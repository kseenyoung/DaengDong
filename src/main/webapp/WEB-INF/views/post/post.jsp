<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2025-01-02
  Time: 오후 2:36
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
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/>
    <title>Document</title>

    <link rel="stylesheet" href="${path}/css/post/post.css" />
<script>
    const path = `${pageContext.servletContext.contextPath}`
</script>
  </head>

  <body>
   <%@include file="../member/header.jsp" %>
    <div id="container" data-path="${path}">

      <div id="post_write_modal">
        <div id="post_write_block">
            <h2>새 게시물 만들기</h2>
            <div class="modal_relative">


                <div id="post_form_box">

                    <form id="dropZone">
                        <div id="buttons">
                            <button id="prevButton" type="button"><img src="${path}/img/left-arrow.png" width="25"/></button>
                            <button id="nextButton" type="button"><img src="${path}/img/right-arrow.png" width="25"/></button>
                        </div>
                        <img id="dropzoneImg" src="${path}/img/modal.png" alt="" width="250" height="250">
                        <span>여기에 파일을 드래그하세요</span>
                        <button type="button" id="fileButton">컴퓨터에서 선택</button>
                    </form>


                    <form action="${path}/post/po" id="post_form" method="POST" enctype="multipart/form-data">
                        <label class="postLabel" for="category">카테고리 선택:</label>
                        <select id="category" name="category">
                            <option value="여행중">여행중</option>
                            <option value="여행완료">여행완료</option>
                            <option value="사진자랑">사진자랑</option>
                            <option value="꿀팁">꿀팁</option>
                        </select>

                        <label for="category" class="postLabel" >내 여행:</label>
                        <select id="myplan" name="planId">
                             <c:forEach var="plan" items="${plans}">
                                  <option value="${plan.planId}">${plan.planName}</option>
                               </c:forEach>
                        </select>

                        <input type="text" name="title" id="title" placeholder="제목 : ">

                        <textarea name="content" id="content" placeholder="내용 : "></textarea>

                        <input type="file" id="fileInput" style="display: none;" name="files[]"   multiple />
                        <button type="button" id="submitPost"> 만들기</button>
                        <button id="uploadButton" class="btn btn-primary" type="button" disabled style="display: none;">
                            <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>
                            <span role="status">만들기</span>
                        </button>
                    </form>
                </div>



            </div>
        </div>
      </div>
      <main id="postMain">
        <h2 id="community">community</h2>

      <div id="kewordAndwrite">
          <ul id="categoryList">
              <li><a href="${path}/post/posts"><button class="select_category">인기글</button></a></li>
              <li><a href="${path}/post/posts?category=여행중"><button>여행중</button></a></li>
              <li><a href="${path}/post/posts?category=여행완료"><button>여행완료</button></a></li>
              <li><a href="${path}/post/posts?category=사진자랑"><button>사진자랑</button></a></li>
              <li><a href="${path}/post/posts?category=꿀팁"><button>꿀팁</button></a></li>
          </ul>
          <button class="post_write">글 쓰기</button>
      </div>

        <div class="filter">
            최신순/인기순
        </div>
        <section id="postList">
     <div class="postCol" id="postCol_1">
           <c:forEach var="post" items="${postList}" varStatus="status">
               <c:if test="${status.index % 4 == 0}">
                   <div class="post">
                     <a href="${path}/post/${post.postId}">
                       <div class="post_relative">
                           <img class="post_img" src="${post.imageUrl}" alt="" style="object-fit: cover;
                     object-position: center;">
                            <c:if test="${post.category == '꿀팁'}">
                                <div class="honeytip">
                                   💡Tip
                                </div>
                            </c:if>

                           <div class="post_content">

                                <c:if test="${post.category == '꿀팁'}">
                                   <h2>${post.postTitle}</h2>
                                   <p>${post.postContent}</p>
                               </c:if>
                           </div>
                       </div>
                     </a>
                       <div class="post_info">
                           <div class="post_info_left"><img src="${post.memberProfilePhoto}" alt="userprofile" style="object-fit: cover;
                     object-position: center;"><span>${post.memberNickName}</span></div>
                           <div class="post_info_right">

                                <c:set var="found" value="false" />

                                <!-- likePostIdsArray에서 해당 post.postId가 있는지 확인 -->
                                <c:forEach var="likePostId" items="${myLike}">
                                    <c:if test="${likePostId == post.postId}">
                                        <c:set var="found" value="true" />
                                        <!-- 좋아요를 누른 경우 -->
                                        <img class="like-img" src="${path}/img/Likefull.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                    </c:if>
                                </c:forEach>

                                <!-- likePostIdsArray에 해당 post.postId가 없으면 기본 이미지 출력 -->
                                <c:if test="${not found}">
                                    <img class="like-img" src="${path}/img/Like.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                </c:if>
                           </div>
                       </div>
                        <c:if test="${post.category != '꿀팁'}">
                            <div class="post_bottom">
                            ${post.postContent}
                            </div>

                        </c:if>
                   </div>

               </c:if>
           </c:forEach>
       </div>

       <div class="postCol" id="postCol_2">
           <c:forEach var="post" items="${postList}" varStatus="status">
               <c:if test="${status.index % 4 == 1}">
                     <div class="post">
                                      <a href="${path}/post/${post.postId}">
                                        <div class="post_relative">
                                            <img class="post_img" src="${post.imageUrl}" alt="" style="object-fit: cover;
                     object-position: center;">
                                             <c:if test="${post.category == '꿀팁'}">
                                                 <div class="honeytip">
                                                    💡Tip
                                                 </div>
                                             </c:if>

                                            <div class="post_content">

                                                 <c:if test="${post.category == '꿀팁'}">
                                                    <h2>${post.postTitle}</h2>
                                                    <p>${post.postContent}</p>
                                                </c:if>
                                            </div>
                                        </div>
                                      </a>
                                        <div class="post_info">
                                            <div class="post_info_left"><img src="${post.memberProfilePhoto}" alt="userprofile" style="object-fit: cover;
                     object-position: center;"><span>${post.memberNickName}</span></div>
                                            <div class="post_info_right">

                                                 <c:set var="found" value="false" />

                                                 <!-- likePostIdsArray에서 해당 post.postId가 있는지 확인 -->
                                                 <c:forEach var="likePostId" items="${myLike}">
                                                     <c:if test="${likePostId == post.postId}">
                                                         <c:set var="found" value="true" />
                                                         <!-- 좋아요를 누른 경우 -->
                                                         <img class="like-img" src="${path}/img/Likefull.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                                     </c:if>
                                                 </c:forEach>

                                                 <!-- likePostIdsArray에 해당 post.postId가 없으면 기본 이미지 출력 -->
                                                 <c:if test="${not found}">
                                                     <img class="like-img" src="${path}/img/Like.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                                 </c:if>
                                            </div>
                                        </div>
                                         <c:if test="${post.category != '꿀팁'}">
                                             <div class="post_bottom">
                                             ${post.postContent}
                                             </div>

                                         </c:if>
                                    </div>
               </c:if>
           </c:forEach>
       </div>

       <div class="postCol" id="postCol_3">
           <c:forEach var="post" items="${postList}" varStatus="status">
               <c:if test="${status.index % 4 == 2}">
                   <!-- 세 번째 컬럼에 해당하는 게시글 -->
                   <div class="post">
                                                         <a href="${path}/post/${post.postId}">
                                                           <div class="post_relative">
                                                               <img class="post_img" src="${post.imageUrl}" alt="" style="object-fit: cover;
                     object-position: center;">
                                                                <c:if test="${post.category == '꿀팁'}">
                                                                    <div class="honeytip">
                                                                       💡Tip
                                                                    </div>
                                                                </c:if>

                                                               <div class="post_content">

                                                                    <c:if test="${post.category == '꿀팁'}">
                                                                       <h2>${post.postTitle}</h2>
                                                                       <p>${post.postContent}</p>
                                                                   </c:if>
                                                               </div>
                                                           </div>
                                                         </a>
                                                           <div class="post_info">
                                                               <div class="post_info_left"><img src="${post.memberProfilePhoto}" alt="userprofile" style="object-fit: cover;
                     object-position: center;"><span>${post.memberNickName}</span></div>
                                                               <div class="post_info_right">

                                                                    <c:set var="found" value="false" />

                                                                    <!-- likePostIdsArray에서 해당 post.postId가 있는지 확인 -->
                                                                    <c:forEach var="likePostId" items="${myLike}">
                                                                        <c:if test="${likePostId == post.postId}">
                                                                            <c:set var="found" value="true" />
                                                                            <!-- 좋아요를 누른 경우 -->
                                                                            <img class="like-img" src="${path}/img/Likefull.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                                                        </c:if>
                                                                    </c:forEach>

                                                                    <!-- likePostIdsArray에 해당 post.postId가 없으면 기본 이미지 출력 -->
                                                                    <c:if test="${not found}">
                                                                        <img class="like-img" src="${path}/img/Like.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                                                    </c:if>
                                                               </div>
                                                           </div>
                                                            <c:if test="${post.category != '꿀팁'}">
                                                                <div class="post_bottom">
                                                                ${post.postContent}
                                                                </div>

                                                            </c:if>
                                                       </div>
               </c:if>
           </c:forEach>
       </div>

       <div class="postCol" id="postCol_4">
           <c:forEach var="post" items="${postList}" varStatus="status">
               <c:if test="${status.index % 4 == 3}">
                   <!-- 네 번째 컬럼에 해당하는 게시글 -->
                  <div class="post">
                                                        <a href="${path}/post/${post.postId}">
                                                          <div class="post_relative">
                                                              <img class="post_img" src="${post.imageUrl}" alt="" style="object-fit: cover;
                     object-position: center;">
                                                               <c:if test="${post.category == '꿀팁'}">
                                                                   <div class="honeytip">
                                                                      💡Tip
                                                                   </div>
                                                               </c:if>

                                                              <div class="post_content">

                                                                   <c:if test="${post.category == '꿀팁'}">
                                                                      <h2>${post.postTitle}</h2>
                                                                      <p>${post.postContent}</p>
                                                                  </c:if>
                                                              </div>
                                                          </div>
                                                        </a>
                                                          <div class="post_info">
                                                              <div class="post_info_left"><img src="${post.memberProfilePhoto}" alt="userprofile" style="object-fit: cover;
                     object-position: center;"><span>${post.memberNickName}</span></div>
                                                              <div class="post_info_right">

                                                                   <c:set var="found" value="false" />

                                                                   <!-- likePostIdsArray에서 해당 post.postId가 있는지 확인 -->
                                                                   <c:forEach var="likePostId" items="${myLike}">
                                                                       <c:if test="${likePostId == post.postId}">
                                                                           <c:set var="found" value="true" />
                                                                           <!-- 좋아요를 누른 경우 -->
                                                                           <img class="like-img" src="${path}/img/Likefull.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                                                       </c:if>
                                                                   </c:forEach>

                                                                   <!-- likePostIdsArray에 해당 post.postId가 없으면 기본 이미지 출력 -->
                                                                   <c:if test="${not found}">
                                                                       <img class="like-img" src="${path}/img/Like.png" data-post-id="${post.postId}" alt="like"><span>${post.likeCount}</span>
                                                                   </c:if>
                                                              </div>
                                                          </div>
                                                           <c:if test="${post.category != '꿀팁'}">
                                                               <div class="post_bottom">
                                                               ${post.postContent}
                                                               </div>

                                                           </c:if>
                                                      </div>
               </c:if>
           </c:forEach>
       </div>
        </section>
      </main>

    </div>
  </body>
  <script src="${path}/js/post/like.js"></script>
  <script>

 document.addEventListener('DOMContentLoaded', () => {


 console.log("${myLike}")
 console.log("${postList}")
 console.log("${plans}")



   const writeButton = document.querySelector(".post_write");
   const modal = document.getElementById("post_write_modal");
   const post_write_block = document.getElementById("post_write_block");
   writeButton.addEventListener("click", function () {
     console.log(1)
      modal.style.display = "flex";
   });
  modal.addEventListener("click", function () {
      modal.style.display = "none"; // 모달을 숨김
  });
  modal.querySelector("#post_write_block").addEventListener("click", function (event) {
      event.stopPropagation(); // 클릭 이벤트 전파를 막음
  });

    const dropZone = document.getElementById('dropZone');
    const dropzoneImg = document.getElementById('dropzoneImg');
    const buttons = document.getElementById('buttons');
    const fileButton = document.getElementById('fileButton');
    const nextButton = document.getElementById('nextButton');
    const prevButton = document.getElementById('prevButton');
    const post_form = document.getElementById('post_form');
    const fileInput = document.getElementById('fileInput');
    let postFormData = new FormData(); // FormData 객체 생성



    const otherInput = document.getElementById('otherInput'); // 다른 입력값을 위한 input 요소

    let images = []; // 업로드된 이미지를 저장하는 배열
    let currentIndex = 0; // 현재 보여주는 이미지의 인덱스

    // 드래그 앤 드롭 이벤트 처리
    dropZone.addEventListener('dragover', (event) => {
        event.preventDefault();
        dropZone.classList.add('dragover');
    });

    dropZone.addEventListener('dragleave', () => {
        dropZone.classList.remove('dragover');
    });

    dropZone.addEventListener('drop', (event) => {
        event.preventDefault();
        dropZone.classList.remove('dragover');
        handleFiles(event.dataTransfer.files);
        hideElements(event.dataTransfer.files);

    });

    // 파일 선택 버튼 클릭 처리
    fileInput.addEventListener('change', (event) => {
        event.preventDefault();
        console.log("event.target.files : ", event.target.files)
        handleFiles(event.target.files);
        hideElements(event.target.files);
    });

    document.getElementById('fileButton').addEventListener('click', () => {
        console.log(2)
        fileInput.click();
    });

    // 다음 버튼 클릭 처리
    nextButton.addEventListener('click', () => {
        event.stopPropagation();
        if (currentIndex < images.length - 1) { // 마지막 이미지가 아니면 이동
            currentIndex++;
            updateDropZoneBackground();
        }
    });

    // 이전 버튼 클릭 처리
    prevButton.addEventListener('click', () => {
        if (currentIndex > 0) { // 첫 번째 이미지가 아니면 이동
            currentIndex--;
            updateDropZoneBackground();
        }
    });

    // 파일 처리 함수
    function handleFiles(files) {
        images = []; // 기존 이미지 배열을 초기화

        for (let key of postFormData.keys()) {
        postFormData.delete(key); // 모든 기존 데이터를 제거
    }

        for (let file of files) {

               const newFileList = new DataTransfer();

               // 드롭된 파일들 추가
                 for (let i = 0; i < files.length; i++) {
                     newFileList.items.add(files[i]);
                 }



                // 새로운 FileList를 input에 설정
                fileInput.files = newFileList.files;

            const reader = new FileReader();
            reader.onload = (e) => {
                images.push(e.target.result); // 이미지 URL 배열에 추가
                 console.log('Uploaded image:', e.target.result); // 콘솔에 업로드된 이미지 출력
                console.log('File Name:', file.name); // 파일 이름
                 console.log('File Size:', file.size); // 파일 크기 (bytes)
                console.log('File Type:', file.type); // 파일 타입 (MIME type)
                currentIndex = 0; // 새로 업로드된 이미지가 첫 번째 이미지가 되도록 설정
                updateDropZoneBackground();
            };
            reader.readAsDataURL(file);
        }

        for (let pair of postFormData.entries()) {
            console.log(pair[0] + ": ", pair[1]); // key와 value를 출력
        }

    }


    function hideElements(files) {
        dropzoneImg.style.display = 'none';  // input 요소 숨기기
        fileButton.style.display = 'none';  // input 요소 숨기기
        dropZone.querySelector('span').style.display = 'none';   // dropZone 숨기기
        post_form.style.display = 'block';
        console.log(("files : ", files))
        if(files.length >= 2){
             buttons.style.display = 'flex';
        }
}
    // 드롭존 배경 업데이트
    function updateDropZoneBackground() {
    console.log(`url(${images[currentIndex]})`)
    console.log(`${images[currentIndex]}`)
    console.log(`${images}`)
    console.log(currentIndex)
        if (images.length > 0) {
            dropZone.style.backgroundImage = 'url(' + images[currentIndex] + ')';
            dropZone.style.backgroundSize = 'cover';
            dropZone.style.backgroundPosition = 'center';
        }
    }
 });



















       const urlParams = new URLSearchParams(window.location.search);
              const category = urlParams.get('category'); // ?category=여행중 부분에서 '여행중' 값을 가져옴

              // 모든 버튼 요소를 선택
              const buttons = document.querySelectorAll('#categoryList button');

              // 카테고리 값이 없다면 '인기글' 버튼에 'select_category' 클래스 추가
              if (!category) {
                  // 기본값으로 '인기글' 버튼에 클래스 추가
                  const defaultButton = Array.from(buttons).find(button => button.textContent.trim() === '인기글');
                  if (defaultButton) {
                      defaultButton.classList.add('select_category');
                  }
              } else {
                  // 카테고리 값과 일치하는 버튼에 'select_category' 클래스 추가
                  buttons.forEach(button => {
                      if (button.textContent.trim() === category) {
                          button.classList.add('select_category');
                      } else {
                          button.classList.remove('select_category');
                      }
                  });
              }
  </script>
<script src="${path}/js/post/postImageUpload.js"></script>
</html>