package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the review database table.
 * 
 */
@Entity
@Table(name="review")
@NamedQuery(name="ReviewEntity.findAll", query="SELECT r FROM ReviewEntity r")
public class ReviewEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="review_id")
	private int reviewId;

	@Lob
	private String comment;

	@Column(name="rating")
	private int rating;

	//bi-directional many-to-one association to BookingEntity
	@ManyToOne
	@JoinColumn(name="booking_id")
	private BookingEntity booking;

	//bi-directional many-to-one association to DriverEntity
	@ManyToOne
	@JoinColumn(name="rated_id")
	private DriverEntity driver;

	//bi-directional many-to-one association to UserEntity
	@ManyToOne
	@JoinColumn(name="reviewer_id")
	private UserEntity user;

	public ReviewEntity() {
	}

	public int getReviewId() {
		return this.reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public String getComment() {
		return this.comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getRating() {
		return this.rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public BookingEntity getBooking() {
		return this.booking;
	}

	public void setBooking(BookingEntity booking) {
		this.booking = booking;
	}

	public DriverEntity getDriver() {
		return this.driver;
	}

	public void setDriver(DriverEntity driver) {
		this.driver = driver;
	}

	public UserEntity getUser() {
		return this.user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

}