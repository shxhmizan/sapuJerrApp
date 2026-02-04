package model;

import java.math.BigDecimal;
import java.sql.Time;
import java.util.Date;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class BookingDAO {
	@PersistenceContext
	private EntityManager em;
	
	public BookingEntity createBooking(Date bookingDate,String origin,String destination,BigDecimal distance,Time pickupTime,BigDecimal price) {
		try {
			BookingEntity booking = new BookingEntity();
		
			booking.setBookingDate(bookingDate);
			booking.setPickupLocation(origin);
			booking.setDropoffLocation(destination);
			booking.setDistance(distance);
			booking.setPickupTime(pickupTime);
			booking.setPrice(price);
			booking.setStatus(BookingEntity.BookingStatus.UPCOMING);

			em.persist(booking);
			return booking;
		}
		catch(Exception e) {
			System.out.print(e);
			return null;
		}
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
