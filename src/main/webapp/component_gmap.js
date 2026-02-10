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

async function displayPrices(){
	if(! startLoc || ! destLoc){
		alert("Please select the trip starting location and destination first.");
		return undefined;
	} 
	const url = `./PricingRateServlet?startPlace=${startLoc.id}&destPlace=${destLoc.id}`;

	try{
		const response = await fetch(url);
		if(response.ok){
			const json = await response.json();
			console.log(json);
			//const basePrice = json.base_price;
			const pricePerKm = json.price_per_km;
			//const pricePerMin = json.price_per_min;
			const effectiveDate = json.effective_date;
			const tripPrice = json.trip_price;
			
			alert("Prices :\n"
				+ "Trip Price : RM " + tripPrice + "\n"
				//+ "Base Price : RM" + basePrice + "\n"
				+ "Price Per KM : RM" + pricePerKm + "\n"
				//+ "Price Per Minute : RM" + pricePerMin + "\n"
				+ "Prices Effective Since : " + effectiveDate + "\n"				
			);
		}
	}
	catch(error){
		console.log(error);
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
	/* Update user-editable inputs containing place names */
	const inpStart = document.querySelector('input.map-input-origin');
	const inpEnd = document.querySelector('input.map-input-destination');
	
	
	if(startLoc && inpStart instanceof HTMLInputElement){
		inpStart.value = startLoc?.displayName?.text;
	}
	if(destLoc && inpEnd instanceof HTMLInputElement){
		inpEnd.value = destLoc?.displayName?.text;
	}
	
	/* Update non-editable inputs containing place IDs */
	const inpOrigin = document.querySelector('input.route-origin-placeid');
	const inpDest = document.querySelector('input.route-destination-placeid');
		
	if(startLoc && inpOrigin instanceof HTMLInputElement){
			inpOrigin.value = startLoc?.id;
		}
	if(destLoc && inpDest instanceof HTMLInputElement){
		inpDest.value = destLoc?.id;
	}
	
	/* Update distance,duration and info displays */
	if(selectLoc && destLoc){
		const route = curRoute;
		//const polyLine = route?.polyline;
		const distanceMeters = route?.distanceMeters;
		const durationText = route?.duration;
		const warningsList = route?.warnings;
		
		const distDisplay = document.querySelector('span.route-distance');
		const durDisplay = document.querySelector('span.route-duration');
		const notesDisplay = document.querySelector('span.route-info');
		
		if(distDisplay instanceof HTMLElement){
			distDisplay.innerText = (distanceMeters / 1000) + " km";
		}
		if(durDisplay instanceof HTMLElement){
			const initDurationSec = (typeof durationText === 'string' || durationText instanceof String) ? Number.parseInt(durationText.replace("s","")) : 0;
			var durationSec = initDurationSec;
			const durationHour = (durationSec > 3600) ? Math.floor(durationSec/3600) : 0;
			if(durationHour > 0) durationSec -= durationHour * 3600;
			const durationMinutes = (durationSec > 60) ? Math.floor(durationSec/60) : 0;
			if(durationMinutes > 0) durationSec -= durationMinutes * 60;
			
			const duration = { 
				hours : durationHour,
				minutes : durationMinutes,
				seconds : durationSec
			};
			durDisplay.innerText = new Intl.DurationFormat("en-MS").format(duration) + `(${initDurationSec}s)`;
		}
		if(notesDisplay instanceof HTMLElement){
			const warnings = (Array.isArray(warningsList)) ? warningsList.join("\n") : warningsList;
			notesDisplay.innerText = warnings;
		}
	}
}
