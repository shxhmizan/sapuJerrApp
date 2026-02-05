package model;

import java.math.BigDecimal;
import java.sql.Time;
import java.util.Date;
import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.FetchType;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.ws.rs.core.Response.Status;

@Stateless
public class BookingDAO {
	@PersistenceContext
	private EntityManager em;
	
	public BookingEntity createBooking(StudentEntity student,Date bookingDate,String origin,String destination,BigDecimal distance,Time pickupTime,BigDecimal price) {
		try {
			BookingEntity booking = new BookingEntity();
			
			booking.setStudent(em.find(StudentEntity.class, student.getStudentId()));
			booking.setBookingDate(bookingDate);
			booking.setPickupLocation(origin);
			booking.setDropoffLocation(destination);
			booking.setDistance(distance);
			booking.setPickupTime(pickupTime);
			booking.setPrice(price);
			booking.setStatus(BookingEntity.BookingStatus.UPCOMING);

			em.persist(booking);
			
			notifyAllDriversNewBooking(booking);
			
			return booking;
		}
		catch(Exception e) {
			System.out.print(e);
			return null;
		}
	}
	
	private void notifyAllDriversNewBooking(BookingEntity booking) {
		try {
			TypedQuery<UserEntity> query = em.createQuery("SELECT u FROM UserEntity u WHERE u.userType = ?1", UserEntity.class);
			query.setParameter(1, UserEntity.UserType.driver);
			query.getResultStream().forEach((UserEntity driver) -> {
				NotificationEntity noti = new NotificationEntity();
				
				noti.setUser(driver);
				noti.setBooking(booking);
				noti.setMessage("New booking " + booking.getBookingId());
				
				em.persist(noti);
			});
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}
	
	public List<BookingEntity> getUserBookings(UserEntity user){
		try {
			List<BookingEntity> bookings;
			TypedQuery<BookingEntity> query;
			if(user.getUserType().equals(UserEntity.UserType.student)){
				query = em.createQuery("SELECT b FROM BookingEntity b JOIN b.student s WHERE s.studentId = ?1", BookingEntity.class);
				query.setParameter(1, user.getUserId());
			}
			else {
				query = em.createQuery("SELECT b FROM BookingEntity b JOIN b.driver d WHERE d.driverId = ?1", BookingEntity.class);
				query.setParameter(1, user.getUserId());
			}
			bookings = query.getResultList();
			bookings.forEach((BookingEntity b) -> {
				b.getDriver();
				if(b.getDriver() != null)
					b.getDriver().getUser();
			});
			return bookings;
		}
		catch(Error e) {
			System.out.println("Error retrieving bookings");
			return null;
		}
	}
	
	public List<BookingEntity> getUserBookingsWithStatus(UserEntity user,BookingEntity.BookingStatus... status){
		try {
			List<BookingEntity> bookings;
			TypedQuery<BookingEntity> query; 
			if(user.getUserType().equals(UserEntity.UserType.student)){
				query = em.createQuery("SELECT b FROM BookingEntity b JOIN b.student s WHERE s.studentId = ?1 AND b.statusBooking IN (?2)", BookingEntity.class);
				query.setParameter(1, user.getUserId());
				query.setParameter(2, List.of(status));
			}
			else {
				query = em.createQuery("SELECT b FROM BookingEntity b JOIN b.driver d WHERE d.driverId = ?1 AND b.statusBooking IN (?2)", BookingEntity.class);
				query.setParameter(1, user.getUserId());
				query.setParameter(2, List.of(status));
			}
			bookings = query.getResultList();
			bookings.forEach((BookingEntity b) -> {
				b.getDriver();
			});
			return bookings;
		}
		catch(Error e) {
			System.out.println("Error retrieving bookings");
			return null;
		}
	}
	
	public boolean cancelBooking(UserEntity user, int bookingId) {
		BookingEntity booking = em.find(BookingEntity.class, bookingId);
		if(booking != null) {
			if(booking.getStudent().getStudentId() == user.getUserId()) {
				booking.setStatus(BookingEntity.BookingStatus.CANCELLED);
				
				em.persist(booking);
				
				if(booking.getDriver() != null) {
					NotificationEntity noti = new NotificationEntity();
					noti.setBooking(booking);
					noti.setUser(booking.getDriver().getUser());
					noti.setMessage("Passenger <strong>" + user.getName() + "</strong> cancelled the trip to <strong>" + booking.getDropoffLocation() + "</scrong>");
					em.persist(noti);
				}
				
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 
	 * @param user
	 * @param bookingId
	 * @return 0 if success, -1 if no booking, -2 if booking already accepted, -3 if user not a driver 
	 */
	public int acceptBooking(UserEntity user, int bookingId) {
		BookingEntity booking = em.find(BookingEntity.class, bookingId);
		if(booking != null) {
			if(user.getUserType().equals(UserEntity.UserType.driver) && user.getDriver() != null && booking.getDriver() == null) {
				booking.setStatus(BookingEntity.BookingStatus.ACCEPTED);
				booking.setDriver(em.find(DriverEntity.class, user.getUserId()));
				em.persist(booking);
				return 0;
			}
			else if(booking.getDriver() != null || booking.getStatus() == BookingEntity.BookingStatus.ACCEPTED) {
				return -2;
			}
			else if( ! user.getUserType().equals(UserEntity.UserType.driver)) {
				return -3;
			}
		}
		return -1;
	}
	
	public boolean saveBooking(BookingEntity booking) {
		try {
			em.persist(booking);
			return true;
		}
		catch(Exception e) {
			System.out.print(e);
			return false;
		}
	}
	
}
