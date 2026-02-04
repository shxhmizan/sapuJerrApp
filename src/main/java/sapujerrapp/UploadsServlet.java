package sapujerrapp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.nio.file.Path;

/**
 * Servlet implementation class UploadsServlet
 */
@WebServlet("/UploadsServlet/*")
public class UploadsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uploadRoot = this.getServletContext().getInitParameter("uploadRoot");
		Path filePath = Path.of(uploadRoot,request.getPathInfo());
		
		File file = filePath.toFile();
		BufferedInputStream fileInput = new BufferedInputStream( new FileInputStream(file) );
		fileInput.transferTo(response.getOutputStream());
		fileInput.close();
		response.getOutputStream().close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
