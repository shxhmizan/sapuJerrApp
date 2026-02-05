<%@ page import="sapujerrapp.App,java.util.*,java.time.*" %>
<%@ include file="component_redirect_if_no_login.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - Advance Booking</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ============================
           1. THEME VARIABLES & RESET
           ============================ */
        :root {
            --brand-red: #D30015;
            --brand-beige: #EEECE1;
            --brand-white: #FFFFFF;
            --text-black: #000000;
            --input-height: 70px; /* Taller inputs */
            --transition-speed: 0.3s;
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
            overflow-x: hidden;
        }

        /* ============================
           2. HEADER
           ============================ */
        .header {
            background-color: var(--brand-red);
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 40px;
            color: white;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            position: relative;
            z-index: 50;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .hamburger { 
            font-size: 2.5rem; 
            cursor: pointer; 
            transition: transform 0.2s;
        }
        .hamburger:hover { transform: scale(1.1); }

        .page-title { font-size: 2.2rem; font-weight: 800; }
        .logo { font-size: 2.8rem; font-weight: 800; font-style: italic; letter-spacing: -2px; }

        /* ============================
           3. SIDEBAR (Updated)
           ============================ */
        .sidebar {
            height: 100%;
            width: 320px;
            position: fixed;
            z-index: 1000;
            top: 0;
            left: -350px;
            background-color: white;
            transition: 0.4s cubic-bezier(0.19, 1, 0.22, 1);
            padding-top: 30px;
            box-shadow: 5px 0 30px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
        }

        .sidebar.active { left: 0; }

        .sidebar-header {
            padding: 0 30px 40px;
            color: var(--brand-red);
            font-size: 2.5rem;
            font-weight: 800;
            font-style: italic;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 20px;
        }

        .sidebar a {
            padding: 20px 30px;
            text-decoration: none;
            font-size: 1.3rem;
            color: #333;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.2s;
            font-weight: 600;
            border-left: 6px solid transparent;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #fff0f0;
            color: var(--brand-red);
            border-left: 6px solid var(--brand-red);
            padding-left: 40px;
        }

        .overlay {
            display: none;
            position: fixed;
            width: 100%; height: 100%; top: 0; left: 0;
            background-color: rgba(0,0,0,0.6);
            z-index: 900;
            backdrop-filter: blur(4px);
            opacity: 0; transition: opacity 0.3s;
        }
        .overlay.active { display: block; opacity: 1; }

        /* ============================
           4. MAIN FORM WRAPPER
           ============================ */
        .form-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px 60px;
            max-width: 1600px;
            margin: 0 auto;
            width: 100%;
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .input-row {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 40px;
            margin-bottom: 35px;
        }

        .w-45 { width: 45%; }

        .label {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 10px;
            margin-left: 5px;
            color: #444;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-box {
            background: white;
            border: 3px solid black;
            border-radius: 16px;
            height: var(--input-height);
            display: flex;
            align-items: center;
            padding: 0 25px;
            font-size: 1.4rem;
            font-weight: 600;
            width: 100%;
            position: relative;
            transition: all 0.2s;
            box-shadow: 0 4px 0 rgba(0,0,0,0.1);
        }

        .input-box:focus-within {
            border-color: var(--brand-red);
            box-shadow: 0 8px 20px rgba(211, 0, 21, 0.15);
            transform: translateY(-2px);
        }

        .input-icon { margin-right: 20px; font-size: 1.6rem; }
        .icon-blue { color: #2E4053; }
        .icon-red { color: #D30015; }

        .input-text {
            color: #333; width: 100%; border: none; outline: none;
            font-size: 1.4rem; background: transparent; font-weight: 600;
        }

        .custom-select {
            width: 100%; height: 100%; border: none; outline: none;
            background: transparent; font-size: 1.4rem; font-weight: 800;
            color: black; appearance: none; -webkit-appearance: none; cursor: pointer; z-index: 2;
        }
        .select-arrow { position: absolute; right: 25px; font-size: 1.2rem; pointer-events: none; }

        .arrow-line {
            flex: 1; height: var(--input-height);
            display: flex; align-items: center; justify-content: center; position: relative;
        }
        .arrow-line::before {
            content: ''; position: absolute; width: 100%; border-bottom: 3px dotted #aaa; top: 50%;
        }
        .arrow-line::after {
            content: '>'; position: absolute; right: 0; top: 30%;
            font-family: monospace; font-weight: 900; font-size: 2rem; color: #888;
        }

        .filter-info {
            text-align: right; font-size: 1.2rem; font-weight: 600; margin-top: 15px; color: #555;
        }

        /* ============================
           5. PRICE CARDS
           ============================ */
        .cards-container {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 40px; margin-top: 50px;
        }

        .price-card {
            background: white;
            border: 3px solid black;
            border-radius: 20px;
            padding: 35px;
            min-height: 240px;
            display: flex; flex-direction: column; justify-content: space-between;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
        }

        .price-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            border-color: var(--brand-red);
        }

        .price-card.selected {
            background-color: #fff5f5;
            border-color: var(--brand-red);
            box-shadow: 0 0 0 4px rgba(211, 0, 21, 0.2);
        }
        .price-card.selected .price-text { color: var(--brand-red); }
        .price-card.selected .black-line { background-color: var(--brand-red); }

        .card-header-line { display: flex; align-items: center; justify-content: space-between; margin-bottom: 30px; }
        
        .black-line { 
            height: 4px; background-color: black; width: 55%; border-radius: 2px;
            transition: background-color 0.3s;
        }
        
        .price-text { font-size: 2.8rem; font-weight: 900; color: black; transition: color 0.3s; }

        .car-name { font-size: 1.6rem; font-weight: 700; margin-bottom: 8px; }
        .car-seat { font-size: 1.3rem; font-weight: 500; color: #666; }

        /* ============================
           6. RESPONSIVE
           ============================ */
        @media (max-width: 1024px) {
            .cards-container { gap: 20px; }
            .price-text { font-size: 2.2rem; }
            .form-container { padding: 30px; }
        }

        @media (max-width: 768px) {
            .input-row { flex-direction: column; gap: 20px; align-items: flex-start; }
            .w-45 { width: 100%; }
            .arrow-line { display: none; }
            .cards-container { grid-template-columns: 1fr; }
            .filter-info { text-align: left; margin-bottom: 20px; }
            .header { padding: 0 20px; height: 80px; }
            .page-title { font-size: 1.5rem; }
        }
    </style>
</head>
<body>
	<%@include file="component_sidebar_student.jsp" %>
	<%@include file="component_header.jsp" %>
	<%@include file="component_gmap.jsp" %>
	<div class="input-row">
		<div class="input-box">	                
   			<div class="car-name">Trip Distance : <span class="route-distance">(Select Route)</span></div>
        </div>
        <div class="input-box">
     		<div class="car-name">Expected Duration : <span class="route-duration">(Select Route)</span></div>
        </div>
        <div class="input-box w-45">
     		<div class="car-name">Notes : </div>
     		<p><span class="route-info">(Select Route)</span></p>
        </div>
     </div>
     <div>
     <%@include file="component_flash_message.jsp" %>
     </div>
    <form class="form-container" action="./AdvanceBookingServlet" method="POST">
        
        <div class="input-row">
            <div class="w-45">
                <label class="label" for="pickup">Pickup Location</label>
                <div class="input-box">
                    <i class="fa-solid fa-location-dot input-icon icon-blue"></i>
                    <input type="text" class="input-text map-input-origin" id="inputPickup" name="pickup" value="Kolej Beta, UiTM Tapah">
                    <input type="hidden" class="route-origin-placeid" name="origin_place_id">
                </div>
            </div>

            <div class="arrow-line"></div>

            <div class="w-45">
                <label class="label" for="dropoff">Drop Off Location</label>
                <div class="input-box">
                    <i class="fa-solid fa-location-dot input-icon icon-red"></i>
                    <input type="text" class="input-text placeholder map-input-destination" id="dropoff" name="destination" placeholder="Where To?">
                    <input type="hidden" class="route-destination-placeid" name="destination_place_id">
                </div>
            </div>
        </div>

        <div class="input-row">
            <div class="w-45">
                <label class="label" for="date">Date</label>
                <div class="input-box">
                    <i class="fa-regular fa-calendar input-icon"></i>
                    <input type="date" class="input-text" id="date" name="date" placeholder="DD/MM/YYYY">
                </div>
            </div>

            <div class="w-45">
                <label class="label" style="opacity:0;" for="filter">Filter</label>
                <div class="input-box">
                    <div class="select-wrapper" style="width:100%;">
                        <select class="custom-select" id="filter" name="filter">
                            <option value="" disabled selected>Add Filter</option>
                            <option value="lady_driver">Lady Driver</option>
                            <option value="6_seater">6 Seater</option>
                            <option value="lady_and_6">Lady Driver + 6 Seater</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-arrow"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="input-row">
            <div class="w-45">
                <label class="label" for="time">Time</label>
                <div class="input-box">
                    <i class="fa-regular fa-clock input-icon"></i>
                    <input type="time" class="input-text" id="time" name="time">
                </div>
            </div>
            
            <div class="w-45">
                <div class="input-box">
                    <button type="submit" name="submit" value="advance_booking">Make Booking</button>
                </div>
            </div>

            <div class="w-45">
                <div class="filter-info"><i class="fa-solid fa-filter"></i> Active: Lady Driver, 6 Seater</div>
            </div>
        </div>

        <div class="cards-container">
            <label class="price-card" onclick="selectCard(this)">
                <input type="radio" name="car_type" value="myvi" style="display:none;"> 
                <div class="card-header-line">
                    <div class="black-line"></div>
                    <div class="price-text">RM 20</div>
                </div>
                <div>
                    <div class="car-name">Perodua Myvi</div>
                    <div class="car-seat">4 Seater</div>
                </div>
            </label>

            <label class="price-card" onclick="selectCard(this)">
                <input type="radio" name="car_type" value="kancil" style="display:none;">
                <div class="card-header-line">
                    <div class="black-line"></div>
                    <div class="price-text">RM 18</div>
                </div>
                <div>
                    <div class="car-name">Perodua Kancil</div>
                    <div class="car-seat">4 Seater</div>
                </div>
            </label>

            <label class="price-card" onclick="selectCard(this)">
                <input type="radio" name="car_type" value="aruz" style="display:none;">
                <div class="card-header-line">
                    <div class="black-line"></div>
                    <div class="price-text">RM 25</div>
                </div>
                <div>
                    <div class="car-name">Perodua Aruz</div>
                    <div class="car-seat">6 Seater</div>
                </div>
            </label>
        </div>

    </form>

    <script>
        // Sidebar Logic
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('overlay');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
        }

        // Card Selection Logic (Visual Feedback)
        function selectCard(cardElement) {
            // Remove 'selected' class from all cards
            document.querySelectorAll('.price-card').forEach(c => c.classList.remove('selected'));
            // Add 'selected' class to the clicked card
            cardElement.classList.add('selected');
        }
    </script>

</body>
</html>