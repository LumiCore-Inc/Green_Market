<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %>

<html>
<head>
    <title>Product Section</title>
    <style>
        /* Add any additional styles here */
        form {
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            border-radius: 5px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            box-sizing: border-box;
        }

        #image-container {
            width: 100px;
            height: 100px;
            border: 2px dashed #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            margin: 0px 10px 10px 0px;
        }

        .img-sec {
            max-width: 100%;
            max-height: 100%;
            display: none;
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

        /* Table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        #productTable {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        #productTable th, #productTable td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        #productTable th {
            background-color: #f2f2f2;
        }

        #productTable img {
            width: 100px;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        #productTable button {
            cursor: pointer;
            padding: 5px 10px;
            margin: 2px;
        }

        #productTable button:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>

<h2>Add Product</h2>

<form id="productForm" enctype="multipart/form-data">
    <label for="productName">Name:</label>
    <input type="text" id="productName" name="productName" required><br>

    <label for="productPrice">Price:</label>
    <input type="number" id="productPrice" name="productPrice" min="0" step="0.01" required><br>

    <label for="productDescription">Description:</label>
    <textarea id="productDescription" name="productDescription" rows="4" required></textarea><br>

    <label for="productQty">Quantity:</label>
    <input type="number" id="productQty" name="productQty" min="0" required><br>

    <div style="display: flex;width: 100%;">
        <div id="image-container" onclick="selectImage('no-image-text1', 'image-preview1')">
            <span id="no-image-text1" style="font-size: 8px">No Image Selected</span>
            <img class="img-sec" id="image-preview1" alt="Image Preview">
        </div>

        <div id="image-container" onclick="selectImage('no-image-text2','image-preview2' )">
            <span id="no-image-text2" style="font-size: 8px">No Image Selected</span>
            <img class="img-sec" id="image-preview2" alt="Image Preview">
        </div>

        <div id="image-container" onclick="selectImage('no-image-text3', 'image-preview3')">
            <span id="no-image-text3" style="font-size: 8px">No Image Selected</span>
            <img class="img-sec" id="image-preview3" alt="Image Preview">
        </div>

        <div style="margin-right: 0" id="image-container" onclick="selectImage('no-image-text4', 'image-preview4')">
            <span id="no-image-text4" style="font-size: 8px">No Image Selected</span>
            <img class="img-sec" id="image-preview4" alt="Image Preview">
        </div>
    </div>

    <input type="file" id="image-input" accept="image/*" style="display: none;" onchange="previewImage()">


    <button id="add-btn" type="button" onclick="addProduct()">Add Product</button>
    <button id="update-btn" type="button" onclick="updateProduct()">Update Product</button>
</form>

<h2>Product List</h2>

<table id="productTable">
    <thead>
    <tr>
        <th>Name</th>
        <th>Price</th>
        <th>Description</th>
        <th>Quantity</th>
        <th>Images</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody id="productTableBody">

    <!-- Product details will be dynamically added here -->
    </tbody>
</table>

    <script src="js/jquery-3.6.0.min.js"></script>
    <script src="js/adminProduct.js"></script>
    </body>
    </html>
