<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script>
        function loadProductData() {
            var xhr = new XMLHttpRequest();
            let jwt = sessionStorage.getItem("jwt");
            var params = "action=all";

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var productData = JSON.parse(xhr.responseText);
                    document.getElementById("Home").innerHTML = "Product Data: " + JSON.stringify(productData);
                }
            };
            xhr.open("GET", "/product?"+params, true);
            xhr.setRequestHeader("Authorization", `Bearer ${jwt}`);
            xhr.send();
        }

        // Load product data when the page is loaded
        window.onload = function() {
            loadProductData();
        };
    </script>
</head>
<body>
<jsp:include page="navbar.jsp" />
<div id="Home">

    <div id="Product">
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
                <div class="col-4">
                    <img src="assets/images/product-1.jpg">
                    <h4>Marvel T-Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$50.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-2.jpg">
                    <h4>Bum Bag</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p>$20.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-3.jpg">
                    <h4>Red Printed T-Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$70.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-4.jpg">
                    <h4>Baggy Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$40.0</p>
                </div>
            </div>

            <div class="row">
                <div class="col-4">
                    <img src="assets/images/product-5.jpg">
                    <h4>Marvel T-Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$50.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-6.jpg">
                    <h4>Bum Bag</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p>$20.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-7.jpg">
                    <h4>Red Printed T-Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$70.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-8.jpg">
                    <h4>Baggy Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$40.0</p>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <img src="assets/images/product-9.jpg">
                    <h4>Marvel T-Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$50.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-10.jpg">
                    <h4>Bum Bag</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <p>$20.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-11.jpg">
                    <h4>Red Printed T-Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$70.0</p>
                </div>
                <div class="col-4">
                    <img src="assets/images/product-12.jpg">
                    <h4>Baggy Shirt</h4>
                    <div class="rating">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p>$40.0</p>
                </div>
            </div>
            <div class="page-btn">
                <span>1</span>
                <span>2</span>
                <span>3</span>
                <span>4</span>
                <span>&#8594;</span>
            </div>
        </div>
    </div>

</div>
<jsp:include page="footer.jsp" />

</body>
</html>
