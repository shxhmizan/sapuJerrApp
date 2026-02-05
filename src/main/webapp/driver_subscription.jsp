<%@page import="sapujerrapp.App" %>
<%@ include file="component_redirect_if_no_login.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr - Manage Subscription</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/subcription.css">
</head>
<body>

    <header class="header">
        <div class="logo">SapuJerr</div>
        <button class="btn-close" onclick="window.location.href='<%=App.Pages.DriverDashboard.link%>'">
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
                window.location.href = '<%=App.Pages.DriverProfileJSP.link%>'; // Redirect to profile
            }, 2000);
        }
    </script>

</body>
</html>