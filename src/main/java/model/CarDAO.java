package model;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.http.Part;

@Stateless
public class CarDAO {
	@PersistenceContext
	EntityManager em;
	
	public CarEntity createCar(String plateNo,String model,int capacity,String type,DriverEntity driverRef) {
		try {
			CarEntity car = new CarEntity();
			car.setPlateNumber(plateNo);
			car.setModel(model);
			car.setCapacity(capacity);
			car.setVehicleType(type);
			//Get the latest driver data from DB before updating
			DriverEntity driver = em.find(DriverEntity.class, driverRef.getDriverId());
			car.setDriver(driver);
			em.persist(car);
			return car;
		}
		catch(Exception ex) {
			System.out.print(ex);
			return null;
		}
	}
	
	public boolean updateCar(CarEntity car) {
		try {
			em.merge(car);
			return true;
		}
		catch(Exception ex) {
			System.out.print(ex);
			return false;
		}
	}
	
	private String saveCarFile(String uploadRoot,CarEntity car,Part part,String name) throws IOException {
		String webPath = "UploadsServlet/cars/" + car.getVehicleId()+ "/" + name + "/" + part.getSubmittedFileName();
		Path uploadDir = Files.createDirectories(Path.of(uploadRoot,"cars","" + car.getVehicleId(),name));
		Path filePath = uploadDir.resolve(part.getSubmittedFileName());
		
		BufferedInputStream inpStream = new BufferedInputStream(part.getInputStream());
		BufferedOutputStream outStream = new BufferedOutputStream(new FileOutputStream(filePath.toFile()));
		
		inpStream.transferTo(outStream);
		inpStream.close();
		outStream.close();
		
		return webPath;
	}
	
	public boolean updateCarFiles(String uploadRoot, CarEntity car, Part grantDoc,Part insuranceDoc, Part roadTaxDoc, Part frontImage, Part leftImage, Part rightImage, Part backImage) {
		try {
			String grantDocPath = saveCarFile(uploadRoot,car,grantDoc,"grant_doc");
			String insuranceDocPath = saveCarFile(uploadRoot,car,insuranceDoc,"insurance_doc");
			String roadTaxDocPath = saveCarFile(uploadRoot,car,roadTaxDoc,"road_tax_doc");
			String frontImagePath = saveCarFile(uploadRoot,car,frontImage,"front_image");
			String leftImagePath = saveCarFile(uploadRoot,car,leftImage,"left_image");
			String rightImagePath = saveCarFile(uploadRoot,car,rightImage,"right_image");
			String backImagePath = saveCarFile(uploadRoot,car,backImage,"back_image");

			car.setGrantDoc(grantDocPath);
			car.setInsuranceDoc(insuranceDocPath);
			car.setRoadtaxDoc(roadTaxDocPath);
			car.setImageFront(frontImagePath);
			car.setImageLeft(leftImagePath);
			car.setImageRight(rightImagePath);
			car.setImageBack(backImagePath);
		
			em.merge(car);
		}
		catch(Exception e) {
			System.out.print(e);
			return false;
		}
		
		return true;
	}
	
	
	
	public boolean deleteCar(CarEntity car) {
		try {
			em.remove(car);
			return true;
		}
		catch(Exception ex) {
			System.out.print(ex);
			return false;
		}
	}
}
