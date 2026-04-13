# 🎓 Student Task Manager

A mobile application for managing student tasks and assignments, built with Flutter and ASP.NET Core Web API.

---

## 🚀 Project Overview

This project allows students to:

* Register and login
* Manage their tasks (CRUD operations)
* View and update their profile

The backend is built using ASP.NET Core Web API, and the frontend will be developed using Flutter.

---

## 🏗️ Architecture

The project follows a clean architecture:

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
* ProfileImagePath

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
POST /api/student/signup
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

#### Response

```json
{
  "message": "Signup Success"
}
```

---

### 🟢 Login

```http
POST /api/student/login
```

#### Request

```json
{
  "email": "20201234@stud.fci-cu.edu.eg",
  "password": "12345678"
}
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
POST /api/tasks
```

#### Request

```json
{
  "title": "Study Flutter",
  "description": "Finish UI screens",
  "dueDate": "2026-04-20T00:00:00",
  "priority": "High",
  "studentId": 1
}
```

#### Response

```json
{
  "id": 5,
  "title": "Study Flutter",
  "description": "Finish UI screens",
  "dueDate": "2026-04-20T00:00:00",
  "priority": "High",
  "isCompleted": false
}
```

---

### 🟢 Get Task by Id

```http
GET /api/tasks/{taskId}
```

#### Response

```json
{
  "id": 1,
  "title": "Study Flutter",
  "description": "Finish UI",
  "dueDate": "2026-04-20T00:00:00",
  "priority": "High",
  "isCompleted": false
}
```

---

### 🟢 Get Tasks by Student

```http
GET /api/tasks/student/{studentId}
```

#### Response

```json
[
  {
    "id": 1,
    "title": "Study Flutter",
    "description": "Finish UI",
    "dueDate": "2026-04-20T00:00:00",
    "priority": "High",
    "isCompleted": false
  }
]
```

---

### 🟡 Update Task

```http
PUT /api/tasks/{id}
```

#### Request

```json
{
  "title": "Updated Task",
  "description": "Updated desc",
  "dueDate": "2026-04-25T00:00:00",
  "priority": "Medium",
  "studentId": 1
}
```

#### Response

```json
{
  "message": "Task updated successfully"
}
```

---

### 🔴 Delete Task

```http
DELETE /api/tasks/{id}
```

#### Response

```json
{
  "message": "Task deleted successfully"
}
```

---

### 🟢 Mark Task as Completed

```http
PUT /api/tasks/{id}/complete
```

#### Response

```json
{
  "message": "Task marked as completed"
}
```

---

## 👤 Profile APIs

### 🟢 Get Profile

```http
GET /api/student/profile/{id}
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

### 🟡 Update Profile

```http
PUT /api/student/profile/{id}
```

#### Request

```json
{
  "fullName": "Tarek M",
  "gender": "Male",
  "academicLevel": 4
}
```

#### Response

```json
{
  "message": "Profile Updated"
}
```

---

## 🛠️ Technologies Used

* ASP.NET Core Web API
* Entity Framework Core
* SQL Server
* Swagger (API Testing)
* Flutter (Frontend - in progress)

---

## ⚠️ Notes

* Authentication is currently implemented without JWT.
* StudentId is passed manually in requests.
* DTOs are used to avoid circular reference issues.
* Clean architecture is applied (Controller → Service → DTO).

---

## 🔜 Next Steps

* Implement JWT Authentication
* Connect Flutter frontend with API
* Add profile image upload
* Improve validation and error handling

---

## 👨‍💻 Author

Tarek Mohamed
Faculty of Computers and Artificial Intelligence - Cairo University

---
