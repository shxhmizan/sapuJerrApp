/**
 * Script for map routing
 */
var selectLoc,startLoc,destLoc,curRoute;

/**
 * Initializes
 */
async function initMap(){
	const {AdvancedMarkerElement} = await google.maps.importLibrary("marker");
	const {Route} = await google.maps.importLibrary("routes");
	const {Place} = await google.maps.importLibrary("places");
	const {encoding} = await google.maps.importLibrary("geometry");
	
	window.addEventListener('load', (_event) => {
		registerMapEventListeners();
	})
}

/**
 * 
 */
function registerMapEventListeners(){
	const mapElem = document.querySelector("gmp-map");
	const map = mapElem.innerMap;
	if(!map) return;
	map.addListener('click',(e) => {
		if(e.placeId){
			showRouteEndpointDialog(e.placeId);
		}
	});
}

/**
 * 
 */
async function getPlace(id){
	const url = `./MapsServlet/places?id=${id}`;
	try{
		const response = await fetch(url);
		if(response.ok){
			const place = await response.json();
			console.log(place);
			selectLoc = place;
			return place;
		}
		else return undefined;
	}
	catch(err){
		console.error(err);
	}
	return undefined;
}
	
async function getRoute(){
	if(! startLoc || ! destLoc) return undefined;
	const url = `./MapsServlet/route?startPlace=${startLoc.id}&destPlace=${destLoc.id}`;
	
	try {
		const response = await fetch(url);
		if(response.ok){
			const json = await response.json();
			const route = json?.routes[0];
			curRoute = route;
			return route;
		}
		else {
			console.log("ROUTE REQUEST FAILED");
		}
	}
	catch(err){
		console.log(err)
	}
}
	
function showRouteEndpointDialog(placeid){
	const dialog = document.getElementById("route_dialog");
	if(! (dialog instanceof HTMLDialogElement)){
		console.log("Dialog missing!");
		return;
	}
	getPlace(placeid).then((place) => {
		if(place){
			dialog.querySelector("#location_name").innerText = place.displayName.text;
			dialog.querySelector("#location_addr").innerText = place.formattedAddress;
			dialog.showModal();
		}
	});
}

/**
 * @param {SubmitEvent} event 
 */
function processRoute(event){
	const submitter = event.submitter;
	var action = "cancel";
	
	if(submitter instanceof HTMLButtonElement){
		action = submitter.value;
	}
	
	if(action == "start" && selectLoc){
		startLoc = selectLoc;
	}
	else if(action == "dest" && selectLoc){
		destLoc = selectLoc;
	}
	else if(!selectLoc) {
		console.log("No selected location!");
	}
	getRoute().then((route) => {
		updateRouteDisplay();
	})
}
	
function updateRouteDisplay(){
	const inpStart = document.getElementById('inputPickup');
	const inpEnd = document.getElementById('inputDropoff');
	if(startLoc && inpStart instanceof HTMLInputElement){
		inpStart.value = startLoc?.displayName?.text;
	}
	if(destLoc && inpEnd instanceof HTMLInputElement){
		inpEnd.value = destLoc?.displayName?.text;
	}
	if(selectLoc && destLoc){
		const route = curRoute;
		const polyLine = route?.polyline;
		const distance = route?.distanceMeters;
		const duration = route?.duration;
		const warnings = route?.warnings;
		
		const distDisplay = document.getElementById('route_distance');
		const durDisplay = document.getElementById('route_duration');
		const notesDisplay = document.getElementById('route_info');
		
		if(distDisplay instanceof HTMLElement){
			distDisplay.innerText = distance;
		}
		if(durDisplay instanceof HTMLElement){
			durDisplay.innerText = duration;
		}
		if(notesDisplay instanceof HTMLElement){
			notesDisplay.innerText = warnings;
		}
	}
}