<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr Driver - Order List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ============================
           1. THEME VARIABLES
           ============================ */
        :root {
            --brand-red: #D30015;
            --brand-beige: #EEECE1;
            --brand-white: #FFFFFF;
            --brand-green: #008f4c;
            --text-black: #000000;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, sans-serif;
        }

        body {
            background-color: var(--brand-beige);
            color: var(--text-black);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ============================
           2. HEADER & SIDEBAR
           ============================ */
        .header {
            background-color: var(--brand-red);
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 30px;
            color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 100;
        }

        .header-left { display: flex; align-items: center; gap: 20px; }
        .hamburger { font-size: 2rem; cursor: pointer; }
        .page-title { font-size: 1.8rem; font-weight: 800; }
        .logo { font-size: 2.2rem; font-weight: 800; font-style: italic; letter-spacing: -1px; }

        .sidebar {
            height: 100%;
            width: 280px;
            position: fixed;
            z-index: 200;
            top: 0;
            left: -300px;
            background-color: white;
            transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding-top: 20px;
            box-shadow: 2px 0 15px rgba(0,0,0,0.2);
            display: flex;
            flex-direction: column;
        }
        .sidebar.active { left: 0; }
        .sidebar-header {
            padding: 0 25px 30px;
            color: var(--brand-red);
            font-size: 2rem;
            font-weight: 800;
            font-style: italic;
            border-bottom: 1px solid #eee;
            margin-bottom: 10px;
        }
        .sidebar a {
            padding: 15px 25px;
            text-decoration: none;
            font-size: 1.1rem;
            color: #333;
            display: flex;
            align-items: center;
            gap: 15px;
            transition: 0.2s;
            font-weight: 600;
            border-left: 5px solid transparent;
        }
        .sidebar a:hover, .sidebar a.active {
            background-color: #fff5f5;
            color: var(--brand-red);
            border-left: 5px solid var(--brand-red);
        }

        .backdrop {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 150;
        }
        .backdrop.active { display: block; }

        /* ============================
           3. MAIN CONTENT
           ============================ */
        .main-container {
            margin-top: 80px;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        /* Order Card - Increased Size */
        .order-card {
            background: white;
            border: 3px solid black; /* Thicker border for better visibility */
            border-radius: 20px;
            padding: 40px; /* Increased padding */
            width: 100%;
            max-width: 700px; /* Increased width from 450px to 700px */
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            position: relative;
        }

        .card-top-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .passenger-name { font-size: 1.8rem; font-weight: 900; } /* Bigger text */
        .passenger-phone { font-size: 1.4rem; font-weight: 700; }
        .field-label { font-size: 1.2rem; color: #333; margin-bottom: 8px; font-weight: 600; }

        .info-box {
            border: 2px solid black;
            border-radius: 12px;
            padding: 18px 20px; /* Larger box */
            display: flex;
            align-items: center;
            background: white;
            margin-bottom: 25px;
            font-size: 1.3rem; /* Larger text inside box */
            font-weight: 600;
        }
        .info-box i { margin-right: 20px; font-size: 1.4rem; color: #2E4053; }
        .info-box.time-box { justify-content: space-between; }

        .btn-details {
            width: 100%; padding: 20px;
            background-color: var(--brand-red);
            color: white; border: 2px solid var(--brand-red);
            border-radius: 12px; font-size: 1.4rem; font-weight: 800;
            text-transform: uppercase; cursor: pointer; margin-top: 15px;
            transition: 0.2s;
        }
        .btn-details:hover {
            background-color: #b00012; border-color: #b00012;
            transform: translateY(-2px); box-shadow: 0 5px 15px rgba(211, 0, 21, 0.3);
        }

        /* ============================
           4. LARGE POPUP MODAL
           ============================ */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.7); z-index: 1000;
            display: none; justify-content: center; align-items: center;
            backdrop-filter: blur(8px);
        }
        .modal-overlay.show { display: flex; }

        .modal-card {
            background: white;
            width: 90%;
            max-width: 600px; 
            border-radius: 30px; 
            padding: 50px; 
            text-align: center;
            position: relative;
            box-shadow: 0 30px 60px rgba(0,0,0,0.4);
            animation: popIn 0.3s cubic-bezier(0.18, 0.89, 0.32, 1.28);
        }

        @keyframes popIn {
            from { opacity: 0; transform: scale(0.8); }
            to { opacity: 1; transform: scale(1); }
        }

        .student-avatar {
            width: 120px; height: 120px; 
            background: #f5f5f5;
            border-radius: 50%;
            margin: 0 auto 25px;
            display: flex; align-items: center; justify-content: center;
            font-size: 3.5rem; color: #bbb;
            border: 4px solid var(--brand-red);
        }

        .modal-title { font-size: 2.2rem; font-weight: 900; margin-bottom: 5px; color: black; }
        .modal-subtitle { color: #666; margin-bottom: 30px; font-size: 1.2rem; font-weight: 500; }

        .detail-row {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #eee;
            padding: 18px 0; 
            font-size: 1.3rem; 
        }
        .detail-row span:first-child { color: #555; }
        .detail-row span:last-child { font-weight: 700; color: black; }

        .btn-close {
            margin-top: 35px;
            background: black;
            color: white; border: none;
            padding: 18px 40px;
            border-radius: 40px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            width: 100%;
            transition: transform 0.2s;
        }
        .btn-close:hover { transform: scale(1.02); background: #333; }
    </style>
</head>
<body>

    <div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
    <div class="sidebar" id="sidebar">
        <div class="sidebar-header">SapuJerr</div>
        <a href="driver_dashboard.html"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
        <a href="driver_orders.html" class="active"><i class="fa-solid fa-list-check"></i> Order List</a>
        <a href="#"><i class="fa-solid fa-clock-rotate-left"></i> Trip History</a>
        <a href="#"><i class="fa-solid fa-user-gear"></i> Profile</a>
        <a href="index.html" style="margin-top: auto; margin-bottom: 30px; color: #666;"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>

    <div class="header">
        <div class="header-left">
            <button class="hamburger" style="background:none; border:none; color:white;" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>
            <div class="page-title">Order List</div>
        </div>
        <div class="logo">SapuJerr</div>
    </div>

    <div class="main-container">

        <div class="order-card">
            
            <div class="card-top-row">
                <div class="passenger-name">Lydia</div>
                <div class="passenger-phone">019 5516 759</div>
            </div>

            <div class="field-label">Depart</div>
            <div class="info-box">
                <i class="fa-solid fa-location-dot"></i>
                Kolej Beta, UiTM Tapah
            </div>

            <div class="field-label">To</div>
            <div class="info-box">
                <i class="fa-solid fa-location-dot" style="color:var(--brand-red);"></i>
                KFC Tapah
            </div>

            <div class="field-label">Date & Time</div>
            <div class="info-box time-box">
                <span>9.30PM</span>
                <span>5/12/2025</span>
            </div>

            <button class="btn-details" onclick="openModal()">See Details</button>
        </div>

    </div>

    <div class="modal-overlay" id="detailModal">
        <div class="modal-card">
            <div class="student-avatar">
                <i class="fa-solid fa-user"></i>
            </div>
            <h3 class="modal-title">Lydia binti Ahmad</h3>
            <p class="modal-subtitle">Student ID: 2023481922</p>

            <div class="detail-row">
                <span>Pickup Point</span>
                <span>Waiting at Gate A</span>
            </div>
            <div class="detail-row">
                <span>Payment</span>
                <span>Cash</span>
            </div>
            <div class="detail-row">
                <span>Total Fare</span>
                <span style="color:var(--brand-red); font-size:1.5rem;">RM 15.00</span>
            </div>

            <button class="btn-close" onclick="closeModal()">Close</button>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        function openModal() {
            document.getElementById('detailModal').classList.add('show');
        }

        function closeModal() {
            document.getElementById('detailModal').classList.remove('show');
        }
    </script>

</body>
</html>