<%--
  Created by IntelliJ IDEA.
  User: evan
  Date: 12/24/24
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/ScrollTrigger.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css" rel="stylesheet"/>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&family=Dongle:wght@400;700&family=Rubik+Bubbles&family=Rubik+Gemstones&display=swap"
            rel="stylesheet">
    <link rel="stylesheet" href="${path}/css/header.css"/>
    <title>myPage</title>
</head>
<header id="header">
    <div id="header_box">
        <h1 id="logo">댕동</h1>
        <div id="header_right">
            <a href="">
                <img src="https://daengdong-bucket.s3.amazonaws.com/2ff2135a-b82b-4c3a-a483-b6f765d23aa0_bell.png" alt="알림" width="30" height="30"/>
                <span class="alt-text"></span>
            </a>
            <a href="${path}/post/posts">
                <img src="https://daengdong-bucket.s3.amazonaws.com/27910ecc-028d-457c-af07-0529c13d5d5b_heart.png" alt="커뮤니티" width="30" height="30" />
                <span class="alt-text"></span>
            </a>
            <a href="${path}/plan/create">
                <img src="https://daengdong-bucket.s3.amazonaws.com/2578b82d-fe9d-4304-8bbb-e365a4666a70_add.png" alt="플랜" width="30" height="30" />
                <span class="alt-text"></span>
            </a>
            <a href="${path}/auth/viewMypage.do">
                <img src="https://daengdong-bucket.s3.amazonaws.com/b3eb7fe8-cbd7-4dc8-a4e2-fd88cd1ca577_single.png" alt="사용자" width="30" height="30" />
                <span class="alt-text"></span>
            </a>
        </div>
    </div>
</header>
