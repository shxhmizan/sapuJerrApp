package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingDAO;
import model.BookingEntity;
import model.PricingRateDAO;
import model.StudentDAO;
import model.StudentEntity;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Time;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

import jakarta.json.JsonString;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/AdvanceBookingServlet")
public class AdvanceBookingServlet extends HttpServlet {
	@EJB
	UserDAO userDao;
	
	@EJB
	StudentDAO studentDao;
	
	@EJB
	PricingRateDAO pricingDao;
	
	@EJB
	BookingDAO bookingDao;
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdvanceBookingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String origin = request.getParameter("pickup");
		String originPlaceID = request.getParameter("origin_place_id");
		String destination = request.getParameter("destination");
		String destinationPlaceID = request.getParameter("destination_place_id");
		String date = request.getParameter("date");
		String time = request.getParameter("time");
		
		FormValidator validator = new FormValidator();
		
		validator.require(origin, "Trip Staring Location")
		.require(originPlaceID, "Trip Starting Location ID")
		.require(destination, "Trip Destination")
		.require(destinationPlaceID, "Trip Destination ID")
		.require(date, "Booking Date")
		.require(time, "Pickup Time");
		
		if(validator.isInvalid()) {
			validator.redirectWithErrors(request, response, App.Pages.StudentAdvanceBooking.link);
			return;
		}
		
		try {
		
		Date bookingDate = App.htmlInputDateFormatter.parse(date);
		Time pickupTime = Time.valueOf(App.htmlInputTimeFormatter.parse(time,LocalTime::from));
		
		HttpRequest routeRequest = MapsServlet.buildRouteRequest(this.getServletContext(), originPlaceID, destinationPlaceID);
		
		HttpClient apiClient = HttpClient.newBuilder()
				.version(HttpClient.Version.HTTP_1_1)
				.followRedirects(HttpClient.Redirect.NORMAL)
				.connectTimeout(Duration.ofSeconds(10))
				.build();
		
		
			HttpResponse<InputStream> apiResponse = apiClient.send(routeRequest, HttpResponse.BodyHandlers.ofInputStream());
			JsonReader jsonReader = Json.createReader(apiResponse.body());
			JsonObject responseJson = jsonReader.readObject();
		
			if(responseJson.containsKey("routes")) {
				JsonArray routes = responseJson.getJsonArray("routes");
				JsonObject route = routes.getFirst().asJsonObject();
				int distanceMeters = route.getInt("distanceMeters");
				int durationSeconds = Integer.parseInt(route.getString("duration").replace("s", ""));
				String warnings = String.join(",",route.getJsonArray("warnings").getValuesAs(JsonString::getString));
				
				BigDecimal distanceKm = new BigDecimal(distanceMeters).divide(new BigDecimal(1000));
				BigDecimal basePrice = pricingDao.getLatestPrice().getBasePrice();
				BigDecimal price = basePrice.multiply(distanceKm);
				
				UserEntity user = App.getUser(request.getSession(), userDao);
				StudentEntity student = user.getStudent();
				
				if(student == null) {
					App.setFlashMessage(request.getSession(), "Unable to retrieve your student information, please try again");
					response.sendRedirect(App.Pages.StudentAdvanceBooking.link);
					return;
				}
				
				BookingEntity booking = bookingDao.createBooking(student,bookingDate, origin, destination, distanceKm, pickupTime,price);
				
				if(booking != null) {
					response.sendRedirect(App.Pages.StudentBooking.link);
					return;
				}
				else {
					App.setFlashMessage(request.getSession(), "Error while saving booking data.");
				}
			}
			else {
				App.setFlashMessage(request.getSession(), "Error while retrieving route information");
			}
			response.sendRedirect(App.Pages.StudentAdvanceBooking.link);
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
}
