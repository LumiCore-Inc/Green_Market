<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Green Market</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/common.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,100&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
          integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <style>
        .footer {
            position: fixed;
            width: 100%;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp"/>
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
                            <img src="${product.productHasImages.get(1).url}" class="small-img"
                                 style="max-width: 170px;">
                        </div>
                        <div class="small-img-col">
                            <img src="${product.productHasImages.get(2).url}" class="small-img"
                                 style="max-width: 170px;">
                        </div>
                        <div class="small-img-col">
                            <img src="${product.productHasImages.get(3).url}" class="small-img"
                                 style="max-width: 170px;">
                        </div>
                    </div>

                </div>
                <div class="col-2" style="flex-basis: 35%;">
                    <h1 id="ProductDetailsName">${product.name}</h1>
                    <h4 id="ProductDetailsPrice">${product.price}</h4>
                    <input type="hidden" id="status"
                           value="<%= (request.getSession().getAttribute("status") != null) ? request.getSession().getAttribute("status") : "" %>">
                    <input type="hidden" id="message"
                           value="<%= (request.getSession().getAttribute("message") != null) ? request.getSession().getAttribute("message") : "Something went wrong!" %>">

                    <form id="cartForm" method="post"
                          action="${pageContext.request.contextPath}/cart?productId=${product.id}"
                          onsubmit="setHeaders()">
                        <input type="hidden" name="Authentication" value="${session.getAttribute("jwt")}">
                        <button id="btnAdminLogin" type="submit" name="action" value="register" class="btn">Add to
                            cart
                        </button>
                    </form>

                    <h3>Product Details <i class="fas fa-indent"></i></h3>
                    <br>
                    <p>${product.description}</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
    var status = document.getElementById("status").value;
    var message = document.getElementById("message").value;
    if (status == "Error") {
        swal("Error", message, "error")
    }

    function setHeaders() {
        var url = '/cart?productId=${product.id}';
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
        })
            .then(res => {
                swal("Success", "Order placed", "success").then(() => {
                    window.location.href = 'index.jsp';
                });

            })
            .catch(error => console.error('Error:', error));
    }
</script>
</body>
</html>
