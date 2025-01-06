$(document).ready(function () {
  initializeEventHandlers();
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

  function initializeEventHandlers() {
    $(document).off("click", "#myTripFragment")
      .off("click", "#mySaveFragment")
      .off("click", "#semiCategories .action-item")
      .off("click", "#following")
      .off("click", "#follower")
      .off("click", ".delete-following")
      .off("click", ".insert-follower")
      .off("click", ".delete-review")
      .off("click", ".update-review")
      .off("click", "#confirm-update")
      .off("click", ".delete-likePosts")
      .off("click", "");

    $(document).on("click", "#myTripFragment", moveToMyTrip);
    $(document).on("click", "#mySaveFragment", getSemiSaveCategory);
    $(document).on("click", "#semiCategories .action-item", injectAction);
    $(document).on("click", "#following", viewFollowingModal);
    $(document).on("click", "#follower", viewFollowerModal);
    $(document).on("click", ".delete-following", deleteFollowing);
    $(document).on("click", ".insert-follower", addFollowing);
    $(document).on("click", ".delete-review", deleteReview);
    $(document).on("click", ".update-review", updateReview);
    $(document).on("click", "#confirm-update", confirmUpdate);
    $(document).on("click", ".delete-likePosts", deleteLikePosts)
    $(document).on("click", ".delete-post-btn", deletePost)
    $(document).on("click", ".delete-favoritePlace", deleteFavoritePlace)

  }

  function moveToMyTrip() {
    $.ajax({
      url: `${path}/auth/getSemiSaveCategory.do`,
      type: "get",
      success: function (response) {
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
        $("#myFavoritePlace").css("color", "#0AB75B")
        $("#myReview").css("color", "#8a8a8a")
        $("#myLikes").css("color", "#8a8a8a")
        $("#myPosts").css("color", "#8a8a8a")
        $("#announcement-box").html(response);
        addHoverScriptStar();
      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function getReview() {
    $.ajax({
      url: `${path}/auth/getReviewFragment.do`,
      type: "get",
      success: function (response) {
        $("#myFavoritePlace").css("color", "#8a8a8a")
        $("#myReview").css("color", "#0AB75B")
        $("#myLikes").css("color", "#8a8a8a")
        $("#myPosts").css("color", "#8a8a8a")
        $("#announcement-box").html(response);
        $(this).closest('.announcement').remove();
      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function getLikes() {
    $.ajax({
      url: `${path}/auth/getLikePostsFragment.do`,
      type: "get",
      success: function (response) {
        $("#myFavoritePlace").css("color", "#8a8a8a")
        $("#myReview").css("color", "#8a8a8a")
        $("#myLikes").css("color", "#0AB75B")
        $("#myPosts").css("color", "#8a8a8a")
        $("#announcement-box").html(response);
        addHoverScriptHeart();
        $(this).closest('.announcement').remove();
      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function getPosts() {
    $.ajax({
      url: `${path}/auth/getMyPosts.do`,
      type: "get",
      success: function (response) {
        $("#myFavoritePlace").css("color", "#8a8a8a")
        $("#myReview").css("color", "#8a8a8a")
        $("#myLikes").css("color", "#8a8a8a")
        $("#myPosts").css("color", "#0AB75B")
        $("#announcement-box").html(response);
      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function deleteFavoritePlace() {
    let star_id = $(this).data("star-id");
    let element = $(this).closest('.announcement'); // 삭제할 요소를 미리 저장

    $.ajax({
      url: `${path}/favoritePlace/${star_id}`,
      type: 'get',
      contentType: 'application/json',
      success: function () {
        // 페이지 새로고침 대신 해당 요소만 제거
        element.remove();
      },
      error: function (err) {
        console.log(err);
      }
    });
  }

  function deleteReview() {
    let review_id = $(this).data("review-id");
    let element = $(this).closest('.announcement'); // 삭제할 요소를 미리 저장

    $.ajax({
      url: `${path}/reviews/${review_id}`,
      type: 'get',
      contentType: 'application/json',
      success: function () {
        // 페이지 새로고침 대신 해당 요소만 제거
        element.remove();
      },
      error: function (err) {
        console.log(err);
      }
    });
  }

  function updateReview(e) {
    // 1) 클릭된 요소(버튼)에서 필요한 데이터 추출
    const button = $(this);
    const reviewId = button.data('review-id');
    const reviewContent = button.data('review-content');
    const reviewRating = button.data('review-rating');
    const kakaoPlaceName = button.data('kakao-place-name');
    const kakaoImageUrl = button.data('kakao-image-url');

    // 2) 모달 내부에 데이터 세팅
    $("#review-modal #review-id").val(reviewId);
    $("#review-modal #review-content").val(reviewContent);
    $("#review-modal #review-rating").val(reviewRating);
    $("#review-modal #placeImg").attr("src", kakaoImageUrl);
    $("#kakao-place-name-display").text(kakaoPlaceName);

    // 서버에서 모달 HTML 가져오기
    $.ajax({
      url: `${path}/auth/getReviewModal.do`,
      type: 'GET',
      data: {
        reviewId: reviewId,
        reviewContent: reviewContent,
        reviewRating: reviewRating,
        kakaoPlaceName: kakaoPlaceName,
        imageUrl: kakaoImageUrl
      },
      success: function (response) {
        // Placeholder에 동적으로 HTML 삽입
        $('#share-placeholder').html(response);
        // 4) Vanilla JS 방식으로 모달 표시
        const modalElement = document.getElementById('review-modal');
        if (modalElement) {
          const modalInstance = new bootstrap.Modal(modalElement); // 모달 초기화
          modalInstance.show(); // 모달 표시

          $(modalElement).on('hidden.bs.modal', function () {
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open');
            $(this).remove();
          });
        } else {
          console.error("Modal element not found!");
        }
      },
      error: function (err) {
        console.error('Failed to load modal:', err);
      }
    });
  }

  // 저장 버튼 클릭 이벤트
  function confirmUpdate() {
    const reviewId = $('#review-id').val();
    const reviewContent = $('#review-content').val();
    const reviewRating = $('#review-rating').val();
    // AJAX로 수정 요청 보내기
    $.ajax({
      url: `${path}/reviews`,
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({
        review_id: reviewId,
        review_content: reviewContent,
        review_rating: reviewRating,
      }),
      success: function (response) {
        // 1) 모달 닫기
        const modalElement = document.getElementById('review-modal');
        if (modalElement) {
          const modalInstance = bootstrap.Modal.getInstance(modalElement); // 기존 모달 인스턴스 가져오기
          if (modalInstance) {
            modalInstance.hide(); // 모달 닫기
          }
        }

        // 2) 모달 데이터 초기화 및 backdrop 제거 (필요한 경우)
        modalElement.addEventListener('hidden.bs.modal', () => {
          // 모달 관련 데이터 초기화
          modalElement.removeAttribute('data-bs-modal');
          // backdrop 제거 (필요한 경우)
          const backdrop = document.querySelector('.modal-backdrop');
          if (backdrop) {
            backdrop.remove();
          }
        });

        // 3) 리뷰 가져오기 함수 호출
        getReview();
      },
      error: function (err) {
        console.error(err);
        alert('리뷰 수정에 실패했습니다.');
      }
    });
  }

  function deleteLikePosts() {
    let postId = $(this).data("post-id");
    let element = $(this).closest('.post-card'); // 삭제할 요소를 미리 저장

    $.ajax({
      url: `${path}/likePosts/${postId}`,
      type: 'get',
      contentType: 'application/json',
      success: function () {
        // 페이지 새로고침 대신 해당 요소만 제거
        element.remove();
      },
      error: function (err) {
        console.log(err);
      }
    });
  }

  function viewFollowingModal() {
    // 모달 컨테이너에 AJAX로 콘텐츠 로드
    $("#share-placeholder").load(`${path}/auth/viewFollowingModal.do`, function (response, status, xhr) {
      if (status === "error") {
        console.log("failed to load modal");
      } else {
        const modalElement = document.getElementById("followModal"); // 모달 DOM 요소 가져오기
        if (modalElement) {
          const modalInstance = new bootstrap.Modal(modalElement); // 모달 초기화
          modalInstance.show(); // 모달 표시

          $(modalElement).on('hidden.bs.modal', function () {
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open');
            $(this).remove();
          });
        } else {
          console.error("Modal element not found!");
        }
        addHoverScripDeleteFollower();
      }
    });
  }

  function viewFollowerModal() {
    $("#share-placeholder").load(`${path}/auth/viewFollowerModal.do`, function (response, status, xhr) {
      if (status === "error") {
        console.log("failed to load modal");
      } else {
        const modalElement = document.getElementById("followModal"); // 모달 DOM 요소 가져오기
        if (modalElement) {
          const modalInstance = new bootstrap.Modal(modalElement); // 모달 초기화
          modalInstance.show(); // 모달 표시

          $(modalElement).on('hidden.bs.modal', function () {
            $('.modal-backdrop').remove();
            $('body').removeClass('modal-open');
            $(this).remove();
          });
        } else {
          console.error("Modal element not found!");
        }
        addHoverScripDeleteFollower();
      }
    });
  }

  //hover효과
  function addHoverScriptStar() {
    // 모든 이미지 태그에 hover 이벤트를 다시 설정
    const starImages = document.querySelectorAll(".hoverable-star");

    starImages.forEach((starImage) => {
      const basePath = `${path}/img/`;

      starImage.addEventListener("mouseover", () => {
        starImage.src = basePath + "empty_star.png"; // hover 시 이미지 변경
      });

      starImage.addEventListener("mouseout", () => {
        starImage.src = basePath + "star.png"; // 원래 이미지로 복원
      });
    });
  }

  function addHoverScriptHeart() {
    // 모든 이미지 태그에 hover 이벤트를 다시 설정
    const heartButtons = document.querySelectorAll(".hoverable-heart");

    heartButtons.forEach((button) => {
      button.addEventListener("mouseover", () => {
        button.textContent = "💔"; // hover 시 변경
      });

      button.addEventListener("mouseout", () => {
        button.textContent = "❤️"; // 원래 상태로 복원
      });
    });
  }

  function addHoverScripDeleteFollower() {
    let buttons = document.querySelectorAll(".delete-following");

    buttons.forEach((button) => {
      button.addEventListener("mouseover", () => {
        button.textContent = "취소";
      });

      button.addEventListener("mouseout", () => {
        button.textContent = "팔로잉";
      });
    });
  }

  function deleteFollowing() {
    let toEmail = $(this).data('to-email');
    let FollowingElement = $(this).closest('.following-list');
    let button = $(this);

    $.ajax({
      url: `${path}/following/${toEmail}`,
      type: "GET",
      contentType: 'application/json',
      success: function () {
        FollowingElement.remove();
        addPopAnimation(button);
      },
      error: function (err) {
        console.log(err)
      }
    });
  }

  function addFollowing() {
    let toEmail = $(this).data('to-email');
    let button = $(this);

    $.ajax({
      url: `${path}/following/${toEmail}`,
      type: "POST",
      contentType: 'application/json',
      success: function () {
        addPopAnimation(button);
      },
      error: function (err) {
        console.log(err)
      }
    });
  }

  function addPopAnimation(button) {
    // 애니메이션 클래스 추가
    button.addClass('pop-explode');

    // 애니메이션 끝난 후 버튼 교체 또는 제거
    setTimeout(() => {
      if (button.hasClass('insert-follower')) {
        button.replaceWith('<button class="btn btn-primary btn-sm delete-following" data-to-email="' +
          button.data('to-email') + '">팔로잉</button>');
      } else if (button.hasClass('delete-following')) {
        button.replaceWith('<button class="btn btn-primary btn-sm insert-follower" data-to-email="' +
          button.data('to-email') + '">팔로우</button>');
      }
      addHoverScripDeleteFollower();
      const modalElement = document.querySelector('.modal.show'); // 현재 열려 있는 모달
      if (modalElement) {
        const modalInstance = bootstrap.Modal.getInstance(modalElement);
        if (modalInstance) {
          modalInstance._config.keyboard = true; // ESC 키 활성화
          modalInstance._config.backdrop = true; // 모달 바깥 클릭 활성화
        }
      }
    }, 400); // 애니메이션 시간과 일치시킴
  }

  function deletePost() {
    let postId = $(this).data("post-id");
    let element = $(this).closest('.post-card');

    $.ajax({
      url: `${path}/myPost/${postId}`,
      method: 'DELETE',
      contentType: 'application/json',
      success: function () {
        console.log("success")
        element.remove();
      },
      error: function (err) {
        console.log(err);
      }
    });
  }
});