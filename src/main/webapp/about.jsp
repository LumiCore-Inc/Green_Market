<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UMart | Ecommerce</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/common.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,100&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <style>
        .footer{
            position: fixed;
            width: 100%;

        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />
<div id="Home">
    <div class="small-container">

        <div class="row row-2">
            <img src="img/about.jpg" alt="about-page-image" style="width: 100%">
        </div>
        <div class="row">
            <h2>About Us</h2>
            <p>At Green Supermarket, we're committed to providing sustainable and eco-friendly options for your everyday needs. Our mission is to make a positive impact on the environment and your well-being by offering a wide range of organic, locally sourced, and environmentally conscious products.</p>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
