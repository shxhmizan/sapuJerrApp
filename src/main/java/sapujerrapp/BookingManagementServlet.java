package sapujerrapp;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingDAO;
import model.UserDAO;
import model.UserEntity;

import java.io.IOException;

/**
 * Servlet implementation class BookingManagementServlet
 */
@Stateless
@WebServlet("/BookingManagementServlet")
public class BookingManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	BookingDAO dao;
	
	@EJB
	UserDAO userDao;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookingManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation = request.getParameter("operation");
		String bookingIdStr = request.getParameter("id");
		int bookingId;
		
		if(operation == null || bookingIdStr == null) {
			response.setStatus(400);
			response.getWriter().println("Please provide both a booking id and operation");
			response.getWriter().close();
			return;
		}
		
		bookingId = Integer.parseInt(bookingIdStr);

		UserEntity user = App.getUser(request.getSession(),userDao);
		switch(operation.trim()) {
			case "cancel":
				if(dao.cancelBooking(user, bookingId)) {
					response.setStatus(200);
				}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
