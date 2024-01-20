<%
	if (session.getAttribute("jwt") == null){
		response.sendRedirect("login.jsp");
	}
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>UMart | Ecommerce</title>
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/common.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,100&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
	<script>
		if (!sessionStorage.getItem('jwt')) {
			sessionStorage.setItem('jwt', '<%= session.getAttribute("jwt") %>');
		}
	</script>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div id="Home">
			<div class="container">
				<img src="img/christmas-home.png" alt="home-image" style="width: -webkit-fill-available;">
				<c:set var="rating" value="${session.getAttribute('jwt')}" />
				<h4><c:out value="${session.getAttribute('jwt')}" /></h4>

			</div>
	</div>
	<jsp:include page="footer.jsp" />

</body>
</html>