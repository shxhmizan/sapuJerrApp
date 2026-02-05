<%@page import="model.*,sapujerrapp.App,java.util.List" %>
<%@ include file="component_redirect_if_no_login.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - My Bookings</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/bookings.css">
</head>
<body>
    <%@include file="component_sidebar_student.jsp" %>
	<%@include file="component_header_student.jsp" %>

    <div class="main-container">
        <h1 class="page-title">My Bookings</h1>
        	<div class="booking-list">
			<% 	
				List bookings = (List) request.getAttribute("bookings");
				for(Object obj : bookings) if(obj instanceof BookingEntity) { 
					BookingEntity booking = (BookingEntity) obj;
					String bookingDate = App.dateDisplayFormatter.format(booking.getBookingDate());
			%>
            <div class="booking-card">
                <div class="card-header">
                    <div><span class="booking-date"><%=bookingDate%></span><span class="booking-id">#<%=booking.getBookingId()%></span></div>
                    <span class="status-badge status-scheduled">Scheduled</span>
                </div>
                <div class="card-body">
                    <div class="route-visual">
                        <div class="route-row"><div class="route-icon"><div class="dot"></div><div class="line"></div></div><div class="route-text"><h4><%=booking.getPickupLocation() %></h4><p>Pickup</p></div></div>
                        <div class="route-row"><div class="route-icon"><i class="fa-solid fa-location-dot pin"></i></div><div class="route-text"><h4><%=booking.getDropoffLocation() %></h4><p>Dropoff</p></div></div>
                    </div>
                    <%--
                    <div class="driver-info">
                        <div class="driver-car">Perodua Aruz</div><div class="driver-plate">PKA 1234</div><div class="price-tag">RM 25.00</div>
                    </div>
                     --%>
                </div>
                <div class="card-footer">
                	<% if(booking.getStatus().equals(BookingEntity.BookingStatus.UPCOMING)){ %>
                    	<button class="btn-sm btn-cancel" onclick="openCancelModal(<%=booking.getBookingId()%>)">Cancel</button>
                    <% } %>
                    <% if(booking.getDriver() != null){ %>
                    <button class="btn-sm btn-track" onclick="openDriverModal()">
                        <i class="fa-solid fa-id-card"></i> Get Driver Details
                    </button>
                    <% } %>
                </div>
            </div>
		<% } %>
			<%-- 
            <div class="booking-card">
                <div class="card-header">
                    <div><span class="booking-date">Tomorrow, 6 Dec • 8:00 AM</span><span class="booking-id">#ID9901</span></div>
                    <span class="status-badge status-scheduled">Scheduled</span>
                </div>
                <div class="card-body">
                    <div class="route-visual">
                        <div class="route-row"><div class="route-icon"><div class="dot"></div><div class="line"></div></div><div class="route-text"><h4>UiTM Gate A</h4><p>Pickup</p></div></div>
                        <div class="route-row"><div class="route-icon"><i class="fa-solid fa-location-dot pin"></i></div><div class="route-text"><h4>Tapah Road KTM</h4><p>Dropoff</p></div></div>
                    </div>
                    <div class="driver-info">
                        <div class="driver-car">Proton Saga</div><div class="driver-plate">ABC 5555</div><div class="price-tag">RM 18.00</div>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="btn-sm btn-cancel" onclick="openCancelModal()">Cancel</button>
                    <button class="btn-sm btn-track" onclick="openDriverModal()">
                        <i class="fa-solid fa-id-card"></i> Get Driver Details
                    </button>
                </div>
            </div>
			--%>
        </div>
    </div>

    <div class="modal-overlay" id="cancelModal">
        <div class="modal-card">
            <div style="font-size:3rem; color:var(--brand-red); margin-bottom:15px;"><i class="fa-solid fa-circle-exclamation"></i></div>
            <h3 class="modal-title">Cancel Trip?</h3>
            <p style="color:#666;">Are you sure?</p>
            <div class="modal-actions">
                <button class="btn-modal btn-modal-back" onclick="closeCancelModal()">No</button>
                <button class="btn-modal btn-modal-confirm" id="btn-confirm-cancel-booking" onclick="confirmCancel()">Yes, Cancel</button>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="driverModal">
        <div class="modal-card driver-card-modal">
            <div class="driver-modal-header">
                <div class="driver-avatar-xl"><i class="fa-solid fa-user"></i></div>
                <h3 style="margin:0;">Ali Bin Abu</h3>
                <div class="rating-pill"><i class="fa-solid fa-star" style="color:#FFD700;"></i> 4.9</div>
            </div>
            <div class="driver-details-grid">
                <div class="detail-item"><span class="label">Car Model</span><span class="value">Perodua Aruz</span></div>
                <div class="detail-item"><span class="label">Plate No.</span><span class="value-plate">PKA 1234</span></div>
                <div class="detail-item"><span class="label">Color</span><span class="value">Silver</span></div>
                <div class="detail-item"><span class="label">Language</span><span class="value">Malay/Eng</span></div>
            </div>
            <div class="driver-contacts">
                <a href="tel:+60123456789" class="btn-contact btn-call">
                    <i class="fa-solid fa-phone"></i> Call Driver (+6012-345 6789)
                </a>
            </div>
            <button class="btn-close-text" onclick="closeDriverModal()">Close</button>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        function openCancelModal(id) { 
        	document.getElementById('cancelModal').classList.add('show'); 
        	document.getElementById("btn-confirm-cancel-booking").onclick = function(event){ 
        		const cancelID = id;
        		confirmCancel(cancelID);
        	};
        }
        function closeCancelModal() { document.getElementById('cancelModal').classList.remove('show'); }
        
        function confirmCancel(id) { 
        	console.log(id);
        	const url = "./BookingManagementServlet?operation=cancel&id=" + id;
        	fetch(url).then((response) => {
        		if(response.ok){
        			alert("Booking Cancelled");  
        			window.location.reload();
        		}
        		else alert("Failed to Cancel Booking");
        		closeCancelModal();
        	})
        }
        

        function openDriverModal() { document.getElementById('driverModal').classList.add('show'); }
        function closeDriverModal() { document.getElementById('driverModal').classList.remove('show'); }
    </script>
</body>
</html>