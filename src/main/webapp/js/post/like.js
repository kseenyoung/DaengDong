$(document).on("click", ".like-img", function() {

       const path = $("#container").data("path");
        const postId = $(this).data("post-id");  // 클릭한 게시글의 postId 가져오기
        const imgElement = $(this);
        const likeCountElement = imgElement.siblings("span");  // 해당 게시글의 like count 표시 요소
        let currentLikeCount = parseInt(likeCountElement.text());  // 현재 좋아요 수

        $.ajax({
            url: `${path}/post/like`,
            type: "POST",
            data: {
                postId: postId,
            },
            success: function(response) {
                // 좋아요 클릭 후 처리 (이미지 변경 등)
                console.log("success : ", response)
                console.log($(this))
                 console.log(currentLikeCount)
                if (imgElement.attr("src") === `${path}/img/Likefull.png`) {
                        imgElement.attr("src", `${path}/img/Like.png`);
                         currentLikeCount--;
                    } else {  // 그렇지 않으면 'Likefull.png'로 변경
                        imgElement.attr("src", `${path}/img/Likefull.png`);
                        currentLikeCount++;
                    }
                 likeCountElement.text(currentLikeCount);
            },
            error: function(err) {
                console.log(err);
            }
        });
    });