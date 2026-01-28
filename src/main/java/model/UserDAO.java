package model;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;
import model.UserEntity;

@Stateless
public class UserDAO {
	@PersistenceContext
	private EntityManager em;
	
	private List<UserEntity> getUsers(){
		return em.createNamedQuery("User.findAll", UserEntity.class).getResultList();
	}
	
	@Transactional
	public boolean registerUser(String name, String password, String email, String phone) {
		try {
			UserEntity user = new UserEntity();
			user.setName(name);
			user.setPassword(password);
			user.setEmail(email);
			user.setPhone(phone);
			user.setAccountStatus("Active");
			user.setUserTypes("S");
			em.persist(user);
			return true;
		}
		catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
	
	public boolean test() {
		Query q = em.createQuery("SELECT u FROM UserEntity u");
		q.getResultList();
		return true;
	}
}
