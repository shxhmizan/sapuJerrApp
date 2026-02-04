<%@page import="sapujerrapp.App" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr Signup</title>
	<link rel="stylesheet" href="css/signup.css">
	<script defer src="signup.js"></script>
</head>
<body>

    <div class="signup-wrapper">
        <div class="card">
            <div class="card-header">
                <h1>SignUp</h1>
               	<%@include file="component_flash_message.jsp" %>
            </div>

            <div class="card-body">
                <form action="RegistrationServlet" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">User Name</label>
                            <input type="text" name="name" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-input" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-input" required>
                        </div>
                        <div class="form-group full-width">
                            <label class="form-label">Select User Type</label>
                            <div>
	                          	<input id="rad_type_driver" class="type-selector" type="radio" name="type" value="driver">
	                          	<label class="form-label">Driver</label>
	                            <input id="rad_type_student" class="type-selector" type="radio" name="type" value="student" checked>
	                            <label class="form-label">Student</label>
                            </div>
                        </div>
                        <div class="form-group driver-field">
                            <label class="form-label">License No.</label>
                            <input type="text" name="licence_number" class="form-input driver-field">
                        </div>
                        <div class="form-group student-field">
                            <label class="form-label">Matric Number</label>
                            <input type="text" name="matric_number" class="form-input student-field">
                        </div>
                        <div class="form-group student-field">
                            <label class="form-label">Faculty</label>
                            <input type="text" name="faculty" class="form-input student-field">
                        </div>
                        <div class="form-group full-width">
                            <button type="submit" name="submit" class="submit-btn">submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="logo">SapuJerr</div>
    </div>

</body>
</html>