<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            background-color: #7f7f7f;
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

<h2 class="header-title">Order List</h2>

<div style="padding: 16px;">
    <table >
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
</div>

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
