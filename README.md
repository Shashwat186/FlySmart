# ✈️ FLYSMART

FLYSMART is a comprehensive flight management and booking service designed to streamline both administrative and operational activities while delivering a smooth and seamless user booking experience.

---

## 🚀 Technologies Used

- Java  
- Spring Boot  
- MySQL  
- JSP (for Frontend)

---

## ⚙️ Project Setup

1. Download the entire project as a `.zip` file and extract it.
2. Import the extracted project into your preferred IDE (e.g., IntelliJ or Eclipse).
3. Navigate to the Spring Boot application and open it in your working directory.
4. A MySQL dump file (`Dump20250508.sql`) is included, containing the database structure (no data).
5. Open **MySQL Workbench**, click on **Server** > **Data Import**.
6. Select the `Dump20250508.sql` file to import the database schema.
7. Edit the `application.properties` file to point to your local MySQL database URL.
8. If you are a beginner, it's recommended to follow each step carefully—ChatGPT can assist if needed.
9. Before using the booking feature, insert sample data (e.g., Airports, Airlines, Flights) into the database.

---

## 🔐 User Roles

1. **Owner** – Added manually to the MySQL database for secure authorization.
2. **Manager** – Added by the Owner via the "Add Manager" feature in the app.
3. **Customer** – Can sign up through the application interface.

- All roles have login access.
- Only Customers can self-register via signup.
- Ensure the required initial data is set up before running the project for a complete experience.

---

## 📌 Prerequisites

- Java 17+  
- Spring Boot  
- MySQL Server  
- MySQL Workbench  
- Maven (for dependency management)

---

Feel free to enhance the database with your own flight data and customize the roles to match your use case!



