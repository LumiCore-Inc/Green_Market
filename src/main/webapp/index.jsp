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

<jsp:include page="navbar.jsp" />



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

<jsp:include page="footer.jsp" />
</div>

<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/navBar.js"></script>
<script src="js/customerProfile.js"></script>
<script src="js/productDetails.js"></script>
<script src="js/adminProfile.js"></script>
<script src="js/cart.js"></script>
</body>
</html>