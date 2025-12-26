package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the subscription database table.
 * 
 */
@Entity
@Table(name="subscription")
@NamedQuery(name="SubscriptionDAO.findAll", query="SELECT s FROM SubscriptionDAO s")
public class SubscriptionDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="subs_id")
	private int subsId;

	@Temporal(TemporalType.DATE)
	@Column(name="date_end")
	private Date dateEnd;

	@Temporal(TemporalType.DATE)
	@Column(name="date_start")
	private Date dateStart;

	@Column(name="status_sub")
	private String statusSub;

	//bi-directional many-to-one association to PaymentDAO
	@OneToMany(mappedBy="subscription")
	private List<PaymentDAO> payments;

	//bi-directional many-to-one association to DriverDAO
	@ManyToOne
	@JoinColumn(name="driver_id")
	private DriverDAO driver;

	//bi-directional many-to-one association to SubscriptionPackageDAO
	@ManyToOne
	@JoinColumn(name="package_id")
	private SubscriptionPackageDAO subcriptionPackage;

	public SubscriptionDAO() {
	}

	public int getSubsId() {
		return this.subsId;
	}

	public void setSubsId(int subsId) {
		this.subsId = subsId;
	}

	public Date getDateEnd() {
		return this.dateEnd;
	}

	public void setDateEnd(Date dateEnd) {
		this.dateEnd = dateEnd;
	}

	public Date getDateStart() {
		return this.dateStart;
	}

	public void setDateStart(Date dateStart) {
		this.dateStart = dateStart;
	}

	public String getStatusSub() {
		return this.statusSub;
	}

	public void setStatusSub(String statusSub) {
		this.statusSub = statusSub;
	}

	public List<PaymentDAO> getPayments() {
		return this.payments;
	}

	public void setPayments(List<PaymentDAO> payments) {
		this.payments = payments;
	}

	public PaymentDAO addPayment(PaymentDAO payment) {
		getPayments().add(payment);
		payment.setSubscription(this);

		return payment;
	}

	public PaymentDAO removePayment(PaymentDAO payment) {
		getPayments().remove(payment);
		payment.setSubscription(null);

		return payment;
	}

	public DriverDAO getDriver() {
		return this.driver;
	}

	public void setDriver(DriverDAO driver) {
		this.driver = driver;
	}

	public SubscriptionPackageDAO getSubcriptionPackage() {
		return this.subcriptionPackage;
	}

	public void setSubcriptionPackage(SubscriptionPackageDAO subcriptionPackage) {
		this.subcriptionPackage = subcriptionPackage;
	}

}