<%@page import="sapujerrapp.App,java.util.List,java.util.Date,java.util.ArrayList,model.*,java.time.*" %>
<%@ include file="component_redirect_if_no_login.jsp" %>
<%
	List subbedPackages = (List) request.getAttribute("packages");
	List subscriptions = (List) request.getAttribute("subscriptions");
	List unsubbedPackages = (List) request.getAttribute("unsubbedPackages");
	
	ArrayList<SubscriptionPackageEntity> semPkg = new ArrayList<>();
	ArrayList<SubscriptionPackageEntity> yearlyPkg = new ArrayList<>();
	
	SubscriptionEntity currentSub = null;
	SubscriptionPackageEntity currentSubPkg = null;
	
	long subEndDays = 0;
	
	if(unsubbedPackages != null) for(Object obj : unsubbedPackages) if(obj instanceof SubscriptionPackageEntity){
		SubscriptionPackageEntity pkg = (SubscriptionPackageEntity) obj;
		
		if(pkg.getDurationDays() < 365){
			semPkg.add(pkg);
		}
		else yearlyPkg.add(pkg);
	}
	
	if(subscriptions != null && subscriptions.size() > 0) {
		Object obj = subscriptions.getFirst();
		if(obj instanceof SubscriptionEntity) currentSub = (SubscriptionEntity) obj;
		subEndDays = Duration.between(new Date().toInstant(),currentSub.getDateEnd().toInstant()).toDays();
	}
	
	
	if(subbedPackages != null && subbedPackages.size() > 0){
		Object obj = subbedPackages.getFirst();
		if(obj instanceof SubscriptionPackageEntity) currentSubPkg = (SubscriptionPackageEntity) obj;
	}
	
	
%>
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
        <% if (currentSub != null){ %>
	        <% if(currentSubPkg != null) { %>
	        <div class="status-pill">Plan: <strong><%= currentSubPkg.getPackageTier()%></strong></div>
	        <% } %>
        	<div class="status-pill" style="background:rgba(0,0,0,0.2);">Ends In: <strong><%=subEndDays%></strong> days</div>
        <% } else { %>
        <div class="status-pill"><strong>Not Subscribed</strong></div>
        <% } %>
        
    </div>

    <div class="pricing-container">
        
        <h1 class="page-title">Subscription Plans</h1>
        <p class="page-subtitle">Choose the perfect plan for your driving journey</p>
		<p class="page-subtitle">Your Current Plan</p>
        <div class="pricing-grid">
            <% if(subbedPackages != null) for(Object obj : subbedPackages) if(obj instanceof SubscriptionPackageEntity){
            		SubscriptionPackageEntity pkg = (SubscriptionPackageEntity) obj;
            %>
            <div class="pricing-card current">
                <div class="plan-name"><%=pkg.getPackageTier() %></div>
                <div class="price-area">
                    <div><span class="currency">RM</span><span class="amount"><%=pkg.getFeeAmount()%></span></div>
                    <div class="duration"><%=pkg.getPackageDuration() %></div>
                </div>
            	<%--
                <ul class="features-list">
                    <li><i class="fa-solid fa-check check-icon"></i> Access to limited daily bookings</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Standard visibility</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Priority matching</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Earnings Analytics</li>
                </ul>
                --%>
                <button class="btn-subscribe">Current Plan</button>
            </div>
            <%
            	}
            %>
       </div>
       <p class="page-subtitle">Choose a New Plan Below</p>
       <div class="billing-toggle-wrapper" id="toggleWrapper">
            <div class="toggle-bg"></div>
            <div class="toggle-btn active" onclick="setBilling('semesterly')">Semesterly</div>
            <div class="toggle-btn" onclick="setBilling('annually')">Annually<span class="discount-badge">Save 10%</span>
            </div>
        </div>
       <div class="pricing-grid semesterly">
            <% for(SubscriptionPackageEntity pkg : semPkg){
            %>
            <div class="pricing-card <%=(pkg.getPackageTier().equalsIgnoreCase("dewa")) ? "featured" : "" %>">
                <div class="plan-name"><%=pkg.getPackageTier() %></div>
                <div class="price-area">
                    <div><span class="currency">RM</span><span class="amount"><%=pkg.getFeeAmount()%></span></div>
                    <div class="duration"><%=pkg.getPackageDuration() %></div>
                </div>
            	<%--
                <ul class="features-list">
                    <li><i class="fa-solid fa-check check-icon"></i> Access to limited daily bookings</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Standard visibility</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Priority matching</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Earnings Analytics</li>
                </ul>
                --%>
                <button class="btn-subscribe" onclick="confirmUpgrade('<%=pkg.getPackageId()%>','<%= pkg.getPackageTier() %> - <%=pkg.getPackageDuration() %>')">Subscribe</button>
            </div>
            <%
            	}
            %>
       </div>
       <div class="pricing-grid annually" style="display:none">
       		<% for(SubscriptionPackageEntity pkg : yearlyPkg){
            %>
            <div class="pricing-card <%=(pkg.getPackageTier().equalsIgnoreCase("dewa")) ? "featured" : "" %>">
                <div class="plan-name"><%=pkg.getPackageTier() %></div>
                <div class="price-area">
                    <div><span class="currency">RM</span><span class="amount"><%=pkg.getFeeAmount()%></span></div>
                    <div class="duration"><%=pkg.getPackageDuration() %></div>
                </div>
            	<%--
                <ul class="features-list">
                    <li><i class="fa-solid fa-check check-icon"></i> Access to limited daily bookings</li>
                    <li><i class="fa-solid fa-check check-icon"></i> Standard visibility</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Priority matching</li>
                    <li><i class="fa-solid fa-xmark cross-icon"></i> Earnings Analytics</li>
                </ul>
                --%>
                <button class="btn-subscribe" onclick="confirmUpgrade('<%=pkg.getPackageId()%>','<%= pkg.getPackageTier() %> - <%=pkg.getPackageDuration() %>')">Subscribe</button>
            </div>
            <%
            	}
            %>
       </div>
            <%-- 
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
			--%>
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
        var currentCycle = "semesterly";
        var pkgId = null;

        function setBilling(cycle) {
            currentCycle = cycle;
            
            const btns = document.querySelectorAll('.toggle-btn');
            const wrapper = document.getElementById('toggleWrapper');
            const semesterlyGrid = document.querySelector('.pricing-grid.semesterly');
            const annualGrid = document.querySelector('.pricing-grid.annually');
            
            if (cycle === 'annually') { 
            	wrapper.classList.add('annual');
            	btns[0].classList.remove('active');
                btns[1].classList.add('active');
            	semesterlyGrid.style.setProperty("display","none");
            	annualGrid.style.setProperty("display","grid");
            }
            
            else {
            	wrapper.classList.remove('annual');
            	btns[1].classList.remove('active');
                btns[0].classList.add('active');
            	semesterlyGrid.style.setProperty("display","grid");
            	annualGrid.style.setProperty("display","none");
            }
            /*
            
            
            
            // Toggle Visuals
            if (cycle === 'annual') {
                
               
                
                // Update Text
                document.getElementById('price-mid').innerText = pricing.mid.annual;
                document.getElementById('duration-mid').innerText = '/ Year';
                document.getElementById('price-dewa').innerText = pricing.dewa.annual;
                document.getElementById('duration-dewa').innerText = '/ Year';
            } else {
               
                

                // Update Text
                document.getElementById('price-mid').innerText = pricing.mid.semester;
                document.getElementById('duration-mid').innerText = '/ Semester';
                document.getElementById('price-dewa').innerText = pricing.dewa.semester;
                document.getElementById('duration-dewa').innerText = '/ Semester';
            }
            */
        }

        // Modal Logic
        function confirmUpgrade(planId,tier) {
            document.getElementById('modalPlanName').innerText = tier;
            pkgId = planId;
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
            const url = "./SubscriptionServlet?subscribe=" + pkgId;
            fetch(url).then((response) => {
            	if(response.ok){
            		alert("Payment Successful! Welcome to your new plan.");
	                closeModal();
	                btn.innerHTML = 'Proceed to Payment'; // Reset
	                window.location.href = '<%=App.Pages.DriverSubscription.link%>'; // Redirect to profile
            	}
            	else alert("Sorry, payment failed to process.");
            })
            setTimeout(() => {
                
            }, 2000);
        }
    </script>

</body>
</html>