<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %></h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>

<form action="hello-servlet" method="post">
	<div class="form-group">
		<label for="user">User Name</label>
		<input type="text" name="name" class="form-control" id="user"
			   placeholder="Enter name here">
	</div>
	<div class="form-group">
		<label for="password">Email address</label>
		<input type="password" name="password" class="form-control" id="password"
			   placeholder="Enter email here">
	</div>
	<div class="container text-center">
		<button type="submit" class="btn btn-outline-success">Submit</button>
	</div>
</form>

</body>
</html>