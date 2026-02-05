<%@ include file="component_redirect_if_no_login.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr Driver - Notifications</title>
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

        /* TABS */
        .tabs-container {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            width: 100%;
            max-width: 700px;
        }

        .tab-btn {
            flex: 1;
            padding: 15px;
            background: white;
            border: 2px solid black;
            border-radius: 10px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            transition: 0.2s;
        }

        .tab-btn.active {
            background: var(--brand-red);
            color: white;
            border-color: var(--brand-red);
            box-shadow: 0 5px 15px rgba(211, 0, 21, 0.3);
        }

        /* NOTIFICATION CARD */
        .notif-card {
            background: white;
            border: 3px solid black;
            border-radius: 20px;
            padding: 30px;
            width: 100%;
            max-width: 700px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            position: relative;
            transition: transform 0.3s, opacity 0.3s;
        }

        .notif-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px dashed #ddd;
        }

        .notif-title { font-size: 1.4rem; font-weight: 800; display: flex; align-items: center; gap: 10px; }
        .notif-time { font-size: 1rem; color: #666; font-weight: 600; }

        .route-info {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            font-size: 1.2rem;
            font-weight: 600;
        }
        .arrow-icon { color: #888; }

        .price-badge {
            background: #eee;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 800;
            font-size: 1.1rem;
        }

        /* Action Buttons */
        .action-row {
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }

        .btn-action {
            flex: 1;
            padding: 15px;
            border-radius: 12px;
            font-size: 1.2rem;
            font-weight: 800;
            cursor: pointer;
            border: 2px solid black;
            transition: 0.2s;
        }

        .btn-accept { background: var(--brand-green); color: white; border-color: var(--brand-green); }
        .btn-accept:hover { background: #006633; }

        .btn-decline { background: white; color: var(--brand-red); border-color: var(--brand-red); }
        .btn-decline:hover { background: #ffebee; }

        .btn-dismiss { background: #333; color: white; border-color: #333; width: 100%; }
        .btn-dismiss:hover { background: black; }

        /* Animation class for removing cards */
        .fade-out {
            transform: translateX(100%);
            opacity: 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 50px;
            color: #888;
            display: none;
        }
        .empty-state i { font-size: 4rem; margin-bottom: 20px; opacity: 0.3; }

        /* Badge Styles */
        .badge-new { background: var(--brand-red); color: white; padding: 2px 8px; border-radius: 5px; font-size: 0.8rem; margin-left: 10px; vertical-align: middle; }
    </style>
</head>
<body>
	<%@include file="component_sidebar_driver.jsp" %>

    <div class="header">
        <div class="header-left">
            <button class="hamburger" style="background:none; border:none; color:white;" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>
            <div class="page-title">Notifications</div>
        </div>
        <div class="logo">SapuJerr</div>
    </div>

    <div class="main-container">

        <div class="tabs-container">
            <button class="tab-btn active" onclick="switchTab('new')">New Requests</button>
            <button class="tab-btn" onclick="switchTab('canceled')">Canceled</button>
        </div>

        <div id="list-new" style="width: 100%; display: flex; flex-direction: column; align-items: center;">
            
            <div class="notif-card" id="req-1">
                <div class="notif-header">
                    <div class="notif-title">
                        <i class="fa-solid fa-user-clock" style="color:var(--brand-red);"></i> 
                        New Request 
                        <span class="badge-new">NEW</span>
                    </div>
                    <div class="notif-time">2 mins ago</div>
                </div>
                <div class="route-info">
                    <strong>Kolej Alpha</strong> 
                    <i class="fa-solid fa-arrow-right arrow-icon"></i> 
                    <strong>Tapah KTM</strong>
                </div>
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                    <div style="font-size:1.1rem; color:#555;">Passenger: <strong>Ali</strong></div>
                    <div class="price-badge">RM 12.00</div>
                </div>
                <div class="action-row">
                    <button class="btn-action btn-decline" onclick="removeCard('req-1')">Decline</button>
                    <button class="btn-action btn-accept" onclick="acceptCard('req-1')">Accept</button>
                </div>
            </div>

            <div class="notif-card" id="req-2">
                <div class="notif-header">
                    <div class="notif-title">
                        <i class="fa-solid fa-user-clock" style="color:var(--brand-red);"></i> 
                        New Request 
                    </div>
                    <div class="notif-time">15 mins ago</div>
                </div>
                <div class="route-info">
                    <strong>UiTM Gate C</strong> 
                    <i class="fa-solid fa-arrow-right arrow-icon"></i> 
                    <strong>Speedmart 99</strong>
                </div>
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
                    <div style="font-size:1.1rem; color:#555;">Passenger: <strong>Sarah</strong></div>
                    <div class="price-badge">RM 8.00</div>
                </div>
                <div class="action-row">
                    <button class="btn-action btn-decline" onclick="removeCard('req-2')">Decline</button>
                    <button class="btn-action btn-accept" onclick="acceptCard('req-2')">Accept</button>
                </div>
            </div>

            <div class="empty-state" id="empty-new">
                <i class="fa-solid fa-inbox"></i>
                <h3>No new requests</h3>
            </div>
        </div>


        <div id="list-canceled" style="width: 100%; display: none; flex-direction: column; align-items: center;">
            
            <div class="notif-card" id="cancel-1" style="border-color:#666;">
                <div class="notif-header" style="border-bottom-color:#ccc;">
                    <div class="notif-title" style="color:#666;">
                        <i class="fa-solid fa-ban"></i> 
                        Trip Canceled
                    </div>
                    <div class="notif-time">1 hour ago</div>
                </div>
                <p style="font-size:1.2rem; color:#333; margin-bottom:15px;">
                    Passenger <strong>Amir</strong> canceled the trip to <strong>KFC Tapah</strong>.
                </p>
                <div class="action-row">
                    <button class="btn-action btn-dismiss" onclick="removeCard('cancel-1')">Dismiss</button>
                </div>
            </div>

             <div class="notif-card" id="cancel-2" style="border-color:#666;">
                <div class="notif-header" style="border-bottom-color:#ccc;">
                    <div class="notif-title" style="color:#666;">
                        <i class="fa-solid fa-ban"></i> 
                        Trip Canceled
                    </div>
                    <div class="notif-time">Yesterday</div>
                </div>
                <p style="font-size:1.2rem; color:#333; margin-bottom:15px;">
                    Passenger <strong>John</strong> canceled the trip to <strong>Tapah Hospital</strong>.
                </p>
                <div class="action-row">
                    <button class="btn-action btn-dismiss" onclick="removeCard('cancel-2')">Dismiss</button>
                </div>
            </div>

            <div class="empty-state" id="empty-canceled">
                <i class="fa-regular fa-folder-open"></i>
                <h3>No canceled orders</h3>
            </div>
        </div>

    </div>

    <script>
        // Sidebar Logic
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        // Tab Logic
        function switchTab(tab) {
            // Update Buttons
            const buttons = document.querySelectorAll('.tab-btn');
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');

            // Show/Hide Lists
            if (tab === 'new') {
                document.getElementById('list-new').style.display = 'flex';
                document.getElementById('list-canceled').style.display = 'none';
            } else {
                document.getElementById('list-new').style.display = 'none';
                document.getElementById('list-canceled').style.display = 'flex';
            }
        }

        // Card Interaction Logic
        function removeCard(id) {
            const card = document.getElementById(id);
            card.classList.add('fade-out');
            setTimeout(() => {
                card.style.display = 'none';
                checkEmptyStates();
            }, 300);
        }

        function acceptCard(id) {
            // In a real app, this would make an API call
            alert("Order Accepted! Redirecting to navigation...");
            removeCard(id);
        }

        function checkEmptyStates() {
            // Logic to show empty state if all cards are gone (simplified)
            // In a real app, you'd check array length
        }
    </script>

</body>
</html>