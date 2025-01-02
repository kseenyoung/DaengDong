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
    $(document).on("click", "#myTripFragment", moveToMyTrip);
    $(document).on("click", "#mySaveFragment", getSemiSaveCategory);
    $(document).on("click", "#semiCategories .action-item", injectAction);
    $(document).on("click", "#following", viewFollowingModal);
    $(document).on("click", "#follower", viewFollowerModal);
    $(document).on("click", ".delete-following", deleteFollowing);
    $(document).on("click", ".insert-follower", addFollowing)
    $(document).on('click', '.insert-follower, .delete-following', addPopAnimation)
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
        // initializeEventHandlers();

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
        // initializeEventHandlers();
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
        $(document).on("click", ".delete-favoritePlace", deleteFavoritePlace);
        $(this).closest('.announcement').remove();
        // initializeEventHandlers();
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
        $('#review-modal').on('hidden.bs.modal', function () {
          $('.modal-backdrop').remove(); // 백드롭 제거
          $(this).removeData('bs.modal'); // 모달 데이터 초기화
        });

        $("#myFavoritePlace").css("color", "#8a8a8a")
        $("#myReview").css("color", "#0AB75B")
        $("#myLikes").css("color", "#8a8a8a")
        $("#myPosts").css("color", "#8a8a8a")
        $("#announcement-box").html(response);
        $(document).on("click", ".delete-review", deleteReview);

        //todo: update 클릭 시, 정보 가져와서 모달에 표시해주기
        //todo: modal이 곂곂이 쌓이는 버그 해결
        //todo: 내가쓴 리뷰, 좋아요에서는 팔로워, 팔로잉 모달이 제대로 나오지 않는 버그 해결
        $(document).on('click', '.update-review', updateReview);
        $(document).on('click', '#confirm-update', confirmUpdate);
        $(this).closest('.announcement').remove();
        // initializeEventHandlers();
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
        $(document).on("click", ".delete-likePosts", deleteLikePosts);
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
        // $(this).closest('.announcement').remove();
        // initializeEventHandlers();
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
        initializeEventHandlers();
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

  function updateReview() {
    const reviewId = $(this).data('review-id');
    const reviewContent = $(this).data('review-content');
    const reviewRating = $(this).data('review-rating');
    const kakaoPlaceName = $(this).data('kakao-place-name');
    const imageUrl = $(this).data('kakao-image-url');

    // 서버에서 모달 HTML 가져오기
    $.ajax({
      url: `${path}/auth/getReviewModal.do`,
      type: 'GET',
      data: {
        reviewId: reviewId,
        reviewContent: reviewContent,
        reviewRating: reviewRating,
        kakaoPlaceName: kakaoPlaceName,
        imageUrl: imageUrl,
      },
      success: function (response) {
        // Placeholder에 동적으로 HTML 삽입
        $('#view-review-modal-placeholder').html(response);

        // 모달 표시
        $('#review-modal').modal('show');

        $('#review-modal').on('hidden.bs.modal', function () {
          $('.modal-backdrop').remove(); // 백드롭 제거
          $(this).removeData('bs.modal'); // 모달 데이터 초기화
        });
      },
      error: function (err) {
        console.error('Failed to load modal:', err);
      }
    });
  }

  // 저장 버튼 클릭 이벤트
  function confirmUpdate() {
    const reviewId = $('#bootstrap-modal #review-id').val();
    const reviewContent = $('#bootstrap-modal #review-content').val();
    const reviewRating = $('#bootstrap-modal #review-rating').val();
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
        $('#bootstrap-modal').modal('hide');
        $(this).removeData('bs.modal'); // 모달의 데이터 초기화
        $('.modal-backdrop').remove(); // 검은 배경 제거
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
        initializeEventHandlers();
      },
      error: function (err) {
        console.log(err);
      }
    });
  }

  function viewFollowingModal() {
    // 모달 컨테이너에 AJAX로 콘텐츠 로드
    $("#view-follow-modal-placeholder").load(`${path}/auth/viewFollowingModal.do`, function (response, status, xhr) {
      if (status === "error") {
        console.log("failed to load modal");
      } else {
        $("#followModal").modal("show");
        addHoverScripDeleteFollower();
      }
    });
  }

  function viewFollowerModal() {
    $("#view-follow-modal-placeholder").load(`${path}/auth/viewFollowerModal.do`, function (response, status, xhr) {
      if (status === "error") {
        console.log("failed to load modal");
      } else {
        $("#followModal").modal("show");
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
    let FollowerElement = $(this).closest('.delete-following');

    $.ajax({
      url: `${path}/following/${toEmail}`,
      type: "GET",
      contentType: 'application/json',
      success: function () {
        FollowingElement.remove();
        addPopAnimation();
      },
      error: function (err) {
        console.log(err)
      }
    });
  }

  function addFollowing() {
    let toEmail = $(this).data('to-email');
    let FollowerElement = $(this).closest('.insert-follower');

    $.ajax({
      url: `${path}/following/${toEmail}`,
      type: "POST",
      contentType: 'application/json',
      success: function () {
        addPopAnimation();
      },
      error: function (err) {
        console.log(err)
      }
    });
  }

  function addPopAnimation() {
    let button = $(this);

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
    }, 400); // 애니메이션 시간과 일치시킴
  }
});