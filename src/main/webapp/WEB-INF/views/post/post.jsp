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

  </head>

  <body>
    <!--  div는 위치나 형태?를 나타낸다. 선택자는 최대 2개, 태그만 있는 경우는
    무조건 앞에 선택자 써주기  -->
    <div id="container">
      <header id="header">
        <div id="header_box">
          <h1 id="Slogo">댕동</h1>
          <div id="header_right">
            <a href="">
              <img src="./images/community.png" alt="커뮤니티" width="30" height="30" />
              <span class="alt-text"></span>
            </a>
            <a href="">
              <img src="./images/plan.png" alt="플랜" width="30" height="30" />
              <span class="alt-text"></span>
            </a>
            <a href="">
              <img src="./images/user.png" alt="사용자" width="30" height="30" />
              <span class="alt-text"></span>
            </a>
          </div>
        </div>
      </header>
      <div id="post_write_modal">
        <div id="post_write_block">
            <h2>새 게시물 만들기</h2>
            <div class="modal_relative">

                <input type="file" id="fileInput" style="display: none;"  multiple />
                <div id="post_form_box">

                    <form id="dropZone">
                        <div id="buttons">
                            <button id="prevButton" type="button">이전</button>
                            <button id="nextButton" type="button">다음</button>
                        </div>
                        <img id="dropzoneImg" src="${path}/img/modal.png" alt="" width="250" height="250">
                        <span>여기에 파일을 드래그하세요</span>
                        <button type="button" id="fileButton">컴퓨터에서 선택</button>
                    </form>


                    <form action="" id="post_form">
                        <label for="category">카테고리 선택:</label>
                        <select id="category" name="category">
                            <option value="여행중">여행중</option>
                            <option value="여행완료">여행완료</option>
                            <option value="사진자랑">사진자랑</option>
                            <option value="꿀팁">꿀팁</option>
                        </select>

                        <input type="text" id="title" placeholder="제목 : ">

                        <textarea name="" id="" placeholder="내용 : "></textarea>

                        <button type="submit">만들기</button>
                    </form>
                </div>



            </div>
        </div>
      </div>
      <main id="postMain">
        <h2 id="community">community</h2>
        <input id="search" type="search">
        <div id="kewordAndwrite">
            <ul id="categoryList">
                <li><button class="select_category">인기글</button></li>
                <li><button>여행중</button></li>
                <li><button>여행완료</button></li>
                <li><button>사진자랑</button></li>
                <li><button>꿀팁</button></li>
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
                       <div class="post_relative">
                           <img class="post_img" src="${path}/img/${post.imageUrl}" alt="">
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
                       <div class="post_info">
                           <div class="post_info_left"><img src="${path}/img/${post.memberProfilePhoto}" alt="userprofile"><span>${post.memberNickName}</span></div>
                           <div class="post_info_right">
                               <img src="${path}/img/Like.png" alt="like"><span>${post.likeCount}</span>
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
                   <!-- 두 번째 컬럼에 해당하는 게시글 -->
                      <div class="post">
                                             <div class="post_relative">
                                                 <img class="post_img" src="${path}/img/${post.imageUrl}" alt="">
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
                                             <div class="post_info">
                                                 <div class="post_info_left"><img src="${path}/img/${post.memberProfilePhoto}" alt="userprofile"><span>${post.memberNickName}</span></div>
                                                 <div class="post_info_right">
                                                     <img src="${path}/img/Like.png" alt="like"><span>${post.likeCount}</span>
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
                                            <div class="post_relative">
                                                <img class="post_img" src="${path}/img/${post.imageUrl}" alt="">
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
                                            <div class="post_info">
                                                <div class="post_info_left"><img src="${path}/img/${post.memberProfilePhoto}" alt="userprofile"><span>${post.memberNickName}</span></div>
                                                <div class="post_info_right">
                                                    <img src="${path}/img/Like.png" alt="like"><span>${post.likeCount}</span>
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
                                            <div class="post_relative">
                                                <img class="post_img" src="${path}/img/${post.imageUrl}" alt="">
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
                                            <div class="post_info">
                                                <div class="post_info_left"><img src="${path}/img/${post.memberProfilePhoto}" alt="userprofile"><span>${post.memberNickName}</span></div>
                                                <div class="post_info_right">
                                                    <img src="${path}/img/Like.png" alt="like"><span>${post.likeCount}</span>
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

  <script>
 document.addEventListener('DOMContentLoaded', () => {
   const writeButton = document.querySelector(".post_write");
   const modal = document.getElementById("post_write_modal");
   writeButton.addEventListener("click", function () {
     console.log(1)
      modal.style.display = "flex";
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

    document.getElementById('post_form').addEventListener('submit', (event) => {
        event.preventDefault(); // 폼의 기본 제출 동작 방지

        // 폼 데이터 추가


        // 텍스트 필드 추가
        const title = document.getElementById('title').value; // 제목 가져오기
        const category = document.getElementById('category').value; // 카테고리 가져오기
        const content = document.querySelector('#post_form textarea').value; // 내용 가져오기

        postFormData.append('title', title);
        postFormData.append('category', category);
        postFormData.append('content', content);

          for (let pair of postFormData.entries()) {
                    console.log(pair[0] + ": ", pair[1]); // key와 value를 출력
                }
        // 서버로 전송
       $.ajax({
               url: `${path}/post/po`,
               type: "POST",
               data: postFormData,
               contentType: false,  // FormData를 사용하므로, 기본 content-type을 설정하지 않음
               processData: false,  // jQuery가 데이터를 자동으로 처리하지 않도록 설정
               success: function (response) {
                    console.log(response)


               },
               error: function (err) {
                  console.log(err)
               }
           });
        });

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
            // 파일을 postFormData에 추가
            postFormData.append("files[]", file); // 서버로 전송할 파일 추가

            const reader = new FileReader();
            reader.onload = (e) => {
                images.push(e.target.result); // 이미지 URL 배열에 추가
                 //console.log('Uploaded image:', e.target.result); // 콘솔에 업로드된 이미지 출력
                //console.log('File Name:', file.name); // 파일 이름
                // console.log('File Size:', file.size); // 파일 크기 (bytes)
                // console.log('File Type:', file.type); // 파일 타입 (MIME type)
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

















    const links = document.querySelectorAll("#header_right a");

    links.forEach(link => {
    const img = link.querySelector("img");
    const altText = link.querySelector(".alt-text");

    // img 태그의 alt 속성값을 span의 텍스트로 설정
    if (img && altText) {
        altText.textContent = img.alt;
    }
    });
  </script>
</html>