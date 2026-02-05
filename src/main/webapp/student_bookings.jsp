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
					DriverEntity driver = booking.getDriver();
			%>
            <div class="booking-card">
                <div class="card-header">
                    <div><span class="booking-date"><%=bookingDate%></span><span class="booking-id">#<%=booking.getBookingId()%></span></div>
                    <% if(booking.getStatus().equals(BookingEntity.BookingStatus.UPCOMING)){ %>
                    <span class="status-badge status-scheduled">Scheduled</span>
                    <% } else { %>
                    <span class="status-badge status-accepted">Accepted</span>
                    <% } %>
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
                    <button class="btn-sm btn-cancel" onclick="openCancelModal(<%=booking.getBookingId()%>)">Cancel</button>
                    <% if(driver != null){ %>
                    <button class="btn-sm btn-track" onclick="openDriverModal(<%=booking.getBookingId()%>)">
                        <i class="fa-solid fa-id-card"></i> Get Driver Details
                    </button>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
    </div>
	<% for(Object obj : bookings) if(obj instanceof BookingEntity) { 
		BookingEntity booking = (BookingEntity) obj;
		String bookingDate = App.dateDisplayFormatter.format(booking.getBookingDate());
		DriverEntity driver = booking.getDriver(); %>
    <div class="modal-overlay" id="cancelModal_<%=booking.getBookingId()%>">
        <div class="modal-card">
            <div style="font-size:3rem; color:var(--brand-red); margin-bottom:15px;"><i class="fa-solid fa-circle-exclamation"></i></div>
            <h3 class="modal-title">Cancel Trip?</h3>
            <p style="color:#666;">Are you sure?</p>
            <div class="modal-actions">
                <button class="btn-modal btn-modal-back" onclick="closeCancelModal(<%=booking.getBookingId()%>)">No</button>
                <button class="btn-modal btn-modal-confirm" id="btn-confirm-cancel-booking" onclick="confirmCancel(<%=booking.getBookingId()%>)">Yes, Cancel</button>
            </div>
        </div>
    </div>
	<% 		if (driver != null){ 
			UserEntity driverUser = driver.getUser();
	%>
    <div class="modal-overlay" id="driverModal_<%=booking.getBookingId()%>">
        <div class="modal-card driver-card-modal">
            <div class="driver-modal-header">
                <div class="driver-avatar-xl"><i class="fa-solid fa-user"></i></div>
                <h3 style="margin:0;" id="field-driver-name"><%= driverUser.getName() %></h3>
                <%-- <div class="rating-pill"><i class="fa-solid fa-star" style="color:#FFD700;"></i><%= driver.getRatingAverage() %></div>--%>
            </div>
            <%-- 
            <div class="driver-details-grid">
                <div class="detail-item"><span class="label">Car Model</span><span id="field-car-name" class="value">Perodua Aruz</span></div>
                <div class="detail-item"><span class="label">Plate No.</span><span id="field-car-plate" class="value-plate">PKA 1234</span></div>
                <div class="detail-item"><span class="label">Color</span><span class="value">Silver</span></div>
                <div class="detail-item"><span class="label">Language</span><span class="value">Malay/Eng</span></div>
            </div>
            --%>
            <div class="driver-contacts">
                <a href="tel:+6<%=driverUser.getPhone()%>>" class="btn-contact btn-call">
                    <i class="fa-solid fa-phone"></i> Call Driver (+6<%=driverUser.getPhone()%>)
                </a>
            </div>
            <button class="btn-close-text" onclick="closeDriverModal(<%=booking.getBookingId()%>)">Close</button>
        </div>
    </div>
    <%		} %>
    <% } %>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        function openCancelModal(id) { 
        	document.getElementById('cancelModal_' + id).classList.add('show'); 
        }
        function closeCancelModal(id) { document.getElementById('cancelModal_' + id).classList.remove('show'); }
        
        function confirmCancel(id) { 
        	console.log(id);
        	const url = "<%=App.Pages.BookingAPI.link %>?operation=cancel&id=" + id;
        	fetch(url).then((response) => {
        		if(response.ok){
        			alert("Booking Cancelled");  
        			window.location.reload();
        		}
        		else alert("Failed to Cancel Booking");
        		closeCancelModal();
        	})
        }
        

        function openDriverModal(id) { 
        	document.getElementById('driverModal_' + id).classList.add('show');
        }
        function closeDriverModal(id) { document.getElementById('driverModal_' + id).classList.remove('show'); }
    </script>
</body>
</html>