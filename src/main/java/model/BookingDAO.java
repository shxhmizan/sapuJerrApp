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
			return booking;
		}
		catch(Exception e) {
			System.out.print(e);
			return null;
		}
	}
	
	public List<BookingEntity> getUserBookings(UserEntity user){
		try {
			List<BookingEntity> bookings;
			
			if(user.getUserType().equals(UserEntity.UserType.student)){
				TypedQuery<BookingEntity> query = em.createQuery("SELECT b FROM BookingEntity b JOIN b.student s WHERE s.studentId = ?1", BookingEntity.class);
				query.setParameter(1, user.getUserId());
				return query.getResultList();
			}
			else {
				bookings = em.find(DriverEntity.class, user.getUserId()).getBookings();
			}
			System.out.println("No.of bookings : " + bookings.size());
			return bookings;
		}
		catch(Error e) {
			System.out.println("Error retrieving bookings");
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
