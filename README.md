# 📋 Task Manager App

A full-featured task management application built with Flutter, featuring user authentication, task CRUD operations, and a modern, responsive UI. This project was developed as part of an Ostad assignment to demonstrate real-world full-stack development skills.

## 📱 Screenshots


## ✨ Features

### 🔐 Authentication System
- **User Registration** - Complete sign-up flow with form validation
- **Secure Login** - Email/password authentication
- **Forgot Password** - Email-based password recovery
- **Email Verification** - 6-digit PIN verification system
- **Password Reset** - Secure password update functionality

### 📋 Task Management
- **Create Tasks** - Add new tasks with titles and descriptions
- **View Tasks** - Organized task dashboard with categorized views
- **Update Tasks** - Edit task details and modify content
- **Delete Tasks** - Remove unwanted tasks with confirmation
- **Status Management** - Track tasks through different states:
    - 🆕 New
    - ⏳ In Progress
    - ✅ Completed
    - ❌ Cancelled

### 🎨 User Experience
- **Modern UI Design** - Clean and intuitive interface
- **Responsive Layout** - Optimized for different screen sizes
- **Real-time Updates** - Instant task status changes
- **User-friendly Navigation** - Smooth transitions and interactions
- **Professional Styling** - Consistent color scheme and typography

- ## 📁 Project Structure

```
task_manager_app/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── data/                     # Data-related files
│   │   ├── models/               # Data models
│   │   │   ├── task_status_count_model.dart
│   │   │   ├── task_model.dart
│   │   │   └── user_model.dart
│   │   ├── service/              # Service-related files
│   │   │   ├── network_caller.dart
│   │   │   └── urls.dart
│   ├── ui/                       # UI-related files
│   │   ├── controller/           # Controller files
│   │   │   └── auth_controller.dart
│   │   ├── screens/              # UI screens
│   │   │   ├── Forgot Password Screens/
│   │   │   │   ├── email_verification_screen.dart
│   │   │   │   ├── pin_verification_screen.dart
│   │   │   │   └── set_password_screen.dart
│   │   │   ├── add_task_screen.dart
│   │   │   ├── cancelled_task_list.dart
│   │   │   ├── completed_task_list.dart
│   │   │   ├── home_screen.dart
│   │   │   ├── new_task_screen.dart
│   │   │   ├── progress_task_screen.dart
│   │   │   ├── sign_in_screen.dart
│   │   │   ├── sign_up_screen.dart
│   │   │   ├── splash_screen.dart
│   │   │   └── update_profile_screen.dart
│   │   ├── widgets/              # Reusable widgets
│   │   │   ├── screen_background.dart
│   │   │   ├── snack_bar_message.dart
│   │   │   ├── task_app_bar.dart
│   │   │   ├── task_card.dart
│   │   │   └── task_summary_card.dart
│   ├── utils/                    # Utility files
│   │   └── assets_path.dart
├── assets/                       # Assets like images and fonts
└── pubspec.yaml                 # Dependencies
