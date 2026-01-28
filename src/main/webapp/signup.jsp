<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr Signup</title>
	<link rel="stylesheet" href="css/signup.css">
</head>
<body>

    <div class="signup-wrapper">
        <div class="card">
            <div class="card-header">
                <h1>SignUp</h1>
            </div>

            <div class="card-body">
                <form action="RegistrationServlet" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" name="name" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" name="email" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-input">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Select User Type</label>
                            <div>
	                          	<input type="radio" name="type" value="driver">
	                          	<label class="form-label">Driver</label>
	                            <input type="radio" name="type" value="student">
	                            <label class="form-label">Student</label>
                            </div>
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