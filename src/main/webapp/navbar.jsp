<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>

<div class="navBar">
    <div class="logo">
        <a href="index.html"><img src="assets/images/logo-black%20.png" width="125px"></a>
    </div>
    <nav>
        <ul>
            <li id="btnHome">Home</li>
            <li id="btnProduct">Product</li>
            <li id="btnAbout">About</li>
            <li id="btnContact">Contact</li>
            <li id="btnAccount">Account</li>
        </ul>
    </nav>
    <img id="btnCart" src="assets/images/cart.png"style="cursor: pointer" width="30px" height="30px">

    <div id="homeModel" class="modal-bg">
        <div class="modal">
            <h2>Please Login</h2>
            <input class="input" id="cartUserName" type="text" placeholder="User Name">
            <input class="input" id="cartPassword" type="password" placeholder="Password">
            <button id="btnCartSingIn" class="btn">SingIn</button>
            <span id="cartModel-close" class="model-close">X</span>
        </div>
    </div>
</div>
</body>
</html>
