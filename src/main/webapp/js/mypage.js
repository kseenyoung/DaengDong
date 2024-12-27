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
        addHoverScript();
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
        $("#myFavoritePlace").css("color", "#8a8a8a")
        $("#myReview").css("color", "#0AB75B")
        $("#myLikes").css("color", "#8a8a8a")
        $("#myPosts").css("color", "#8a8a8a")
        $("#announcement-box").html(response);
        $(document).on("click", ".delete-review", deleteReview);
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
        // initializeEventHandlers();
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
      url: `${path}/auth/getFavoritePlace.do`,
      type: "get",
      success: function (response) {
        $("#myFavoritePlace").css("color", "#8a8a8a")
        $("#myReview").css("color", "#8a8a8a")
        $("#myLikes").css("color", "#8a8a8a")
        $("#myPosts").css("color", "#0AB75B")
        $("#announcement-box").html(response);
        $(this).closest('.announcement').remove();
        initializeEventHandlers();
      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function addHoverScript() {
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

  function deleteFavoritePlace() {
    let star_id = $(this).data("star-id");
    $.ajax({
      url: `${path}/favoritePlace/${star_id}`,
      type: 'get',
      contentType: 'application/json',
      success: function () {
        // 페이지 새로고침 대신 해당 요소만 제거
        $(this).closest('.announcement').remove();
        initializeEventHandlers();
      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function deleteReview() {
    let review_id = $(this).data("review-id");
    $.ajax({
      url: `${path}/reviews/${review_id}`,
      type: 'get',
      contentType: 'application/json',
      success: function () {
        // 페이지 새로고침 대신 해당 요소만 제거
        $(this).closest('.announcement').remove();

      },
      error: function (err) {
        console.log(err);
        $(this).closest('.announcement').remove();
      }
    });
  }

  function updateReview() {
    const reviewId = $(this).data('review-id'); // 데이터 속성에서 리뷰 ID 가져오기
    const reviewContent = $(this).data('review-content'); // 리뷰 내용
    const reviewRating = $(this).data('review-rating'); // 평점
    const kakaoPlaceNameDisplay = $(this).data('kakao-place-name'); // 평점

    // 모달 내부의 입력 필드에 데이터 설정
    $('#bootstrap-modal #review-id').val(reviewId);
    $('#bootstrap-modal #review-content').val(reviewContent);
    $('#bootstrap-modal #review-rating').val(reviewRating);
    $('#kakao-place-name-display').text(`${kakaoPlaceNameDisplay}`);
    // 모달 열기
    $('#bootstrap-modal').modal('show');
  }

  // 저장 버튼 클릭 이벤트
  function confirmUpdate() {
    const reviewId = $('#bootstrap-modal #review-id').val();
    const reviewContent = $('#bootstrap-modal #review-content').val();
    const reviewRating = $('#bootstrap-modal #review-rating').val();
    console.log(reviewId)
    console.log(reviewContent)
    console.log(reviewRating)
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
});