$(document).ready(function () {
    // const forms = document.getElementsByClassName('validation-form');
    //
    // Array.prototype.filter.call(forms, (form) => {
    //     form.addEventListener('submit', function (event) {
    //         if (form.checkValidity() === false) {
    //             event.preventDefault();
    //             event.stopPropagation();
    //         }
    //
    //         form.classList.add('was-validated');
    //     }, false);
    // });

    // 회원가입 버튼 클릭 시
    $("#btn-signup").click(function (){
        event.preventDefault(); // 기본 동작 방지
        // 폼 데이터 가져오기
        const pets = [];

        // 반려동물 데이터 가져오기
        $("#pets .pet").each(function () {
            const petName = $(this).find(`#name_${$(this).attr('id').split('_')[1]}`).val();
            const petGender = $(this).find(`input[name=pet_gender_${$(this).attr('id').split('_')[1]}]:checked`).val();
            const petBloodType = $(this).find("#root").val();
            const petBirthday = $(this).find(".datepicker input").val();
            const petSpecies = $(this).find("#root2").val();

            pets.push({
                petName,
                petGender,
                petBloodType,
                petBirthday,
                petSpecies
            });
        });

        $.ajax({
            url: `/daengdong/auth/signUp.do`,
            type : 'post',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                memberName: $("#member_name").val(),
                memberNickname: $("#member_nickname").val(),
                pets, // 단순화
            }),
            success: function (result){

                // alert(JSON.stringify(result));
                if( result == null){
                    // 세션 없는 사람 -> 로그인 시도 후 회원가입 하세요!
                    alert('session이 없습니다. 로그인 시도를 먼저 해주세요..')
                    location.href= `/daengdong/auth/login.do`;
                }
                else{
                    // 회원가입 성공 -> home.jsp
                    alert('회원가입 성공!')
                    location.href=`/daengdong`;
                }
            },
            error: function (e){
                console.error(e)
            }
        })

    })

}, false);

function f_remove_pet(pet_id){
    $(`#${pet_id}`).remove();
}

function f_add_pet() {
    $('#editPetModal').modal('show');
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

function petCreateUploadFile(apiPath) {
    const formData = new FormData();
    const fileInput = document.getElementById("petFile");

    const uploadButton = document.getElementById("uploadButton");
    const clickButton = document.getElementById("confirm-insert-petDetail");

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
          });
    }

    uploadPromise
      .then((uploadedUrl) => {
          const petName = $("#petName").val();
          const petBirthday = $("#petBirthday").val();
          const petSpecies = $("#petSpecies").val();
          const petBloodType = $("#petBloodType").val();
          const petGender = $("#petGender").val();

          // Step 2: 업로드된 URL이 있으면 DB에 저장
          if (uploadedUrl) {
              return fetch(`${apiPath}/auth/createPetProfile.do`, {
                  method: "POST",
                  headers: {
                      "Content-Type": "application/json",
                  },
                  body: JSON.stringify({
                      pet_profile_photo: uploadedUrl,
                      pet_name: petName,
                      pet_birthday: petBirthday,
                      pet_species: petSpecies,
                      pet_blood_type: petBloodType,
                      pet_gender: petGender,
                  }),
              }).then(() => uploadedUrl); // URL을 다음 then으로 전달
          } else {
              return Promise.resolve(null); // 업로드가 없는 경우에도 다음으로 진행
          }
      })
      .then((uploadedUrl) => {
          // Step 3: 화면 갱신
          const petName = $("#petName").val();
          const petSpecies = $("#petSpecies").val();

          const petDetailContainer = document.getElementById("pets-detail");
          if (petDetailContainer) {
              const imageUrl = uploadedUrl || ""; // URL이 없을 경우 빈 문자열 사용
              const cardHtml = `
          <div class="announcement">
            <img id="my-pet-image" src="${imageUrl}" alt="my-pet-image">
            <div class="text-container">
              <h2 class="my-pet-name">
                <a>${petName}</a>
              </h2>
              <div class="my-pet-species">${petSpecies}</div>
            </div>
            <div class="button-container">
              <button class="delete-plan">삭제</button>
            </div>
          </div>
        `;
              petDetailContainer.insertAdjacentHTML("beforeend", cardHtml);
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
