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
    <%--   <script>
   function submitForm() {--%>
    <%--        var jwt = sessionStorage.getItem('jwt')--%>
    <%--        var form = document.getElementById('cartForm');--%>

    <%--        console.log("Form Action:", form);--%>

    <%--        &lt;%&ndash;// Create and send the XMLHttpRequest&ndash;%&gt;--%>
    <%--        &lt;%&ndash;var xhr = new XMLHttpRequest();&ndash;%&gt;--%>
    <%--        &lt;%&ndash;xhr.open("POST", form.action, true);&ndash;%&gt;--%>
    <%--        &lt;%&ndash;xhr.setRequestHeader("Authorization", `Bearer ${jwt}`);&ndash;%&gt;--%>
    <%--        &lt;%&ndash;xhr.setRequestHeader("xx", `Bearer ${jwt}`);&ndash;%&gt;--%>
    <%--        &lt;%&ndash;xhr.onreadystatechange = function() {&ndash;%&gt;--%>
    <%--        &lt;%&ndash;    // Handle the response here if needed&ndash;%&gt;--%>
    <%--        &lt;%&ndash;    if (xhr.readyState == 4 && xhr.status == 200) {&ndash;%&gt;--%>
    <%--        &lt;%&ndash;        // Handle successful response&ndash;%&gt;--%>
    <%--        &lt;%&ndash;        console.log(xhr.responseText);&ndash;%&gt;--%>
    <%--        &lt;%&ndash;    }&ndash;%&gt;--%>
    <%--        &lt;%&ndash;};&ndash;%&gt;--%>
    <%--        &lt;%&ndash;xhr.send(formData);&ndash;%&gt;--%>

    <%--        fetch(form.action, {--%>
    <%--            method: 'POST',--%>
    <%--            headers: {--%>
    <%--                'Content-Type': 'application/x-www-form-urlencoded',--%>
    <%--                'Authorization': `Bearer ${jwt}`--%>
    <%--            },--%>
    <%--            body: `cartQty=${encodeURIComponent(cartQty)}`--%>
    <%--        })--%>
    <%--            .then(response => {--%>
    <%--                if (!response.ok) {--%>
    <%--                    throw new Error(`Request failed with status: ${response.status}`);--%>
    <%--                }--%>
    <%--                return response.text();--%>
    <%--            })--%>
    <%--            .then(data => {--%>
    <%--                // Handle successful response--%>
    <%--                console.log(data);--%>
    <%--            })--%>
    <%--            .catch(error => {--%>
    <%--                // Handle errors--%>
    <%--                console.error(error);--%>
    <%--            });--%>
    <%--    }--%>
    <%--</script>--%>
</head>
<body>
<jsp:include page="navbar.jsp" />
<div id="Home">
    <div id="ProductDetails">
        <p id="cartNumber"></p>
        <div class="small-container single-product">
            <div class="row">
                <div class="col-2" style="flex-basis: 65%; display: flex; flex-direction: row;">
                    <div>
                        <img src="${product.productHasImages.get(0).url}" width="100%" id="ProductImg">
                    </div>

                    <div class="small-img-parent" style="flex-basis: 24%;">
                        <div class="small-img-col">
                            <img src="${product.productHasImages.get(1).url}" class="small-img" style="max-width: 170px;">
                        </div>
                        <div class="small-img-col">
                            <img src="${product.productHasImages.get(0).url}" class="small-img" style="max-width: 170px;">
                        </div>
                        <div class="small-img-col">
                            <img src="${product.productHasImages.get(1).url}" class="small-img" style="max-width: 170px;">
                        </div>
                    </div>

                </div>
                <div class="col-2" style="flex-basis: 35%;">
                    <p>Home / T-Shirt</p>
                    <h1 id="ProductDetailsName">${product.name}</h1>
                    <h4 id="ProductDetailsPrice">${product.price}</h4>
                    <select id="selectSize">
                        <option>Select Size</option>
                        <option>XXL</option>
                        <option>XL</option>
                        <option>Large</option>
                        <option>Medium</option>
                        <option>Small</option>
                    </select>
                    <input type="hidden" id="status" value="<%= (request.getSession().getAttribute("status") != null) ? request.getSession().getAttribute("status") : "" %>">
                    <input type="hidden" id="message" value="<%= (request.getSession().getAttribute("message") != null) ? request.getSession().getAttribute("message") : "Something went wrong!" %>">
                    <form id="cartForm" method="post" action="/cart?productId=${product.id}" >
                        <input id="cartQty" type="number" value="1">
                        <input type="hidden" name="Authentication" value="${session.getAttribute("jwt")}">
                        <button id="btnAdminLogin" type="submit" name="action" value="register" class="btn">Add to cart</button>
                    </form>

                    <h3>Product Details <i class="fas fa-indent"></i></h3>
                    <br>
                    <p>${product.description}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
    var status = document.getElementById("status").value;
    var message = document.getElementById("message").value;
    if (status == "Error") {
        swal("Error", message, "error")
    } else if (status == "Success") {
        swal("Success", message, "success")

    }
</script>
</body>
</html>
