<%
	if (session.getAttribute("name")==null){
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>UMart | Ecommerce</title>
	<link rel="stylesheet" href="css/style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,100&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
</head>
<body>


<div class="navBar">
	<div class="logo">
		<a href="index.html"><img src="assets/images/logo-black%20.png" width="125px"></a>
	</div>
	<nav>
		<ul>
			<li id="btnHome">Home</li>
			<li id="btnProduct">Product</li>
			<li id="btnAbout">About</li>
			<li id="btnContact">Contact</li>
			<li id="btnAccount">Account</li>
		</ul>
	</nav>
	<img id="btnCart" src="assets/images/cart.png"style="cursor: pointer" width="30px" height="30px">

	<div id="homeModel" class="modal-bg">
		<div class="modal">
			<h2>Please Login</h2>
			<input class="input" id="cartUserName" type="text" placeholder="User Name">
			<input class="input" id="cartPassword" type="password" placeholder="Password">
			<button id="btnCartSingIn" class="btn">SingIn</button>
			<span id="cartModel-close" class="model-close">X</span>
		</div>
	</div>
</div>

<div id="Home">
	<div class="header">
		<div class="container">
			<div class="row">
				<div class="col-2">
					<h1>Give Your Workout <br> A New Style!</h1>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. A amet, commodi eligendi esse facere fuga labore, laborum maxime odio quas quis quos reiciendis?</p>
					<a href="" class="btn">Explore Now  &#8594;</a>
				</div>
				<div class="col-2">
					<img src="assets/images/image1.png" >
				</div>
			</div>
		</div>
	</div>

	<div class="categories">
		<div class="small-container">
			<div class="row">
				<div class="col-3">
					<img src="assets/images/category-1.jpg" >
				</div>
				<div class="col-3">
					<img src="assets/images/category-2.jpg" >
				</div>
				<div class="col-3">
					<img src="assets/images/category-3.jpg" >
				</div>
			</div>
		</div>
	</div>

	<div class="small-container">
		<h2 class="title">Featured Products</h2>
		<div class="row">
			<div class="col-4">
				<img  class="ProductHomeImg" id="btnProductDetails1" src="assets/images/product-1.jpg">
				<h4 id="Name1">Marvel T-Shirt</h4>
				<div class="rating">
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="far fa-star"></i>
				</div>
				<p id="price1">$50.00</p>
			</div>
			<div class="col-4">
				<img class="ProductHomeImg" id="btnProductDetails2" src="assets/images/product-2.jpg">
				<h4 id="Name2" class="Name">Bum Bag</h4>
				<div class="rating">
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star-half-alt"></i>
				</div>
				<p id="price2">$20.00</p>
			</div>
			<div class="col-4">
				<img class="ProductHomeImg" id="btnProductDetails3" src="assets/images/product-3.jpg">
				<h4 id="Name3">Red Printed T-Shirt</h4>
				<div class="rating">
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="far fa-star"></i>
				</div>
				<p id="price3">$70.00</p>
			</div>
			<div class="col-4">
				<img class="ProductHomeImg" id="btnProductDetails4" src="assets/images/product-4.jpg">
				<h4 id="Name4">Baggy Shirt</h4>
				<div class="rating">
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star"></i>
					<i class="fas fa-star-half-alt"></i>
					<i class="far fa-star"></i>
				</div>
				<p id="price4">$40.00</p>
			</div>
		</div>

		<h2 class="title">Latest Products</h2>

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
	</div>

	<div class="offer">
		<div class="small-container">
			<div class="row">
				<div class="col-2">
					<img src="assets/images/exclusive.png" class="offer-img">
				</div>
				<div class="col-2">
					<p>Exclusively Available on UMart</p>
					<h1>Smart Brand 4</h1>
					<small>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium architecto commodi harum laborum molestias natus nihil null</small>
					<a href="" class="btn">Buy Now &#8594</a>
				</div>
			</div>
		</div>
	</div>

	<div class="testimonial">
		<div class="small-container">
			<div class="row">
				<div class="col-3">
					<i class="fas fa-quote-left"></i>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam animi consectetur enim facilis in ipsum, labore magnam quisquam quo veniam. </p>
					<div class="rating">
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="far fa-star"></i>
					</div>
					<img src="assets/images/user-1.png">
					<h3>Suny Leon</h3>
				</div>

				<div class="col-3">
					<i class="fas fa-quote-left"></i>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam animi consectetur enim facilis in ipsum, labore magnam quisquam quo veniam. </p>
					<div class="rating">
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="far fa-star"></i>
					</div>
					<img src="assets/images/user-2.png">
					<h3>Jone Sins</h3>
				</div>

				<div class="col-3">
					<i class="fas fa-quote-left"></i>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquam animi consectetur enim facilis in ipsum, labore magnam quisquam quo veniam. </p>
					<div class="rating">
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="far fa-star"></i>
					</div>
					<img src="assets/images/user-3.png">
					<h3>Brandi Lovers</h3>
				</div>
			</div>
		</div>
	</div>

	<div class="brands">
		<div class="small-container">
			<div class="row">
				<div class="col-5">
					<img src="assets/images/logo-paypal.png">
				</div>
			</div>
		</div>
	</div>

	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="footer-col-1">
					<h3>Download Our App</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
					<div class="app-logo">
						<img src="assets/images/play-store.png">
						<img src="assets/images/app-store.png">
					</div>
				</div>
				<div class="footer-col-2">
					<img src="assets/images/logo-white%20.png" width="300px" height="70px">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
				</div>
				<div class="footer-col-3">
					<h3>Useful Links</h3>
					<ul>
						<li>Coupons</li>
						<li>Blog Post</li>
						<li>Return Police</li>
						<li>Join Affiliate</li>
					</ul>
				</div>
				<div class="footer-col-4">
					<h3>Follow us</h3>
					<ul>
						<li>Facebook</li>
						<li>Twitter</li>
						<li>Instagram</li>
						<li>Youtube</li>
					</ul>
				</div>
			</div>
			<hr>
			<p class="copyright">Copyright 2021 | Ushan Shanilka</p>
		</div>
	</div>
</div>

<div id="Cart">
	<h1 style="display:none;" id="saveCartNumber"></h1>
	<div class="container">

	</div>

	<div id="placeOrderModel" class="modal-bg">
		<div class="modal placeOrderModel">
			<small id="orderId"></small>
			<h2>Place Order</h2>
			<div class="row">
				<div class="col-3 customerInfo">
					<div class="container">
						<h3 class="topic">Customer Info</h3>
						<input id="txtCusName" class="cusInfoTxt" type="text" placeholder="Customer Name">
						<input id="txtCusPhoneNumber" class="cusInfoTxt" type="number" placeholder="PhoneNumber">
						<input id="txtCusStreet" class="cusInfoTxt" type="text" placeholder="Street Address">
						<input id="txtCusCountry" class="cusInfoTxt" type="text" placeholder="Country">
						<input id="txtCusZipCode" class="cusInfoTxt" type="text" placeholder="Zip Code">
					</div>

				</div>
				<div class="col-2 billingInfo">
					<div class="container">
						<h3 class="topic">Billing Info</h3>
						<div class="container">
							<input id="txtCusCreditCardNumber" class="bilInfo" type="text" placeholder="Credit Card Number">
							<input id="txtCusCardHolder" class="bilInfo" type="text" placeholder="Card Holder Name">
							<div class="row">
								<input id="txtCusCarExpDate" class="bilInfoCard" type="text" placeholder="MM/YY">
								<input id="txtCusCardCvv" class="bilInfoCVV" type="number" placeholder="CVV">
							</div>
							<div class="placeOrderInfo">
								<div class="row">
									<div class="cart-info place">
										<img id="placeOrderImg" class="placeOrderImg" src="assets/images/buy-1.jpg">
										<div class="placeOrderDetails">
											<p id="ProductPlaceOrderName">name</p>
											<small id="ProductPlaceOrderPrice">$200.00</small> <br>
											<small id="ProductPlaceOrderQty">2</small>
										</div>
									</div>
									<div class="btnSection">
										<small class="total" id="ProductPlaceOrderTotal">$200.00</small>
										<button id="btnPlaceOrder" class="btn placeOrderBtn">Place Order</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<span id="placeOrderModel-close" class="model-close">X</span>
		</div>
	</div>

	<div class="small-container cart-page">

		<table class="table">
			<thead>
			<th>Product</th>
			<th>Cart Number</th>
			<th>Size</th>
			<th>Qty</th>
			<th>Tax</th>
			<th>Subtotal</th>
			</thead>
			<tbody id="tblCart">

			</tbody>
		</table>
	</div>

	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="footer-col-1">
					<h3>Download Our App</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
					<div class="app-logo">
						<img src="assets/images/play-store.png">
						<img src="assets/images/app-store.png">
					</div>
				</div>
				<div class="footer-col-2">
					<img src="assets/images/logo-white%20.png" width="300px" height="70px">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
				</div>
				<div class="footer-col-3">
					<h3>Useful Links</h3>
					<ul>
						<li>Coupons</li>
						<li>Blog Post</li>
						<li>Return Police</li>
						<li>Join Affiliate</li>
					</ul>
				</div>
				<div class="footer-col-4">
					<h3>Follow us</h3>
					<ul>
						<li>Facebook</li>
						<li>Twitter</li>
						<li>Instagram</li>
						<li>Youtube</li>
					</ul>
				</div>
			</div>
			<hr>
			<p class="copyright">Copyright 2021 | Ushan Shanilka</p>
		</div>
	</div>
</div>

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

	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="footer-col-1">
					<h3>Download Our App</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
					<div class="app-logo">
						<img src="assets/images/play-store.png">
						<img src="assets/images/app-store.png">
					</div>
				</div>
				<div class="footer-col-2">
					<img src="assets/images/logo-white%20.png" width="300px" height="70px">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
				</div>
				<div class="footer-col-3">
					<h3>Useful Links</h3>
					<ul>
						<li>Coupons</li>
						<li>Blog Post</li>
						<li>Return Police</li>
						<li>Join Affiliate</li>
					</ul>
				</div>
				<div class="footer-col-4">
					<h3>Follow us</h3>
					<ul>
						<li>Facebook</li>
						<li>Twitter</li>
						<li>Instagram</li>
						<li>Youtube</li>
					</ul>
				</div>
			</div>
			<hr>
			<p class="copyright">Copyright 2021 | Ushan Shanilka</p>
		</div>
	</div>
</div>

<div id="Profile">
	<div class="account-page">
		<div class="container">
			<div class="row">
				<div class="col-2">
					<img src="assets/images/image1.png" width="100%">
				</div>
				<div class="col-2">
					<div class="form-container">
						<div class="form-btn">
							<span onclick="login()">Login</span>
							<span onclick="register()">Register</span>
							<span onclick="admin()">Admin</span>
							<hr id="indicator">
						</div>

						<form id="loginForm">
							<input id="userName" type="text" value="" placeholder="User Name">
							<input id="password" type="password" value="" placeholder="Password">
							<button id="btnLogin" type="button" class="btn">Login</button>
							<a>Forget Password</a>
						</form>

						<form id="regForm">
							<input id="txtUserName" type="text" placeholder="User Name">
							<input id="txtUserEmail" type="email" placeholder="Email">
							<input id="txtUserPassword" type="password" placeholder="Password">
							<button id="btnRegister" type="button" class="btn">Register</button>
						</form>

						<form id="adminForm">
							<input id="adminEmail" type="email" value="" placeholder="Email">
							<input id="adminPassword" type="password" value="" placeholder="Password">
							<button id="btnAdminLogin" type="button" class="btn">Login</button>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="footer-col-1">
					<h3>Download Our App</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
					<div class="app-logo">
						<img src="assets/images/play-store.png">
						<img src="assets/images/app-store.png">
					</div>
				</div>
				<div class="footer-col-2">
					<img src="assets/images/logo-white%20.png" width="300px" height="70px">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
				</div>
				<div class="footer-col-3">
					<h3>Useful Links</h3>
					<ul>
						<li>Coupons</li>
						<li>Blog Post</li>
						<li>Return Police</li>
						<li>Join Affiliate</li>
					</ul>
				</div>
				<div class="footer-col-4">
					<h3>Follow us</h3>
					<ul>
						<li>Facebook</li>
						<li>Twitter</li>
						<li>Instagram</li>
						<li>Youtube</li>
					</ul>
				</div>
			</div>
			<hr>
			<p class="copyright">Copyright 2021 | Ushan Shanilka</p>
		</div>
	</div>
</div>

<div id="customerProfile">
	<div class="container">
		<div class="row">
			<div class="col-2">
				<h2 class="">Profile</h2>
				<nv>
					<ul>
						<li id="btnMyOrder">My Orders</li>
						<li id="btnToBeShipped">To Be Shipped</li>
						<li id="btnOnShipped">Shipped</li>
						<li id="btnMyAccount">Account</li>

					</ul>
				</nv>
			</div>
			<div class="col-2">
				<p class="welcomeNote" id="ownerInfo"></p>
				<a id="btnSingOut" class="btn singOut">SingOut</a>
			</div>
		</div>
	</div>

	<div id="myOrder" class="container">
		<div class="row">
			<h1>Complete Order</h1>
			<table class="table">
				<thead>
				<th>Order Info</th>
				<th>Order ID</th>
				<th>Shipping Date</th>
				<th>Tracking Number</th>
				<th>Submit Date</th>
				<th>Order Status</th>
				</thead>
				<tbody id="tblCompleteOrder">

				</tbody>
			</table>
		</div>
	</div>

	<div id="account" class="container">
		<h1 style="text-align: center">Account Setting</h1>
		<div class="row">
			<div class="col-2 ">
				<div class="container">
					<div class="form-container">
						<form >
							<h2>Change Password</h2>
							<input id="txtCusCurrentPw" type="text" placeholder="Current Password">
							<input id="txtCusNewPw" type="password" placeholder="New Password">
							<input id="txtCusConfirmPw" type="password" placeholder="Confirm  Password">
							<button id="btnCusChangePw" type="button" class="btn">Save</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-2">
				<img src="assets/images/image1.png">
			</div>
		</div>
	</div>

	<div id="toBeShipped" class="container">
		<div class="row">
			<h1>To Be Shipped</h1>
			<table class="table">
				<thead>
				<th>Order Info</th>
				<th>Order Id</th>
				<th>Order Date</th>
				<th>Order Status</th>
				<th>Option</th>
				</thead>
				<tbody id="tblToBeShipped">

				</tbody>
			</table>
		</div>
	</div>

	<div id="shipped" class="container">
		<div class="row">
			<h1>Shipped</h1>
			<table class="table">
				<thead>
				<th>Order Info</th>
				<th>Order ID</th>
				<th>Shipping Date</th>
				<th>Tracking Number</th>
				<th>Estimated Delivery Date</th>
				<th>Order Submit</th>
				</thead>
				<tbody id="tblShipped">

				</tbody>
			</table>
		</div>
	</div>
</div>

<div id="adminProfile">

	<div id="addTrackingModal" class="modal-bg">
		<div class="modal addTrackingModal">
			<div class="row">
				<div class="col-3">
					<div class="cart-info">
						<img id="addTrackingImg" class="addTrackingImg" src="assets/images/buy-3.jpg" width="100px">
					</div>
				</div>
				<div class="col-3">
					<div class="row">
						<div>
							<p id="trackOrderId" style="font-size: 21px;">O001</p>
							<p id="trackProductName">T-Shirt</p>
							<small id="trackUnitPrice" >$200.00</small> <br>
							<small id="trackQty">qty 4</small>
						</div>

						<div>
							<p id="cusName">Matara</p>
							<p id="cusStreet">Matara</p>
							<p id="cusZIpCode">Matara</p>
							<p id="cusCountry">Matara</p>
						</div>
					</div>

				</div>
				<div class="col-3">
					<div class="container addtrack">
						<label>	Estimated Delivery Date
							<input id="txtEDDDate" class="txtInput" type="date">
						</label>
						<input id="txtTrackingNumber" class="txtInput addtrackNumber" placeholder="Add Tracking Number" type="text">
						<br>
						<br>
						<br>
						<button id="btnSave" class="btn trackingSaveBtn">Save</button>

					</div>
				</div>
			</div>
			<span id="addTrackingModal-close" class="model-close">X</span>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-2 admin">
				<h2 class="">Admin Profile</h2>
				<nv>
					<ul>
						<li id="btnWaitingForShipment">Waiting for Shipment</li>
						<li id="btnOnShipping">OnShipping</li>
						<li id="btnCompleteShipped">Complete Shipped</li>
						<li id="btnAccountSetting">Account Setting</li>
					</ul>
				</nv>
			</div>
			<div class="col-2">
				<p id="adminWelcomeNote" class="welcomeNote"></p>
				<h1 id="adminTempEmail" style="display:none;"></h1>
				<h1 id="adminTempUserName" style="display:none;"></h1>
				<h1 id="adminTempPw" style="display:none;"></h1>
			</div>
		</div>
	</div>

	<div id="waitingForShipment" class="container">
		<div class="row">
			<h1>Waiting For Shipment</h1>
			<table class="table">
				<thead>
				<th>Order Info</th>
				<th>Order ID</th>
				<th>Shipping Address</th>
				<th>Order Date</th>
				<th>Add Tracking</th>
				</thead>
				<tbody id="tblWaitingForShipment">

				</tbody>
			</table>
		</div>
	</div>

	<div id="onShipping" class="container">
		<div class="row">
			<h1>On Shipping</h1>
			<table class="table">
				<thead>
				<th>Order Info</th>
				<th>Order ID</th>
				<th>Order Address</th>
				<th>Order Date</th>
				<th>Shipping Date</th>
				<th>Tracking Number</th>
				<th>Estimated Delivery Date</th>
				<th>Order Status</th>
				</thead>
				<tbody id="tblOnShipping">

				</tbody>
			</table>
		</div>
	</div>

	<div id="completeShipped" class="container">
		<div class="row">
			<h1>Complete Shipped</h1>
			<table class="table">
				<thead>
				<th>Order Info</th>
				<th>Order ID</th>
				<th>Order Address</th>
				<th>Order Date</th>
				<th>Shipping Date</th>
				<th>Tracking Number</th>
				<th>Estimated Delivery Date</th>
				<th>Order Status</th>
				</thead>
				<tbody id="tblCompleteShipped">

				</tbody>
			</table>
		</div>
	</div>

	<div id="accountSetting" class="container accountSetting">
		<h1 style="text-align: center">Account Setting</h1>
		<div class="row">
			<div class="col-2 ">
				<div class="container">
					<div class="form-container">
						<form >
							<h2>Change Password</h2>
							<input id="txtCurrentPw" type="text" placeholder="Current Password">
							<input id="txtNewPw" type="password" placeholder="New Password">
							<input id="txtConfirmPw" type="password" placeholder="Confirm  Password">
							<button id="btnUpdateAdmin" type="button" class="btn">Save</button>
						</form>
					</div>
				</div>
			</div>
			<div class="col-2">
				<img src="assets/images/image1.png">
			</div>
		</div>

	</div>

</div>

<div id="ProductDetails">
	<p id="cartNumber"></p>
	<div class="small-container single-product">
		<div class="row">
			<div class="col-2">
				<img src="assets/images/gallery-1.jpg" width="100%" id="ProductImg">

				<div class="small-img-row">
					<div class="small-img-col">
						<img src="assets/images/gallery-1.jpg" class="small-img">
					</div>
					<div class="small-img-col">
						<img src="assets/images/gallery-2.jpg" class="small-img">
					</div>
					<div class="small-img-col">
						<img src="assets/images/gallery-3.jpg" class="small-img">
					</div>
				</div>

			</div>
			<div class="col-2">
				<p>Home / T-Shirt</p>
				<h1 id="ProductDetailsName">Marvel T-Shirt</h1>
				<h4 id="ProductDetailsPrice">$50.00</h4>
				<select id="selectSize">
					<option>Select Size</option>
					<option>XXL</option>
					<option>XL</option>
					<option>Large</option>
					<option>Medium</option>
					<option>Small</option>
				</select>
				<input id="cartQty" type="number" value="1">
				<a id="btnAddCart" class="btn">Add to Cart</a>
				<h3>Product Details <i class="fas fa-indent"></i></h3>
				<br>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequatur consequuntur distinctio dolorem eius eligendi error, est impedit </p>
			</div>
		</div>
	</div>

	<div id="model" class="modal-bg">
		<div class="modal">
			<h2>Please Login</h2>
			<input class="txtInput" id="tempUserName" type="text" placeholder="User Name">
			<input class="txtInput" id="tempPassword" type="password" placeholder="Password">
			<button id="btnSingIn" class="btn">SingIn</button>
			<span id="model-close" class="model-close">X</span>
		</div>
	</div>

	<div class="small-container">
		<div class="row row-2">
			<h2>Related Product</h2>
			<p>View More</p>
		</div>
	</div>


	<div class="small-container">
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
	</div>

	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="footer-col-1">
					<h3>Download Our App</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
					<div class="app-logo">
						<img src="assets/images/play-store.png">
						<img src="assets/images/app-store.png">
					</div>
				</div>
				<div class="footer-col-2">
					<img src="assets/images/logo-white%20.png" width="300px" height="70px">
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
				</div>
				<div class="footer-col-3">
					<h3>Useful Links</h3>
					<ul>
						<li>Coupons</li>
						<li>Blog Post</li>
						<li>Return Police</li>
						<li>Join Affiliate</li>
					</ul>
				</div>
				<div class="footer-col-4">
					<h3>Follow us</h3>
					<ul>
						<li>Facebook</li>
						<li>Twitter</li>
						<li>Instagram</li>
						<li>Youtube</li>
					</ul>
				</div>
			</div>
			<hr>
			<p class="copyright">Copyright 2021 | Ushan Shanilka</p>
		</div>
	</div>
</div>


<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/navBar.js"></script>
<script src="js/customerProfile.js"></script>
<script src="js/productDetails.js"></script>
<script src="js/adminProfile.js"></script>
<script src="js/cart.js"></script>
</body>
</html>