planId = window.planId;

let tempMemoryPlaces = []; // 임시 메모리 배열 초기화

document.getElementById("finalizePlanBtn").addEventListener("click", function () {
    const requestData = tempMemoryPlaces.map(place => ({
        planId: planId,
        kakaoPlaceId: place.kakaoPlaceId,
        day: place.day
    }));
    console.log("requestData : ", requestData);

    // 서버로 POST 요청
    fetch("/daengdong/place/finalPlanPlaces", {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify(planPlaces)
    })
        .then(res => {
            if (!res.ok) throw new Error("일정 저장 실패");
            return res.text();
        })
        .then(msg => {
            alert("최종 일정이 저장되었습니다!");
            console.log("서버 응답:", msg);
        })
        .catch(err => {
            console.error("일정 저장 오류:", err);
        });
});