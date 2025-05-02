import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_to_do_list_app/task.dart';

class DbService extends ChangeNotifier{
  List<Task> tasks=[];
  int id=0;
  List<Color> colors=[];
  bool isInitial =true;
  bool isLoading=false;
  bool isloaded=false;
  static const DB_NAME="TaskManangement";
  static const VERSION=9;
  static DbService? _instance;
  DbService._internal();
  factory DbService(){
    return _instance??=DbService._internal();
  }
  Future<Database> get database async{
    var path=await getDatabasesPath();
    String dbpath = path + 'posts.db';
    return await openDatabase(
      dbpath,
      onCreate: (db, version) => db.execute(Task.CREATE_TABLE),
      onUpgrade: (db, oldVersion, newVersion) {
        if(newVersion!=oldVersion){
            db.execute(Task.DROP_ALL_TASKS);
            db.execute(Task.CREATE_TABLE);
        }
      },
      version: VERSION,
      singleInstance: true
      );    
  }
  Future<List<Task>> fetchTasks() async{
    for(int i =0; i<100;i++){
      colors.add(Color.fromARGB(Random().nextInt(255),Random().nextInt(255),Random().nextInt(255),Random().nextInt(255)));
    }
    var db=await database;
    isLoading=true;
    List map=await db.rawQuery(Task.SELECT_ALL_TASKS) ;
    isloaded=true;
    notifyListeners();
    tasks=map.map((e) => Task.fromMap(e),).toList();
    return tasks;
  }
  Future<bool> inserting(Task task) async{
    id+=1;
    var db=await database;
    db.insert(Task.TABLE_NAME, task.toMap());
    notifyListeners();
    return true;
  }
  Future<bool> deleteTask(String id)async{
    var db=await database;
    Future<int> bol=db.delete(Task.TABLE_NAME,where: 'id=$id');
    tasks=[];
    await fetchTasks();
    notifyListeners();
    if(await bol>0){
      notifyListeners();
      return true;
    }else{
      notifyListeners();
      return false;
    }
  }
}