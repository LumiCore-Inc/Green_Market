<%
    if (session.getAttribute("jwt") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Green Market | User Profile</title>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            background-color: #2c3e50;
            padding-top: 20px;
        }

        .sidebar a {
            padding: 15px 20px;
            text-decoration: none;
            font-size: 18px;
            color: #ecf0f1;
            display: block;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background-color: #3498db;
        }

        .content {
            margin-left: 250px;
            padding: 16px;
        }

        h2 {
            color: #2c3e50;
        }

        .top-bar {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: -16px;
            position: sticky;
            top: 0;
        }

        .label {
            font-size: 18px;
            font-weight: bold;
        }

    </style>


</head>
<body>
<div class="sidebar">
    <a href="javascript:void(0);" onclick="loadContent('userProfileCard.jsp')">Profile Info</a>
    <a href="javascript:void(0);" onclick="loadContent('adminOrders.jsp')">Orders</a>
</div>

<div class="content">
    <div class="top-bar">
        <div class="label">Green Market</div>
    </div>
    <div id="mainContent">
        <jsp:include page="userProfileCard.jsp"/>
    </div>
</div>

<script>
    function loadContent(page) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("mainContent").innerHTML = this.responseText;
                executeLoadedScript(page);
            }
        };
        xhttp.open("GET", page, true);
        xhttp.send();
    }

    function executeLoadedScript(page) {
        var scripts = document.getElementById("mainContent").getElementsByTagName("script");
        for (var i = 0; i < scripts.length; i++) {
            eval(scripts[i].innerText);
        }
        if (typeof loadedScriptInit === 'function') {
            loadedScriptInit();
        }
    }
</script>

</body>
</html>
