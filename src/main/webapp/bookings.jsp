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
                <div class="profile-info"><h2>Mamat</h2><div class="plan-badge">Dewa</div></div>
            </div>
        </div>
        <nav class="sidebar-menu">
            <a href="dashboard.jsp" class="menu-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
            <a href="#" class="menu-item" style="background:#f5f5f5; color:var(--brand-red);"><i class="fa-solid fa-clock-rotate-left"></i> Your Trips</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-wallet"></i> Wallet</a>
        </nav>
    </aside>

    <header class="header">
        <div class="header-left"><button class="btn-profile-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i> Mamat</button></div>
        <div class="header-right"><div class="logo">SapuJerr</div></div>
    </header>

    <div class="main-container">
        <h1 class="page-title">My Bookings</h1>

        <div class="tabs-wrapper">
            <button class="tab-btn active" onclick="switchTab(this, 'upcoming')">Upcoming</button>
            <button class="tab-btn" onclick="switchTab(this, 'completed')">Completed</button>
            <button class="tab-btn" onclick="switchTab(this, 'cancelled')">Canceled</button>
        </div>

        <div class="booking-list" id="bookingList">
            
            <div class="booking-card item-upcoming">
                <div class="card-header">
                    <div><span class="booking-date">Today, 5 Dec • 9:30 PM</span><span class="booking-id">#ID8823</span></div>
                    <span class="status-badge status-scheduled">Scheduled</span>
                </div>
                <div class="card-body">
                    <div class="route-visual">
                        <div class="route-row"><div class="route-icon"><div class="dot"></div><div class="line"></div></div><div class="route-text"><h4>Kolej Beta</h4><p>Pickup</p></div></div>
                        <div class="route-row"><div class="route-icon"><i class="fa-solid fa-location-dot pin"></i></div><div class="route-text"><h4>KFC Tapah</h4><p>Dropoff</p></div></div>
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

            <div class="booking-card item-completed" style="display:none;">
                <div class="card-header">
                    <div><span class="booking-date">1 Dec 2025</span><span class="booking-id">#ID7721</span></div>
                    <span class="status-badge status-completed">Completed</span>
                </div>
                <div class="card-body">
                    <div class="route-visual">
                        <div class="route-row"><div class="route-icon"><div class="dot"></div><div class="line"></div></div><div class="route-text"><h4>Tapah KTM</h4></div></div>
                        <div class="route-row"><div class="route-icon"><i class="fa-solid fa-location-dot pin"></i></div><div class="route-text"><h4>UiTM Tapah</h4></div></div>
                    </div>
                    <div class="driver-info">
                        <div class="driver-car">Honda City</div><div class="driver-plate">JJU 8888</div><div class="price-tag">RM 15.00</div>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="btn-sm btn-edit">Get Receipt</button>
                    <button class="btn-sm btn-rate" onclick="openRatingModal()">
                        <i class="fa-solid fa-star"></i> Rate Driver
                    </button>
                </div>
            </div>

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

    <div class="modal-overlay" id="ratingModal">
        <div class="modal-card">
            <h3 class="modal-title">Rate Your Trip</h3>
            <p style="color:#666;">How was your ride with <strong>Ali</strong>?</p>
            <div class="rating-stars" id="starContainer">
                <i class="fa-regular fa-star" onclick="rate(1)"></i>
                <i class="fa-regular fa-star" onclick="rate(2)"></i>
                <i class="fa-regular fa-star" onclick="rate(3)"></i>
                <i class="fa-regular fa-star" onclick="rate(4)"></i>
                <i class="fa-regular fa-star" onclick="rate(5)"></i>
            </div>
            <textarea class="rating-textarea" rows="3" placeholder="Leave a comment..."></textarea>
            <div class="modal-actions">
                <button class="btn-modal btn-modal-back" onclick="closeRatingModal()">Later</button>
                <button class="btn-modal btn-modal-confirm" onclick="submitRating()">Submit</button>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        // Tab Switching
        function switchTab(btn, category) {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            const upcoming = document.querySelectorAll('.item-upcoming');
            const completed = document.querySelectorAll('.item-completed');
            document.querySelectorAll('.booking-card').forEach(card => card.style.display = 'none');
            
            if (category === 'upcoming') upcoming.forEach(card => card.style.display = 'block');
            else if (category === 'completed') completed.forEach(card => card.style.display = 'block');
        }

        // Modals
        function openCancelModal() { document.getElementById('cancelModal').classList.add('show'); }
        function closeCancelModal() { document.getElementById('cancelModal').classList.remove('show'); }
        function confirmCancel() { alert("Booking Cancelled"); closeCancelModal(); }

        function openDriverModal() { document.getElementById('driverModal').classList.add('show'); }
        function closeDriverModal() { document.getElementById('driverModal').classList.remove('show'); }

        function openRatingModal() { document.getElementById('ratingModal').classList.add('show'); }
        function closeRatingModal() { document.getElementById('ratingModal').classList.remove('show'); resetStars(); }

        // Star Logic
        function rate(stars) {
            const starIcons = document.getElementById('starContainer').children;
            for (let i = 0; i < 5; i++) {
                if (i < stars) { starIcons[i].classList.remove('fa-regular'); starIcons[i].classList.add('fa-solid', 'active'); }
                else { starIcons[i].classList.remove('fa-solid', 'active'); starIcons[i].classList.add('fa-regular'); }
            }
        }
        function resetStars() {
            const starIcons = document.getElementById('starContainer').children;
            for (let i = 0; i < 5; i++) { starIcons[i].classList.remove('fa-solid', 'active'); starIcons[i].classList.add('fa-regular'); }
        }
        function submitRating() { alert("Thank you! Rating submitted."); closeRatingModal(); }
    </script>

</body>
</html>