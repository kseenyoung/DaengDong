function uploadFile(apiPath) {
  const formData = new FormData();
  const fileInput = document.getElementById("file");

  if (fileInput.files.length === 0) {
    alert("파일을 선택해주세요!");
    return;
  }
  console.log("sadf")

  formData.append("file", fileInput.files[0]);

  fetch(`${apiPath}/api/s3/upload`, {
    method: "POST",
    body: formData,
  })
    .then((response) => {
      if (response.ok) {
        return response.text(); // 성공 시 서버에서 반환된 URL 가져오기
      } else {
        throw new Error("업로드 실패!");
      }
    })
    .then((data) => {
      alert("업로드 성공: " + data);
      // 업로드 후 처리 (예: 이미지 미리보기 갱신)
      const imgPreview = document.getElementById("my-image");
      if (imgPreview) {
        imgPreview.src = data; // 서버에서 반환된 URL을 이미지로 설정
      }
      // Step 2: 업로드된 URL을 DB에 저장
      return fetch(`${path}/auth/modifyProfile.do`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ imageUrl: data }),
      });
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("업로드 실패: " + error.message);
    });
}