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
                <img src="${path}/images/community.png" alt="커뮤니티" width="30" height="30"/>
                <span class="alt-text"></span>
            </a>
            <a href="">
                <img src="${path}/images/plan.png" alt="플랜" width="30" height="30"/>
                <span class="alt-text"></span>
            </a>
            <a href="${path}/auth/viewMypage.do">
                <img src="${path}/images/user.png" alt="사용자" width="30" height="30"/>
                <span class="alt-text"></span>
            </a>
        </div>
    </div>
</header>