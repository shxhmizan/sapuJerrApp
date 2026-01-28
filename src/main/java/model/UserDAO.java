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
	/**
	 * Entity manager for managing and performing operations on database entities
	 */
	@PersistenceContext
	private EntityManager em;
	
	@Transactional
	public UserEntity registerUser(String name, String password, String email, String phone,String type) {
		try {
			UserEntity user = new UserEntity();
			user.setName(name);
			user.setPassword(password);
			user.setEmail(email);
			user.setPhone(phone);
			user.setAccountStatus("Active");
			user.setUserTypes(type);
			em.persist(user);
			return user;
		}
		catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
