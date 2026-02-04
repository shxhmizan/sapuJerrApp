<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SapuJerr - Driver Pro Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/dashboard2.css">
</head>
<body>

    <div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">SapuJerr</div>
            <div class="user-profile-row">
                <div class="profile-avatar-large"><i class="fa-solid fa-user"></i></div>
                <div>
                    <h2 style="font-size:1.5rem; font-weight:800;">Jacky</h2>
                    <div style="font-size:1rem; opacity:0.9;">4.9 <i class="fa-solid fa-star" style="color:#FFD700;"></i></div>
                </div>
            </div>
        </div>
        <nav class="sidebar-menu">
            <a href="#" class="menu-item" style="background:#f5f5f5; color:var(--brand-red);">
                <i class="fa-solid fa-gauge-high"></i> Dashboard
            </a>
            <a href="#" class="menu-item" onclick="openPanel('notifications')">
                <i class="fa-solid fa-bell"></i> Notifications <span class="badge-dot"></span>
            </a>
            <a href="profile.jsp" class="menu-item"><i class="fa-solid fa-user"></i> Profile</a>
            <a href="cardetail.jsp" class="menu-item"><i class="fa-solid fa-car"></i> Vehicle</a>
        </nav>
        <div class="sidebar-footer">
            <a href="#" style="color:#666; text-decoration:none; font-size:1rem;">Log Out <i class="fa-solid fa-right-from-bracket"></i></a>
        </div>
    </aside>

    <header class="header" id="mainHeader">
        <div class="header-left">
            <div class="hamburger-btn" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></div>
            <div class="logo-main">SapuJerr</div>
            <div class="status-text" id="statusText">OFFLINE</div>
        </div>
        <div class="toggle-container" onclick="toggleStatus()">
            <div class="toggle-bg"></div>
            <div class="toggle-knob" id="toggleKnob"><i class="fa-solid fa-power-off"></i></div>
        </div>
    </header>

    <div class="dashboard-container">
        
        <div class="radar-bar" id="radarBar">
            <div class="radar-text"><i class="fa-solid fa-satellite-dish radar-icon"></i> <span id="radarText">System Paused</span></div>
            <div style="color:#999; font-weight:600;">v4.2.0</div>
        </div>

        <div class="data-grid">
            <div class="stats-col">
                <div class="big-card card-earnings">
                    <div class="card-label">Today's Earnings</div>
                    <div class="card-value">RM 145</div>
                    <div style="color:var(--brand-green); font-weight:700;"><i class="fa-solid fa-arrow-trend-up"></i> +12%</div>
                </div>
                <div class="big-card card-performance">
                    <div class="card-label">Jobs Done</div>
                    <div class="card-value">8</div>
                    <div style="color:#888; font-weight:600;">Goal: 15</div>
                </div>
            </div>
            <div class="graph-card">
                <div class="graph-header"><div class="graph-title">Weekly Revenue</div></div>
                <div class="chart-container">
                    <div class="bar-group" data-tooltip="RM 120"><div class="bar" style="height: 40%;"></div><div class="day-label">Mon</div></div>
                    <div class="bar-group" data-tooltip="RM 200"><div class="bar" style="height: 65%;"></div><div class="day-label">Tue</div></div>
                    <div class="bar-group" data-tooltip="RM 150"><div class="bar" style="height: 50%;"></div><div class="day-label">Wed</div></div>
                    <div class="bar-group" data-tooltip="RM 280"><div class="bar" style="height: 85%;"></div><div class="day-label">Thu</div></div>
                    <div class="bar-group" data-tooltip="RM 320"><div class="bar active" style="height: 100%;"></div><div class="day-label" style="color:var(--brand-red);">Fri</div></div>
                    <div class="bar-group" data-tooltip="RM 90"><div class="bar" style="height: 30%;"></div><div class="day-label">Sat</div></div>
                    <div class="bar-group" data-tooltip="RM 0"><div class="bar" style="height: 5%;"></div><div class="day-label">Sun</div></div>
                </div>
            </div>
        </div>

        <div class="action-grid">
            <div class="action-btn" onclick="openAvailabilityModal()">
                <div class="btn-icon"><i class="fa-solid fa-clock"></i></div>
                <div class="btn-text"><h3>Set Availability</h3><p>Manage shifts</p></div>
            </div>
            <div class="action-btn" onclick="openPanel('orderList')">
                <div class="btn-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                <div class="btn-text"><h3>Order List</h3><p>View requests</p></div>
            </div>
            <div class="action-btn" onclick="openPanel('notifications')">
                <div class="btn-icon"><i class="fa-solid fa-bell"></i></div>
                <div class="btn-text"><h3>Notifications</h3><p>3 New</p></div>
            </div>
        </div>
    </div>

    <div class="side-panel" id="sidePanel">
        <div class="panel-header">
            <div class="panel-title" id="panelTitle">Title</div>
            <i class="fa-solid fa-xmark" style="font-size:1.5rem; cursor:pointer;" onclick="closePanel()"></i>
        </div>
        
        <div class="panel-content" id="panelContent">
            </div>
    </div>

    <div class="modal-overlay" id="availModal">
        <div class="modal-card">
            <div class="modal-title">Manage Weekly Shifts</div>
            <div class="schedule-list">
                <div class="schedule-item">
                    <div class="day-check">
                        <span style="font-weight:700;">Mon, 6 Dec</span>
                        <label><input type="checkbox" checked hidden><div class="toggle-switch-sm"></div></label>
                    </div>
                    <div class="time-inputs">
                        <input type="time" class="time-box" value="08:00"> <span style="align-self:center">-</span> <input type="time" class="time-box" value="17:00">
                    </div>
                </div>
                <div class="schedule-item">
                    <div class="day-check">
                        <span style="font-weight:700;">Tue, 7 Dec</span>
                        <label><input type="checkbox" hidden><div class="toggle-switch-sm"></div></label>
                    </div>
                    <div class="time-inputs" style="opacity:0.5; pointer-events:none;">
                        <input type="time" class="time-box" value="08:00"> <span style="align-self:center">-</span> <input type="time" class="time-box" value="17:00">
                    </div>
                </div>
            </div>
            <div class="modal-actions">
                <button class="btn-modal btn-cancel" onclick="closeAvailModal()">Cancel</button>
                <button class="btn-modal btn-save" onclick="saveSchedule()">Save</button>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('active');
            document.getElementById('backdrop').classList.toggle('active');
        }

        // --- SIDE PANEL LOGIC ---
        const panelContent = {
            notifications: `
                <div class="sys-msg-item money">
                    <div class="sys-msg-header"><span class="sys-msg-title">Payout Processed</span><span class="sys-msg-time">2h ago</span></div>
                    <div class="sys-msg-body">RM 1,250.00 transferred to bank.</div>
                </div>
                <div class="sys-msg-item admin">
                    <div class="sys-msg-header"><span class="sys-msg-title">Verification</span><span class="sys-msg-time">1d ago</span></div>
                    <div class="sys-msg-body">Update insurance before 10 Dec.</div>
                </div>`,
            orderList: `
                <div class="order-tabs">
                    <div class="order-tab active">Marketplace</div>
                    <div class="order-tab">My Schedule</div>
                </div>
                <div class="order-card">
                    <div class="student-info">
                        <div class="student-pic"><i class="fa-solid fa-user"></i></div>
                        <div class="student-name"><h4>Sarah</h4><span>Student</span></div>
                        <div style="margin-left:auto; font-weight:700;">9:30 PM</div>
                    </div>
                    <div class="route-mini">
                        <div class="route-row-mini"><div class="dot-mini"></div><div class="addr-text">Kolej Beta</div></div>
                        <div class="route-row-mini"><div class="dot-mini red"></div><div class="addr-text">KFC Tapah</div></div>
                    </div>
                    <div class="order-footer">
                        <div class="order-price">RM 15.00</div>
                        <button class="btn-take" onclick="alert('Order Accepted')">Accept</button>
                    </div>
                </div>
                <div class="order-card">
                    <div class="student-info">
                        <div class="student-pic"><i class="fa-solid fa-user"></i></div>
                        <div class="student-name"><h4>Ahmad</h4><span>Staff</span></div>
                        <div style="margin-left:auto; font-weight:700;">Tom. 8 AM</div>
                    </div>
                    <div class="route-mini">
                        <div class="route-row-mini"><div class="dot-mini"></div><div class="addr-text">UiTM Tapah</div></div>
                        <div class="route-row-mini"><div class="dot-mini red"></div><div class="addr-text">KTM Station</div></div>
                    </div>
                    <div class="order-footer">
                        <div class="order-price">RM 12.00</div>
                        <button class="btn-take" onclick="alert('Order Accepted')">Accept</button>
                    </div>
                </div>`
        };

        function openPanel(type) {
            const panel = document.getElementById('sidePanel');
            const title = document.getElementById('panelTitle');
            const content = document.getElementById('panelContent');
            
            panel.classList.add('active');
            if(type === 'notifications') {
                title.innerHTML = '<i class="fa-solid fa-bell"></i> System Alerts';
                content.innerHTML = panelContent.notifications;
            } else {
                title.innerHTML = '<i class="fa-solid fa-list"></i> Order List';
                content.innerHTML = panelContent.orderList;
            }
        }
        function closePanel() { document.getElementById('sidePanel').classList.remove('active'); }

        // --- AVAILABILITY MODAL ---
        function openAvailabilityModal() { document.getElementById('availModal').classList.add('show'); }
        function closeAvailModal() { document.getElementById('availModal').classList.remove('show'); }
        function saveSchedule() { alert("Schedule Updated!"); closeAvailModal(); }

        // --- STATUS LOGIC ---
        let isOnline = false;
        function toggleStatus() {
            isOnline = !isOnline;
            const header = document.getElementById('mainHeader');
            const statusText = document.getElementById('statusText');
            const radarBar = document.getElementById('radarBar');
            const radarText = document.getElementById('radarText');

            if (isOnline) {
                header.classList.add('online'); statusText.innerText = "ONLINE";
                radarBar.classList.add('active'); radarText.innerText = "Scanning...";
                radarText.style.color = "var(--brand-green)";
            } else {
                header.classList.remove('online'); statusText.innerText = "OFFLINE";
                radarBar.classList.remove('active'); radarText.innerText = "System Paused";
                radarText.style.color = "#999";
            }
        }
    </script>

</body>
</html>