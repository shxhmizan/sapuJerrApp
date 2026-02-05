<%@ page language="java" contentType="text/html; charset=UTF-8" import="sapujerrapp.App"%>
<%
	if(! App.userLoggedIn(session)){
		App.setFlashMessage(session, "Your session has expired. Please login.");
		response.sendRedirect(App.Pages.Login.link);
	}
%>
<jsp:useBean id="user" class="model.UserEntity" scope="session"/>