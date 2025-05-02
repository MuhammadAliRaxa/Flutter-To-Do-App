

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_to_do_list_app/DialogPopup.dart';
import 'package:task_to_do_list_app/db_service.dart';
import 'package:task_to_do_list_app/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<DbService>(create: (context) =>DbService(),child: const MyHomePage(title: 'Flutter Demo Home Page'),));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbService service =DbService();
  @override
  void initState() {
    service.fetchTasks();
    super.initState();
  }
  @override
void didChangeDependencies() {
  super.didChangeDependencies();

  final dbService = Provider.of<DbService>(context, listen: false);
  dbService.fetchTasks();
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tasks",style: TextStyle(fontSize: 20),),
        leading: const CircleAvatar(
          backgroundImage: AssetImage("assets/Microsoft_To-Do_icon.png"),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:()=> showDialog(builder: (context) =>
      const Dialog(
      child: ShowDialogBoX()
      ), context: context
      ),child: Icon(Icons.add)
      ),
      body: Consumer<DbService>(builder: (context, value, child){
        value.fetchTasks();
         if(value.tasks.isNotEmpty){
           return TaskAdded();
        }
        else{
           return const NoTask();
        }
      } ,)
    );
  }
}
class NoTask extends StatefulWidget {
  const NoTask({super.key});

  @override
  State<NoTask> createState() => _NoTaskState();
}

class _NoTaskState extends State<NoTask> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("No Task Added"),);
  }
}
class TaskAdded extends StatefulWidget {
  const TaskAdded({super.key});

  @override
  State<TaskAdded> createState() => _TaskAddedState();
}

class _TaskAddedState extends State<TaskAdded> {
  @override
void didChangeDependencies() {
  super.didChangeDependencies();

  final dbService = Provider.of<DbService>(context, listen: false);
  dbService.fetchTasks();
}
  @override
  Widget build(BuildContext context) {
    DbService service =DbService();
    final size=MediaQuery.sizeOf(context);
    var width=size.width;
    var height=size.height;
    return ListView.builder(itemBuilder: (context, index) =>
       Padding(
        padding:const EdgeInsets.all(15),
         child: Dismissible(
          key: Key(context.watch<DbService>().tasks[index].id),

          onDismissed: (direction)async{
            await service.deleteTask(Provider.of<DbService>(context,listen:false).tasks[index].id);
          }, 
           child: Container(
            width: width,
            height: height*0.15,
            decoration:BoxDecoration(
              color: context.watch<DbService>().colors[index],
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                 Positioned(top: 10,left: width*0.1,child: Text(context.watch<DbService>().tasks[index].title.toString().toUpperCase(),style: TextStyle(fontSize: 22,),)),
                 Positioned(top: height*0.12,left: width*0.7,child: SizedBox(width: 100,child: Text(context.watch<DbService>().tasks[index].date.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)))),
                 Positioned(top: 50,left: width*0.1,child: SizedBox(width: 250,child: Text(context.watch<DbService>().tasks[index].description.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400)))),
              ],
            ),
           ),
         ),
       ),
       itemCount: context.watch<DbService>().tasks.length,
    );
  }
}

