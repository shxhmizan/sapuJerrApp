<%@ page import="java.util.Date,java.util.List" %>
<%@ include file="component_redirect_if_no_login.jsp" %>
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
	<%@include file="component_sidebar_driver.jsp" %>
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
		<%
		List stats = (List) request.getAttribute("stats");
		
		int jobsDone = 0;
		int jobsInProgress = 0;
		int jobsAvailable = 0;
		
		if(stats != null && stats.size() == 3){
			jobsDone = (int) stats.get(0);
			jobsInProgress = (int) stats.get(1);
			jobsAvailable = (int) stats.get(2);
		}
		
		%>
        <div class="action-grid">
               <div class="big-card card-performance">
                    <div class="card-label">Jobs Done</div>
                    <div class="card-value"><%=jobsDone%></div>
                    <div style="color:#888; font-weight:600;">Goal: <%= jobsDone + jobsInProgress%></div>
                </div>
                <div class="big-card card-performance">
                    <div class="card-label">Jobs In Progress</div>
                    <div class="card-value"><%=jobsInProgress %></div>
                    <div style="color:#888; font-weight:600;">Goal: 0</div>
                </div>
                <div class="big-card card-performance">
                    <div class="card-label">Available Jobs</div>
                    <div class="card-value"><%=jobsAvailable%></div>
                </div>
        </div>

        <div class="action-grid">
            <div class="action-btn" onclick="openAvailabilityModal()">
                <div class="btn-icon"><i class="fa-solid fa-clock"></i></div>
                <div class="btn-text"><h3>Set Availability</h3><p>Manage shifts</p></div>
            </div>
            <div class="action-btn" onclick="<%=App.Pages.DriverOrders%>">
                <div class="btn-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                <div class="btn-text"><h3>Order List</h3><p>View requests</p></div>
            </div>
            <a class="action-btn" href="<%=App.Pages.DriverNotifications%>">
                <div class="btn-icon"><i class="fa-solid fa-bell"></i></div>
                <div class="btn-text"><h3>Notifications</h3><p>3 New</p></div>
            </a>
        </div>
    </div>

    <div class="modal-overlay" id="availModal">
        <div class="modal-card">
            <div class="modal-title">Manage Weekly Shifts</div>
            <div class="schedule-list">
                <div class="schedule-item">
                    <div class="day-check">
                        <span style="font-weight:700;"><%=App.dateDisplayFormatter.format(new Date())%></span>
                        <label><input type="checkbox" checked hidden><div class="toggle-switch-sm"></div></label>
                    </div>
                    <div class="time-inputs">
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