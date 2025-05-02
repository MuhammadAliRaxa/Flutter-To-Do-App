// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  String id;
  String title;
  String description;
  String date;
  static const TABLE_NAME='Task';
  static const COL_TITLE='title';
  static const COL_DECRIPTION='description';
  static const COL_DATE='date';
  static const COL_ID='id';
  static const CREATE_TABLE='''
CREATE TABLE IF NOT EXISTS $TABLE_NAME(
$COL_ID TEXT NOT NULL,
$COL_TITLE TEXT NOT NULL,
$COL_DECRIPTION TEXT NOT NULL,
$COL_DATE TEXT NOT NULL)''';
static const SELECT_ALL_TASKS='''SELECT * FROM $TABLE_NAME''';
static const DROP_TASK='''DELETE FROM $TABLE_NAME''';
static const DROP_ALL_TASKS='''DROP TABLE IF EXISTS $TABLE_NAME''';
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  } 

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, date: $date)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      date.hashCode;
  }
}
