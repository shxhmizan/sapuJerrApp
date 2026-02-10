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
@NamedQuery(name="SubscriptionEntity.findAll", query="SELECT s FROM SubscriptionEntity s")
public class SubscriptionEntity implements Serializable {
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

	//bi-directional many-to-one association to DriverEntity
	@ManyToOne
	@JoinColumn(name="driver_id")
	private DriverEntity driver;

	//bi-directional many-to-one association to SubscriptionPackageEntity
	@ManyToOne
	@JoinColumn(name="package_id")
	private SubscriptionPackageEntity subcriptionPackage;

	public SubscriptionEntity() {
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

	public DriverEntity getDriver() {
		return this.driver;
	}

	public void setDriver(DriverEntity driver) {
		this.driver = driver;
	}

	public SubscriptionPackageEntity getSubcriptionPackage() {
		return this.subcriptionPackage;
	}

	public void setSubcriptionPackage(SubscriptionPackageEntity subcriptionPackage) {
		this.subcriptionPackage = subcriptionPackage;
	}

}