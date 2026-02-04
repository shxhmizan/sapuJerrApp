<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - History</title>
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
            <a href="dashboard.html" class="menu-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
            <a href="mybookings.html" class="menu-item"><i class="fa-solid fa-car-side"></i>Advance Bookings</a>
            <a href="history.html" class="menu-item active"><i class="fa-solid fa-clock-rotate-left"></i> My Bookings</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-wallet"></i> History</a>
        </nav>
    </aside>

    <header class="header">
        <div class="header-left"><button class="btn-profile-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i> Mamat</button></div>
        <div class="header-right"><div class="logo">SapuJerr</div></div>
    </header>

    <div class="main-container">
        <h1 class="page-title">History</h1>

        <div class="tabs-wrapper">
            <button class="tab-btn active" onclick="switchTab(this, 'completed')">Completed</button>
            <button class="tab-btn" onclick="switchTab(this, 'cancelled')">Canceled</button>
        </div>

        <div class="booking-list" id="historyList">
            
            <div class="booking-card item-completed">
                <div class="card-header">
                    <div><span class="booking-date">1 Dec 2025 • 2:00 PM</span><span class="booking-id">#ID7721</span></div>
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

            <div class="booking-card item-cancelled" style="display:none;">
                <div class="card-header">
                    <div><span class="booking-date">28 Nov 2025 • 10:00 AM</span><span class="booking-id">#ID6602</span></div>
                    <span class="status-badge status-cancelled" style="background:#ffebee; color:var(--brand-red);">Cancelled</span>
                </div>
                <div class="card-body">
                    <div class="route-visual">
                        <div class="route-row"><div class="route-icon"><div class="dot"></div><div class="line"></div></div><div class="route-text"><h4>Kolej Alpha</h4></div></div>
                        <div class="route-row"><div class="route-icon"><i class="fa-solid fa-location-dot pin"></i></div><div class="route-text"><h4>Tapah Town</h4></div></div>
                    </div>
                    <div class="driver-info">
                         <div style="color:var(--brand-red); font-weight:bold;">Cancelled by You</div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="modal-overlay" id="ratingModal">
        <div class="modal-card">
            <h3 class="modal-title">Rate Your Trip</h3>
            <p style="color:#666;">How was your ride?</p>
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

        function switchTab(btn, category) {
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            const completed = document.querySelectorAll('.item-completed');
            const cancelled = document.querySelectorAll('.item-cancelled');
            
            // Hide all first
            document.querySelectorAll('.booking-card').forEach(card => card.style.display = 'none');
            
            if (category === 'completed') {
                completed.forEach(card => card.style.display = 'block');
            } else if (category === 'cancelled') {
                cancelled.forEach(card => card.style.display = 'block');
            }
        }

        function openRatingModal() { document.getElementById('ratingModal').classList.add('show'); }
        function closeRatingModal() { document.getElementById('ratingModal').classList.remove('show'); resetStars(); }

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