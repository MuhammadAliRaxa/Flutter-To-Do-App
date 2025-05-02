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
  <img src="https://github.com/user-attachments/assets/06fb6ccf-eb76-45ed-ae70-bedcb4f00845" width="200"/>
  <img src="https://github.com/user-attachments/assets/39179655-3f70-4859-a717-94d99599bd10" width="200"/>
  <img src="https://github.com/user-attachments/assets/17ee8040-97c1-4312-922d-3c8c3accbd24" width="200"/>
  <img src="https://github.com/user-attachments/assets/3a384265-a8b8-4624-a386-801bdc16267e" width="200"/>
</p>

## 🤝 Contributing

Feel free to fork the repo, open issues, or submit pull requests.

