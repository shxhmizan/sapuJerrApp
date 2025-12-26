<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="RegistrationServlet" method="post">
		<label for="name">Name</label>
		<input type="text" name="name" id="name" required><br>
		<label for="password">Password</label>
		<input type="password" name="password" id="password" required><br>
		<label for="email">Email</label>
		<input type="text" name="email" id="email"><br>
		<label for="phone">Phone Number</label>
		<input type="tel" name="phone" id="phone"><br>
		<input type="submit" value="Register">
	</form>
</body>
</html>