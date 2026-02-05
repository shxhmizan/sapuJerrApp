<%@page import="model.*,sapujerrapp.App,java.util.List,sapujerrapp.BookingListBean" %>
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

    <div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="user-profile-row">
                <div class="profile-avatar-large"><i class="fa-solid fa-user"></i></div>
            </div>
        </div>
        <nav class="sidebar-menu">
            <a href="dashboard.html" class="menu-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
            <a href="mybookings.html" class="menu-item active"><i class="fa-solid fa-car-side"></i> Advance Bookings</a>
            <a href="history.html" class="menu-item"><i class="fa-solid fa-clock-rotate-left"></i> My Bookings</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-wallet"></i> History</a>
        </nav>
    </aside>

    <header class="header">
        <div class="header-left"><button class="btn-profile-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i> Mamat</button></div>
        <div class="header-right"><div class="logo">SapuJerr</div></div>
    </header>

    <div class="main-container">
        <h1 class="page-title">My Bookings</h1>
		<% 	
			List bookings = (List) request.getAttribute("bookings");
			for(Object obj : bookings) if(obj instanceof BookingEntity) { 
				BookingEntity booking = (BookingEntity) obj;
				String bookingDate = App.dateDisplayFormatter.format(booking.getBookingDate());
		%>
        <div class="booking-list">
            <div class="booking-card">
                <div class="card-header">
                    <div><span class="booking-date"><%=bookingDate%></span><span class="booking-id">#ID8823</span></div>
                    <span class="status-badge status-scheduled">Scheduled</span>
                </div>
                <div class="card-body">
                    <div class="route-visual">
                        <div class="route-row"><div class="route-icon"><div class="dot"></div><div class="line"></div></div><div class="route-text"><h4><%=booking.getPickupLocation() %></h4><p>Pickup</p></div></div>
                        <div class="route-row"><div class="route-icon"><i class="fa-solid fa-location-dot pin"></i></div><div class="route-text"><h4><%=booking.getDropoffLocation() %></h4><p>Dropoff</p></div></div>
                    </div>
                    <div class="driver-info">
                        <div class="driver-car">Perodua Aruz</div><div class="driver-plate">PKA 1234</div><div class="price-tag">RM 25.00</div>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="btn-sm btn-cancel" onclick="openCancelModal()">Cancel</button>
                    <button class="btn-sm btn-track" onclick="openDriverModal()">
                        <i class="fa-solid fa-id-card"></i> Get Driver Details
                    </button>
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
                <button class="btn-modal btn-modal-confirm" onclick="confirmCancel()">Yes, Cancel</button>
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

        function openCancelModal() { document.getElementById('cancelModal').classList.add('show'); }
        function closeCancelModal() { document.getElementById('cancelModal').classList.remove('show'); }
        function confirmCancel() { alert("Booking Cancelled"); closeCancelModal(); }

        function openDriverModal() { document.getElementById('driverModal').classList.add('show'); }
        function closeDriverModal() { document.getElementById('driverModal').classList.remove('show'); }
    </script>
</body>
</html>