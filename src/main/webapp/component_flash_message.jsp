<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="sapujerrapp.App"%>
<% 
	String msg = App.getFlashMessage(session);
	if(msg != null) {
%><p><%=msg%></p><%}%>
