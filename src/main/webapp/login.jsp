<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SapuJerr Login</title>
 <link rel="stylesheet" href="css/global.css">

</head>
<body>

	<div class="login-container">
		<div class="left-panel">
			<div class="logo-text">SapuJerr</div>
			<div class="logo-subtext">A web-based E-Hailing System</div>
		</div>

		<div class="right-panel">
			<h1 class="login-header">Log In</h1>

			<form id="loginForm" onsubmit="return validateForm()">
				<div class="form-group">
					<label for="username" class="form-label">username</label> <input
						type="text" id="username" name="username" class="form-input"
						placeholder="mamat@gmail.com" autocomplete="off">
				</div>

				<div class="form-group">
					<label for="password" class="form-label">password</label> <input
						type="password" id="password" name="password" class="form-input">
				</div>

				<button type="submit" class="submit-btn">submit</button>
			</form>

			<div class="signup-link">
				Don't have an account? <a>SignUp</a>
			</div>
		</div>
	</div>

	<script>
		function validateForm() {
			const usernameInput = document.getElementById('username');
			const passwordInput = document.getElementById('password');

			if (usernameInput.value.trim() === "") {
				alert("Please enter your username.");
				usernameInput.focus();
				return false;
			}
			if (passwordInput.value.trim() === "") {
				alert("Please enter your password.");
				passwordInput.focus();
				return false;
			}
			alert("Logging in...");
			return false;
		}
	</script>
</body>


</html>