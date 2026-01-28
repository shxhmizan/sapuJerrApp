package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the notification database table.
 * 
 */
@Entity
@Table(name="notification")
@NamedQuery(name="NotificationEntity.findAll", query="SELECT n FROM NotificationEntity n")
public class NotificationEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="notification_id")
	private int notificationId;

	@Lob
	private String message;

	//bi-directional many-to-one association to BookingEntity
	@ManyToOne
	@JoinColumn(name="booking_id")
	private BookingEntity booking;

	//bi-directional many-to-one association to UserEntity
	@ManyToOne
	@JoinColumn(name="user_id")
	private UserEntity user;

	public NotificationEntity() {
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

	public BookingEntity getBooking() {
		return this.booking;
	}

	public void setBooking(BookingEntity booking) {
		this.booking = booking;
	}

	public UserEntity getUser() {
		return this.user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

}