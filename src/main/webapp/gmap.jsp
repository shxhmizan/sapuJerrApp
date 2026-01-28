<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String key = this.getServletContext().getInitParameter("mapsAPIKey");
%>
<script async
    src="https://maps.googleapis.com/maps/api/js?key=<%=key%>&loading=async&callback=initMap&libraries=routes,marker">
</script>
<gmp-map
	center="4.178077894908865, 101.21876889817179"
	zoom="17"
	map-id="SAPUJERR-MAP"
	style="height: 50vh"
>
</gmp-map>
<script async>
	async function initMap(){
		const {AdvancedMarkerElement} = await google.maps.importLibrary("marker");
		
		const mapElem = document.querySelector("gmp-map");
		const map = mapElem.innerMap;
		if(!map) return;
		map.addListener('click',(e) => {
			console.log(e);
			const marker = new AdvancedMarkerElement({
				position: e.latLng
			});
			mapElem.append(marker);
		});
	}
	
</script>