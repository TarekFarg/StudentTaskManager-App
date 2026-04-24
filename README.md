# 🎓 Student Task Manager

A full-stack mobile application for managing student tasks and assignments, built with **Flutter** and **ASP.NET Core Web API**.

---

## 🚀 Project Overview

This application allows students to:

* 🔐 Register & Login
* 📋 Manage tasks (Create, Read, Update, Delete)
* ✅ Mark tasks as completed
* ⭐ Favorite / Unfavorite tasks
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
* IsFavorite
* StudentId (FK)

---

## 🔐 Authentication APIs

### 🟢 Signup

```http
POST /api/Student/signup
```

#### Request Body

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

#### Request Body

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
POST /api/Tasks
```

#### Request Body

```json
{
  "title": "Complete Assignment",
  "description": "Finish the data structures homework",
  "dueDate": "2025-05-01T00:00:00",
  "priority": "High",
  "userId": 1
}
```

---

### 🟢 Get All Tasks by Student

```http
GET /api/Tasks/student/{studentId}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `studentId` | `int` | The student's ID |

---

### 🟢 Get Task Details

```http
GET /api/Tasks/{taskId}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `taskId` | `int` | The task's ID |

---

### 🟡 Edit Task

```http
PUT /api/Tasks/Edit/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The task's ID |

#### Request Body

```json
{
  "title": "Updated Task Title",
  "description": "Updated description",
  "dueDate": "2025-06-01T00:00:00",
  "priority": "Medium",
  "userId": 1
}
```

---

### 🔴 Delete Task

```http
DELETE /api/Tasks/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The task's ID |

---

### 🟡 Mark Task as Completed

```http
PUT /api/Tasks/MarkAsCompleted/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The task's ID |

---

### ⭐ Get Favorite Tasks by Student

```http
GET /api/Tasks/student/{studentId}/favorites
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `studentId` | `int` | The student's ID |

---

### ⭐ Favorite a Task

```http
PATCH /api/Tasks/{id}/favorite
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The task's ID |

---

### ⭐ Unfavorite a Task

```http
PATCH /api/Tasks/{id}/unfavorite
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The task's ID |

---

## 👤 Profile APIs

### 🟢 Get Profile

```http
GET /api/Profile/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The student's ID |

---

### 🟡 Update Profile

```http
PUT /api/Profile/{id}
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int` | The student's ID |

#### Request Body

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

#### Description

* Accepts image file (`multipart/form-data`)
* Stores image in server (`wwwroot/profileImages`)
* Returns the image URL

#### Request

| Field | Type | Description |
|-------|------|-------------|
| `file` | `binary` | Image file to upload |

#### Response

```json
{
  "path": "http://localhost:5000/profileImages/image.png"
}
```

---

## 📊 API Summary

| Method | Endpoint | Description |
|--------|----------|-------------|
| `POST` | `/api/Student/signup` | Register a new student |
| `POST` | `/api/Student/login` | Login and get student data |
| `POST` | `/api/Tasks` | Add a new task |
| `GET` | `/api/Tasks/{taskId}` | Get task details |
| `GET` | `/api/Tasks/student/{studentId}` | Get all tasks for a student |
| `GET` | `/api/Tasks/student/{studentId}/favorites` | Get favorite tasks for a student |
| `PUT` | `/api/Tasks/Edit/{id}` | Edit a task |
| `PUT` | `/api/Tasks/MarkAsCompleted/{id}` | Mark a task as completed |
| `DELETE` | `/api/Tasks/{id}` | Delete a task |
| `PATCH` | `/api/Tasks/{id}/favorite` | Mark a task as favorite |
| `PATCH` | `/api/Tasks/{id}/unfavorite` | Remove a task from favorites |
| `GET` | `/api/Profile/{id}` | Get student profile |
| `PUT` | `/api/Profile/{id}` | Update student profile |
| `POST` | `/api/Profile/upload-profile-image` | Upload profile image |

---

## 📱 Flutter Features

* Login & Signup screens
* Tasks list with:

  * Delete task
  * Mark as completed
  * Favorite / Unfavorite task
* Favorites screen
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

