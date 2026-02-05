<%@page import="sapujerrapp.App" %>
<div class="backdrop" id="backdrop" onclick="toggleSidebar()"></div>
<aside class="sidebar" id="sidebar">
     <div class="sidebar-header">
         <div class="user-profile-row">
             <div class="profile-avatar-large"><i class="fa-solid fa-user"></i></div>
         </div>
     </div>
     <nav class="sidebar-menu">
         <a href="<%=App.Pages.StudentDashboard.link%>" class="menu-item"><i class="fa-solid fa-gauge-high"></i> Dashboard</a>
         <a href="<%=App.Pages.StudentAdvanceBooking.link%>" class="menu-item"><i class="fa-solid fa-car-side"></i>Advance Bookings</a>
         <a href="<%=App.Pages.StudentBooking.link%>" class="menu-item active"><i class="fa-solid fa-clock-rotate-left"></i> My Bookings</a>
         <a href="<%=App.Pages.StudentBookingHistory.link%>" class="menu-item"><i class="fa-solid fa-wallet"></i> History</a>
         <a href="<%=App.Pages.Login.link%>" class="menu-item">Logout</a>
     </nav>
 </aside>