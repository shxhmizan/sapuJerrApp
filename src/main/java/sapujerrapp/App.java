package sapujerrapp;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Date;
import java.util.GregorianCalendar;

import jakarta.servlet.http.HttpSession;
import model.UserDAO;
import model.UserEntity;

/**
 * Represents common application processes and data
 */
public class App {
	/**
	 * Holds constant String names for keys to session data from HttpSession.getAttribute()
	 */
	public static class SessionDataKey {
		public static final String USER = "user";
		public static final String FLASH_MESSAGE = "error";
	}
	
	/**
	 * Enum mapping links to Views
	 */
	public static enum Pages {
		Index("index.html"),
		Login("login.jsp"),
		Splash("splash.jsp"),
		Registration("signup.jsp"),
		StudentDashboard("student_dashboard.jsp"),
		StudentBooking("student_bookings.jsp"),
		StudentBookingHistory("student_booking_history.jsp"),
		StudentAdvanceBooking("student_advance_booking.jsp"),
		DriverDashboard("driver_dashboard.jsp"),
		DriverProfile("driver_profile.jsp"),
		DriverSubscriptions("driver_subscription.jsp"),
		DriverNotifications("driver_notifications.jsp"),
		DriverCarDetail("driver_car_detail.jsp"),
		DriverOrders("driver_orders.jsp"),
		ComponentGMap("component_gmap.jsp");
		
		
		public final String link;
		
		private Pages(String link) {
			this.link = link;
		}
		
		public String toString() {
			return this.link;
		}
	}
	
	private static final GregorianCalendar appCalendar = new GregorianCalendar();
	
	public static final DateTimeFormatter dateDisplayFormatter = DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM);;
	public static final DateTimeFormatter htmlInputDateFormatter = DateTimeFormatter.ISO_LOCAL_DATE;
	public static final DateTimeFormatter htmlInputTimeFormatter = DateTimeFormatter.ISO_LOCAL_TIME;
	
	public static GregorianCalendar getCalendar() {
		return appCalendar;
	}
	
	public static LocalDate getCurrentDate() {
		return appCalendar.toInstant().atZone(appCalendar.getTimeZone().toZoneId()).toLocalDate();
	}
	
	/**
	 * A list of allowed content types for file uploads
	 */
	private static final String[] allowedContentTypes = {
		"image/jpeg",
		"image/png",
		"image/gif",
		"image/bmp",
		"image/svg+xml",
		"application/pdf"
	};
	
	/**
	 * Determines if the MIME content type of an uploaded image is valid
	 * @param contentType The MIME content type of the image
	 * @return true if the content type is valid, false otherwise
	 */
	public static boolean isValidUploadedContentType(String contentType) {
		String type = contentType.trim();
		for(String allowedType : App.allowedContentTypes) {
			if(allowedType.equals(type)) return true;
		}
		return false;
	}
	
	/**
	 * Saves a flash message to be displayed later in the session store
	 * This is used to pass view-once messages between different pages & requests
	 * 
	 * @param session The current HTTP session 
	 * @param message The message to store
	 */
	public static void setFlashMessage(HttpSession session,String message) {
		if(session == null) return;
		session.setAttribute(SessionDataKey.FLASH_MESSAGE, message);
	}
	
	/**
	 * Retrieves the flash message that was in the session store, if any.
	 * The message is read-once, meaning that it will be cleared from the session after this function is called.
	 * 
	 * @param session The current HTTP session 
	 * @return
	 */
	public static String getFlashMessage(HttpSession session) {
		if(session == null) return null;
		String msg = (String) session.getAttribute(SessionDataKey.FLASH_MESSAGE);
		session.setAttribute(SessionDataKey.FLASH_MESSAGE, null);
		return msg;
	}
	
	/**
	 * Check if the current user has logged in and has their information in the session store.
	 * 
	 * @param session The current HTTP session 
	 * @return true if the user has credentials in the session store, false otherwise
	 */
	public static boolean userLoggedIn(HttpSession session) {
		return session.getAttribute(App.SessionDataKey.USER) != null;
	}
	
	/**
	 * Retrieves info about current user from the session store
	 * @param session
	 * @return
	 */
	public static UserEntity getUser(HttpSession session) {
		return (UserEntity) session.getAttribute(App.SessionDataKey.USER);
	}
	
	/**
	 * Retrieves info about current user from the session store, and updates/syncs it with latest data from database
	 * @param session
	 * @param dao
	 * @return
	 */
	public static UserEntity getUser(HttpSession session,UserDAO dao) {
		return dao.getLatestUserData( (UserEntity) session.getAttribute(App.SessionDataKey.USER) );
	}
	
	/**
	 * Sets the user information in the session store
	 * @param session
	 * @param user
	 */
	public static void setUser(HttpSession session, UserEntity user) {
		session.setAttribute(App.SessionDataKey.USER, user);
	}
}
