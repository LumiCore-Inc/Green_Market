<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Login Form</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/style.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,100&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>

</head>
<body>
<div class="account-page">
	<div class="container">
		<div class="row">
			<div class="col-2" style="left: 170px;position: relative;">
				<img src="img/logo-nsbm.jpg" width="100%">
				<div style="
					font-size: 3rem;
					font-weight: 600;
					color: #04566E;
				">GREEN MARKET</div>
			</div>
			<div class="col-2">
				<div class="form-container">
					<div class="form-btn">
						<span onclick="login()">Login</span>
						<span onclick="register()">Register</span>
						<span onclick="admin()">Admin</span>
						<hr id="indicator">
					</div>

					<input type="hidden" id="status" value="<%= (request.getSession().getAttribute("status") != null) ? request.getSession().getAttribute("status") : "" %>">
					<input type="hidden" id="message" value="<%= (request.getSession().getAttribute("message") != null) ? request.getSession().getAttribute("message") : "Something went wrong!" %>">
					<form id="loginForm" method="post" action="user">
						<input id="userName" type="text" name="userName" value="" placeholder="User Name">
						<input id="password" type="password" name="password" value="" placeholder="Password">
						<button id="btnLogin" type="submit" name="action" value="login"  class="btn">Login</button>
						<a>Forget Password</a>
					</form>

					<form id="regForm" method="post" action="user">
						<input id="userName" name="userName" type="text" placeholder="User Name">
						<input id="firstName" name="firstName" type="text" placeholder="First Name">
						<input id="lastName" name="lastName" type="text" placeholder="Last Name">
						<input id="tp" name="tp" type="text" placeholder="Tp">
						<input id="address" name="address" type="text" placeholder="Address">
						<input id="password" name="password" type="password" placeholder="Password">
						<input id="email" name="email" type="email" placeholder="Email">
						<button id="btnRegister" type="submit" name="action" value="register" class="btn">Register</button>
					</form>

					<form id="adminForm" method="post" action="admin">
						<input id="adminUserName" type="text" name="userName" value="" placeholder="userName">
						<input id="adminPassword" type="password" name="password" value="" placeholder="Password">
						<button id="btnAdminLogin" type="submit" name="action" value="register" class="btn">Login</button>
					</form>

				</div>
			</div>
		</div>
	</div>
</div>
<script src="js/customerProfile.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<script type="text/javascript">
	var status = document.getElementById("status").value;
	var message = document.getElementById("message").value;
	if (status == "Error") {
		swal("Error", message, "error")
	} else if (status == "created") {
		swal("Success", message, "success")

	}
</script>
</body>
</html>
