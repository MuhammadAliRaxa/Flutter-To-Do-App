# 📝 Flutter To-Do App

A simple To-Do application built with **Flutter** and **Sqflite** for local data storage. This app allows users to:

* Add new tasks
* View all tasks
* Delete tasks

## 🛠 Features

* Insert tasks into a local database
* Fetch and display saved tasks
* Delete tasks from the database

## 🧰 Technologies Used

* **Flutter**
* **Dart**
* **Sqflite** (SQLite plugin for Flutter)
* **Provider** (State Management)

## 📦 Dependencies

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path_provider: ^2.1.2
  path: ^1.8.3
```

> Make sure to run `flutter pub get` after adding dependencies.

## 📁 Project Structure

```
lib/
├── main.dart
├── db/
│   └── database_services.dart
├── models/
│   └── task.dart
└── screens/
    └── home_screen.dart
```

## 🗃️ Database (SQFLite)

### Insert a Task

```dart
await db.insert('tasks', task.toMap());
```

### Get All Tasks

```dart
List<Map<String, dynamic>> maps = await db.query('tasks');
```

### Delete a Task

```dart
await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
```

## 🚀 Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/flutter-todo-sqflite.git
cd flutter-todo-sqflite
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/acb24266-c56c-4f52-a5e6-5bde3ec225d2" width="300"/>
  <img src="https://github.com/user-attachments/assets/75f44c94-f586-471b-acef-30d9dc14e320" width="300"/>
  <img src="https://github.com/user-attachments/assets/116299ad-b4f3-45d9-9e85-8d0c50006606" width="300"/>
  <img src="https://github.com/user-attachments/assets/e8dacc98-c334-469b-aaee-3ca7d86bac36" width="300"/>
</p>

## 🤝 Contributing

Feel free to fork the repo, open issues, or submit pull requests.

