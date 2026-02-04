<%@page import="sapujerrapp.App" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SapuJerr - Vehicle Management</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="css/base.css">
<link rel="stylesheet" href="css/cardetail.css">
</head>
<body>

	<div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
	<aside class="sidebar" id="sidebar">
		<div class="sidebar-header">
			<div class="user-profile-row">
				<div class="profile-avatar-large">
					<i class="fa-solid fa-user"></i>
				</div>
				<div class="profile-info">
					<h2 style="color: white;">Mamat</h2>
					<div class="plan-badge">
						<i class="fa-solid fa-crown"></i> &nbsp;Dewa
					</div>
				</div>
			</div>
		</div>
		<nav class="sidebar-menu">
			<a href="dashboard.html" class="menu-item"><i
				class="fa-solid fa-gauge-high"></i> Dashboard</a> <a href="profile.html"
				class="menu-item"><i class="fa-solid fa-user"></i> Profile</a> <a
				href="#" class="menu-item"><i class="fa-solid fa-car"></i> My
				Car</a> <a href="#" class="menu-item"><i class="fa-solid fa-wallet"></i>
				Wallet</a>
		</nav>
	</aside>

	<header class="header">
		<div class="header-left">
			<button class="btn-profile-toggle" onclick="toggleSidebar()">
				<i class="fa-solid fa-bars"></i> Mamat
			</button>
		</div>
		<div class="header-right">
			<div class="logo">SapuJerr</div>
		</div>
	</header>
	<form class="form-grid" enctype="multipart/form-data" action="CarServlet" method="post">
	<div class="main-content">
		<div class="image-section">
			<div class="section-header">
				<h3 class="section-title">
					<i class="fa-solid fa-camera"></i> Car Photos
				</h3>
				<%
				String errMsg = (String) App.getFlashMessage(session);
						if(errMsg != null){
				%>
				<p><%=errMsg%></p>
				<% 
					}
				%>
			</div>

			<input type="file" id="pic-main" class="hidden-file-input"
				accept="image/*" onchange="previewImage(this, 'label-main')" name="image_left">
			<label for="pic-main" id="label-main" class="upload-box large-box">
				<div class="btn-view-example"
					onclick="openExample(event, 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?q=80&w=1000&auto=format&fit=crop', 'Full View Example')">
					<i class="fa-regular fa-eye"></i> Example
				</div>
				<div class="upload-content">
					<i class="fa-solid fa-cloud-arrow-up upload-icon"></i>
					<div>Overview (Full Car)</div>
					<div style="font-size: 0.8rem; font-weight: 400; margin-top: 5px;">Click
						to Upload</div>
				</div>
			</label>

			<div class="small-boxes-container">
				<div class="small-box-wrapper">
					<input type="file" id="pic-right" class="hidden-file-input"
						accept="image/*" onchange="previewImage(this, 'label-right')" name="image_right">
					<label for="pic-right" id="label-right"
						class="upload-box small-box">
						<div class="btn-view-example"
							onclick="openExample(event, 'https://images.unsplash.com/photo-1489824904134-891ab64532f1?q=80&w=1000&auto=format&fit=crop', 'Side View Example')">
							<i class="fa-regular fa-eye"></i>
						</div>
						<div class="upload-content">
							<i class="fa-solid fa-plus"></i>
						</div>
					</label>
					<div class="box-label">Side View</div>
				</div>

				<div class="small-box-wrapper">
					<input type="file" id="pic-back" class="hidden-file-input"
						accept="image/*" onchange="previewImage(this, 'label-back')" name="image_back">
					<label for="pic-back" id="label-back" class="upload-box small-box">
						<div class="btn-view-example"
							onclick="openExample(event, 'https://images.unsplash.com/photo-1628198902509-c45f49d2112d?q=80&w=1000&auto=format&fit=crop', 'Rear View Example')">
							<i class="fa-regular fa-eye"></i>
						</div>
						<div class="upload-content">
							<i class="fa-solid fa-plus"></i>
						</div>
					</label>
					<div class="box-label">Rear View</div>
				</div>

				<div class="small-box-wrapper">
					<input type="file" id="pic-front" class="hidden-file-input"
						accept="image/*" onchange="previewImage(this, 'label-front')" name="image_front">
					<label for="pic-front" id="label-front"
						class="upload-box small-box">
						<div class="btn-view-example"
							onclick="openExample(event, 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?q=80&w=1000&auto=format&fit=crop', 'Front View Example')">
							<i class="fa-regular fa-eye"></i>
						</div>
						<div class="upload-content">
							<i class="fa-solid fa-plus"></i>
						</div>
					</label>
					<div class="box-label">Front View</div>
				</div>
			</div>
		</div>

		<div class="form-section">
			<div class="form-card">
				<div class="section-header">
					<h3 class="section-title">
						<i class="fa-solid fa-circle-info"></i> Vehicle Info
					</h3>
				</div>
				<label class="form-label">Plate Number *</label> 
				<input type="text" class="form-input" placeholder="e.g. ABC 1234" name="plate_number"> 
				
				<label class="form-label">Model *</label> 
				<input type="text" class="form-input" placeholder="e.g. Perodua Myvi" name="model"> 
				
				<label class="form-label">Car Year</label> 
				<select class="form-select" name="model">
					<option>2025</option>
					<option>2024</option>
					<option>2023</option>
					<option>Older...</option>
				</select> 
				
				<label class="form-label">Color</label> 
				<select	class="form-select" id="colorSelect" onchange="toggleOtherColor()">
					<option value="White">White</option>
					<option value="Black">Black</option>
					<option value="Silver">Silver</option>
					<option value="Blue">Blue</option>
					<option value="Red">Red</option>
					<option value="Other">Other (Please Specify)</option>
				</select>
				<div id="otherColorContainer">
					<input type="text" class="form-input input-animate-in" placeholder="Type your car color here...">
				</div>

				<label class="form-label">Type *</label> 
				<input type="text" class="form-input" placeholder="e.g. 4 Seater" name="type">
					
				<label class="form-label">Capacity (No. off passengers) *</label> 
				<input type="number" class="form-input" placeholder="e.g. 4" name="capacity" min="0" step="1">  
					
				<label class="form-label">Road Tax *</label>
				<input type="file" class="form-input" name="road_tax"	accept="application/pdf">

				<label class="form-label">Insurance *</label>
				<input type="file" class="form-input" name="insurance"	accept="application/pdf">

				<label class="form-label">Grant *</label>
				<input type="file" class="form-input" name="grant"	accept="application/pdf">
				
				<div class="action-buttons">
					<button class="btn-action btn-back" onclick="history.back()">Back</button>
					<button class="btn-action btn-submit">Submit Vehicle</button>
				</div>
			</div>
		</div>
	</div>
	</form>
	<div class="modal-overlay" id="exampleModal">
		<div class="modal-content">
			<h3 id="modalTitle" style="margin-bottom: 15px; color: #333;">Example</h3>
			<img id="modalImg" src="" class="modal-img">
			<button class="modal-close-btn" onclick="closeExample()">Got
				it</button>
		</div>
	</div>

	<script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        function previewImage(input, labelId) {
            const label = document.getElementById(labelId);
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    label.style.backgroundImage = `url(${e.target.result})`;
                    label.classList.add('has-image');
                    label.style.borderColor = "#007d40";
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 1. TOGGLE OTHER COLOR INPUT
        function toggleOtherColor() {
            const select = document.getElementById('colorSelect');
            const container = document.getElementById('otherColorContainer');
            
            if (select.value === "Other") {
                container.style.display = 'block';
            } else {
                container.style.display = 'none';
            }
        }

        // 2. EXAMPLE IMAGE MODAL LOGIC
        function openExample(event, imageUrl, title) {
            event.preventDefault(); // Stop file upload dialogue from opening
            event.stopPropagation(); // Stop bubbling
            
            document.getElementById('modalImg').src = imageUrl;
            document.getElementById('modalTitle').textContent = title;
            
            const modal = document.getElementById('exampleModal');
            modal.style.display = 'flex';
            setTimeout(() => { modal.classList.add('show'); }, 10);
        }

        function closeExample() {
            const modal = document.getElementById('exampleModal');
            modal.classList.remove('show');
            setTimeout(() => { modal.style.display = 'none'; }, 300);
        }
    </script>

</body>
</html>