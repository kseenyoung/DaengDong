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
  $(document).on("click", ".delete-favoritePlace", deleteFavoritePlace);
  // $("#myFavoritePlace").on("click", getFavoritePlace)

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
        addHoverScript();
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
      url: `${path}/auth/getLikePostsFragment.do`,
      type: "get",
      success: function (response) {
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
    let star_id = $(this).data("star-id"); // data-star-id 속성 값 가져오기
    console.log(star_id);
    $.ajax({
      url: `${path}/favoritePlace?star_id=${star_id}`,
      type: "DELETE",
      success: function () {
        location.href = `${path}/auth/getFavoritePlace.do`;
      },
      error: function (err) {
        console.log(err);
      }
    });
  }
});