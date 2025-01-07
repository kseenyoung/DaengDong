// searchPlace.jsp 동행자추가 부분

// 동행자 이메일 리스트
let companions = [];

document.addEventListener("DOMContentLoaded", function () {
    // 페이지 로드 시 동행자 리스트 가져오기
    fetchCompanions();
});

// 모달 열기 버튼 클릭 이벤트
document.getElementById("openCompanionModalBtn").addEventListener("click", function () {
    document.getElementById("companionModal").style.display = "flex";
    fetchCompanions(); // 모달 열릴 때 동행자 리스트 가져오기
    document.getElementById("companionEmail").focus();
});

// 모달 닫기 버튼 클릭 이벤트
document.getElementById("closeCompanionModalBtn").addEventListener("click", function () {
    document.getElementById("companionModal").style.display = "none";
});

// 모달 외부 클릭 시 모달 닫기
window.addEventListener("click", function(event) {
    const modal = document.getElementById("companionModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }
});

// 동행자 추가 폼 제출 이벤트
document.getElementById("companionForm").addEventListener("submit", function (e) {
    e.preventDefault();
    const companionEmailInput = document.getElementById("companionEmail");
    const companionEmail = companionEmailInput.value.trim();

    // 이메일 입력 유효성 검사
    if (!companionEmail) {
        alert("동행자 이메일을 입력해주세요.");
        return;
    }

    // 이메일 형식 검사 (기본 정규식)
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(companionEmail)) {
        alert("유효한 이메일 주소를 입력해주세요.");
        return;
    }

    // 중복 체크 (프론트엔드에서도 중복 방지)
    if (companions.includes(companionEmail)) {
        // alert("이미 추가된 동행자입니다.");
        companionEmailInput.value = "";
        return;
    }

    // 동행자 추가 요청
    addCompanion(companionEmail);
});

// 동행자 추가 함수
function addCompanion(email) {
    fetch(`addCompanion`, {
        method: 'POST',
        headers: {'Content-Type': 'text/plain'},
        body: email
    })
        .then(response => response.text())
        .then(() => {
            fetchCompanions(); // 리스트 업데이트
            document.getElementById("companionEmail").value = "";
        })
        .catch(error => {
            console.log("동행자 추가에 실패했습니다.");
        });
}

// 동행자 리스트 가져오기 함수
function fetchCompanions() {
    fetch('companions')
        .then(response => {
            if (!response.ok) {
                throw new Error("네트워크 응답이 올바르지 않습니다.");
            }
            return response.json();
        })
        .then(data => {
            const companionList = document.getElementById("companionList");
            companionList.innerHTML = ""; // 기존 리스트 초기화
            companions = []; // 동행자 이메일 리스트 초기화

            data.forEach(companion => {
                const listItem = document.createElement("li");
                listItem.textContent = companion.memberEmail;

                // 삭제 버튼 생성
                const deleteBtn = document.createElement("button");
                deleteBtn.textContent = "삭제";
                deleteBtn.classList.add("deleteBtn"); // 스타일링을 위해 클래스 추가
                deleteBtn.addEventListener("click", function () {
                    deleteCompanion(companion.memberEmail);
                });

                listItem.appendChild(deleteBtn);
                companionList.appendChild(listItem);

                // 배열에 추가
                companions.push(companion.memberEmail);
            });
        })
        .catch(error => {
            console.error("동행자 리스트 가져오기 실패:", error);
        });
}

// 동행자 삭제 함수
function deleteCompanion(email) {
    if (!confirm(`"${email}"님을 동행자에서 삭제하시겠습니까?`)) {
        return;
    }

    fetch(`companionsDelete?memberEmail=${email}`,
        {method: 'GET'}

    )
        .then(response => response.text())
        .then(() => {
            fetchCompanions(); // 리스트 업데이트
        })
        .catch(error => {
            console.error("동행자 삭제 요청 실패:", error);
        });
}

// 동행자 제출 버튼 클릭 이벤트
document.getElementById("submitCompanionsBtn").addEventListener("click", function () {
    if (companions.length === 0) {
        //alert("동행자를 추가해주세요.");
        return;
    }

    // 확인 메시지
    if (!confirm("동행자를 제출하시겠습니까?")) {
        return;
    }

    //alert("동행자가 제출되었습니다.");
    document.getElementById("companionModal").style.display = "none";
    location.reload(); // 페이지 새로고침
});

// 장소 추가 버튼 클릭 이벤트 (추가 기능 필요 시 구현)
document.getElementById("addPlaceBtn").addEventListener("click", function () {
    // const placeName = prompt("추가할 장소의 이름을 입력해주세요:");
    // if (placeName && placeName.trim() !== "") {
    //     const placeList = document.getElementById("placeList");
    //     const listItem = document.createElement("li");
    //     listItem.textContent = placeName.trim();

        // 삭제 버튼 생성
        const deleteBtn = document.createElement("button");
        deleteBtn.textContent = "삭제";
        deleteBtn.classList.add("deleteBtn"); // 스타일링을 위해 클래스 추가
        deleteBtn.addEventListener("click", function () {
            placeList.removeChild(listItem);
        });

        listItem.appendChild(deleteBtn);
        placeList.appendChild(listItem);
    // } else {
    //     alert("유효한 장소 이름을 입력해주세요.");
    // }
});
