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
@NamedQuery(name="DriverEntity.findAll", query="SELECT d FROM DriverEntity d")
public class DriverEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="driver_id")
	private int driverId;

	@Column(name="licence_number")
	private String licenceNumber;

	@Column(name="rating_average")
	private BigDecimal ratingAverage;

	@Column(name="status_verified")
	private byte statusVerified;

	@Column(name="username")
	private String username;

	//bi-directional many-to-one association to BookingEntity
	@OneToMany(mappedBy="driver")
	private List<BookingEntity> bookings;

	//bi-directional many-to-one association to CarEntity
	@OneToMany(mappedBy="driver")
	private List<CarEntity> cars;

	//bi-directional one-to-one association to UserEntity
	@OneToOne
	@JoinColumn(name="driver_id")
	private UserEntity user;

	//bi-directional many-to-one association to ReviewEntity
	@OneToMany(mappedBy="driver")
	private List<ReviewEntity> reviews;

	//bi-directional many-to-one association to SubscriptionEntity
	@OneToMany(mappedBy="driver")
	private List<SubscriptionEntity> subscriptions;

	public DriverEntity() {
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

	public List<BookingEntity> getBookings() {
		return this.bookings;
	}

	public void setBookings(List<BookingEntity> bookings) {
		this.bookings = bookings;
	}

	public BookingEntity addBooking(BookingEntity booking) {
		getBookings().add(booking);
		booking.setDriver(this);

		return booking;
	}

	public BookingEntity removeBooking(BookingEntity booking) {
		getBookings().remove(booking);
		booking.setDriver(null);

		return booking;
	}

	public List<CarEntity> getCars() {
		return this.cars;
	}

	public void setCars(List<CarEntity> cars) {
		this.cars = cars;
	}

	public CarEntity addCar(CarEntity car) {
		getCars().add(car);
		car.setDriver(this);

		return car;
	}

	public CarEntity removeCar(CarEntity car) {
		getCars().remove(car);
		car.setDriver(null);

		return car;
	}

	public UserEntity getUser() {
		return this.user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

	public List<ReviewEntity> getReviews() {
		return this.reviews;
	}

	public void setReviews(List<ReviewEntity> reviews) {
		this.reviews = reviews;
	}

	public ReviewEntity addReview(ReviewEntity review) {
		getReviews().add(review);
		review.setDriver(this);

		return review;
	}

	public ReviewEntity removeReview(ReviewEntity review) {
		getReviews().remove(review);
		review.setDriver(null);

		return review;
	}

	public List<SubscriptionEntity> getSubscriptions() {
		return this.subscriptions;
	}

	public void setSubscriptions(List<SubscriptionEntity> subscriptions) {
		this.subscriptions = subscriptions;
	}

	public SubscriptionEntity addSubscription(SubscriptionEntity subscription) {
		getSubscriptions().add(subscription);
		subscription.setDriver(this);

		return subscription;
	}

	public SubscriptionEntity removeSubscription(SubscriptionEntity subscription) {
		getSubscriptions().remove(subscription);
		subscription.setDriver(null);

		return subscription;
	}

}