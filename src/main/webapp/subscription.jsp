<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - Manage Subscription</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ============================
           1. THEME VARIABLES
           ============================ */
        :root {
            --brand-red: #D30015;
            --brand-red-hover: #b00012;
            --brand-beige: #EEECE1;
            --brand-white: #FFFFFF;
            --brand-gold: #FFD700;
            --text-dark: #2c2c2c;
            --text-gray: #666666;
            --shadow-card: 0 10px 30px rgba(0,0,0,0.08);
            --shadow-hover: 0 20px 40px rgba(211, 0, 21, 0.15);
            --sidebar-width: 320px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; }

        body {
            background-color: var(--brand-beige);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        /* ============================
           2. NAVIGATION (Simplified for this view)
           ============================ */
        .header {
            background-color: var(--brand-white);
            height: 70px; display: flex; align-items: center; justify-content: space-between;
            padding: 0 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); position: sticky; top: 0; z-index: 100;
        }
        .logo { font-size: 2rem; font-weight: 800; font-style: italic; letter-spacing: -1px; color: var(--brand-red); }
        .btn-close {
            background: #f0f0f0; border: none; padding: 10px 20px; border-radius: 30px;
            font-weight: 700; cursor: pointer; transition: all 0.2s;
        }
        .btn-close:hover { background: #e0e0e0; transform: scale(1.05); }

        /* ============================
           3. SUBSCRIPTION STATUS BAR
           ============================ */
        .status-bar {
            background: var(--brand-red); color: white; padding: 15px 40px;
            display: flex; justify-content: center; align-items: center; gap: 20px;
            font-weight: 600; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .status-pill {
            background: rgba(255,255,255,0.2); padding: 5px 15px; border-radius: 20px;
            font-size: 0.9rem; display: flex; align-items: center; gap: 8px;
        }

        /* ============================
           4. PRICING CONTAINER
           ============================ */
        .pricing-container {
            max-width: 1200px; margin: 40px auto; padding: 0 20px;
            display: flex; flex-direction: column; align-items: center;
        }

        .page-title {
            font-size: 3rem; font-weight: 800; color: var(--brand-red);
            text-transform: uppercase; letter-spacing: -1px; margin-bottom: 10px;
            text-shadow: 2px 2px 0px rgba(0,0,0,0.1);
        }
        .page-subtitle { color: var(--text-gray); font-size: 1.1rem; margin-bottom: 30px; }

        /* TOGGLE SWITCH (Semester vs Annual) */
        .billing-toggle-wrapper {
            background: white; padding: 5px; border-radius: 30px;
            display: flex; position: relative; margin-bottom: 50px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05); border: 1px solid #ddd;
        }
        .toggle-btn {
            padding: 12px 30px; border-radius: 25px; cursor: pointer;
            font-weight: 700; color: var(--text-gray); transition: all 0.3s;
            position: relative; z-index: 2;
        }
        .toggle-btn.active { color: white; }
        
        /* The sliding background pill */
        .toggle-bg {
            position: absolute; top: 5px; left: 5px; width: 50%; height: calc(100% - 10px);
            background: var(--brand-red); border-radius: 25px; transition: transform 0.3s cubic-bezier(0.4, 0.0, 0.2, 1);
            z-index: 1;
        }
        /* Logic to move the background */
        .billing-toggle-wrapper.annual .toggle-bg { transform: translateX(96%); } /* Adjust based on width */

        .discount-badge {
            position: absolute; top: -15px; right: -20px;
            background: var(--brand-gold); color: black; font-size: 0.75rem; font-weight: 800;
            padding: 3px 8px; border-radius: 5px; transform: rotate(10deg);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        /* ============================
           5. PRICING CARDS
           ============================ */
        .pricing-grid {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; width: 100%;
            align-items: center; /* Align vertically */
        }

        .pricing-card {
            background: white; border-radius: 25px; padding: 40px 30px;
            position: relative; transition: all 0.3s ease;
            border: 2px solid transparent; display: flex; flex-direction: column;
            box-shadow: var(--shadow-card);
        }

        .pricing-card:hover { transform: translateY(-10px); box-shadow: var(--shadow-hover); }

        /* Featured Card (Dewa) */
        .pricing-card.featured {
            border-color: var(--brand-gold);
            transform: scale(1.05);
            box-shadow: 0 15px 40px rgba(211, 0, 21, 0.15);
            z-index: 2;
        }
        .pricing-card.featured:hover { transform: scale(1.05) translateY(-10px); }

        .best-value-badge {
            position: absolute; top: -15px; left: 50%; transform: translateX(-50%);
            background: var(--brand-gold); color: black; padding: 8px 20px;
            border-radius: 20px; font-weight: 800; font-size: 0.9rem; text-transform: uppercase;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }

        /* Card Content */
        .plan-name { font-size: 1.5rem; font-weight: 800; color: var(--text-dark); margin-bottom: 15px; }
        
        .price-area { margin-bottom: 30px; height: 80px; display: flex; flex-direction: column; justify-content: center; }
        .currency { font-size: 1.5rem; font-weight: 600; vertical-align: top; }
        .amount { font-size: 3.5rem; font-weight: 800; color: var(--text-dark); line-height: 1; }
        .duration { font-size: 0.9rem; color: var(--text-gray); font-weight: 600; }

        .features-list { list-style: none; margin-bottom: 40px; flex: 1; }
        .features-list li {
            margin-bottom: 15px; font-size: 0.95rem; color: #555;
            display: flex; align-items: flex-start; gap: 10px;
        }
        .check-icon { color: var(--brand-red); font-weight: bold; }
        .cross-icon { color: #ccc; }

        /* Buttons */
        .btn-subscribe {
            width: 100%; padding: 15px; border-radius: 12px; font-size: 1.1rem; font-weight: 700;
            cursor: pointer; transition: all 0.2s; border: 2px solid var(--text-dark);
            background: transparent; color: var(--text-dark);
        }
        .btn-subscribe:hover { background: var(--text-dark); color: white; }

        .pricing-card.featured .btn-subscribe {
            background: var(--brand-red); border-color: var(--brand-red); color: white;
            box-shadow: 0 5px 15px rgba(211, 0, 21, 0.3);
        }
        .pricing-card.featured .btn-subscribe:hover { background: var(--brand-red-hover); border-color: var(--brand-red-hover); }

        /* Current Plan State */
        .pricing-card.current { border: 2px solid #ccc; background: #f9f9f9; }
        .pricing-card.current .btn-subscribe { background: #ccc; border-color: #ccc; color: #666; cursor: default; }

        /* ============================
           6. MODAL (Confirmation)
           ============================ */
        .modal-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.6); z-index: 2000;
            display: none; align-items: center; justify-content: center;
            backdrop-filter: blur(5px); opacity: 0; transition: opacity 0.3s;
        }
        .modal-overlay.show { display: flex; opacity: 1; }
        .modal-content {
            background: white; padding: 40px; border-radius: 25px; text-align: center;
            max-width: 400px; width: 90%; transform: scale(0.9); transition: transform 0.3s;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .modal-overlay.show .modal-content { transform: scale(1); }
        .modal-icon { font-size: 4rem; color: var(--brand-red); margin-bottom: 20px; }
        .btn-confirm {
            background: var(--brand-red); color: white; padding: 12px 30px; border-radius: 10px;
            border: none; font-weight: bold; cursor: pointer; width: 100%; margin-top: 10px;
        }

        @media (max-width: 900px) {
            .pricing-grid { grid-template-columns: 1fr; max-width: 400px; }
            .pricing-card.featured { transform: none; }
            .pricing-card.featured:hover { transform: translateY(-5px); }
            .status-bar { flex-direction: column; gap: 10px; text-align: center; }
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="logo">SapuJerr</div>
        <button class="btn-close" onclick="window.history.back()">
            <i class="fa-solid fa-xmark"></i> Close
        </button>
    </header>

    <div class="status-bar">
        <span><i class="fa-solid fa-circle-info"></i> Current Status:</span>
        <div class="status-pill">Plan: <strong>Basic Ahh</strong></div>
        <div class="status-pill" style="background:rgba(0,0,0,0.2);">Ends In: <strong>0 Days</strong></div>
    </div>

    <div class="pricing-container">
        
        <h1 class="page-title">Subscription Plans</h1>
        <p class="page-subtitle">Choose the perfect plan for your driving journey</p>

        <div class="billing-toggle-wrapper" id="toggleWrapper">
            <div class="toggle-bg"></div>
            <div class="toggle-btn active" onclick="setBilling('semester')">Semesterly</div>
            <div class="toggle-btn" onclick="setBilling('annual')">
                Annually
                <span class="discount-badge">Save 10%</span>
            </div>
        </div>

        <div class="pricing-grid">
            
            <div class="pricing-card current">
                <div class="plan-name">Basic Ahh</div>
                <div class="price-area">
                    <div><span class="currency">RM</span><span class="amount">0</span></div>
                    <div class="duration">Forever Free</div>
                </div>
                <ul class="features-list">
                    <li><i class="fa-solid fa-check check-icon"></i> Access to limited daily bookings</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Standard visibility</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Priority matching</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Earnings Analytics</li>
                </ul>
                <button class="btn-subscribe">Current Plan</button>
            </div>

            <div class="pricing-card">
                <div class="plan-name">Mid</div>
                <div class="price-area">
                    <div><span class="currency">RM</span><span class="amount" id="price-mid">220</span></div>
                    <div class="duration" id="duration-mid">/ Semester</div>
                </div>
                <ul class="features-list">
                    <li><i class="fa-solid fa-check check-icon"></i> Increased daily bookings</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Better visibility than Basic</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Priority matching (Peak Hours)</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Standard Support</li>
                </ul>
                <button class="btn-subscribe" onclick="confirmUpgrade('Mid')">Subscribe</button>
            </div>

            <div class="pricing-card featured">
                <div class="best-value-badge">Best Value</div>
                <div class="plan-name">Dewa</div>
                <div class="price-area">
                    <div><span class="currency">RM</span><span class="amount" id="price-dewa">280</span></div>
                    <div class="duration" id="duration-dewa">/ Semester</div>
                </div>
                <ul class="features-list">
                    <li><i class="fa-solid fa-check check-icon"></i> <strong>Unlimited</strong> bookings</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Highest Priority Matching</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Maximum Visibility</li>
                    <li><i class="fa-solid fa-check check-icon"></i> 24/7 Priority Support</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Full Earnings Analytics</li>
                </ul>
                <button class="btn-subscribe" onclick="confirmUpgrade('Dewa')">Subscribe Now</button>
            </div>

        </div>
    </div>

    <div class="modal-overlay" id="paymentModal">
        <div class="modal-content">
            <div class="modal-icon"><i class="fa-solid fa-circle-check"></i></div>
            <h2 style="margin-bottom:10px;">Confirm Upgrade?</h2>
            <p style="color:#666; margin-bottom:20px;">You are about to upgrade to the <strong id="modalPlanName">...</strong> plan.</p>
            <button class="btn-confirm" onclick="processPayment()">Proceed to Payment</button>
            <button style="background:transparent; border:none; color:#999; margin-top:15px; cursor:pointer;" onclick="closeModal()">Cancel</button>
        </div>
    </div>

    <script>
        // Data for Prices
        const pricing = {
            mid: { semester: 220, annual: 440 },
            dewa: { semester: 280, annual: 550 }
        };

        let currentCycle = 'semester';

        function setBilling(cycle) {
            currentCycle = cycle;
            const btns = document.querySelectorAll('.toggle-btn');
            const wrapper = document.getElementById('toggleWrapper');
            
            // Toggle Visuals
            if (cycle === 'annual') {
                btns[0].classList.remove('active');
                btns[1].classList.add('active');
                wrapper.classList.add('annual');
                
                // Update Text
                document.getElementById('price-mid').innerText = pricing.mid.annual;
                document.getElementById('duration-mid').innerText = '/ Year';
                document.getElementById('price-dewa').innerText = pricing.dewa.annual;
                document.getElementById('duration-dewa').innerText = '/ Year';
            } else {
                btns[1].classList.remove('active');
                btns[0].classList.add('active');
                wrapper.classList.remove('annual');

                // Update Text
                document.getElementById('price-mid').innerText = pricing.mid.semester;
                document.getElementById('duration-mid').innerText = '/ Semester';
                document.getElementById('price-dewa').innerText = pricing.dewa.semester;
                document.getElementById('duration-dewa').innerText = '/ Semester';
            }
        }

        // Modal Logic
        function confirmUpgrade(planName) {
            document.getElementById('modalPlanName').innerText = planName;
            const modal = document.getElementById('paymentModal');
            modal.style.display = 'flex';
            setTimeout(() => { modal.classList.add('show'); }, 10);
        }

        function closeModal() {
            const modal = document.getElementById('paymentModal');
            modal.classList.remove('show');
            setTimeout(() => { modal.style.display = 'none'; }, 300);
        }

        function processPayment() {
            const btn = document.querySelector('.btn-confirm');
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';
            setTimeout(() => {
                alert("Payment Successful! Welcome to your new plan.");
                closeModal();
                btn.innerHTML = 'Proceed to Payment'; // Reset
                window.location.href = 'profile.html'; // Redirect to profile
            }, 2000);
        }
    </script>

</body>
</html>