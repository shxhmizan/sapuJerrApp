package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.List;


/**
 * The persistent class for the package database table.
 * 
 */
@Entity
@Table(name="package")
@NamedQuery(name="SubscriptionPackageDAO.findAll", query="SELECT s FROM SubscriptionPackageDAO s")
public class SubscriptionPackageDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="package_id")
	private int packageId;

	@Column(name="duration_days")
	private int durationDays;

	@Column(name="fee_amount")
	private BigDecimal feeAmount;

	@Column(name="package_duration")
	private String packageDuration;

	@Column(name="package_tier")
	private String packageTier;

	//bi-directional many-to-one association to SubscriptionDAO
	@OneToMany(mappedBy="subcriptionPackage")
	private List<SubscriptionDAO> subscriptions;

	public SubscriptionPackageDAO() {
	}

	public int getPackageId() {
		return this.packageId;
	}

	public void setPackageId(int packageId) {
		this.packageId = packageId;
	}

	public int getDurationDays() {
		return this.durationDays;
	}

	public void setDurationDays(int durationDays) {
		this.durationDays = durationDays;
	}

	public BigDecimal getFeeAmount() {
		return this.feeAmount;
	}

	public void setFeeAmount(BigDecimal feeAmount) {
		this.feeAmount = feeAmount;
	}

	public String getPackageDuration() {
		return this.packageDuration;
	}

	public void setPackageDuration(String packageDuration) {
		this.packageDuration = packageDuration;
	}

	public String getPackageTier() {
		return this.packageTier;
	}

	public void setPackageTier(String packageTier) {
		this.packageTier = packageTier;
	}

	public List<SubscriptionDAO> getSubscriptions() {
		return this.subscriptions;
	}

	public void setSubscriptions(List<SubscriptionDAO> subscriptions) {
		this.subscriptions = subscriptions;
	}

	public SubscriptionDAO addSubscription(SubscriptionDAO subscription) {
		getSubscriptions().add(subscription);
		subscription.setSubcriptionPackage(this);

		return subscription;
	}

	public SubscriptionDAO removeSubscription(SubscriptionDAO subscription) {
		getSubscriptions().remove(subscription);
		subscription.setSubcriptionPackage(null);

		return subscription;
	}

}