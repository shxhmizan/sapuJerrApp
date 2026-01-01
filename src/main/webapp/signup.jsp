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
                <form>
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
                            <label class="form-label">NRIC</label>
                            <input type="text" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label" style="visibility: hidden;">Toggle</label> <div class="toggle-container">
                                <button type="button" class="toggle-btn active">Driver</button>
                                <button type="button" class="toggle-btn">Student</button>
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