# 🎓 Student Task Manager

A full-stack mobile application for managing student tasks and assignments, built with **Flutter** and **ASP.NET Core Web API**.

---

## 🚀 Project Overview

This application allows students to:

* 🔐 Register & Login
* 📋 Manage tasks (Create, Read, Update, Delete)
* ✅ Mark tasks as completed
* 👤 View and edit profile
* 🖼️ Upload and update profile image (Camera / Gallery)

---

## 🏗️ Architecture

The backend follows a clean architecture:

* **Controllers** → Handle HTTP requests
* **Services** → Business logic
* **DTOs** → Data transfer between layers
* **Entities** → Database models
* **Database** → SQL Server (Entity Framework Core)

---

## 🧱 Database Design

### 👤 Student

* Id
* FullName
* Email
* StudentId
* Gender
* AcademicLevel
* PasswordHash
* ProfileImagePath ✅ (stores image URL)

---

### 📋 Task

* Id
* Title
* Description
* DueDate
* Priority (Low / Medium / High)
* IsCompleted
* StudentId (FK)

---

## 🔐 Authentication APIs

### 🟢 Signup

```http
POST /api/Student/signup
```

#### Request

```json
{
  "fullName": "Tarek Mohamed",
  "email": "20201234@stud.fci-cu.edu.eg",
  "studentId": "20201234",
  "gender": "Male",
  "academicLevel": 3,
  "password": "12345678"
}
```

---

### 🟢 Login

```http
POST /api/Student/login
```

#### Response

```json
{
  "id": 1,
  "fullName": "Tarek Mohamed",
  "email": "20201234@stud.fci-cu.edu.eg",
  "studentId": "20201234",
  "gender": "Male",
  "academicLevel": 3,
  "profileImagePath": null
}
```

---

## 📋 Task APIs

### 🟢 Add Task

```http
POST /api/Tasks
```

---

### 🟢 Get Tasks by Student

```http
GET /api/Tasks/student/{studentId}
```

---

### 🟢 Get Task Details

```http
GET /api/Tasks/{taskId}
```

---

### 🟡 Update Task

```http
PUT /api/Tasks/{id}
```

---

### 🔴 Delete Task

```http
DELETE /api/Tasks/{id}
```

---

### 🟢 Mark Task as Completed

```http
PUT /api/Tasks/{id}/complete
```

---

## 👤 Profile APIs

### 🟢 Get Profile

```http
GET /api/Profile/{id}
```

---

### 🟡 Update Profile

```http
PUT /api/Profile/{id}
```

#### Request

```json
{
  "fullName": "Updated Name",
  "gender": "Male",
  "academicLevel": 4,
  "profileImagePath": "image_url_here"
}
```

---

## 🖼️ Image Upload API

### 🟢 Upload Profile Image

```http
POST /api/Profile/upload-profile-image
```

#### Description:

* Accepts image file (multipart/form-data)
* Stores image in server (wwwroot/profileImages)
* Returns image URL

#### Response

```json
{
  "path": "http://localhost:5000/profileImages/image.png"
}
```

---

## 📱 Flutter Features

* Login & Signup screens
* Tasks list with:

  * Delete task
  * Mark as completed
* Task details screen + Edit task
* Add new task screen
* Profile screen:

  * View data in table style
  * Edit profile
  * Upload profile image (Camera / Gallery)
* API integration using HTTP

---

## 🛠️ Technologies Used

### Backend

* ASP.NET Core Web API
* Entity Framework Core
* SQL Server
* Swagger

### Frontend

* Flutter
* HTTP package
* Image Picker

---

## ⚠️ Notes

* Authentication currently **without JWT**
* StudentId is passed manually
* Images are stored in server (not database)
* Database stores only image path (best practice)

---

## 🔜 Future Improvements

* 🔐 Add JWT Authentication
* ☁️ Use Cloud storage (AWS / Cloudinary)
* 🖼️ Image compression before upload
* 📊 Task filtering & sorting
* 🔔 Notifications & reminders

---

## 👨‍💻 Author

**Tarek Mohamed Abdullah**
Faculty of Computers and Artificial Intelligence
Cairo University

---
