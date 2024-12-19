$(function () {
    const forms = document.getElementsByClassName('validation-form');

    Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    });

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
            url: `/auth/signUp.do`,
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
                    location.href= `/login.do`;
                }
                else{
                    // 회원가입 성공 -> home.jsp
                    alert('회원가입 성공!')
                    location.href=`/home`;
                }
            },
            error: function (e){
                console.error(e)
            }
        })

    })

}, false);



let petCount = 0;

function f_remove_pet(pet_id){
    $(`#${pet_id}`).remove();
}

function f_add_pet() {
    petCount++; // 고유 ID 증가
    let html = `<div class="col-md-6 mb-3 pet" id="pet_${petCount}">
                    <button class="d-block" onclick="f_remove_pet('pet_${petCount}')">X</button>
                    <label for="nickname_${petCount}">이름</label>
                    <input type="text" class="form-control" id="name_${petCount}" placeholder="" value="" required>
                    <div class="form-check d-inline">
                      <input class="form-check-input" type="radio" value="Male"  name="pet_gender_${petCount}" id="pet_gender_${petCount}_male">
                      <label class="form-check-label" for="pet_gender_${petCount}_male">
                        Male
                      </label>
                    </div>
                    <div class="form-check d-inline">
                      <input class="form-check-input" type="radio" value="Female" name="pet_gender_${petCount}" id="pet_gender_${petCount}_female" checked>
                      <label class="form-check-label" for="pet_gender_${petCount}_female">
                        Female
                      </label>
                    </div>
                    <div class="mb-4">
                      <label for="root">혈액형</label>
                      <select class="custom-select d-block w-100" id="root">
                        <option value=""></option>
                        <option value="DEA-1">DEA-1</option>
                        <option value="DEA1.1">DEA1.1</option>
                        <option value="DEA1.2">DEA1.2</option>
                        <option value="DEA3">DEA3</option>
                        <option value="DEA4">DEA4</option>
                        <option value="DEA5">DEA5</option>
                        <option value="DEA6">DEA6</option>
                      </select>
                    </div>
                    <div class="mb-4">
                      <label for="root2">종</label>
                      <select class="custom-select d-block w-100" id="root2">
                        <option value=""></option>
                        <option value="말티즈">말티즈</option>
                        <option value="포메라니안">포메라니안</option>
                        <option value="시츄">시츄</option>
                        <option value="믹스">믹스</option>
                        <option value="시바">시바</option>
                        <option value="푸들">푸들</option>
                      </select>
                    </div>
                     <!-- Date Picker Input -->
                    <label class="birthday d-block me-3">생일</label>
                    <div class="form-group mb-4">
                        <div class="datepicker date input-group p-0 shadow-sm">
                          <input
                            type="text"
                            placeholder="생일 입력"
                            class="form-control py-3 px-4 datepicker"
                          />
                          <div class="input-group-append">
                            <span class="input-group-text px-3">
                              <i class="fa fa-clock-o"></i>
                            </span>
                          </div>
                        </div>
                    </div>
                </div>`;

    $("#pets").prepend(html);

    // 동적으로 추가된 Datepicker 다시 초기화
    // INITIALIZE DATEPICKER PLUGIN
    $('.datepicker').datepicker({
        clearBtn: true,
        format: "yy/mm/dd"
    });


    // FOR DEMO PURPOSE
    $('#reservationDate').on('change', function () {
        var pickedDate = $('input').val();
        $('#pickedDate').html(pickedDate);
    });
}
