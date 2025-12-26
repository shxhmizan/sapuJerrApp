package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the student database table.
 * 
 */
@Entity
@Table(name="student")
@NamedQuery(name="StudentDAO.findAll", query="SELECT s FROM StudentDAO s")
public class StudentDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="student_id")
	private String studentId;

	private String faculty;

	//bi-directional many-to-one association to BookingDAO
	@OneToMany(mappedBy="student")
	private List<BookingDAO> bookings;

	//bi-directional one-to-one association to UserDAO
	@OneToOne
	@JoinColumn(name="student_id")
	private UserDAO user;

	public StudentDAO() {
	}

	public String getStudentId() {
		return this.studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getFaculty() {
		return this.faculty;
	}

	public void setFaculty(String faculty) {
		this.faculty = faculty;
	}

	public List<BookingDAO> getBookings() {
		return this.bookings;
	}

	public void setBookings(List<BookingDAO> bookings) {
		this.bookings = bookings;
	}

	public BookingDAO addBooking(BookingDAO booking) {
		getBookings().add(booking);
		booking.setStudent(this);

		return booking;
	}

	public BookingDAO removeBooking(BookingDAO booking) {
		getBookings().remove(booking);
		booking.setStudent(null);

		return booking;
	}

	public UserDAO getUser() {
		return this.user;
	}

	public void setUser(UserDAO user) {
		this.user = user;
	}

}