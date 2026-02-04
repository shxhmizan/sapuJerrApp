package sapujerrapp;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

public class FormValidator {
	private boolean valid;
	private ArrayList<String> errorMessages;
	
	/**
	 * Default constructor for FormValidator
	 * The validator is initially in valid state and has no error messages
	 */
	public FormValidator() {
		valid = true;
		errorMessages = new ArrayList<>();
	}
	
	/**
	 * Checks if this form validator is in valid state
	 * @return
	 */
	public boolean validate() {
		return this.valid;
	}
	
	/**
	 * Checks if this form validator is not in valid state
	 * @return
	 */
	public boolean isInvalid() {
		return !this.valid;
	}
	
	/**
	 * Gets all error messages of this validator as a list
	 * @return
	 */
	public List<String> getErrorMessages(){
		return this.errorMessages;
	}
	
	/**
	 * Gets all error messages of this validator as a string joined with &lt br &gt elements
	 * @return
	 */
	public String getErrorMessage() {
		return this.getErrorMessage("<br>");
	}
	
	/**
	 * Gets all error messages of this validator as a string joined with the specified delimiter
	 * @return
	 */
	public String getErrorMessage(String delimiter) {
		return String.join(delimiter, this.errorMessages);
	}
	
	/**
	 * Set the validator to an invalid state and append an error message to this validator
	 * @param str The error message
	 */
	public void addErrorMessage(String str) {
		valid = false;
		this.errorMessages.add(str);
	}
	
	/**
	 * Sends a HTTP redirect response to another page with error flash messages using App.setFlashMessage()
	 * @param request The HTTP request that submitted the form
	 * @param response The HTTP response object from the processing HttpServlet
	 * @param destination The URL to the redirect destination page
	 * @throws IOException If an I/O error occurs
	 */
	public void redirectWithErrors(HttpServletRequest request,HttpServletResponse response,String destination) throws IOException {
		App.setFlashMessage(request.getSession(), getErrorMessage());
		response.sendRedirect(destination);
	}
	
	/**
	 * Checks if a required field is not empty and if it is empty, updates validation state to invalid
	 * @param val
	 * @param displayName The name of the field to show in error message
	 * @return
	 */
	public FormValidator require(String val,String displayName) {
		if(val == null || val.trim().length() < 1) {
			valid = false;
			errorMessages.add(displayName + " is required.");
		}
		return this;
	}
	
	/**
	 * Checks if a required file upload field:<br>
	 * <ol>
	 * <li>Has a file uploaded</li>
	 * <li>Has nonzero file size</li>
	 * <li>Has non-empty filename</li>
	 * </ol>
	 * @param part
	 * @param displayName
	 * @return
	 */
	public FormValidator require(Part part,String displayName) {
		if(part == null || part.getSize() < 1L || part.getSubmittedFileName().trim().length() < 1) {
			valid = false;
			errorMessages.add(displayName + " is required to be uploaded and has non-empty file name.");
		}
		return this;
	}
	
	/**
	 * Checks if a field is not empty, without changing validation state
	 * @param val
	 * @return
	 */
	public boolean notEmpty(Object val) {
		return val != null;
	}
	
	/**
	 * Checks if a text input string is within the specified minimum and maximum lengths
	 * @param str The input field
	 * @param displayName The name of the field to show in error message
	 * @param minLength Minimum character length (inclusive)
	 * @param maxLength Maximum character length (inclusive)
	 * @return
	 */
	public FormValidator boundedStrField(String str,String displayName,int minLength,int maxLength) {
		if(require(str,displayName).isInvalid()) return this;
		if(str.length() < minLength || str.length() > maxLength ) {
			valid = false;
			errorMessages.add(displayName + " must be at least " + minLength + " and at most " + maxLength + " characters long.");
		}
		return this;
	}
	
	/**
	 * Checks if an input field has a numeric value
	 * @param str
	 * @param displayName The name of the field to show in error message
	 * @return
	 */
	public FormValidator numericField(String str,String displayName) {
		if(require(str,displayName).isInvalid()) return this;
		try {
			BigDecimal num = new BigDecimal(str);
		}
		catch(NumberFormatException e) {
			valid = false;
			errorMessages.add(displayName + " must be a valid number.");
		}
		return this;
	}
	
	/**
	 * Check if an input field has an integer value
	 * @param str
	 * @param displayName The name of the field to show in error message
	 * @return
	 */
	public FormValidator integerField(String str,String displayName) {
		if(require(str,displayName).isInvalid()) return this;
		try {
			Integer.parseInt(str);
		}
		catch(NumberFormatException e) {
			valid = false;
			errorMessages.add(displayName + " must be an integer.");
		}
		return this;
	}
	
}
