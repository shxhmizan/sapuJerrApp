/**
 * 
 */
/** * @type {HTMLInputElement} */
const driverTypeField = document.getElementById("rad_type_driver");
/** * @type {HTMLInputElement} */
const studentTypeField = document.getElementById("rad_type_student");

/**
 * @param {Event} e
 */
function updateFieldVisibilities(e){
	const driverFieldGroups = document.querySelectorAll("div.driver-field");
	const driverFields = document.querySelectorAll("input.driver-field");
				
	const studentFieldGroups = document.querySelectorAll("div.student-field");
	const studentFields = document.querySelectorAll("input.student-field");
				
	var hideDriverFields = (studentTypeField instanceof HTMLInputElement && studentTypeField.checked);
	var hideStudentFields = (driverTypeField instanceof HTMLInputElement && driverTypeField.checked);
	
	driverFieldGroups.forEach((value) =>{
		if(value instanceof HTMLElement) value.style.display = hideDriverFields ? "none" : "flex";
	});
	driverFields.forEach((value) => {
		if(value instanceof HTMLInputElement){
			value.style.display = hideDriverFields ? "none" : "flex";
			value.disabled = hideDriverFields;
		} 
	});
	
	studentFieldGroups.forEach((value) =>{
		if(value instanceof HTMLElement) value.style.display = hideStudentFields ? "none" : "flex";
	});
	studentFields.forEach((value) => {
		if(value instanceof HTMLInputElement){
			value.style.display = hideStudentFields ? "none" : "flex";
			value.disabled = hideStudentFields;
		} 
	});
}

if(driverTypeField instanceof HTMLInputElement) 
	driverTypeField.addEventListener('change' ,updateFieldVisibilities);
if(studentTypeField instanceof HTMLInputElement) 
	studentTypeField.addEventListener('change',updateFieldVisibilities);

updateFieldVisibilities();