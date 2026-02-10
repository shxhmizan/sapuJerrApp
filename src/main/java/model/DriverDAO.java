package model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
public class DriverDAO {
	@PersistenceContext
	private EntityManager em;
	
	public DriverEntity getDriverData(UserEntity user) {
		return em.find(DriverEntity.class, user.getUserId());
	}
	
	public DriverEntity registerDriver(UserEntity user, String licenseNo) {
		try {
			DriverEntity driver = new DriverEntity();
			//driver.setUser(user);
			driver.setDriverId(user.getUserId());
			driver.setLicenceNumber(licenseNo);
			driver.setRatingAverage(new BigDecimal(0));
			driver.setUsername(user.getName());
			driver.setStatusVerified( (byte) 0);
			em.persist(driver);
			return driver;
		}
		catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
	
	public List<Integer> getDriverStats(DriverEntity d){
		ArrayList<Integer> stats = new ArrayList<>();
		DriverEntity driver = em.find(DriverEntity.class, d.getDriverId());
		int bookingCompleted = 0;
		int bookingAvailable = 0;
		int bookingAccepted = 0;
		
		for(BookingEntity booking : driver.getBookings()){
			switch(booking.getStatus()) {
				case BookingEntity.BookingStatus.ACCEPTED: bookingAccepted++; break;
				case BookingEntity.BookingStatus.COMPLETED: bookingCompleted++; break;
				default: break;
			}
		}
		
		
		
		TypedQuery<BookingEntity> query = em.createQuery("SELECT b FROM BookingEntity b WHERE b.statusBooking = ?1 AND b.driver IS NULL", BookingEntity.class);
		for(BookingEntity booking : query.getResultList()){
			if(booking.getStatus().equals(BookingEntity.BookingStatus.UPCOMING)) bookingAvailable++;
		}
		
		stats.add(bookingCompleted);
		stats.add(bookingAccepted);
		stats.add(bookingAvailable);
		
		return stats;
		
	}
	
	public boolean updateDriver(DriverEntity d,String licenseNo) {
		try {
			DriverEntity driver = em.find(DriverEntity.class, d.getDriverId());
			driver.setLicenceNumber(licenseNo);
			em.persist(driver);
			return true;
		}
		catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
}
