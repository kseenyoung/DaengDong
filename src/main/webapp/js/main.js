document.addEventListener("DOMContentLoaded", function () {
  const names = ["코코야!", "보리야!", "초코야!", "콩이야!", "사랑아!", "별이야!", "까미야!", "똘이야!", "해피야!"];
  const dynamicText = document.getElementById("dynamicText");

  let index = 0; // 현재 이름의 인덱스
  let isAdding = true; // 현재 타이핑 중인지 여부
  let charIndex = 0; // 현재 이름의 문자 인덱스

  function typeText() {
    const currentName = names[index];

    if (isAdding) {
      // 문자 추가 중
      dynamicText.textContent = `${currentName.slice(0, charIndex + 1)}`;
      charIndex++;

      if (charIndex === currentName.length) {
        // 이름 전체가 입력되었으면 잠시 대기
        isAdding = false;
        setTimeout(typeText, 2000); // 2초 대기
        return;
      }
    } else {
      // 문자 삭제 중
      dynamicText.textContent = `${currentName.slice(0, charIndex)}`;
      charIndex--;

      if (charIndex < 0) {
        // 삭제 완료 후 다음 이름으로 이동
        isAdding = true;
        index = (index + 1) % names.length; // 다음 이름으로 순환
      }
    }

    setTimeout(typeText, isAdding ? 200 : 100); // 타이핑 속도: 추가 시 200ms, 삭제 시 100ms
  }

  typeText(); // 타이핑 시작
});