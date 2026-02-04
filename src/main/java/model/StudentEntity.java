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
@NamedQuery(name="StudentEntity.findAll", query="SELECT s FROM StudentEntity s")
public class StudentEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="student_id")
	private int studentId;

	@Column(name="faculty")
	private String faculty;

	@Column(name="matric_number")
	private String matricNumber;

	//bi-directional many-to-one association to BookingEntity
	@OneToMany(mappedBy="student")
	private List<BookingEntity> bookings;

	//bi-directional one-to-one association to UserEntity
	@OneToOne
	@JoinColumn(name="student_id")
	private UserEntity user;

	public StudentEntity() {
	}

	public int getStudentId() {
		return this.studentId;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public String getFaculty() {
		return this.faculty;
	}

	public void setFaculty(String faculty) {
		this.faculty = faculty;
	}

	public String getMatricNumber() {
		return this.matricNumber;
	}

	public void setMatricNumber(String matricNumber) {
		this.matricNumber = matricNumber;
	}

	public List<BookingEntity> getBookings() {
		return this.bookings;
	}

	public void setBookings(List<BookingEntity> bookings) {
		this.bookings = bookings;
	}

	public BookingEntity addBooking(BookingEntity booking) {
		getBookings().add(booking);
		booking.setStudent(this);

		return booking;
	}

	public BookingEntity removeBooking(BookingEntity booking) {
		getBookings().remove(booking);
		booking.setStudent(null);

		return booking;
	}

	public UserEntity getUser() {
		return this.user;
	}

	public void setUser(UserEntity user) {
		this.user = user;
	}

}