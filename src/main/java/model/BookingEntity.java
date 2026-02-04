package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.sql.Time;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the booking database table.
 * 
 */
@Entity
@Table(name="booking")
@NamedQuery(name="BookingEntity.findAll", query="SELECT b FROM BookingEntity b")
public class BookingEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public static final String BOOKING_PENDING = "PENDING";
	public static final String BOOKING_CANCELLED = "CANCEL";
	public static final String BOOKING_ACCEPTED = "ACCEPTED";

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="booking_id")
	private int bookingId;

	@Temporal(TemporalType.DATE)
	@Column(name="booking_date")
	private Date bookingDate;

	@Column(name="distance")
	private BigDecimal distance;

	@Column(name="dropoff_location")
	private String dropoffLocation;

	@Column(name="pickup_location")
	private String pickupLocation;

	@Column(name="pickup_time")
	private Time pickupTime;

	@Column(name="price")
	private BigDecimal price;

	@Enumerated(EnumType.STRING)
	@Column(name="status_booking")
	private BookingStatus statusBooking;
	
	public static enum BookingStatus {
		UPCOMING,
		COMPLETED;
	}

	//bi-directional many-to-one association to DriverEntity
	@ManyToOne
	@JoinColumn(name="driver_id")
	private DriverEntity driver;

	//bi-directional one-to-one association to PricingRateEntity
	@OneToOne
	@JoinColumn(name="rate_id")
	private PricingRateEntity pricingRate;

	//bi-directional one-to-one association to StudentEntity
	@OneToOne
	@JoinColumn(name="student_id")
	private StudentEntity student;

	//bi-directional many-to-one association to NotificationEntity
	@OneToMany(mappedBy="booking")
	private List<NotificationEntity> notifications;

	//bi-directional many-to-one association to PaymentEntity
	@OneToMany(mappedBy="booking")
	private List<PaymentEntity> payments;

	//bi-directional many-to-one association to ReviewEntity
	@OneToMany(mappedBy="booking")
	private List<ReviewEntity> reviews;

	public BookingEntity() {
	}

	public int getBookingId() {
		return this.bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public Date getBookingDate() {
		return this.bookingDate;
	}

	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}

	public BigDecimal getDistance() {
		return this.distance;
	}

	public void setDistance(BigDecimal distance) {
		this.distance = distance;
	}

	public String getDropoffLocation() {
		return this.dropoffLocation;
	}

	public void setDropoffLocation(String dropoffLocation) {
		this.dropoffLocation = dropoffLocation;
	}

	public String getPickupLocation() {
		return this.pickupLocation;
	}

	public void setPickupLocation(String pickupLocation) {
		this.pickupLocation = pickupLocation;
	}

	public Time getPickupTime() {
		return this.pickupTime;
	}

	public void setPickupTime(Time pickupTime) {
		this.pickupTime = pickupTime;
	}

	public BigDecimal getPrice() {
		return this.price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BookingStatus getStatus() {
		return this.statusBooking;
	}

	public void setStatus(BookingStatus statusBooking) {
		this.statusBooking = statusBooking;
	}

	public DriverEntity getDriver() {
		return this.driver;
	}

	public void setDriver(DriverEntity driver) {
		this.driver = driver;
	}

	public PricingRateEntity getPricingRate() {
		return this.pricingRate;
	}

	public void setPricingRate(PricingRateEntity pricingRate) {
		this.pricingRate = pricingRate;
	}

	public StudentEntity getStudent() {
		return this.student;
	}

	public void setStudent(StudentEntity student) {
		this.student = student;
	}

	public List<NotificationEntity> getNotifications() {
		return this.notifications;
	}

	public void setNotifications(List<NotificationEntity> notifications) {
		this.notifications = notifications;
	}

	public NotificationEntity addNotification(NotificationEntity notification) {
		getNotifications().add(notification);
		notification.setBooking(this);

		return notification;
	}

	public NotificationEntity removeNotification(NotificationEntity notification) {
		getNotifications().remove(notification);
		notification.setBooking(null);

		return notification;
	}

	public List<PaymentEntity> getPayments() {
		return this.payments;
	}

	public void setPayments(List<PaymentEntity> payments) {
		this.payments = payments;
	}

	public PaymentEntity addPayment(PaymentEntity payment) {
		getPayments().add(payment);
		payment.setBooking(this);

		return payment;
	}

	public PaymentEntity removePayment(PaymentEntity payment) {
		getPayments().remove(payment);
		payment.setBooking(null);

		return payment;
	}

	public List<ReviewEntity> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<ReviewEntity> reviews) {
		this.reviews = reviews;
	}

	public ReviewEntity addReview(ReviewEntity review) {
		getReviews().add(review);
		review.setBooking(this);

		return review;
	}

	public ReviewEntity removeReview(ReviewEntity review) {
		getReviews().remove(review);
		review.setBooking(null);

		return review;
	}

}