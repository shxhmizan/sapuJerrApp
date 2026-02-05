package model;

import java.math.BigDecimal;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

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
