package model;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
public class SubscriptionDAO {
	@PersistenceContext
	EntityManager em;
	
	public List<SubscriptionEntity> getDriverSubscription(DriverEntity driver){
		TypedQuery<SubscriptionEntity> query = em.createQuery("SELECT s FROM SubscriptionEntity s JOIN s.driver d WHERE d.driverId = ?1", SubscriptionEntity.class);
		query.setParameter(1, driver.getDriverId());
		return query.getResultList();
	}
	
	public boolean subscribe(DriverEntity driver, SubscriptionPackageEntity pkg) {
		try {
			List<SubscriptionEntity> subs = this.getDriverSubscription(driver);
			pkg = em.find(SubscriptionPackageEntity.class,pkg.getPackageId());
			SubscriptionEntity sub;
			if(subs.size() < 1) {
				driver = em.find(DriverEntity.class, driver.getDriverId());
				sub = new SubscriptionEntity();
				sub.setDriver(driver);	
			}
			else {
				sub = subs.getFirst();
			}
			sub.setDateStart(new Date());
			sub.setSubcriptionPackage(pkg);
			LocalDate endDate = LocalDate.now().plusDays(pkg.getDurationDays());
			sub.setDateEnd(Date.from(endDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
			sub.setStatusSub("SUBSCRIBED");
			em.persist(sub);
			return true;
		}
		catch(Exception e) {
			System.out.println(e);
			return false;
		}
		
	}
}
