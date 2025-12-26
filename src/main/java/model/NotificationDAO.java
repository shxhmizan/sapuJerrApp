package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the notification database table.
 * 
 */
@Entity
@Table(name="notification")
@NamedQuery(name="NotificationDAO.findAll", query="SELECT n FROM NotificationDAO n")
public class NotificationDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="notification_id")
	private int notificationId;

	@Lob
	private String message;

	//bi-directional many-to-one association to BookingDAO
	@ManyToOne
	@JoinColumn(name="booking_id")
	private BookingDAO booking;

	//bi-directional many-to-one association to UserDAO
	@ManyToOne
	@JoinColumn(name="user_id")
	private UserDAO user;

	public NotificationDAO() {
	}

	public int getNotificationId() {
		return this.notificationId;
	}

	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public BookingDAO getBooking() {
		return this.booking;
	}

	public void setBooking(BookingDAO booking) {
		this.booking = booking;
	}

	public UserDAO getUser() {
		return this.user;
	}

	public void setUser(UserDAO user) {
		this.user = user;
	}

}