package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the payment database table.
 * 
 */
@Entity
@Table(name="payment")
@NamedQuery(name="PaymentEntity.findAll", query="SELECT p FROM PaymentEntity p")
public class PaymentEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="payment_id")
	private int paymentId;

	@Column(name="amount_paid")
	private BigDecimal amountPaid;

	private String method;

	@Column(name="payment_status")
	private String paymentStatus;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="transaction_date")
	private Date transactionDate;

	//bi-directional many-to-one association to BookingEntity
	@ManyToOne
	@JoinColumn(name="booking_id")
	private BookingEntity booking;

	//bi-directional many-to-one association to SubscriptionEntity
	@ManyToOne
	@JoinColumn(name="subs_id")
	private SubscriptionEntity subscription;

	public PaymentEntity() {
	}

	public int getPaymentId() {
		return this.paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public BigDecimal getAmountPaid() {
		return this.amountPaid;
	}

	public void setAmountPaid(BigDecimal amountPaid) {
		this.amountPaid = amountPaid;
	}

	public String getMethod() {
		return this.method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getPaymentStatus() {
		return this.paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public Date getTransactionDate() {
		return this.transactionDate;
	}

	public void setTransactionDate(Date transactionDate) {
		this.transactionDate = transactionDate;
	}

	public BookingEntity getBooking() {
		return this.booking;
	}

	public void setBooking(BookingEntity booking) {
		this.booking = booking;
	}

	public SubscriptionEntity getSubscription() {
		return this.subscription;
	}

	public void setSubscription(SubscriptionEntity subscription) {
		this.subscription = subscription;
	}

}