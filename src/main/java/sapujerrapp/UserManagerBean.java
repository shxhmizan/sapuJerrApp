package sapujerrapp;

import java.util.List;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import model.UserDAO;

@Stateless
public class UserManagerBean {
	@PersistenceContext
	private EntityManager em;
	
	private List<UserDAO> getUsers(){
		return em.createNamedQuery("User.findAll", UserDAO.class).getResultList();
	}
	
	@Transactional
	public boolean registerUser(String name, String password, String email, String phone) {
		try {
			UserDAO user = new UserDAO();
			user.setName(name);
			user.setPassword(password);
			user.setEmail(email);
			user.setPhone(phone);
			user.setAccountStatus("Active");
			user.setUserTypes(UserDAO.UserType.STUDENT);
			user.setUserId("U" + user.hashCode());
			em.persist(user);
			return true;
		}
		catch(Exception e) {
			System.out.println(e);
			return false;
		}
		

	}
}
