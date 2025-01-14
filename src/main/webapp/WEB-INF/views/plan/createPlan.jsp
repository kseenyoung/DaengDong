<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>여행 계획 생성</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Date Range Picker CSS -->
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

  <style>

  .plan_body {

  }
  .plan_div1 {
    width: 45%;
   background: url("${path}/img/plan_create2.jpg") no-repeat center 100% / cover
  }
  .plan_div2 {
     height: 100vh;
     display: flex;
     flex-direction: column;
     justify-content: center;
     align-items: center;
     width: 55%;
   font-weight: 700;
  }
  .plan_div2 h1 {
    font-weight: 700;
  }
   .container_plan {
        width: 100vw;
          display: flex;
          height: 100vh;
          margin:0;
   }
   #planForm {
     width: 400px;
     height: 450px;
     background: #4ac3ffc4;
     padding: 10px;
     border-radius: 10px;
     margin-top: 20px;
     border: 2px solid #fff;
     color:#fff;
     display: flex;
     flex-direction: column;
     justify-content: center;
   }
     #planForm button {
       display: block;
       margin: 0 auto;
       border: 0px;
           font-weight: 700;
           background-color: #4f9bf7;
     }
     .plan_button_div {



     }
  </style>
</head>
<body class="plan_body">
    <%@include file="../member/header.jsp" %>
<div class="container_plan">
<div class="plan_div1">
</div>

<div class="plan_div2">
      <h1 >함께하는 여행</h1>
      <form id="planForm" method="post" action="/plan">
        <div class="mb-3">
          <label for="planName" class="form-label">여행이름</label>
          <input type="text" class="form-control" id="planName" name="planName" required>
        </div>
        <div class="mb-3">
          <label for="dateRange" class="form-label">기간</label>
          <input type="text" class="form-control" id="dateRange" name="dateRange" required>
        </div>
        <!-- 공개 여부 스위치 -->
        <div class="mb-3">
          <label for="planState" class="form-label">공개 여부</label>
          <div class="form-check form-switch">
            <input class="form-check-input" type="checkbox" id="planState" name="planState">
            <label class="form-check-label" for="planState">공개</label>
          </div>
        </div>
        <div class="plan_button_div">
        <button type="submit" class="btn btn-primary">플랜 생성</button>
        </div>

      </form>

</div>
</div>

<%-- 콘솔 찍어보는 용 --%>
<script>
  document.getElementById("planForm").addEventListener('submit', function (event) {
    event.preventDefault();  // 기본 form 제출 방지

    // Form 데이터 수집
    const formData = {
      planName: document.getElementById("planName").value,
      dateRange: document.getElementById('dateRange').value,
      planState: document.getElementById('planState').checked ? 1 : 0 // 공개 여부: true = 1, false = 0
    };

    // dateRange를 startDate와 endDate로 분리
    const [startDate, endDate] = formData.dateRange.split(" - ");
    const requestData = {
      planName: formData.planName,
      startDate: `\${startDate.trim()}`,  // 시작 날짜에 시간 추가
      endDate: `\${endDate.trim()}`,      // 종료 날짜에 시간 추가
      planState: formData.planState
    };

    // 콘솔에 실질적으로 전송될 객체 출력
    console.log("전송 데이터:", requestData);

    // 서버로 전송
      fetch('${path}/plan/create', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(requestData)
      }).then(response => response.json())
          .then(data => {
              const redirectUrl = data.redirectUrl;
              if (redirectUrl) {
                  location.href = redirectUrl;
              } else {
                  alert("플랜 생성에 실패했습니다.");
              }
          }).catch(error => {
          console.error("요청 실패:", error);
          alert("오류가 발생했습니다.");
      });

  });
</script>

<!-- External Libraries -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>
  $(document).ready(function () {
    $('#dateRange').daterangepicker({
      "startDate": moment().format('YYYY-MM-DD'),
      "endDate": moment().add(7, 'days').format('YYYY-MM-DD'),
      locale: {
        format: 'YYYY-MM-DD'
      }
    });
  });
</script>
</body>
</html>