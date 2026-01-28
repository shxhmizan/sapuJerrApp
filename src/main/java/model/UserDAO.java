package model;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;
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
	
	public UserEntity loginUser(String name, String password) {
		TypedQuery<UserEntity> query = em.createQuery("SELECT u "
					+ "FROM UserEntity u "
					+ "WHERE u.name LIKE ?1 "
					+ "AND u.password LIKE ?2", 
					UserEntity.class);
		query.setParameter(1, name);
		query.setParameter(2, password);
		
		try {
			return query.getSingleResult();
		}
		catch(NoResultException ne) {
			System.out.println("User not found");
			return null;
		}
		catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
}
