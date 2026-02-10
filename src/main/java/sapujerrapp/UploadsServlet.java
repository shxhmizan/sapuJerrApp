package sapujerrapp;

import jakarta.servlet.ServletContext;
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
    
    public static String getUploadRoot(ServletContext context) {
    	String uploadRoot = System.getenv(App.EnvironmentVarKey.FILE_UPLOAD_ROOT_PATH);
		if(uploadRoot == null) {
			System.out.println("[SapuJerrApp] INFO: File upload path not found in system environment variables. Using defaults in context.xml");
			uploadRoot = context.getInitParameter("uploadRoot");
			if(uploadRoot == null) System.out.println("[SapuJerrApp] WARNING: Could not find default file upload path in context.xml , it is set to null.");
		}
		return uploadRoot;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String uploadRoot = getUploadRoot(this.getServletContext());
			//else System.out.println("[SapuJerrApp] INFO: using file upload path defined in system environment variables." + uploadRoot.substring(0,3) + "***");
			Path filePath = Path.of(uploadRoot,request.getPathInfo());
			
			File file = filePath.toFile();
			if(file.exists()) {
				BufferedInputStream fileInput = new BufferedInputStream( new FileInputStream(file) );
				fileInput.transferTo(response.getOutputStream());
				fileInput.close();
				response.getOutputStream().close();
				return;
			}
		}
		catch(Exception e) {
			System.out.println(e);
			response.sendError(500);
		}
		response.sendError(404);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
