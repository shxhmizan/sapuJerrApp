package model;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class StudentDAO {
	@PersistenceContext
	private EntityManager em;
	
	public StudentEntity getStudentData(UserEntity user) {
		return em.find(StudentEntity.class, user.getUserId());
	}
	
	public StudentEntity registerStudent(UserEntity user, String matricNo, String faculty) {
		try {
			StudentEntity student = new StudentEntity();
			student.setStudentId(user.getUserId());
			student.setMatricNumber(matricNo);
			student.setFaculty(faculty);
			em.persist(student);
			return student;
		}
		catch(Exception e) {
			System.out.println(e);
			return null;
		}
	}
	
	public boolean updateStudent(StudentEntity s,String matricNo, String faculty) {
		try {
			StudentEntity student = em.find(StudentEntity.class, s.getStudentId());
			student.setMatricNumber(matricNo);
			student.setFaculty(faculty);
			em.persist(student);
			return true;
		}
		catch(Exception e) {
			System.out.println(e);
			return false;
		}
	}
}
