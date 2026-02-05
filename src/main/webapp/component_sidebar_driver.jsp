<%@page import="sapujerrapp.App" %>
<div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
<aside class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="sidebar-logo">SapuJerr</div>
        <div class="user-profile-row">
            <div class="profile-avatar-large"><i class="fa-solid fa-user"></i></div>
            <div>
                <h2 style="font-size:1.5rem; font-weight:800;"><jsp:getProperty property="name" name="user"/></h2>
                <div style="font-size:1rem; opacity:0.9;">4.9 <i class="fa-solid fa-star" style="color:#FFD700;"></i></div>
            </div>
        </div>
    </div>
    <nav class="sidebar-menu">
        <a href="<%=App.Pages.DriverDashboard.link %>" class="menu-item" style="background:#f5f5f5; color:var(--brand-red);">
            <i class="fa-solid fa-gauge-high"></i> Dashboard
        </a>
        <a href="<%=App.Pages.DriverOrders.link%>" class="menu-item"><i class="fa-solid fa-car"></i> Orders</a>
        <a href="<%=App.Pages.DriverNotifications.link %>" class="menu-item">
            <i class="fa-solid fa-bell"></i> Notifications <span class="badge-dot"></span>
        </a>
        <a href="<%=App.Pages.DriverProfile.link%>" class="menu-item"><i class="fa-solid fa-user"></i> Profile</a>
        <a href="<%=App.Pages.DriverCarDetail.link %>" class="menu-item"><i class="fa-solid fa-car"></i> Vehicle</a>
        <a href="<%=App.Pages.DriverSubscription.link %>" class="menu-item"><i class="fa-solid fa-car"></i> Subscription</a>
    </nav>
    <div class="sidebar-footer">
        <a href="<%=App.Pages.Login.link %>" style="color:#666; text-decoration:none; font-size:1rem;">Log Out <i class="fa-solid fa-right-from-bracket"></i></a>
    </div>
</aside>