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
    </script>
</head>
<body>
<jsp:include page="navbar.jsp" />

<!-- Loader -->
<div id="loader" class="loader"></div>

<div id="Home" style="height: 100vh">
    <div class="small-container">

        <div class="row row-2">
            <h2>All Product</h2>
            <select>
                <option>Default Shorting</option>
                <option>Short by Price</option>
                <option>Short by Popularity</option>
                <option>Short by Rating</option>
                <option>Short by Sale</option>
            </select>
        </div>
        <div class="row">
            <c:forEach var="todo" items="${listTodo}">
            <div class="col-4">
                <img src="assets/images/product-1.jpg">
                <h4><c:out value="${todo.name}" /></h4>
                <div class="rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                </div>
                <p><c:out value="${todo.price}" /></p>
            </div>
            </c:forEach>

        </div>
    </div>
</div>
<%--    <c:forEach var="todo" items="${listTodo}">--%>

<%--        <tr>--%>
<%--            <td><c:out value="${todo.title}" /></td>--%>
<%--            <td><c:out value="${todo.targetDate}" /></td>--%>
<%--            <td><c:out value="${todo.status}" /></td>--%>

<%--            <td><a href="edit?id=<c:out value='${todo.id}' />">Edit</a>--%>
<%--                &nbsp;&nbsp;&nbsp;&nbsp; <a--%>
<%--                        href="delete?id=<c:out value='${todo.id}' />">Delete</a></td>--%>

<%--            <!--  <td><button (click)="updateTodo(todo.id)" class="btn btn-success">Update</button>--%>
<%--                      <button (click)="deleteTodo(todo.id)" class="btn btn-warning">Delete</button></td> -->--%>
<%--        </tr>--%>

<jsp:include page="footer.jsp" />
</body>
</html>
