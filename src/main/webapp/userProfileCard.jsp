<%--
  Created by IntelliJ IDEA.
  User: ushan
  Date: 1/20/2024
  Time: 11:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <style>
        .modal {
            display: none;
            position: fixed!important;
            z-index: 1!important;
            left: 0!important;
            top: 0!important;
            width: 100% !important;
            height: 100% !important;
            background-color: rgba(0,0,0,0.7) !important;
            justify-content: center!important;
            align-items: center!important;
        }

        .modal-content {
            background-color: #fefefe!important;
            margin: 10% auto!important;
            padding: 20px!important;
            border: 1px solid #888!important;
            width: 80% !important;
            overflow-y: scroll!important;
            height: 80% !important;
        }

        .close {
            color: #aaa!important;
            float: right!important;
            font-size: 28px!important;
            font-weight: bold!important;
        }

        .close:hover,
        .close:focus {
            color: black!important;
            text-decoration: none!important;
            cursor: pointer!important;
        }

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

        .navBar{
            display: flex;
            align-items: center;
            padding: 5px 20px;
            border-bottom: 1px solid #cfcfcf;
        }
        nav{
            flex: 1;
            text-align: right;
        }
        nav ul{
            display: inline-block;
            list-style-type: none;
        }
        nav ul li{
            display: inline-block;
            margin-right: 20px;
            cursor: pointer;
            color: #04566E;
            font-weight: 600;
        }
        a{
            text-decoration: none!important;
            color: #555!important;
        }
    </style>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>

<div class="navBar">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/index.jsp"><img src="img/logo-nsbm.jpg" width="170px"></a>
    </div>
    <nav>
        <ul>
            <li id="btnHome"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
        </ul>
    </nav>
</div>

<div class="container rounded bg-white mt-5 mb-5">
    <div class="row">
        <div class="col-md-3 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5"
                                                                                         width="150px"
                                                                                         src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span
                    class="font-weight-bold" id="username"></span><span
                    class="text-black-50" id="email"></span><span> </span></div>
        </div>
        <div class="col-md-9 border-right">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="text-right">Profile Info</h4>
                </div>
                <div class="row mt-2">
                    <div class="col-md-6"><label class="labels">Email</label><input id="email-input" type="email" class="form-control"
                                                                                   placeholder="Email" >
                    </div>
                    <div class="col-md-6"><label class="labels">Password</label><input id="password" type="password" class="form-control"
                                                                                      value="" placeholder="password">
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-6"><label class="labels">First name</label><input type="text" class="form-control" id="firstName"
                                                                                      placeholder="First name" value="">
                    </div>
                    <div class="col-md-6"><label class="labels">Last name</label><input type="text" id="lastName"
                                                                                           class="form-control" value=""
                                                                                           placeholder="Last name"></div>
                </div>

                <div class="row mt-3">
                    <div class="col-md-6"><label class="labels">T.p</label><input id="tp" type="text" class="form-control"
                                                                                      placeholder="TP" value="">
                    </div>
                    <div class="col-md-6"><label class="labels">Address</label><input type="text" id="address"
                                                                                           class="form-control" value=""
                                                                                           placeholder="address"></div>
                </div>
                <div class="mt-5 text-center">
                    <button onclick="updateUserDetails()" class="btn btn-primary profile-button" type="button">Save Profile</button>
                </div>
            </div>
        </div>
    </div>

    <div>
        <h2>Orders History</h2>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Order Date</th>
                <th>Total</th>
                <th>Customer</th>
                <th style="text-align: center;">Action</th>
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
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/userProfile.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</body>
</html>
