// 이미지 미리보기 함수
function myProfilePreviewImage(file) {
  const reader = new FileReader();
  reader.onload = function (ev) {
    $("#currentPhoto").attr("src", ev.target.result); // 이미지를 미리보기로 설정
  };
  reader.readAsDataURL(file);
}

function petProfilePreviewImage(input) {
  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = function (ev) {
      $("#currentPetPhoto").attr("src", ev.target.result); // 이미지를 미리보기로 설정
    };
    reader.readAsDataURL(input.files[0]);
  }
}

// 파일 업로드 함수
function uploadFile(apiPath) {
  const formData = new FormData();
  const fileInput = document.getElementById("file");

  const uploadButton = document.getElementById("profile-uploadButton");
  const clickButton = document.getElementById("confirm-update-profile");

  if (uploadButton) {
    uploadButton.disabled = false;
    uploadButton.style.display = "inline-flex";
    clickButton.style.display = "none";
  }

  if (fileInput.files.length === 0) {
    alert("파일을 선택해주세요!");
    return;
  }

  const selectedFile = fileInput.files[0];
  myProfilePreviewImage(selectedFile); // 미리보기 실행

  formData.append("file", selectedFile);

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
        body: JSON.stringify({imageUrl: data}),
      });
    })
    .then(() => {
      // 모달 닫기
      const modal = document.getElementById("editNicknameModal"); // 모달 ID에 맞게 변경
      if (modal) {
        const bootstrapModal = bootstrap.Modal.getInstance(modal); // Bootstrap Modal 인스턴스 가져오기
        bootstrapModal.hide();
        // 강제로 backdrop 제거
        document.querySelectorAll(".modal-backdrop").forEach((backdrop) => backdrop.remove());
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("업로드 실패: " + error.message);
    })
    .finally(() => {
      uploadButton.disabled = true;
      uploadButton.style.display = "none";
      clickButton.style.display = "inline-block";
    });
}

function petUploadFile(apiPath, petId, petName, petBloodType) {
  const formData = new FormData();
  const fileInput = document.getElementById("petFile");

  const uploadButton = document.getElementById("uploadButton");
  const clickButton = document.getElementById("confirm-update-petDetail");

  if (uploadButton) {
    uploadButton.disabled = false;
    uploadButton.style.display = "inline-flex";
    clickButton.style.display = "none";
  }

  let uploadPromise;

  if (fileInput.files.length === 0) {
    // 사진이 없는 경우에도 로직을 실행하기 위해 기본 Promise 생성
    uploadPromise = Promise.resolve(null); // null 값을 전달
  } else {
    const selectedFile = fileInput.files[0];
    formData.append("file", selectedFile);

    // 사진 업로드 Promise
    uploadPromise = fetch(`${apiPath}/api/s3/upload`, {
      method: "POST",
      body: formData,
    })
      .then((response) => {
        if (response.ok) {
          return response.text(); // 서버에서 반환된 URL 가져오기
        } else {
          throw new Error("업로드 실패!");
        }
      })
  }

  uploadPromise
    .then((data) => {
      let petImageId = "pet-image-" + petId;
      const imgPreview = document.getElementById(petImageId);
      if (imgPreview) {
        imgPreview.src = data; // 서버에서 반환된 URL을 이미지로 설정
      }
      // Step 2: 업로드된 URL이 있으면 DB에 저장
      if (data) {
        return fetch(`${apiPath}/auth/modifyPetProfile.do`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            imageUrl: data,
            petId: petId,
          }),
        });
      } else {
        return Promise.resolve(); // 업로드가 없는 경우에도 다음으로 진행
      }
    })
    .then(() => {
      // Step 3: 다른 프로필 정보 저장
      return fetch(`${apiPath}/petProfile`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          pet_id: petId,
          pet_name: petName,
          pet_blood_type: petBloodType,
        }),
      });
    })
    .then(() => {
      // Step 4: 화면 갱신
      const selectPetId = `pet-name-${petId}`;
      const previewPetName = document.getElementById(selectPetId);
      if (previewPetName) {
        previewPetName.textContent = petName; // 수정: textContent 사용
      }

      // 모달 닫기
      const modal = document.getElementById("editPetModal");
      if (modal) {
        const bootstrapModal = bootstrap.Modal.getInstance(modal);
        bootstrapModal.hide();
        document
          .querySelectorAll(".modal-backdrop")
          .forEach((backdrop) => backdrop.remove());
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("업로드 실패: " + error.message);
    })
    .finally(() => {
      uploadButton.disabled = true;
      uploadButton.style.display = "none";
      clickButton.style.display = "inline-block";
    });
}

// 파일 선택 시 미리보기 처리
document.getElementById("file").addEventListener("change", function () {
  const fileInput = this;
  if (fileInput.files.length > 0) {
    myProfilePreviewImage(fileInput.files[0]);
  }
});