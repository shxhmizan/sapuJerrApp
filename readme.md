# 🚖 SapuJerr – E-Hailing Web Application

SapuJerrApp is a **Java-based Dynamic Web Application** built using the **MVC (Model–View–Controller) architecture**.  
The system simulates an e-hailing platform where users can request rides and manage ride-related operations through a web browser.

This project is developed mainly for **learning and academic purposes**, demonstrating how MVC is implemented in a Java Dynamic Web environment.

---

## 📌 About the Project

SapuJerr follows the **MVC design pattern** to separate business logic, user interface, and request handling.  
The application is structured as a **Java Dynamic Web Project** and deployed on an **Apache Tomcat** server.

**MVC Breakdown:**
- **Model** – Handles business logic and database operations
- **View** – JSP / HTML / CSS for user interface
- **Controller** – Java Servlets handling HTTP requests and responses

---

## 💡 Features

- User registration and login
- Ride booking and request handling
- View ride status and history
- Admin management for users and rides
- MVC-based request routing
- Responsive web interface

> Feature availability depends on implemented modules.

---

## 🧠 Tech Stack

**Architecture**
- MVC (Model–View–Controller)

**Backend**
- Java (Servlets)

**Frontend**
- JSP
- HTML
- CSS
- JavaScript

**Tools**
- Eclipse IDE (Java EE / Enterprise)
- Apache Tomcat 9+

**Database**
- MySQL (or any relational database)

---

## 📁 Project Structure (MVC – Java Dynamic Web)

```text
sapuJerrApp/
├── src/
│   └── main/
│       ├── java/
│       │   ├── controller/        # Servlets (Controller)
│       │   ├── model/             # Java Beans / DAO (Model)
│       │   └── util/              # Database utilities
│       └── resources/
├── WebContent/
│   ├── jsp/                       # JSP files (View)
│   ├── css/
│   ├── js/
│   └── images/
├── WEB-INF/
│   └── web.xml
├── .gitignore
├── README.md
└── pom.xml                        # Maven config (if used)
```
**To Clone the Repository**
```text
git clone https://github.com/shxhmizan/sapuJerrApp.git
cd sapuJerrApp
```
