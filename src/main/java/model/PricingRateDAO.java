package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the pricing_rate database table.
 * 
 */
@Entity
@Table(name="pricing_rate")
@NamedQuery(name="PricingRateDAO.findAll", query="SELECT p FROM PricingRateDAO p")
public class PricingRateDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="rate_id")
	private int rateId;

	@Column(name="base_price")
	private BigDecimal basePrice;

	@Temporal(TemporalType.DATE)
	@Column(name="effective_date")
	private Date effectiveDate;

	@Column(name="price_per_km")
	private BigDecimal pricePerKm;

	@Column(name="price_per_min")
	private BigDecimal pricePerMin;

	//bi-directional many-to-one association to BookingDAO
	@OneToMany(mappedBy="pricingRate")
	private List<BookingDAO> bookings;

	public PricingRateDAO() {
	}

	public int getRateId() {
		return this.rateId;
	}

	public void setRateId(int rateId) {
		this.rateId = rateId;
	}

	public BigDecimal getBasePrice() {
		return this.basePrice;
	}

	public void setBasePrice(BigDecimal basePrice) {
		this.basePrice = basePrice;
	}

	public Date getEffectiveDate() {
		return this.effectiveDate;
	}

	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	public BigDecimal getPricePerKm() {
		return this.pricePerKm;
	}

	public void setPricePerKm(BigDecimal pricePerKm) {
		this.pricePerKm = pricePerKm;
	}

	public BigDecimal getPricePerMin() {
		return this.pricePerMin;
	}

	public void setPricePerMin(BigDecimal pricePerMin) {
		this.pricePerMin = pricePerMin;
	}

	public List<BookingDAO> getBookings() {
		return this.bookings;
	}

	public void setBookings(List<BookingDAO> bookings) {
		this.bookings = bookings;
	}

	public BookingDAO addBooking(BookingDAO booking) {
		getBookings().add(booking);
		booking.setPricingRate(this);

		return booking;
	}

	public BookingDAO removeBooking(BookingDAO booking) {
		getBookings().remove(booking);
		booking.setPricingRate(null);

		return booking;
	}

}