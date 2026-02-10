package model;

import java.util.ArrayList;
import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
public class SubscriptionPackageDAO {
	@PersistenceContext
	EntityManager em;
	
	public List<SubscriptionPackageEntity> getDriverPackages(DriverEntity d){
		TypedQuery<SubscriptionPackageEntity> query = em.createQuery("SELECT p FROM DriverEntity d JOIN d.subscriptions s JOIN s.subcriptionPackage p WHERE d.driverId = ?1",SubscriptionPackageEntity.class);
		query.setParameter(1, d.getDriverId());
		return query.getResultList();
	}
	
	public List<SubscriptionPackageEntity> getUnsubbedPackages(DriverEntity d){
		TypedQuery<SubscriptionPackageEntity> query = em.createQuery("SELECT p FROM SubscriptionPackageEntity p WHERE p.packageId NOT IN (SELECT s.subcriptionPackage.packageId FROM SubscriptionEntity s WHERE s.driver.driverId = ?1) ",SubscriptionPackageEntity.class);
		query.setParameter(1,d.getDriverId());
		List<SubscriptionPackageEntity> result = query.getResultList();
		if(result.size() == 0) {
			query = em.createQuery("SELECT p FROM SubscriptionPackageEntity p",SubscriptionPackageEntity.class);
			result = query.getResultList();
		}
		return result;
	}
	
	public SubscriptionPackageEntity getPackageById(int id) {
		return em.find(SubscriptionPackageEntity.class, id);
	}
}
