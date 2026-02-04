package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.CarDAO;
import model.CarEntity;
import model.DriverEntity;
import model.UserEntity;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

/**
 * Servlet implementation class CarServlet
 */
@WebServlet("/CarServlet")
@MultipartConfig
public class CarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	CarDAO dao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher rd;
		
		FormValidator formValidator = new FormValidator();
		
		String capacityStr = request.getParameter("capacity");
		String model = request.getParameter("model");
		String plateNo = request.getParameter("plate_number");
		String vehicleType = request.getParameter("type");
		
		Part roadTaxDoc = request.getPart("road_tax");
		Part insuranceDoc = request.getPart("insurance");
		Part grantDoc = request.getPart("grant");
		
		Part frontImage = request.getPart("image_front");
		Part leftImage = request.getPart("image_left");
		Part rightImage = request.getPart("image_right");
		Part backImage = request.getPart("image_back");
		
		boolean formValid = formValidator
				.require(capacityStr,"Capacity")
				.require(model,"Car Model")
				.require(plateNo,"Plate Number")
				.require(vehicleType,"Vehicle Type")
				.require(roadTaxDoc,"Road Tax Document")
				.require(frontImage,"Car Front Image")
				.require(leftImage,"Car Overview Image")
				.require(rightImage, "Car Side Image")
				.require(backImage,"Car Rear Image")
				.numericField(capacityStr, "Capacity")
				.validate();
		
		if(!formValid) {
			formValidator.redirectWithErrors(request, response, App.Pages.DriverCarDetail.link);
			return;
		}
		
		Part[] uploads = {grantDoc,insuranceDoc,roadTaxDoc,frontImage,leftImage,rightImage,backImage};
		
		UserEntity user = (UserEntity) request.getSession().getAttribute(App.SessionDataKey.USER);
		DriverEntity driver = null;
		
		//Validate that user has logged in and has driver data
		if(user == null) {
			App.setFlashMessage(request.getSession(), "Your session has expired, please login again");
			response.sendRedirect(App.Pages.Login.link);
			return;
		}
		driver = user.getDriver();
		if(driver == null) {
			App.setFlashMessage(request.getSession(), "Sorry, you are not registered as a driver and cannot register cars.");
			response.sendRedirect(App.Pages.DriverCarDetail.link);
			return;
		}
		
		//Attempt to save the car
		try {
			int capacity = Integer.parseInt(capacityStr);
			CarEntity car = dao.createCar(plateNo, model, capacity, vehicleType, driver);
			
			if(car == null) {
				App.setFlashMessage(request.getSession(), "System failed to register car details, registration aborted.");
				response.sendRedirect(App.Pages.DriverCarDetail.link);
				return;
			}
			
			String uploadRoot = this.getServletContext().getInitParameter("uploadRoot");
			boolean filesSaved = dao.updateCarFiles(uploadRoot,car, grantDoc, insuranceDoc, roadTaxDoc, frontImage, leftImage, rightImage, backImage);
			if(! filesSaved) {
				dao.deleteCar(car);
				App.setFlashMessage(request.getSession(), "System failed to save uploaded files, registration aborted.");
				response.sendRedirect(App.Pages.DriverCarDetail.link);
				return;
			}
			
			String out = "<html><body>"
					+ "<h1>Car Data : </h1><br>"
					+ "Plate No : " + car.getPlateNumber() + "<br>"
					+ "Model : " + car.getModel() + "<br>"
					+ "Capacity : " + car.getCapacity() + "<br>"
					+ "Type : " + car.getVehicleType() + "<br>"
					+ "Road Tax : <a href=\"" + car.getRoadtaxDoc() + "\">View</a><br>"
					+ "Insurance : <a href=\"" + car.getInsuranceDoc() + "\">View</a><br>"
					+ "Grant : <a href=\"" + car.getGrantDoc() + "\">View</a><br>"
					+ "Front Image : <img src=\"" + car.getImageFront() + "\"><br>"
					+ "Left Image : <img src=\"" + car.getImageLeft() + "\"><br>"
					+ "Right Image : <img src=\"" + car.getImageRight() + "\"><br>"
					+ "Back Image : <img src=\"" + car.getImageBack() + "\"><br>"
					+ "</body></html>";
			
			response.getWriter().println(out);
			response.getWriter().close();
		}
		catch(Exception e) {
			System.out.print(e);
			App.setFlashMessage(request.getSession(), "System exception while registering car.");
			response.sendRedirect(App.Pages.DriverCarDetail.link);
			return;
		}
		
	}

}
