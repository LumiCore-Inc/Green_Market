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
    <script>
        function loadProductData() {
            var xhr = new XMLHttpRequest();
            let jwt = sessionStorage.getItem("jwt");
            var params = "action=all";

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    // Hide the loader when data is loaded
                    document.getElementById("loader").style.display = "none";

                    if (xhr.status === 200) {
                        var productData = JSON.parse(xhr.responseText);
                        displayProductData(productData.data);
                    } else {
                        // Handle errors here
                        console.error("Error loading product data");
                    }
                }
            };

            // Show loader while waiting for data
            document.getElementById("loader").style.display = "block";

            xhr.open("GET", "/product?" + params, true);
            xhr.setRequestHeader("Authorization", `Bearer ${jwt}`);
            xhr.send();
        }

        function displayProductData(productData) {
            var homeElement = document.getElementById("Home");
            var productElement = document.createElement("div");
            productElement.id = "Product";
            productElement.innerHTML = '<div class="small-container">' +
                '<div class="row row-2">' +
                '<h2>All Products</h2>' +
                '<select><option>Default Sorting</option><option>Sort by Price</option><option>Sort by Popularity</option><option>Sort by Rating</option><option>Sort by Sale</option></select></div></div>';
            productElement.innerHTML += '<div class="main-row">'

            for (var i = 0; i < productData.length; i++) {
                productElement.innerHTML += '<div class="row">' +
                    '<div class="col-4">' +
                    '<img src="' + productData[i].images[0]?.url + '">' +
                    '<h4>' + productData[i].name + '</h4>' +
                    '<div class="rating">' + generateStars(productData[i].ratings) + '</div>' +
                    '<p>$' + productData[i].price + '</p></div></div>';
            }

            productElement.innerHTML += '</div>><div class="page-btn"><span>1</span><span>2</span><span>3</span><span>4</span><span>&#8594;</span></div></div>';

            // Append the generated content to the Home element
            homeElement.appendChild(productElement);
        }

        function generateStars(rating) {
            // Generate star icons based on the product rating
            var stars = '';
            for (var i = 0; i < 5; i++) {
                stars += (i < rating) ? '<i class="fas fa-star"></i>' : '<i class="far fa-star"></i>';
            }
            return stars;
        }

        // Load product data when the page is loaded
        window.onload = function() {
            loadProductData();
        };
    </script>
</head>
<body>
<jsp:include page="navbar.jsp" />

<!-- Loader -->
<div id="loader" class="loader"></div>

<div id="Home" style="height: 100vh"></div>
<jsp:include page="footer.jsp" />
</body>
</html>
