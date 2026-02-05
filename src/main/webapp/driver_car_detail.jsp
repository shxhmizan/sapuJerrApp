<%@page import="sapujerrapp.App,java.util.List,model.*" %>
<%@ include file="component_redirect_if_no_login.jsp" %>
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
	<%@include file="component_sidebar_driver.jsp" %>
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
	
	
	<div class="main-content">
	<div>
		<a href="<%=App.Pages.DriverCarDetailForm.link%>">Register New Car</a>
	</div>
	<%
		List cars = (List) request.getAttribute("cars");
		if(cars != null) {
			for(Object obj : cars){ 
				if(obj instanceof CarEntity){
				CarEntity car = (CarEntity) obj;
	%>
		<div class="cardetail">
			<div class="image-section">
				<div class="section-header">
					<h3 class="section-title">
						<i class="fa-solid fa-camera"></i> Car Photos
					</h3>
				</div>
				<div class="box-label">Overview (Full Car)</div>
				<img src="<%=car.getImageLeft() %>">
				<div class="box-label">Side View</div>
				<img src="<%=car.getImageRight() %>">
				<div class="box-label">Rear View</div>
				<img src="<%=car.getImageBack() %>">
				<div class="box-label">Front View</div>
				<img src="<%=car.getImageFront() %>">
				</div>
			</div>
	
			<div class="form-section">
				<div class="form-card">
					<div class="section-header">
						<h3 class="section-title">
							<i class="fa-solid fa-circle-info"></i> Vehicle Info
						</h3>
					</div>
					<label class="form-label">Plate Number</label>
					<div><%=car.getPlateNumber() %></div>
					
					<label class="form-label">Model</label> 
					<div><%=car.getModel() %></div>
	
					<label class="form-label">Type</label> 
					<div><%=car.getVehicleType() %></div>
						
					<label class="form-label">Capacity (No. of passengers)</label> 
					<div><%=car.getCapacity() %></div>
						
					<label class="form-label">Road Tax</label>
					<div><a href="<%=car.getRoadtaxDoc() %>">View</a></div>
	
					<label class="form-label">Insurance</label>
					<div><a href="<%=car.getInsuranceDoc() %>">View</a></div>
	
					<label class="form-label">Grant</label>
					<div><a href="<%=car.getGrantDoc() %>">View</a></div>
				</div>
			</div>
		</div>
	<%			}
			}
		}
	%>
	</div>
	
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