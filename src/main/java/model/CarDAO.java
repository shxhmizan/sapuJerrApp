package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the car database table.
 * 
 */
@Entity
@Table(name="car")
@NamedQuery(name="CarDAO.findAll", query="SELECT c FROM CarDAO c")
public class CarDAO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="vehicle_id")
	private int vehicleId;

	private int capacity;

	@Column(name="grant_doc")
	private String grantDoc;

	@Column(name="image_back")
	private String imageBack;

	@Column(name="image_front")
	private String imageFront;

	@Column(name="image_left")
	private String imageLeft;

	@Column(name="image_right")
	private String imageRight;

	@Column(name="insurance_doc")
	private String insuranceDoc;

	private String model;

	@Column(name="plate_number")
	private String plateNumber;

	@Column(name="roadtax_doc")
	private String roadtaxDoc;

	@Column(name="vehicle_type")
	private String vehicleType;

	//bi-directional many-to-one association to DriverDAO
	@ManyToOne
	@JoinColumn(name="driver_id")
	private DriverDAO driver;

	public CarDAO() {
	}

	public int getVehicleId() {
		return this.vehicleId;
	}

	public void setVehicleId(int vehicleId) {
		this.vehicleId = vehicleId;
	}

	public int getCapacity() {
		return this.capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getGrantDoc() {
		return this.grantDoc;
	}

	public void setGrantDoc(String grantDoc) {
		this.grantDoc = grantDoc;
	}

	public String getImageBack() {
		return this.imageBack;
	}

	public void setImageBack(String imageBack) {
		this.imageBack = imageBack;
	}

	public String getImageFront() {
		return this.imageFront;
	}

	public void setImageFront(String imageFront) {
		this.imageFront = imageFront;
	}

	public String getImageLeft() {
		return this.imageLeft;
	}

	public void setImageLeft(String imageLeft) {
		this.imageLeft = imageLeft;
	}

	public String getImageRight() {
		return this.imageRight;
	}

	public void setImageRight(String imageRight) {
		this.imageRight = imageRight;
	}

	public String getInsuranceDoc() {
		return this.insuranceDoc;
	}

	public void setInsuranceDoc(String insuranceDoc) {
		this.insuranceDoc = insuranceDoc;
	}

	public String getModel() {
		return this.model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getPlateNumber() {
		return this.plateNumber;
	}

	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
	}

	public String getRoadtaxDoc() {
		return this.roadtaxDoc;
	}

	public void setRoadtaxDoc(String roadtaxDoc) {
		this.roadtaxDoc = roadtaxDoc;
	}

	public String getVehicleType() {
		return this.vehicleType;
	}

	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}

	public DriverDAO getDriver() {
		return this.driver;
	}

	public void setDriver(DriverDAO driver) {
		this.driver = driver;
	}

}