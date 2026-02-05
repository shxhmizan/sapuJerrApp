package sapujerrapp;

import java.util.ArrayList;
import java.util.List;

import model.BookingEntity;

public class BookingListBean {
	List<BookingEntity> bookings;
	
	public BookingListBean() {
		bookings = new ArrayList<>();
		System.out.println("Booking List Empty!");
	}
	
	public BookingListBean(List<BookingEntity> bookings) {
		this.bookings = bookings;
		System.out.println("Booking List Created!");
	}
	
	public void setBookings(List<BookingEntity> bookings) {
		this.bookings = bookings;
	}
	
	public List<BookingEntity> getBookings() {
		return this.bookings;
	}
}
