package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.json.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalTime;
import java.util.Date;
import java.util.Map;

import model.BookingEntity;
import model.PricingRateDAO;
import model.PricingRateEntity;
import model.StudentEntity;
import model.UserEntity;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/PricingRateServlet")
public class PricingRateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	PricingRateDAO pricingDao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PricingRateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String originPlaceID = request.getParameter("startPlace");
		String destinationPlaceID = request.getParameter("destPlace");
		
		FormValidator validator = new FormValidator();
		
		validator.require(originPlaceID, "Trip Starting Location ID")
		.require(destinationPlaceID, "Trip Destination ID");
		
		if(validator.isInvalid()) {
			response.setStatus(400);
			response.getWriter().write("Missing or invalid place IDs for startPlace & endPlace.");
			return;
		}
		
		JsonWriter writer = Json.createWriter(response.getWriter());
		try {
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
				
				BigDecimal distanceKm = new BigDecimal(distanceMeters).divide(new BigDecimal(1000));
				BigDecimal price = pricingDao.calculateBookingPrice(distanceKm);
				
				PricingRateEntity pricingRate = pricingDao.getLatestPrice();
				
				
				JsonObject obj = Json.createObjectBuilder()
					.add("base_price", pricingRate.getBasePrice())
					.add("price_per_km", pricingRate.getPricePerKm())
					.add("price_per_min", pricingRate.getPricePerMin())
					.add("effective_date", App.dateDisplayFormatter.format( pricingRate.getEffectiveDate()) )
					.add("trip_price",price.setScale(2).toPlainString())
				.build();
				
				writer.write(obj);
			}
			else {
				response.setStatus(500);
			}
		}
		catch(Exception e) {
			System.out.println(e);
		}
		
		writer.close();
		response.getWriter().close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Form processing should go here
	}

}
