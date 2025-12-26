package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the review database table.
 * 
 */
@Entity
@Table(name="review")
@NamedQuery(name="ReviewDAO.findAll", query="SELECT r FROM ReviewDAO r")
public class ReviewDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="review_id")
	private int reviewId;

	@Lob
	private String comment;

	private int rating;

	//bi-directional many-to-one association to BookingDAO
	@ManyToOne
	@JoinColumn(name="booking_id")
	private BookingDAO booking;

	//bi-directional many-to-one association to DriverDAO
	@ManyToOne
	@JoinColumn(name="rated_id")
	private DriverDAO driver;

	//bi-directional many-to-one association to UserDAO
	@ManyToOne
	@JoinColumn(name="reviewer_id")
	private UserDAO user;

	public ReviewDAO() {
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

	public BookingDAO getBooking() {
		return this.booking;
	}

	public void setBooking(BookingDAO booking) {
		this.booking = booking;
	}

	public DriverDAO getDriver() {
		return this.driver;
	}

	public void setDriver(DriverDAO driver) {
		this.driver = driver;
	}

	public UserDAO getUser() {
		return this.user;
	}

	public void setUser(UserDAO user) {
		this.user = user;
	}

}