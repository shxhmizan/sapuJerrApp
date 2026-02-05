<%@ include file="component_redirect_if_no_login.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/driverprofile.css">
</head>
<body>
	<%@include file="component_sidebar_driver.jsp" %>
	
    <div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
    <%@include file="component_sidebar_driver.jsp" %>

    <div class="header-toggle-container">
        <button class="btn-profile-toggle" onclick="toggleSidebar()">
            <i class="fa-solid fa-bars"></i> Mamat
        </button>
    </div>

    <div class="main-container">
        <div class="profile-card">
            <div class="card-top">
                <div class="top-left-icon"><i class="fa-solid fa-id-card"></i></div>
                <h1 class="card-title">Profile</h1>
                <div class="avatar-container">
                    <div class="profile-avatar-img"></div>
                    <div class="avatar-add-btn" onclick="document.getElementById('avatarUpload').click()"><i class="fa-solid fa-camera"></i></div>
                    <input type="file" id="avatarUpload" style="display:none;">
                </div>
            </div>

            <div class="card-bottom">
                <div class="header-row">
                    <h2 class="greeting">Hi Mamat,</h2>
                    <button class="btn-edit-mode" id="editBtn" onclick="handleEditClick()">
                        <i class="fa-solid fa-pen-to-square"></i> Edit Profile
                    </button>
                </div>

                <form id="profileForm">
                    <div class="form-grid">
                        <div class="input-group">
                            <label>Name</label>
                            <input type="text" class="red-input" value="Mamat Bin Abu" readonly>
                        </div>
                        <div class="input-group">
                            <label>NRIC</label>
                            <input type="text" class="red-input" value="901010-10-1234" readonly>
                        </div>
                        <div class="input-group">
                            <label>Email</label>
                            <input type="email" class="red-input" value="mamat@sapujerr.com" readonly>
                        </div>
                        <div class="input-group">
                            <label>Driving License (Front & Back)*</label>
                            <input type="file" id="licenseUpload" style="display:none;" onchange="updateFileName(this)" disabled>
                            <label for="licenseUpload" class="file-attach-label" id="licenseLabel">
                                Attach File <i class="fa-solid fa-paperclip"></i>
                            </label>
                        </div>
                    </div>

                    <div class="actions-grid">
                        <button type="button" class="btn-pro" onclick="window.location.href='cardetail.html'">
                            <div class="btn-content">
                                <span class="btn-title">Car Detail</span>
                                <span class="btn-subtitle">Manage vehicle info</span>
                            </div>
                            <div class="btn-icon-circle"><i class="fa-solid fa-car"></i></div>
                        </button>

                        <button type="button" class="btn-pro">
                            <div class="btn-content">
                                <span class="btn-title">Subscription</span>
                                <span class="btn-subtitle">Current Plan: Dewa</span>
                            </div>
                            <div class="btn-icon-circle"><i class="fa-solid fa-crown"></i></div>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="corner-logo">SapuJerr</div>

    <div class="confirm-modal-wrapper" id="confirmModal">
        <div class="confirm-card">
            <div class="modal-icon"><i class="fa-solid fa-circle-question"></i></div>
            <h3 class="modal-title">Save Changes?</h3>
            <p class="modal-desc">Are you sure you want to update your profile information?</p>
            <div class="modal-btn-group">
                <button class="btn-modal btn-cancel" onclick="closeConfirmation()">Cancel</button>
                <button class="btn-modal btn-confirm" onclick="finalizeSave()">Yes, Update</button>
            </div>
        </div>
    </div>

    <script>
        // --- Sidebar Logic ---
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        function updateFileName(input) {
            const label = document.getElementById('licenseLabel');
            if (input.files && input.files.length > 0) {
                label.innerHTML = input.files[0].name + ' <i class="fa-solid fa-circle-check"></i>';
                label.style.borderColor = "#FFD700";
            }
        }

        // --- Edit Mode Logic ---
        function handleEditClick() {
            const btn = document.getElementById('editBtn');
            const isEditing = btn.classList.contains('active');

            if (!isEditing) {
                // Enter Edit Mode
                enableEditing();
            } else {
                // Trigger Confirmation (Do not save yet)
                showConfirmation();
            }
        }

        function enableEditing() {
            const inputs = document.querySelectorAll('.red-input');
            const btn = document.getElementById('editBtn');
            const fileInput = document.getElementById('licenseUpload');

            inputs.forEach(input => {
                input.readOnly = false;
                input.classList.add('editable');
            });
            fileInput.disabled = false; // Enable file upload

            btn.classList.add('active');
            btn.innerHTML = '<i class="fa-solid fa-check"></i> Save Changes';
            inputs[0].focus();
        }

        // --- Confirmation Modal Logic ---
        function showConfirmation() {
            document.getElementById('confirmModal').classList.add('show');
        }

        function closeConfirmation() {
            document.getElementById('confirmModal').classList.remove('show');
        }

        function finalizeSave() {
            // Close modal
            closeConfirmation();

            // Lock inputs (Revert state)
            const inputs = document.querySelectorAll('.red-input');
            const btn = document.getElementById('editBtn');
            const fileInput = document.getElementById('licenseUpload');

            inputs.forEach(input => {
                input.readOnly = true;
                input.classList.remove('editable');
            });
            fileInput.disabled = true;

            btn.classList.remove('active');
            btn.innerHTML = '<i class="fa-solid fa-pen-to-square"></i> Edit Profile';

            // Optional: Show simple success alert or toast
            setTimeout(() => {
                alert("Profile Updated Successfully!");
            }, 300);
        }
    </script>

</body>
</html>