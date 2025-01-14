<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js"></script>
    <script src="${path}/js/main.js"></script>
    <title>댕동</title>
    <link
            href="
    https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
    "
            rel="stylesheet"
    />

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@400;700&family=Rubik+Bubbles&family=Rubik+Gemstones&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${path}/style2.css" />

</head>

<body>
<form id="uploadForm" method="post" enctype="multipart/form-data">
    <input type="file" id="file" name="file" />
    <button type="button" onclick="uploadFile()">이미지 업로드</button>
</form>

<!--  div는 위치나 형태?를 나타낸다. 선택자는 최대 2개, 태그만 있는 경우는
무조건 앞에 선택자 써주기  -->
<div id="container">
    <header id="header">
        <div id="header_box">
            <h1 id="logo"><a href="${path}">댕동</a></h1>
            <div id="header_right">
                <a href="">
                    <img src="${path}/images/header_arlam.png" alt="알림" width="30" height="30"/>
                    <span class="alt-text"></span>
                </a>
                <a href="${path}/post/posts">
                    <img src="${path}/images/header_community.png" alt="커뮤니티" width="30" height="30" />
                    <span class="alt-text"></span>
                </a>
                <a href="${path}/plan/create">
                    <img src="${path}/images/header_plan.png" alt="플랜" width="30" height="30" />
                    <span class="alt-text"></span>
                </a>
                <a href="${path}/auth/viewMypage.do">
                    <img src="${path}/images/header_user.png" alt="사용자" width="30" height="30" />
                    <span class="alt-text"></span>
                </a>
            </div>
        </div>
    </header>
    <div id="banner">
        <div id="banner_container">
            <div id="banner_box">
                <div id="banner_box_top">
                    <h2>여행 가자</h2>
                    <h2 id="dynamicText">코코야!</h2>
                </div>
                <div id="banner_box_bottom">
                    <p>지금 바로 계획을 만들어보세요.</p>
                    <button>Let's plan</button>
                </div>
            </div>
        </div>
    </div>

    <div id="drawer-start"></div>
    <main id="main">
        <section id="section1">
            <div class="sec_top">
                <p>일정 생성 ・ 관리</p>
                <h1>펫과 함께 하는 여행 일정,</h1>
                <h1>같이 떠나요</h1>
            </div>
            <div id="sec1_bottom">
                <div id="sec1_bottom_left">
                    <h1>여행을 한눈에, 그리고 한 번에!</h1>
                    <p>
                        다른 곳에서는 할 수 없었던 일이 트리플에서는 가능해요. 여행
                        전이든 여행 중이든 내가 계획한 일정을 간편하게 수정하고
                        꺼내보세요.
                    </p>
                    <div>
                        <%--<button>
                            <span id="select_num">1</span><span id="select_menu">현지인 맛집 탐방</span>
                        </button>
                        <button><span>2</span><span>현지인 맛집 탐방</span></button>
                        <button><span>3</span><span>현지인 맛집 탐방</span></button>
                        <button><span>4</span><span>현지인 맛집 탐방</span></button>--%>
                    </div>
                    <a href=""><button>일정 살펴보기</button></a>
                </div>
                <div id="sec1_bottom_right">
                    <img
                            src="https://triple.guide/intro/static/images/itineraries/itinerary_01@2x.png"
                            alt=""
                            width="460px"
                            height="520px"
                    />
                </div>
            </div>
            <div class="sec_top">
                <p>여행지 정보</p>
                <h1>내가 가려는 그곳,</h1>
                <h1>같이 만들어 봐요</h1>
                <p>
                    여행 중에도 내가 여행하는 곳의 유용한 정보와 현지 상황을 다른
                    여행자들과 공유해 보세요.
                </p>
            </div>
            <img
                    src="https://triple.guide/intro/static/images/community_01@2x.png"
                    width="100%"
                    alt=""
            />
        </section>
        <section id="section2">
            <div id="sec2_left">
                <div id="sec2_left_box">
                    <h2>여행지 정보</h2>
                    <p>지금은 어디가 핫플?</p>
                    <p>같이 알아보아요</p>
                    <a href=""><button>핫플 속으로 Go</button></a>
                </div>
            </div>
            <div id="sec2_right">
                <!-- <h2>항공권 시세 확인</h2>
                <p>
                  해외 항공권의 실시간 가격 추이 예측으로 적절한 금액을
                  알려드립니다. 지금 사는 가격이 괜찮을지 더 이상 고민하지 마세요!
                </p> -->
                <div id="div1"></div>
                <div id="div2"></div>
                <div id="div3"></div>
            </div>
        </section>
    </main>
</div>
</body>

<script>
  function uploadFile() {
    const formData = new FormData();
    const fileInput = document.getElementById('file');

    if (fileInput.files.length === 0) {
      alert("파일을 선택해주세요!");
      return;
    }

    formData.append("file", fileInput.files[0]);

    fetch('${path}/api/s3/upload', {
      method: 'POST',
      body: formData
    })
      .then(response => {
        if (response.ok) {
          return response.text(); // 성공 시 서버에서 반환된 URL 가져오기
        } else {
          throw new Error("업로드 실패!");
        }
      })
      .then(data => {
        alert("업로드 성공: " + data);
      })
      .catch(error => {
        console.error("Error:", error);
        alert("업로드 실패: " + error.message);
      });
  }
</script>

<script>
  // use a script tag or an external JS file
  document.addEventListener("DOMContentLoaded", (event) => {
    gsap.registerPlugin(ScrollTrigger);
    // gsap code here!

    const tl = gsap.timeline();

    ScrollTrigger.create({
      trigger: "#main", // main 요소가 트리거 역할
      start: "top 2%", // main의 상단이 화면 상단에 도달하면
      end: "bottom top", // main이 끝날 때까지
      scrub: true, // 스크롤에 맞춰 애니메이션 진행
      onEnter: () => {
        // 타임라인을 사용하여 애니메이션을 순차적으로 진행
        tl.to("#banner", {
          backgroundColor: "#fff", // 배경색 변경
          duration: 0, // 0초 동안 배경색 변경
          ease: "power1.inOut",
        }).to("#header", {
          backgroundColor: "#fff", // 배경색 변경
          zIndex: 3, // zIndex 변경
          duration: 0, // 즉시 zIndex 변경
        });
      },
      onLeaveBack: () => {
        // 타임라인을 사용하여 애니메이션을 순차적으로 진행
        tl.to("#header", {
          backgroundColor: "transparent", // 배경색 원래대로 변경
          duration: 0, // 1초 동안 배경색 변경
          ease: "power1.inOut",
        }).to("#header_box", {
          backgroundColor: "transparent", // 배경색 원래대로 변경
          duration: 0, // 즉시 zIndex 변경
        });
      },
    });

    ScrollTrigger.create({
      trigger: "#section2", // main 요소가 트리거 역할
      start: "top top", // main의 상단이 화면 상단에 도달하면
      end: "bottom top", // main이 끝날 때까지
      scrub: true, // 스크롤에 맞춰 애니메이션 진행
      marker: true,
      onEnter: () => {
        // 타임라인을 사용하여 애니메이션을 순차적으로 진행
        tl.to("#header", {
          backgroundColor: "transparent", // 배경색 변경
          duration: 0, // 0초 동안 배경색 변경
        }).to("#header_box", {
          color: "#fff",
          zIndex: 5,
          backgroundColor: "transparent", // 배경색 변경
          duration: 0, // 즉시 zIndex 변경
        });
      },
      onLeaveBack: () => {
        // 타임라인을 사용하여 애니메이션을 순차적으로 진행
        tl.to("#header", {
          zIndex: 3,
          backgroundColor: "#fff", // 배경색 원래대로 변경
          duration: 0, // 1초 동안 배경색 변경
        }).to("#header_box", {
          backgroundColor: "#fff", // 배경색 원래대로 변경
          color: "#000",
          duration: 0, // 즉시 zIndex 변경
        });
      },
    });
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
  // 스크롤 트리거를 사용하여 애니메이션 추가
  // gsap.to("#main", {
  //   scrollTrigger: {
  //     trigger: "#main", // .box가 트리거 역할
  //     start: "top 10%", // 화면의 80% 지점에 도달하면 시작
  //     end: "top 100%", // 추가로 200px 동안 애니메이션 진행
  //     markers: true,
  //     scrub: true,
  //     // toggleActions: "play reverse play reverse", // 트리거가 작동할 때 실행
  //   },
  //   y: -300, // 위로 500px 이동

  //   // duration: 1, // 애니메이션이 2초 동안 지속
  //   // opacity: 1,
  // });

  // gsap.set("#sec3_img1", {
  //   y: 100,
  //   opacity: 0,
  // });
  // gsap.set("#sec3_img2", {
  //   y: 100,
  //   opacity: 0,
  // });
  // const tl2 = gsap.timeline({
  //   scrollTrigger: {
  //     trigger: "#section3", // 트리거 요소
  //     start: "top 90%", // 트리거 시작 지점
  //     end: "bottom 20%", // 트리거 끝 지점
  //     markers: true, // 디버깅용 마커 표시
  //     toggleActions: "play reverse play reverse",
  //   },
  // });

  // // 타임라인에 애니메이션 추가
  // tl2
  //   .to("#sec3_img1", {
  //     duration: 1,
  //     y: 0, // 아래에서 원래 위치로 이동
  //     opacity: 1, // 불투명하게 변화
  //   })
  //   .to(
  //     "#sec3_img2",
  //     {
  //       duration: 1,
  //       y: 0,
  //       opacity: 1,
  //     },
  //     "-=0.7"
  //   ); // 이전 애니메이션 끝나기 0.5초 전에 시작
</script>
</html>
