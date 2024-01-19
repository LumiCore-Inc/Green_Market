<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UMart | Ecommerce</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,100&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <style>
        .loader {
            border: 8px solid #f3f3f3;
            border-top: 8px solid #3498db;
            border-radius: 50%;
            width: 50px;
            animation: spin 15s linear infinite;
            margin: 50px auto;
            height: 50px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<!-- Loader -->
<%--<div id="loader" class="loader"></div>--%>

<div id="Home">
    <div class="small-container">

        <div class="row row-2">
            <h2>All Product</h2>
<%--            <select>--%>
<%--                <option>Default Shorting</option>--%>
<%--                <option>Short by Price</option>--%>
<%--                <option>Short by Popularity</option>--%>
<%--                <option>Short by Rating</option>--%>
<%--                <option>Short by Sale</option>--%>
<%--            </select>--%>
        </div>
        <div class="row">
            <c:forEach var="todo" items="${listTodo}">
            <div class="col-4">
                <a href="${pageContext.request.contextPath}/product?productId=${todo.id}" >
                <img src="${todo.productHasImages.get(0).url}">
                <h4><c:out value="${todo.name}" /></h4>


                <c:set var="rating" value="${todo.ratings}" />

                <div class="rating">
                    <c:forEach begin="1" end="${rating}" var="i">
                        <i class="fas fa-star"></i>
                    </c:forEach>
                    <c:forEach begin="${rating + 1}" end="5" var="i">
                        <i class="far fa-star"></i>
                    </c:forEach>
                </div>

                <p><c:out value="${todo.price}" /></p>
                </a>
            </div>
            </c:forEach>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
