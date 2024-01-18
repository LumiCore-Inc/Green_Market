<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Green Mart | Admin</title>
</head>

<style>
    /* styles.css */

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

    /* Add more styles as needed */

</style>

<body>
<div class="sidebar">
    <a href="javascript:void(0);" onclick="loadContent('adminProducts.jsp')">Product</a>
    <a href="javascript:void(0);" onclick="loadContent('adminOrders.jsp')">Orders</a>
</div>

<div class="content" id="mainContent">
    <jsp:include page="adminProducts.jsp"/> <!-- Initial content -->
</div>

<script>
    function loadContent(page) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("mainContent").innerHTML = this.responseText;
            }
        };
        xhttp.open("GET", page, true);
        xhttp.send();
    }
</script>
</body>
</html>
