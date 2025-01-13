document.addEventListener("DOMContentLoaded", function () {
    const companionEmailInput = document.getElementById("companionEmail");

    // 팔로잉 목록 가져오기
    fetch('/daengdong/plan/followingList')
        .then(response => response.json())
        .then(data => renderList(data, "followingList"));

    // 팔로워 목록 가져오기
    fetch('/daengdong/plan/followerList')
        .then(response => response.json())
        .then(data => renderList(data, "followerList"));

    // 리스트 렌더링 함수
    function renderList(data, elementId) {
        const listElement = document.getElementById(elementId);
        listElement.innerHTML = "";

        data.forEach(item => {
            const listItem = document.createElement("li");
            const nickname = item.memberNickname || "닉네임 없음"; // 닉네임이 없을 경우 기본값 사용
            listItem.textContent = `${nickname} (${item.memberEmail})`;

            const checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.value = item.memberEmail;

            listItem.prepend(checkbox);
            listElement.appendChild(listItem);
        });
    }

    // 페이지 로드 시 동행자 리스트 가져오기
    fetchCompanions();

    // 버튼 통합 클릭 이벤트
    document.getElementById("submitCompanionsBtn").addEventListener("click", function () {
        const checkedEmails = Array.from(document.querySelectorAll("#followingList input:checked, #followerList input:checked"))
            .map(input => input.value);

        // 텍스트 입력값 추가 (선택적으로 사용)
        const companionEmail = companionEmailInput.value.trim();
        if (companionEmail && !checkedEmails.includes(companionEmail)) {
            checkedEmails.push(companionEmail);
        }

        if (checkedEmails.length === 0) {
            alert("동행자를 선택하거나 이메일을 입력해주세요.");
            return;
        }

        // 동행자 DB 저장 요청
        Promise.all(checkedEmails.map(email => addCompanion(email)))
            .then(() => {
                fetchCompanions(); // 리스트 업데이트
                companionEmailInput.value = ""; // 입력 필드 초기화
                document.querySelectorAll("#followingList input:checked, #followerList input:checked").forEach(input => input.checked = false);
                alert("동행자가 성공적으로 추가되었습니다.");
            })
            .catch(error => {
                console.error("동행자 추가 중 오류 발생:", error);
            });
    });

    // 모달 열기 버튼 클릭 이벤트
    document.getElementById("openCompanionModalBtn").addEventListener("click", function () {
        document.getElementById("companionModal").style.display = "flex";
        fetchCompanions(); // 모달 열릴 때 동행자 리스트 가져오기
        companionEmailInput.focus();
    });

    // 모달 닫기 버튼 클릭 이벤트
    document.getElementById("closeCompanionModalBtn").addEventListener("click", function () {
        document.getElementById("companionModal").style.display = "none";
    });

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener("click", function (event) {
        const modal = document.getElementById("companionModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    });
});

// 동행자 추가 함수
function addCompanion(email) {
    return fetch('/daengdong/plan/addCompanion', {
        method: 'POST',
        headers: {'Content-Type': 'text/plain'},
        body: email
    })
        .then(response => {
            if (!response.ok) {
                throw new Error("네트워크 응답이 올바르지 않습니다.");
            }
            return response.text();
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
            let companions = []; // 동행자 이메일 리스트 초기화

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

    fetch(`companionsDelete?memberEmail=${email}`, {method: 'GET'})
        .then(response => response.text())
        .then(() => {
            fetchCompanions(); // 리스트 업데이트
        })
        .catch(error => {
            console.error("동행자 삭제 요청 실패:", error);
        });
}
