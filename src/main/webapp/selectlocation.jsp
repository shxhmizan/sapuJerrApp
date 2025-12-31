<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="leaflet-1_9_4/dist/leaflet.css">
<script src="leaflet-1_9_4/dist/leaflet.js"></script>
<style>
	#map {
		height : 80vh;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Leaflet Map Test</h1>
	<div id="map"></div>
	<script>
		var map = L.map('map').setView([4.17814,101.21876],13);
		L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png',{
			maxZoom: 19,
			attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
		}).addTo(map);
	</script>
</body>
</html>