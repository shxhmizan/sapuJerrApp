package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.List;


/**
 * The persistent class for the driver database table.
 * 
 */
@Entity
@Table(name="driver")
@NamedQuery(name="DriverDAO.findAll", query="SELECT d FROM DriverDAO d")
public class DriverDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="driver_id")
	private int driverId;

	@Column(name="licence_number")
	private String licenceNumber;

	@Column(name="rating_average")
	private BigDecimal ratingAverage;

	@Column(name="status_verified")
	private byte statusVerified;

	private String username;

	//bi-directional many-to-one association to BookingDAO
	@OneToMany(mappedBy="driver")
	private List<BookingDAO> bookings;

	//bi-directional many-to-one association to CarDAO
	@OneToMany(mappedBy="driver")
	private List<CarDAO> cars;

	//bi-directional one-to-one association to UserDAO
	@OneToOne
	@JoinColumn(name="driver_id")
	private UserDAO user;

	//bi-directional many-to-one association to ReviewDAO
	@OneToMany(mappedBy="driver")
	private List<ReviewDAO> reviews;

	//bi-directional many-to-one association to SubscriptionDAO
	@OneToMany(mappedBy="driver")
	private List<SubscriptionDAO> subscriptions;

	public DriverDAO() {
	}

	public int getDriverId() {
		return this.driverId;
	}

	public void setDriverId(int driverId) {
		this.driverId = driverId;
	}

	public String getLicenceNumber() {
		return this.licenceNumber;
	}

	public void setLicenceNumber(String licenceNumber) {
		this.licenceNumber = licenceNumber;
	}

	public BigDecimal getRatingAverage() {
		return this.ratingAverage;
	}

	public void setRatingAverage(BigDecimal ratingAverage) {
		this.ratingAverage = ratingAverage;
	}

	public byte getStatusVerified() {
		return this.statusVerified;
	}

	public void setStatusVerified(byte statusVerified) {
		this.statusVerified = statusVerified;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<BookingDAO> getBookings() {
		return this.bookings;
	}

	public void setBookings(List<BookingDAO> bookings) {
		this.bookings = bookings;
	}

	public BookingDAO addBooking(BookingDAO booking) {
		getBookings().add(booking);
		booking.setDriver(this);

		return booking;
	}

	public BookingDAO removeBooking(BookingDAO booking) {
		getBookings().remove(booking);
		booking.setDriver(null);

		return booking;
	}

	public List<CarDAO> getCars() {
		return this.cars;
	}

	public void setCars(List<CarDAO> cars) {
		this.cars = cars;
	}

	public CarDAO addCar(CarDAO car) {
		getCars().add(car);
		car.setDriver(this);

		return car;
	}

	public CarDAO removeCar(CarDAO car) {
		getCars().remove(car);
		car.setDriver(null);

		return car;
	}

	public UserDAO getUser() {
		return this.user;
	}

	public void setUser(UserDAO user) {
		this.user = user;
	}

	public List<ReviewDAO> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<ReviewDAO> reviews) {
		this.reviews = reviews;
	}

	public ReviewDAO addReview(ReviewDAO review) {
		getReviews().add(review);
		review.setDriver(this);

		return review;
	}

	public ReviewDAO removeReview(ReviewDAO review) {
		getReviews().remove(review);
		review.setDriver(null);

		return review;
	}

	public List<SubscriptionDAO> getSubscriptions() {
		return this.subscriptions;
	}

	public void setSubscriptions(List<SubscriptionDAO> subscriptions) {
		this.subscriptions = subscriptions;
	}

	public SubscriptionDAO addSubscription(SubscriptionDAO subscription) {
		getSubscriptions().add(subscription);
		subscription.setDriver(this);

		return subscription;
	}

	public SubscriptionDAO removeSubscription(SubscriptionDAO subscription) {
		getSubscriptions().remove(subscription);
		subscription.setDriver(null);

		return subscription;
	}

}