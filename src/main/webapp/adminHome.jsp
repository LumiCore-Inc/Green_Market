<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Green Mart | Admin</title>
    <link rel="stylesheet" href="css/common.css">
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
            background-color: #2c3e50; /* Background color */
            padding-top: 20px;
        }

        .sidebar a {
            padding: 15px 20px;
            text-decoration: none;
            font-size: 18px;
            color: #ecf0f1; /* Text color */
            display: block;
            transition: 0.3s;
        }

        .sidebar a:hover {
            background-color: #3498db; /* Hover color */
        }

        .content {
            margin-left: 250px;
            padding: 16px;
        }

        h2 {
            color: #2c3e50; /* Heading color */
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

        .user-info {
            display: flex;
            align-items: center;
        }

        .username {
            margin-right: 10px;
        }

        .user-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #fff;
            overflow: hidden;
        }

        .user-icon img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

    </style>
</head>


<body>
<div class="sidebar">
    <a href="javascript:void(0);" onclick="loadContent('adminProducts.jsp')">Product</a>
    <a href="javascript:void(0);" onclick="loadContent('adminOrders.jsp')">Orders</a>
</div>

<div class="content" >
    <div class="top-bar">
        <div class="label">Green Market</div>
        <div class="user-info">
            <div class="username" id="username"></div>
            <div class="user-icon">
                <!-- You can replace the src attribute with the path to your user icon image -->
                <img src="img/default_profile.png" alt="User Icon">
            </div>
        </div>
    </div>
    <div id="mainContent">
        <jsp:include page="adminProducts.jsp"/>
    </div>
</div>

<script>

    if (typeof loadedAdminProductScriptInit === 'function') {
        loadedAdminProductScriptInit();
    }

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
        // Extract the script tags from the loaded content
        var scripts = document.getElementById("mainContent").getElementsByTagName("script");

        // Iterate through the script tags and execute them
        for (var i = 0; i < scripts.length; i++) {
            eval(scripts[i].innerText);
        }

        if (typeof loadedScriptInit === 'function') {
            loadedScriptInit();
        }

    }

</script>
<%--<script src="js/adminProduct.js"></script>--%>
<%--<script src="js/adminOrders.js"></script>--%>


</body>
</html>
