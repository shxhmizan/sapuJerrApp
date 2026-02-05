package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.json.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URI;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Map;
import model.PricingRateDAO;
import model.PricingRateEntity;

/**
 * Servlet implementation class BookingServlet
 */
@WebServlet("/BookingServlet")
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
		Map<String,String[]> params = request.getParameterMap();
		PrintWriter writer = response.getWriter();
		JsonWriter jsonOutWriter = Json.createWriter(writer);
		PricingRateEntity pricingRate = pricingDao.getLatestPrice();
		
		if(request.getParameter("latestPrice") != null) {
			SimpleDateFormat df = new SimpleDateFormat("dd MMM y");
			
			if(pricingRate == null) {
				response.setStatus(404);
				writer.close();
				return;
			}
			JsonObject obj = Json.createObjectBuilder()
				.add("base_price", pricingRate.getBasePrice())
				.add("price_per_km", pricingRate.getPricePerKm())
				.add("price_per_min", pricingRate.getPricePerMin())
				.add("effective_date",df.format(pricingRate.getEffectiveDate()))
				.build();
			
			jsonOutWriter.writeObject(obj);
			
			jsonOutWriter.close();
		}
		else if(request.getParameter("distanceMeters") != null) {
			if(pricingRate == null) {
				response.setStatus(404);
				writer.close();
				return;
			}
			BigDecimal distanceMeters = new BigDecimal(request.getParameter("distanceMeters"));
			BigDecimal distanceKm = distanceMeters.divide(new BigDecimal(1000));
			BigDecimal price = pricingDao.calculateBookingPrice(distanceKm);
			
			JsonObject obj = Json.createObjectBuilder()
				.add("price", price)
				.build();
			
			jsonOutWriter.writeObject(obj);
			
			jsonOutWriter.close();
		}
		
		writer.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Form processing should go here
	}

}
