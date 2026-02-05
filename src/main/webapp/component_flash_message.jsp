<%@ page import="sapujerrapp.App"%>
<% 
	String msg = App.getFlashMessage(session);
	if(msg != null) {
%><p><%=msg%></p><%}%>
