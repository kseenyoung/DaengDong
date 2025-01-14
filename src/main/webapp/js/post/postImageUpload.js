document.getElementById("submitPost").addEventListener("click", () => {
  const apiPath = `${path}`; // API 경로 설정
  uploadPostFiles(apiPath);
});

function uploadPostFiles(apiPath) {
  const uploadButton = document.getElementById("uploadButton");
  const clickButton = document.getElementById("submitPost");

  const fileInput = document.getElementById("fileInput");
  const title = document.getElementById("title").value;
  const content = document.getElementById("content").value;
  const category = document.getElementById("category").value;
  const planId = document.getElementById("myplan").value;

  if (uploadButton) {
    uploadButton.disabled = false;
    uploadButton.style.display = "inline-flex";
    clickButton.style.display = "none";
  }

  if (fileInput.files.length === 0) {
    alert("파일을 선택해주세요!");
    return;
  }

  // 모든 파일을 업로드
  const filePromises = Array.from(fileInput.files).map((file) => {
    const fileFormData = new FormData();
    fileFormData.append("file", file);

    return fetch(`${apiPath}/api/s3/upload`, {
      method: "POST",
      body: fileFormData,
    }).then((response) => {
      if (response.ok) {
        return response.text(); // 업로드된 URL 반환
      } else {
        throw new Error("업로드 실패!");
      }
    });
  });

  Promise.all(filePromises)
    .then((fileUrls) => {
      console.log("업로드된 파일 URLs:", fileUrls);

      // 게시글 데이터와 이미지 URL 전송
      return fetch(`${apiPath}/post/po`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          planId: planId,
          postTitle: title,
          postContent: content,
          category: category,
          imageUrls: fileUrls, // 업로드된 파일 URL 배열
        }),
      });
    })
    .then((response) => {
      if (response.ok) {
        alert("게시글 생성 성공!");
        window.location.href = `${apiPath}/post/posts`; // 성공 시 리다이렉트
      } else {
        throw new Error("게시글 생성 실패!");
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("오류 발생: " + error.message);
    })
    .finally(() => {
      uploadButton.disabled = true;
      uploadButton.style.display = "none";
      clickButton.style.display = "inline-block";
    });
}