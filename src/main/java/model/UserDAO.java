package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Table(name="users")
@NamedQuery(name="UserDAO.findAll", query="SELECT u FROM UserDAO u")
public class UserDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	public enum UserType{
		STUDENT,
		DRIVER
	};
	
	@Id
	@Column(name="user_id")
	private String userId;

	@Column(name="account_status")
	private String accountStatus;

	private String email;

	private String name;

	private String password;

	private String phone;

	@Column(name="user_types")
	@Enumerated(EnumType.STRING)
	private UserType userTypes;

	//bi-directional one-to-one association to DriverDAO
	@OneToOne(mappedBy="user")
	private DriverDAO driver;

	//bi-directional many-to-one association to NotificationDAO
	@OneToMany(mappedBy="user")
	private List<NotificationDAO> notifications;

	//bi-directional many-to-one association to ReviewDAO
	@OneToMany(mappedBy="user")
	private List<ReviewDAO> reviews;

	//bi-directional one-to-one association to StudentDAO
	@OneToOne(mappedBy="user")
	private StudentDAO student;

	public UserDAO() {
	}

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAccountStatus() {
		return this.accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public UserType getUserTypes() {
		return this.userTypes;
	}

	public void setUserTypes(UserType userType) {
		this.userTypes = userType;
	}

	public DriverDAO getDriver() {
		return this.driver;
	}

	public void setDriver(DriverDAO driver) {
		this.driver = driver;
	}

	public List<NotificationDAO> getNotifications() {
		return this.notifications;
	}

	public void setNotifications(List<NotificationDAO> notifications) {
		this.notifications = notifications;
	}

	public NotificationDAO addNotification(NotificationDAO notification) {
		getNotifications().add(notification);
		notification.setUser(this);

		return notification;
	}

	public NotificationDAO removeNotification(NotificationDAO notification) {
		getNotifications().remove(notification);
		notification.setUser(null);

		return notification;
	}

	public List<ReviewDAO> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<ReviewDAO> reviews) {
		this.reviews = reviews;
	}

	public ReviewDAO addReview(ReviewDAO review) {
		getReviews().add(review);
		review.setUser(this);

		return review;
	}

	public ReviewDAO removeReview(ReviewDAO review) {
		getReviews().remove(review);
		review.setUser(null);

		return review;
	}

	public StudentDAO getStudent() {
		return this.student;
	}

	public void setStudent(StudentDAO student) {
		this.student = student;
	}

}