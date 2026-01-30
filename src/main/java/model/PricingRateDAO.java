package model;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

@Stateless
public class PricingRateDAO {
	@PersistenceContext
	private EntityManager em;
	
	public PricingRateEntity getLatestPrice() {
		try {
			TypedQuery<PricingRateEntity> query = em.createQuery("SELECT p "
					+ "FROM PricingRateEntity p "
					+ "WHERE p.effectiveDate = ("
					+ "SELECT MAX(p.effectiveDate) FROM PricingRateEntity p) "
					+ "ORDER BY p.effectiveDate", PricingRateEntity.class);
			PricingRateEntity pricingRate = (PricingRateEntity) query.getSingleResult();
			return pricingRate;
		}
		catch(Exception e) {
			System.out.println(e);
			return null;
		}
		
	}
}
