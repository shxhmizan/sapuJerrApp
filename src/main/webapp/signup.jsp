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
                            <input type="text" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-input">
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">User Type</label>
                            <div>
	                          	<input type="radio" name="type" value="D">
	                          	<label class="form-label">Driver</label>
	                            <input type="radio" name="type" value="S">
	                            <label class="form-label">Student</label>
                            </div>
                        </div>
                        <div class="form-group full-width">
                            <button type="submit" class="submit-btn">submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="logo">SapuJerr</div>
    </div>

</body>
</html>