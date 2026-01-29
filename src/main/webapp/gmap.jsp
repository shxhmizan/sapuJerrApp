<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script async
    src="/SapuJerr/MapsServlet/mapview?loading=async&callback=initMap&libraries=routes,marker,places">
</script>
<gmp-map
	center="4.178077894908865, 101.21876889817179"
	zoom="17"
	map-id="SAPUJERR-MAP"
	style="height: 50vh"
>
</gmp-map>
<script defer src="map_routing.js"></script>
<!-- Confirmation dialog for location -->
<dialog style="margin:auto;" id="route_dialog">
	<form method="dialog" id="route_form" onsubmit="processRoute(event)">
		<p>Selected Location:
		<br><span id="location_name"></span>
		<br><span id="location_addr"></span>
		</p>
		<button type="submit" name="start" value="start">Set As Starting Location</button>
		<button type="submit" name="dest" value="dest">Set As End Location</button>
		<button type="submit" name="cancel" value="cancel">Cancel</button>
	</form>
</dialog>