<%@page import="model.UserEntity" %>
<%
	if(session.getAttribute("user") == null) response.sendRedirect("login.jsp");
%>
<jsp:useBean id="user" class="model.UserEntity" scope="session"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - Professional Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>
    <div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <div class="user-profile-row">
                <div class="profile-avatar-large"><i class="fa-solid fa-user"></i></div>
                <div class="profile-info">
                    <h2><jsp:getProperty property="name" name="user"/></h2>
                    <div class="plan-badge"><i class="fa-solid fa-crown"></i> &nbsp;Dewa</div>
                </div>
            </div>
            <div class="wallet-widget">
                <div>
                    <div class="wallet-label">SapuPay Balance</div>
                    <div class="wallet-amount">RM 150.50</div>
                </div>
                <i class="fa-solid fa-chevron-right" style="color:#ccc;"></i>
            </div>
        </div>

        <nav class="sidebar-menu">
            <a href="#" class="menu-item"><i class="fa-solid fa-clock-rotate-left"></i> Your Trips</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-wallet"></i> Wallet</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-percent"></i> Promotions</a>
            <a href="#" class="menu-item">
                <i class="fa-solid fa-envelope"></i> Messages 
                <span style="background:var(--brand-red); color:white; font-size:0.7rem; padding:2px 8px; border-radius:10px; margin-left:auto;">2</span>
            </a>
            <div style="height:1px; background:#eee; margin:10px 30px;"></div>
            <a href="#" class="menu-item"><i class="fa-solid fa-gear"></i> Settings</a>
            <a href="#" class="menu-item"><i class="fa-solid fa-circle-info"></i> Legal</a>
        </nav>

        <div class="sidebar-footer">
            <a href="#" class="legal-link">Help</a>
            <a href="#" class="legal-link">Privacy</a>
            <p style="margin-top:10px; font-size:0.75rem; color:#ccc;">v4.20.0</p>
        </div>
    </aside>

    <header class="header">
        <div class="header-left">
            <button class="btn-profile" onclick="toggleSidebar()">
                <i class="fa-regular fa-user"></i><jsp:getProperty property="name" name="user"/>
            </button>
        </div>
        <div class="header-right">
            <a href="splash.html" style="text-decoration: none; color: inherit;" title="Replay Splash Screen">
                <div class="logo">SapuJerr</div>
            </a>
        </div>
    </header>

    <div class="hero-container">
        
        <div class="hero-left">
            <h1 id="greetingText"><span id="dynamicGreeting"></span><jsp:getProperty property="name" name="user"/></h1>
            <p class="greeting-sub">Where would you like to go today?</p>

            <div class="input-block">
                
                <div class="block-tabs">
                    <div class="tab-item active"><i class="fa-solid fa-car"></i> Ride</div>
                    <div class="tab-item"><i class="fa-solid fa-box-open"></i> Courier</div>
                </div>

                <div class="connector-container">
                    <div class="dot-circle"></div>
                    <div class="line-vertical"></div>
                    <div class="dot-square"></div>
                </div>

                <button class="btn-swap" onclick="swapLocations()" title="Swap Locations">
                    <i class="fa-solid fa-arrow-right-arrow-left" style="transform: rotate(90deg);"></i>
                </button>

                <div class="input-wrapper">
                    <input type="text" class="clean-input" id="inputPickup" value="Kolej Beta, UiTM Tapah">
                    <i class="fa-solid fa-location-crosshairs" style="position:absolute; right:20px; top:15px; color:#999; cursor:pointer;" title="Current Location"></i>
                </div>

                <div class="input-wrapper" style="position:relative;">
                    <input type="text" class="clean-input" id="inputDropoff" placeholder="Where to?" onfocus="showRecent()" onblur="hideRecent()">
                     <!-- 
                    <div class="recent-dropdown" id="recentDropdown">
                   
                        <div class="recent-item" onmousedown="selectRecent('Tapah Road KTM')">
                            <div class="recent-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                            <div class="recent-info">
                                <div>Tapah Road KTM</div>
                                <span>Perak, Malaysia</span>
                            </div>
                        </div>
                        <div class="recent-item" onmousedown="selectRecent('Aeon Mall Kinta City')">
                            <div class="recent-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
                            <div class="recent-info">
                                <div>Aeon Mall Kinta City</div>
                                <span>Ipoh, Perak</span>
                            </div>
                        </div>
                    </div>
                     -->
                </div>

                <div class="actions-row">
                    <button class="btn-schedule">
                        <i class="fa-solid fa-clock"></i> Now <i class="fa-solid fa-chevron-down" style="font-size:0.8rem; margin-left:5px;"></i>
                    </button>
                    <button class="btn-action" onclick="displayPrices()">See Prices</button>
                </div>

            </div>
        </div>

        <div class="hero-right">
            <div class="map-container">
                <%@include file="gmap.jsp"%>
                <!--
                <div class="map-overlay">
                    <div class="driver-avatar-wrapper">
                        <div class="radar-pulse"></div>
                        <div class="driver-avatar"><i class="fa-solid fa-car"></i></div>
                    </div>
                    <div>
                        <div style="font-weight:800; font-size:0.95rem;">Finding Drivers...</div>
                        <div style="font-size:0.8rem; color:#666;">High demand nearby</div>
                    </div>
                </div>
                -->
                <div class="block-tabs">
                	<h3>Trip Distance</h3><p id="route_distance"></p>
                	<h3>Expected Duration</h3><p id="route_duration"></p>
                	<h3>Notes</h3><p id="route_info"></p>
            	</div>
            </div>
        </div>
   </div>

    <div class="suggestions-section">
        <div class="section-header">
            <h2 class="section-title">Suggestions</h2>
        </div>
        
        <div class="suggestions-grid">
            <div class="suggestion-card" onclick="alert('Opening Advance Booking...')">
                <div class="card-content">
                    <h3>Advance Booking</h3>
                    <p>Schedule your ride ahead.</p>
                </div>
                <div class="card-icon"><i class="fa-solid fa-calendar-plus"></i></div>
            </div>

            <div class="suggestion-card" onclick="alert('Opening Bookings...')">
                <div class="card-content">
                    <h3>My Bookings</h3>
                    <p>Check upcoming trips.</p>
                </div>
                <div class="card-icon"><i class="fa-solid fa-ticket"></i></div>
            </div>

            <div class="suggestion-card" onclick="alert('Opening History...')">
                <div class="card-content">
                    <h3>History</h3>
                    <p>View past transactions.</p>
                </div>
                <div class="card-icon"><i class="fa-solid fa-clock-rotate-left"></i></div>
            </div>
        </div>
    </div>

    <script>
        // 1. Sidebar Logic
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const backdrop = document.getElementById('backdrop');
            
            sidebar.classList.toggle('active');
            backdrop.classList.toggle('active');
        }

        // 2. Dynamic Greeting based on Time
        window.onload = function() {
            const hour = new Date().getHours();
            const title = document.getElementById('dynamicGreeting');
            if (hour < 12) title.innerHTML = "Good Morning,";
            else if (hour < 18) title.innerHTML = "Good Afternoon,";
            else title.innerHTML = "Good Evening,";
        };

        // 3. Swap Locations Logic
        function swapLocations() {
            const p = document.getElementById('inputPickup');
            const d = document.getElementById('inputDropoff');
            const temp = p.value;
            p.value = d.value;
            d.value = temp;
        }

        // 4. Recent Locations Dropdown Logic
        function showRecent() {
            document.getElementById('recentDropdown').style.display = 'block';
        }
        function hideRecent() {
            // Delay hide so click event registers
            setTimeout(() => {
                document.getElementById('recentDropdown').style.display = 'none';
            }, 200);
        }
        function selectRecent(location) {
            document.getElementById('inputDropoff').value = location;
        }

        // 5. Booking Chat Logic
        function toggleChat() {
            const chatBox = document.getElementById('bookingChatBox');
            chatBox.style.display = chatBox.style.display === 'none' ? 'flex' : 'none';
        }

        function sendChatMessage() {
            const input = document.getElementById('chatInput');
            const message = input.value.trim();
            if (!message) return;

            const chatMessages = document.getElementById('chatMessages');
            chatMessages.innerHTML += '<div class="chat-message user">' + message + '</div>';
            input.value = '';

            fetch('/sapujerrApp2/booking-chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'message=' + encodeURIComponent(message)
            })
            .then(response => response.text())
            .then(reply => {
                chatMessages.innerHTML += '<div class="chat-message bot">' + reply + '</div>';
                chatMessages.scrollTop = chatMessages.scrollHeight;
            })
            .catch(error => {
                chatMessages.innerHTML += '<div class="chat-message bot">Sorry, I\'m having trouble connecting. Please try again.</div>';
            });
        }

        function handleChatKeyPress(event) {
            if (event.key === 'Enter') {
                sendChatMessage();
            }
        }
        
        async function displayPrices(){
        	const url = "/SapuJerr/BookingServlet?latestPrice";
        	
        	try{
        		const response = await fetch(url);
        		if(response.ok){
        			const json = await response.json();
        			console.log(json);
        			const basePrice = json.base_price;
        			const pricePerKm = json.price_per_km;
        			const pricePerMin = json.price_per_min;
        			const effectiveDate = json.effective_date;
        			
        			alert("Prices :\nBase Price : RM" + basePrice + "\n"
        				+ "Price Per KM : RM" + pricePerKm + "\n"
        				+ "Price Per Minute : RM" + pricePerMin + "\n"
        				+ "Prices Effective Since : " + effectiveDate + "\n"
        			);
        		}
        	}
        	catch(error){
        		console.log(error);
        	}
        }
    </script>

    <!-- Booking Chat Box -->
    <div id="bookingChatBox" class="chat-box">
        <div class="chat-header">
            <span>Booking Assistant</span>
            <button onclick="toggleChat()" style="background: none; border: none; color: white; font-size: 20px; cursor: pointer;">&times;</button>
        </div>
        <div id="chatMessages" class="chat-messages">
            <div class="chat-message bot">Hi! I'm your booking assistant. How can I help you with your SapuJerr bookings today?</div>
        </div>
        <div class="chat-input-area">
            <input type="text" id="chatInput" class="chat-input" placeholder="Ask about your bookings..." onkeypress="handleChatKeyPress(event)">
            <button onclick="sendChatMessage()" class="chat-send">Send</button>
        </div>
    </div>

    <!-- Chat Toggle Button -->
    <button onclick="toggleChat()" class="chat-toggle" title="Booking Assistant">💬</button>

</body>
</html>