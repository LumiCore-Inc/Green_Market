<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>
<html>
<head>
    <link rel="stylesheet" href="css/common.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        #ordersTableBody button:hover {
            background-color: #ddd;
        }

        /* Add your styling here */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.7);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            overflow-y: scroll;
            height: 80%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }


    </style>
</head>
<body>

<h2>Orders List</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Order Date</th>
        <th>Total</th>
        <th>Customer</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody id="ordersTableBody">
    </tbody>
</table>

<div class="modal" id="orderModal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div id="orderDetails"></div>
    </div>
</div>

<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/adminOrders.js"></script>
</body>
</html>
