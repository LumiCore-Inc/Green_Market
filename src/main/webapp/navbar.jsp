<!-- <%@ page contentType="text/html;charset=UTF-8" language="java" %> -->
<html>
<head>
</head>
<body>

<div class="navBar">
    <div class="logo">
        <a href="index.jsp"><img src="img/logo-nsbm.jpg" width="170px"></a>
    </div>
    <nav>
        <ul>
            <li id="btnHome"><a href="index.jsp">Home</a></li>
            <li id="btnProduct"><a href="${pageContext.request.contextPath}/product">Product</a></li>
            <li id="btnAbout"><a href="/about">About</a></li>
            <li id="btnContact">Contact</li>
            <li id="btnAccount"><a href="${pageContext.request.contextPath}/login.jsp">Account</a></li>
        </ul>
    </nav>
    <img id="btnCart" src="img/icons/cart.png"style="cursor: pointer" width="30px" height="30px">
</div>
</body>
</html>
