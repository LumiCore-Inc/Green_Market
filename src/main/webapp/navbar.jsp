<!-- <%@ page contentType="text/html;charset=UTF-8" language="java" %> -->
<html>
<head>

    <style>
        .user-menu {
            position: relative;
            display: inline-block;
            cursor: pointer;
        }

        .user-menu-content {
            display: none;
            position: absolute;
            background-color: #fff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            z-index: 1;
            min-width: 160px;
            right: 0;
        }

        .user-menu:hover .user-menu-content {
            display: block;
        }

        .user-menu-item {
            padding: 10px;
            text-decoration: none;
            color: #333;
            display: block;
        }

        .user-menu-item:hover {
            background-color: #f0f0f0;
        }

        span{
            width: auto;
            border: none;
        }
    </style>

</head>
<body>

<div class="navBar">
    <div class="logo">
        <a href="index.jsp"><img src="img/logo-nsbm.jpg" width="170px"></a>
    </div>
    <nav>
        <ul>
            <li id="btnHome"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <li id="btnProduct"><a href="${pageContext.request.contextPath}/product">Product</a></li>
            <li id="btnAbout"><a href="${pageContext.request.contextPath}/about">About</a></li>
            <li id="btnContact">Contact</li>
            <li id="btnAccount"><a href="${pageContext.request.contextPath}/login.jsp">Account</a></li>
        </ul>
    </nav>
    <a style="margin-right: 20px;" href="${pageContext.request.contextPath}/cart"><img id="btnCart" src="img/icons/cart.png"style="cursor: pointer" width="30px" height="30px"></a>
    <div class="user-menu">
        <span><img src="img/default_profile.png"style="cursor: pointer" width="30px" height="30px"></span>
        <div class="user-menu-content">
            <a href="${pageContext.request.contextPath}/userProfileCard.jsp" class="user-menu-item">Profile</a>
            <a href="#" onclick="logout()" class="user-menu-item">Logout</a>
        </div>
    </div>
</div>

<script src="js/navBar.js"></script>
</body>
</html>
