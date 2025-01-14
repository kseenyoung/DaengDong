<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@400;700&family=Rubik+Bubbles&family=Rubik+Gemstones&display=swap"
            rel="stylesheet">
    <link rel="stylesheet" href="${path}/css/header.css"/>
    <title>myPage</title>
</head>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
const links = document.querySelectorAll("#header_right a");

  links.forEach(link => {
    const img = link.querySelector("img");
    const altText = link.querySelector(".alt-text");

    // img 태그의 alt 속성값을 span의 텍스트로 설정
    if (img && altText) {
      altText.textContent = img.alt;
    }
      document.addEventListener("DOMContentLoaded", function () {
          const popoverTrigger = document.querySelector('#notification-icon');
          let popover = new bootstrap.Popover(popoverTrigger, {
              container: 'body',
              trigger: 'manual',
              placement: 'bottom',
              html: true,
              content: '<div class="popover-body">로딩 중...</div>',
              sanitize: false
          });

          let isPopoverVisible = false;

          // 알림 아이콘 클릭 시 팝오버 열기/닫기
          popoverTrigger.addEventListener('click', function (e) {
              e.stopPropagation();

              if (isPopoverVisible) {
                  popover.hide();
                  isPopoverVisible = false;
              } else {
                  // 서버에서 알림 데이터 가져오기
                  fetchNotifications().then(notifications => {
                      console.log(11111111111111)
                          const content = renderNotifications(notifications);
                      console.log('content' + content)
                      // 기존 팝오버 제거
                      popover.dispose();

                      // 새로운 팝오버 생성
                       popover = new bootstrap.Popover(popoverTrigger, {
                          container: 'body',
                          trigger: 'manual',
                          placement: 'bottom',
                          html: true,
                          content: content,
                           sanitize: false

                      });

                      popover.show();
                      isPopoverVisible = true;
                      console.log(2)
                      addNotificationClickHandlers();
                      console.log('content' + content)
                  }).catch(error => {
                      console.error('알림 로드 실패:', error);
                      popover.dispose();
                      popover = new bootstrap.Popover(popoverTrigger, {
                          container: 'body',
                          trigger: 'manual',
                          placement: 'bottom',
                          html: true,
                          content: '<p>알림을 불러오는 데 실패했습니다.</p>',
                          sanitize: false
                      });
                      popover.show();
                      isPopoverVisible = true;
                      addNotificationClickHandlers();
                  })
              }
          });

          // 팝오버 외부 클릭 시 닫기
          document.addEventListener('click', function (e) {
              const popoverElement = document.querySelector('.popover');
              if (popoverElement && popoverElement.contains(e.target)) {
                  return;
              }
              if (isPopoverVisible && !popoverTrigger.contains(e.target)) {
                  popover.hide();
                  isPopoverVisible = false;
              }
          });

          // 서버에서 알림 가져오기
          function fetchNotifications() {
              return fetch('${path}/auth/getSelectNotification.do', {
                  method: 'GET',
                  headers: {
                      'Content-Type': 'application/json',
                      'Cache-Control': 'no-cache' // 캐시 방지
                  }
              })
                  .then(response => {
                      if (!response.ok) {
                          throw new Error('Network response was not ok');
                      }
                      return response.json();
                  });
          }

          // 알림 데이터를 HTML로 렌더링
          function renderNotifications(notifications) { // 파라미터 이름 변경
              console.log(notifications)
              if (notifications.length === 0) {

                  // return '<div class="popover-body"><p class="mb-0">새로운 알림이 없습니다.</p></div>';
                  return '<p class="mb-0">새로운 알림이 없습니다.</p>';
              }

              let unreadCount = 0;
              let listItems = notifications.map(notif => { // 변수 이름 변경
                  const checkedClass = notif.is_checked == 1 ? 'checked' : '';
                  if (notif.is_checked == 0) unreadCount++;
                  let notificationText = "";

                  // 알림 타입에 따른 메시지 생성
                  switch (notif.notification_type) {
                      case 1:
                          notificationContent = getUserName(notif.sender_email) + "님이 팔로우했습니다.";
                          break;
                      case 4:
                          notificationContent = getUserName(notif.sender_email) + "님이 당신을 동행자로 초대했습니다.";
                          notificationContent += "<div class=\"mt-2\">" +
                              "<button class=\"btn btn-sm btn-primary accept-btn\" data-id=\"" + notif.notification_id + "\">수락</button>" +
                              "<button class=\"btn btn-sm btn-secondary decline-btn\" data-id=\"" + notif.notification_id + "\">거절</button>" +
                              "</div>";
                          break;
                      // 다른 타입 추가 가능...
                      default:
                          notificationContent = "알림";
                  }

                  return "<li class='list-group-item " + checkedClass + "' data-id='" + notif.notification_id + "'>" + notificationContent + "</li>";
              }).join('');

              // 알림 개수 표시
              if (unreadCount > 0) {
                  // .alt-text 요소가 존재하는지 확인
                  const altTextElement = popoverTrigger.querySelector('.alt-text');
                  if (altTextElement) {
                      altTextElement.textContent = " (" + unreadCount + ")";
                  }
              } else {
                  // .alt-text 요소가 존재하는지 확인
                  const altTextElement = popoverTrigger.querySelector('.alt-text');
                  if (altTextElement) {
                      altTextElement.textContent = "";
                  }
              }
              console.log(listItems)
              return "<div class='popover-body'><ul class='list-group'>" + listItems + "</ul></div>";
          }

          // 사용자 이름을 추출하는 함수 (간단한 예시)
          function getUserName(email) {
              if (email && email.includes("@")) {
                  return email.substring(0, email.indexOf("@"));
              }
              return "사용자";
          }

          // 알림 항목 클릭 시 읽음 처리
          function addNotificationClickHandlers() {
              const popoverContent = document.querySelector('.popover-body ul.list-group');
              if (popoverContent) {
                  popoverContent.querySelectorAll('li').forEach(item => {
                      item.addEventListener('click', function () {
                          const notificationId = this.getAttribute('data-id');
                          console.log('Notification clicked:', notificationId); // 로그 추가
                          if (!this.classList.contains('checked')) {
                              isChecked(notificationId);
                          }
                      });
                  });
                  // Handle accept button clicks
                  popoverContent.querySelectorAll('.accept-btn').forEach(button => {
                      button.addEventListener('click', function (e) {
                          e.stopPropagation();
                          const notificationId = this.getAttribute('data-id');
                          console.log('Accept clicked for notification:', notificationId);
                          acceptCompanion(notificationId);
                      });
                  });

                  // Handle decline button clicks
                  popoverContent.querySelectorAll('.decline-btn').forEach(button => {
                      button.addEventListener('click', function (e) {
                          e.stopPropagation();
                          const notificationId = this.getAttribute('data-id');
                          console.log('Decline clicked for notification:', notificationId);
                          declineCompanion(notificationId);
                      });
                  });
              }
          }

          // 서버에 읽음 처리 요청
          function isChecked(notification_id) {
              console.log('Marking notification as read:', notification_id); // 로그 추가

              fetch('${path}/auth/isChecked.do', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify({notification_id: notification_id})
              })
                  .then(response => response.json())
                  .then(data => {
                      if (data.status === 'success') {
                          // UI 업데이트: 알림을 회색으로 표시
                          const notificationElement = document.querySelector(`[data-id='${notification_id}']`);
                          if (notificationElement) {
                              notificationElement.classList.add('checked');
                          } else {
                              console.error(`Notification element with data-id='${notification_id}' not found.`);
                          }

                          // 알림 개수 감소 및 표시
                          let currentCountText = popoverTrigger.querySelector('.alt-text').textContent;
                          let currentCount = parseInt(currentCountText.replace(/[()]/g, '')) || 0;
                          if (currentCount > 0) {
                              popoverTrigger.querySelector('.alt-text').textContent = ` (${currentCount - 1})`;
                          }
                      } else {
                          console.error('읽음 처리 실패:', data.message);
                      }
                  })
                  .catch(error => {
                      console.error('네트워크 오류:', error);
                  });
          }
          // 동행 요청 수락 처리
          function acceptCompanion(notificationId) {
              fetch(`${path}/auth/acceptCompanion.do`, {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(notificationId)
              })
                  .then(response => response.json())
                  .then(data => {
                      console.log(data);
                      if (data.status === 'success') {
                          alert(data.message);
                          // 팝오버 내용 갱신
                          fetchNotifications().then(notifications => {
                              const content = renderNotifications(notifications);
                              popover.dispose();
                               popover = new bootstrap.Popover(popoverTrigger, {
                                  container: 'body',
                                  trigger: 'manual',
                                  placement: 'bottom',
                                  html: true,
                                  content: content
                              });
                              popover.show();
                              isPopoverVisible = true;
                              addNotificationClickHandlers();
                          });
                      } else {
                          alert(data.message);
                      }
                  })
                  .catch(error => {
                      console.error('동행 요청 수락 실패:', error);
                      alert('동행 요청 수락에 실패했습니다.');
                  });
          }

          // 동행 요청 거절 처리
          function declineCompanion(notificationId) {
              fetch(`${path}/auth/declineCompanion.do`, {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(notificationId)
              })
                  .then(response => response.json())
                  .then(data => {
                      console.log(data);
                      if (data.status === 'success') {
                          alert(data.message);
                          // 팝오버 내용 갱신
                          fetchNotifications().then(notifications => {
                              const content = renderNotifications(notifications);
                              popover.dispose();
                               popover = new bootstrap.Popover(popoverTrigger, {
                                  container: 'body',
                                  trigger: 'manual',
                                  placement: 'bottom',
                                  html: true,
                                  content: content
                              });
                              popover.show();
                              isPopoverVisible = true;
                              addNotificationClickHandlers();
                          });
                      } else {
                          alert(data.message);
                      }
                  })
                  .catch(error => {
                      console.error('동행 요청 거절 실패:', error);
                      alert('동행 요청 거절에 실패했습니다.');
                  });
          }
      });
  });
</script>
