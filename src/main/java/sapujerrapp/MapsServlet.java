package sapujerrapp;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.core.UriBuilder;

import java.io.IOException;
import java.io.Serializable;
import java.io.StringWriter;
import java.net.URI;
import java.net.http.*;
import java.time.Duration;
import java.util.Map;

import jakarta.json.*;

/**
 * Servlet implementation class MapsServlet
 * This Servlet provides an interface between the application and the Google Maps API
 */
@WebServlet(urlPatterns={"/MapsServlet","/MapsServlet/*"})
public class MapsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected String apiKey;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MapsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	/**
	 * Processes HTTP GET requests sent to this servlet
	 * For API requests, this servlet will construct the API call including API keys and request parameters
	 * Then, the Servlet will send a HTTP request to the external API and copies its response to be sent back to the client
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.apiKey = getServletContext().getInitParameter("mapsAPIKey");
		String leadPath = getFirstDir(request.getPathInfo());
		HttpRequest req;
		switch(leadPath) {
			case "mapview":
				String mapViewUrl = "https://maps.googleapis.com/maps/api/js";
				UriBuilder uriBuilder = UriBuilder.fromUri(mapViewUrl);
				uriBuilder.queryParam("key", apiKey);
				request.getParameterMap().forEach( (String key, Object[] values) -> {
					uriBuilder.queryParam(key, values);
				});
				req = HttpRequest.newBuilder().uri(uriBuilder.build()).build();
				forwardAPIRequest(req,response);
				break;
			case "places":
				String id = request.getParameter("id");
				if(id == null) {
					response.getWriter().append("Missing required parameter 'id' in request");
					response.sendError(HttpServletResponse.SC_BAD_REQUEST);
					return;
				}
				String placesAPIUrl = "https://places.googleapis.com/v1/places/" + id
						+ "?key=" + this.apiKey
						+ "&fields=id,displayName,location,formattedAddress";
				req = HttpRequest.newBuilder()
						.uri(URI.create(placesAPIUrl)).build();
				forwardAPIRequest(req,response);
				break;
			case "route":
				final String startPlace = request.getParameter("startPlace");
				final String destPlace = request.getParameter("destPlace");
				if(startPlace == null || destPlace == null) {
					response.getWriter().append("Missing required parameter(s) 'startPlace' and 'destPlace' in request");
					response.sendError(HttpServletResponse.SC_BAD_REQUEST);
					return;
				}
				String routeAPIUrl = "https://routes.googleapis.com/directions/v2:computeRoutes";
				
				/**
				 * Request body for getting routes
				 */
				JsonObject apiRequestData = Json.createObjectBuilder()
						.add("origin",Json.createObjectBuilder()
								.add("placeId", startPlace)
						)
						.add("destination", Json.createObjectBuilder()
								.add("placeId", destPlace)
						)
						.add("travelMode", "DRIVE")
						.add("routingPreference", "TRAFFIC_UNAWARE")
						.add("computeAlternativeRoutes", false)
						.add("routeModifiers", Json.createObjectBuilder()
								.add("avoidTolls", true))
						.add("languageCode", "en-MY")
						.add("regionCode", "my")
						.add("units", "METRIC")
						.build();
				StringWriter bodyWriter = new StringWriter();
				JsonWriter jsonWriter = Json.createWriter(bodyWriter);
				jsonWriter.writeObject(apiRequestData);
				jsonWriter.close();
				
				String reqBody = bodyWriter.toString();
				
				bodyWriter.close();
				
				req = HttpRequest.newBuilder()
						.uri(URI.create(routeAPIUrl))
						.headers(
								"Content-Type", "application/json",
								"X-Goog-Api-Key" , apiKey,
								"X-Goog-FieldMask" , "*")
						.POST(HttpRequest.BodyPublishers.ofString(reqBody))
						.build();
				forwardAPIRequest(req,response);
				break;
			default:
				response.getWriter().println("Invalid route :" + leadPath);
		}
	}
	
	/**
	 * Sends the internal API request and forwards its response back to the client
	 * @param req The HttpRequest object to be sent by the server
	 * @param response The HttpResponse object to be sent back to the client
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void forwardAPIRequest(HttpRequest req, HttpServletResponse response) throws ServletException,IOException {
		try {
			HttpResponse<String> internalResponse = this.buildHttpClient().send(req, HttpResponse.BodyHandlers.ofString());
			response.setStatus(internalResponse.statusCode());
			response.getWriter().write(internalResponse.body());
			response.getWriter().close();
		}
		catch(Exception e) {
			System.out.println(e);
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * Find the first sub directory from the servlet's request path
	 * For example, get the directory 'places' from the URL /MapsServlet/places/123
	 * @param pathSegment
	 * @return
	 */
	protected String getFirstDir(String pathInfo) {
		if(pathInfo == null) return null;
		String[] paths = pathInfo.split("/");
		String leadPath = null;
		for(String str : paths) {
			if(str != null && str.length() > 0) {
				leadPath = str;
				break;
			}
		}
		return leadPath;
	}
	
	/**
	 * Constructs an internal HTTP client for sending server-side API requests
	 */
	protected HttpClient buildHttpClient() {
		return HttpClient.newBuilder()
		.version(HttpClient.Version.HTTP_1_1)
		.followRedirects(HttpClient.Redirect.NORMAL)
		.connectTimeout(Duration.ofSeconds(10))
		.build()
		;
	}
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
