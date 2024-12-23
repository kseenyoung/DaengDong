<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여행 계획 생성</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>여행 계획 생성</h1>
    <form id="planForm" method="post" action="/api/plans">
        <div class="mb-3">
            <label for="planName" class="form-label">Travel Name</label>
            <input type="text" class="form-control" id="planName" name="planName" required>
        </div>
        <div class="mb-3">
            <label for="region" class="form-label">Select Region</label>
            <select class="form-control" id="region" name="region" required>
                <option value="">-- Select Region --</option>
                <!-- 서버에서 전달된 regions 데이터를 렌더링 -->
                <c:forEach var="region" items="${regions}">
                    <option value="${region}">${region}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label for="dateRange" class="form-label">Period</label>
            <input type="text" class="form-control" id="dateRange" name="dateRange" required>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    // Initialize date range picker (if needed)
    document.addEventListener('DOMContentLoaded', () => {
        const dateRangeInput = document.getElementById('dateRange');
        // Add your preferred date picker library here if needed
    });
</script>
</body>
</html>
