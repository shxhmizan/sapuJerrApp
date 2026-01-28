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
@NamedQuery(name="UserEntity.findAll", query="SELECT u FROM UserEntity u")
public class UserEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="user_id")
	private int userId;

	@Column(name="account_status")
	private String accountStatus;

	private String email;

	private String name;

	private String password;

	private String phone;

	@Column(name="user_types")
	private String userTypes;

	//bi-directional one-to-one association to DriverEntity
	@OneToOne(mappedBy="user")
	private DriverEntity driver;

	//bi-directional many-to-one association to NotificationEntity
	@OneToMany(mappedBy="user")
	private List<NotificationEntity> notifications;

	//bi-directional many-to-one association to ReviewEntity
	@OneToMany(mappedBy="user")
	private List<ReviewEntity> reviews;

	//bi-directional one-to-one association to StudentEntity
	@OneToOne(mappedBy="user")
	private StudentEntity student;

	public UserEntity() {
	}

	public int getUserId() {
		return this.userId;
	}

	public void setUserId(int userId) {
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

	public String getUserTypes() {
		return this.userTypes;
	}

	public void setUserTypes(String userTypes) {
		this.userTypes = userTypes;
	}

	public DriverEntity getDriver() {
		return this.driver;
	}

	public void setDriver(DriverEntity driver) {
		this.driver = driver;
	}

	public List<NotificationEntity> getNotifications() {
		return this.notifications;
	}

	public void setNotifications(List<NotificationEntity> notifications) {
		this.notifications = notifications;
	}

	public NotificationEntity addNotification(NotificationEntity notification) {
		getNotifications().add(notification);
		notification.setUser(this);

		return notification;
	}

	public NotificationEntity removeNotification(NotificationEntity notification) {
		getNotifications().remove(notification);
		notification.setUser(null);

		return notification;
	}

	public List<ReviewEntity> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<ReviewEntity> reviews) {
		this.reviews = reviews;
	}

	public ReviewEntity addReview(ReviewEntity review) {
		getReviews().add(review);
		review.setUser(this);

		return review;
	}

	public ReviewEntity removeReview(ReviewEntity review) {
		getReviews().remove(review);
		review.setUser(null);

		return review;
	}

	public StudentEntity getStudent() {
		return this.student;
	}

	public void setStudent(StudentEntity student) {
		this.student = student;
	}

}