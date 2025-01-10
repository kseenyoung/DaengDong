planId = window.planId;

const tempMemoryPlaces = []; // 임시 메모리 배열 초기화

document.getElementById("finalizePlanBtn").addEventListener("click", function () {
    const requestData = tempMemoryPlaces.map(place => ({
        planId: planId,
        kakaoPlaceId: place.kakaoPlaceId,
        day: place.day
    }));
    console.log("requestData : ", requestData);

    // 서버로 POST 요청
    fetch('/daengdong/place/finalPlanPlaces', {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(requestData)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to submit plan places");
            }
            return response.text();
        })
        /*.then(data => {
            alert("일정 저장이 완료되었습니다!");
            console.log("Response:", data);
            // 저장 후 페이지 이동 (필요에 따라 변경 가능)
            window.location.href = `/daengdong/plan/place?planId=${planId}`; // 예시: 전체 일정 목록으로 이동
        })*/
        .catch(error => {
            console.error("Error:", error);
            alert("일정 저장 중 오류가 발생했습니다.");
        });
});