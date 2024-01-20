<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List" %>
<%@ page import="com.green_market.entities.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
</head>
<body>
<jsp:include page="navbar.jsp" />
<div id="Home" style="width: -webkit-fill-available;">
  <div id="ProductDetails">

<%--    <form method="post" action="order" class="cart-table">--%>
    <div class="cart-table">
      <table  >
        <thead>
        <tr>
          <th>Product ID</th>
          <th>Product Name</th>
          <th>Price</th>
          <th>Description</th>
          <th>Image URL</th>
          <th>Product Count</th>
          <th>Action</th>

        </tr>
        </thead>
        <tbody id="t-body">
        <c:forEach var="product" items="${cartList}">
          <tr>
            <td><c:out value="${product.productCartId}" /></td>
            <td><c:out value="${product.productName}" /></td>
            <td><c:out value="${product.price}" /></td>
            <td><c:out value="${product.description}" /></td>
            <td><img src="${product.imgUrl}" alt="product url"></td>
            <td><input id="productCount" type="text" name="count" placeholder="Product Count" required="required"></td>
            <td class="cart-table-action-buttons">
<%--              <a href="${pageContext.request.contextPath}/cart?productId=${product.productCartId}&method=delete"><button>Delete</button></a>--%>
            <button onclick="deleteFunction(${product.productCartId})">Delete</button>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <div style="display: flex;justify-content: end;">
<%--        <button style="width: 20%;" type="submit" name="action" value="register" class="btn">Place Order</button>--%>
  <div style="display: flex;justify-content: end;">
    <c:set var="cartListJson">
      [
      <c:forEach var="product" items="${cartList}" varStatus="loop">
        {
        "productCartId": "${product.productCartId}",
        "productName": "${product.productName}",
        "price": "${product.price}",
        "description": "${product.description}",
        "imgUrl": "${product.imgUrl}"
        }<c:if test="${!loop.last}">,</c:if>
      </c:forEach>
      ]
    </c:set>
    <input id="hiddenInput" type="hidden" name="id" value="<c:out value='${cartListJson}' />" />


  </div>
  <button style="width: 20%;" onclick="placeOrder()" class="btn">Place Order </button>



<%--  <input type="button" onclick="placeOrder()" placeholder="Place Order">--%>


      </div>
    </div>
<%--    </form>--%>

</div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
  // var status = document.getElementById("status").value;
  // var message = document.getElementById("message").value;
  // if (status == "Error") {
  //   swal("Error", message, "error")
  // }

   function editFunction(productId) {
    // Make an AJAX request to the EditServlet with the productId
    // Replace 'EditServlet' with the actual servlet mapping for editing
    // You may need to adjust the URL and handle the response accordingly
    var url = '/product?productId=' + productId;
    // Example using fetch API
    fetch(url, {
    method: 'PUT',
    headers: {
    'Content-Type': 'application/json'
  },
  })
    .then(response => {
    // Handle the response as needed
    console.log(response);
  })
    .catch(error => console.error('Error:', error));
  }

  function placeOrder() {
    // Get all productCount input elements
    var productCountInputs = document.querySelectorAll('[id^="productCount"]');
    var cartListJsonString = document.getElementById('hiddenInput').value;

    var cartList = JSON.parse(cartListJsonString);

    // Check if all productCount inputs have valid values
    for (var i = 0; i < productCountInputs.length; i++) {
      var productCounts = productCountInputs[i].value;

      if (!isPositiveInteger(productCounts)) {
        alert('Please enter a valid product count for all products.');
        return;
      }
    }
    var detailsArray = [];

    // Iterate through cartList and productCountInputs to build the JSON object
    for (var i = 0; i < cartList.length; i++) {
      var product = cartList[i];
      var productCount = productCountInputs[i]?.value;

      // Create an object for each product
      var productObject = {
        "productId": parseInt(product.productCartId), // Change this to match your actual product ID property
        "unitPrice": parseFloat(product.price), // Assuming product price is a string, convert to float
        "qty": parseInt(productCount) // Assuming productCount is a string, convert to integer
      };

      // Add the product object to the array
      detailsArray.push(productObject);
    }

    // Calculate the total price based on the detailsArray
    var total = detailsArray.reduce((acc, product) => acc + (product.unitPrice * product.qty), 0);

    // Create the final JSON object
    var orderDetails = {
      "total": parseInt(total), // Ensure total is formatted with two decimal places
      "details": detailsArray
    };

    // Log the created JSON object for debugging
    console.log(orderDetails);

    // Example: send the order only if validation passes
    var url = '/order';
    fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(orderDetails)
    })
            .then(response => {
              // Handle the response as needed
              console.log(response);
            })
            .catch(error => console.error('Error:', error));
  }

     function isPositiveInteger(str) {
       var n = Math.floor(Number(str));
       return n !== Infinity && String(n) === str && n > 0;
     }
  //
  //  function placeOrder(productList) {
  //    console.log("Received JSON data:", document.getElementById('hiddenInput').value);
  //
  //    var productCountInputs = document.querySelectorAll('[id^="productCount"]');
  //
  //    for (var i = 0; i < productCountInputs.length; i++) {
  //      var productCount = productCountInputs[i].value;
  //
  //      if (!isPositiveInteger(productCount)) {
  //        alert('Please enter a valid product count for all products.');
  //        return;
  //      }
  //    }
  //
  //    function isPositiveInteger(str) {
  //      var n = Math.floor(Number(str));
  //      return n !== Infinity && String(n) === str && n > 0;
  //    }
  //
  //    // Make an AJAX request to the EditServlet with the productId
  //   // Replace 'EditServlet' with the actual servlet mapping for editing
  //   // You may need to adjust the URL and handle the response accordingly
  //   var url = '/order';
  //   // Example using fetch API
  //   fetch(url, {
  //   method: 'POST',
  //   headers: {
  //   'Content-Type': 'application/json'
  //   },
  //     data: JSON.stringify(document.getElementById('hiddenInput').value)
  // })
  //   .then(response => {
  //   // Handle the response as needed
  //   console.log(response);
  // })
  //   .catch(error => console.error('Error:', error));
  // }

    function deleteFunction(productId) {
    // Make an AJAX request to the DeleteServlet with the productId
    // Replace 'DeleteServlet' with the actual servlet mapping for deletion
    // You may need to adjust the URL and handle the response accordingly
    var url = '/cart?productCartId=' + productId + '&method=delete';
    // Example using fetch API
    fetch(url, {
    method: 'GET',
    headers: {
    'Content-Type': 'application/json'
  },
  })
    .then(response => {
      location.reload(true);
    // Handle the response as needed
    console.log(response);
  })
    .catch(error => console.error('Error:', error));
  }
</script>
</body>
</html>
