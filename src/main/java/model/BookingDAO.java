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
@NamedQuery(name="BookingDAO.findAll", query="SELECT b FROM BookingDAO b")
public class BookingDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="booking_id")
	private int bookingId;

	@Temporal(TemporalType.DATE)
	@Column(name="booking_date")
	private Date bookingDate;

	private BigDecimal distance;

	@Column(name="dropoff_location")
	private String dropoffLocation;

	@Column(name="pickup_location")
	private String pickupLocation;

	@Column(name="pickup_time")
	private Time pickupTime;

	private BigDecimal price;

	@Column(name="status_booking")
	private String statusBooking;

	//bi-directional many-to-one association to DriverDAO
	@ManyToOne
	@JoinColumn(name="driver_id")
	private DriverDAO driver;

	//bi-directional many-to-one association to PricingRateDAO
	@ManyToOne
	@JoinColumn(name="rate_id")
	private PricingRateDAO pricingRate;

	//bi-directional many-to-one association to StudentDAO
	@ManyToOne
	@JoinColumn(name="student_id")
	private StudentDAO student;

	//bi-directional many-to-one association to NotificationDAO
	@OneToMany(mappedBy="booking")
	private List<NotificationDAO> notifications;

	//bi-directional many-to-one association to PaymentDAO
	@OneToMany(mappedBy="booking")
	private List<PaymentDAO> payments;

	//bi-directional many-to-one association to ReviewDAO
	@OneToMany(mappedBy="booking")
	private List<ReviewDAO> reviews;

	public BookingDAO() {
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

	public String getStatusBooking() {
		return this.statusBooking;
	}

	public void setStatusBooking(String statusBooking) {
		this.statusBooking = statusBooking;
	}

	public DriverDAO getDriver() {
		return this.driver;
	}

	public void setDriver(DriverDAO driver) {
		this.driver = driver;
	}

	public PricingRateDAO getPricingRate() {
		return this.pricingRate;
	}

	public void setPricingRate(PricingRateDAO pricingRate) {
		this.pricingRate = pricingRate;
	}

	public StudentDAO getStudent() {
		return this.student;
	}

	public void setStudent(StudentDAO student) {
		this.student = student;
	}

	public List<NotificationDAO> getNotifications() {
		return this.notifications;
	}

	public void setNotifications(List<NotificationDAO> notifications) {
		this.notifications = notifications;
	}

	public NotificationDAO addNotification(NotificationDAO notification) {
		getNotifications().add(notification);
		notification.setBooking(this);

		return notification;
	}

	public NotificationDAO removeNotification(NotificationDAO notification) {
		getNotifications().remove(notification);
		notification.setBooking(null);

		return notification;
	}

	public List<PaymentDAO> getPayments() {
		return this.payments;
	}

	public void setPayments(List<PaymentDAO> payments) {
		this.payments = payments;
	}

	public PaymentDAO addPayment(PaymentDAO payment) {
		getPayments().add(payment);
		payment.setBooking(this);

		return payment;
	}

	public PaymentDAO removePayment(PaymentDAO payment) {
		getPayments().remove(payment);
		payment.setBooking(null);

		return payment;
	}

	public List<ReviewDAO> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<ReviewDAO> reviews) {
		this.reviews = reviews;
	}

	public ReviewDAO addReview(ReviewDAO review) {
		getReviews().add(review);
		review.setBooking(this);

		return review;
	}

	public ReviewDAO removeReview(ReviewDAO review) {
		getReviews().remove(review);
		review.setBooking(null);

		return review;
	}

}