// searchPlace.jsp 동행자추가 부분

    // 동행자 이메일 리스트
    const companions = [];
    document.getElementById("addCompanionBtn").addEventListener("click", function () {
    const companionEmailInput = document.getElementById("companionEmailInput");
    const companionEmail = companionEmailInput.value.trim();
    if (!companionEmail) {
    alert("동행자 이메일을 입력해주세요.");
    return;
}
    if (companions.includes(companionEmail)) {
    alert("이미 추가된 동행자입니다.");
    return;
}
    // 리스트에 이메일 추가
    companions.push(companionEmail);
    // 동행자 리스트 UI 업데이트
    const companionList = document.getElementById("companionList");
    const listItem = document.createElement("li");
    listItem.textContent = companionEmail;
    // 삭제 버튼 생성
    const deleteBtn = document.createElement("button");
    deleteBtn.textContent = "삭제";
    deleteBtn.addEventListener("click", function () {
    const index = companions.indexOf(companionEmail);
    if (index > -1) {
    companions.splice(index, 1);
    companionList.removeChild(listItem);
}
});
    listItem.appendChild(deleteBtn);
    companionList.appendChild(listItem);
    // 입력 필드 초기화
    companionEmailInput.value = "";
});
    // 동행자 제출 버튼 클릭 이벤트
    document.getElementById("submitCompanionsBtn").addEventListener("click", function () {
    if (companions.length === 0) {
    alert("동행자를 추가해주세요.");
    return;
}
    // 쉼표로 구분된 문자열 생성
    const companionData = companions.join(',');
    // 서버로 전송
    fetch('/daengdong/plan/addCompanion', {
    method: 'POST',
    headers: {'Content-Type': 'text/plain'},
    body: companionData
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