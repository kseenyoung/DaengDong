// searchPlace.jsp 동행자추가 부분

document.getElementById("addCompanionBtn").addEventListener('click', function() {
    const companionEmail = document.getElementById("companionEmailInput").value;

    if (!companionEmail) {
        alert("동행자 이메일을 입력해주세요.");
        return;
    }

    fetch('/daengdong/plan/addCompanion', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ companionEmail })
    })
        .then(response => {
            if (response.ok) {
                alert("동행자가 성공적으로 추가되었습니다!");
                location.reload(); // 페이지 새로고침
            } else {
                alert("동행자 추가에 실패했습니다.");
            }
        })
        .catch(error => console.error("동행자 추가 요청 실패:", error));
});