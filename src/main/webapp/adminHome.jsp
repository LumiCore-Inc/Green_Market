<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Green Market</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
            background-color: #04566E;
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
        .header-title {
            padding: 16px;
            background-color: #04566E;
            color: white;
        }
    </style>
</head>


<body>
<div class="sidebar">
    <div class="logo">
        <img src="img/logo-nsbm.jpg" width="140px" style="margin-left: 1rem;">
    </div>
    <a href="javascript:void(0);" onclick="loadContent('adminProducts.jsp')">Product</a>
    <a href="javascript:void(0);" onclick="loadContent('adminOrders.jsp')">Orders</a>
</div>

<div class="content" >
    <div id="mainContent">
        <jsp:include page="adminProducts.jsp"/>
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
