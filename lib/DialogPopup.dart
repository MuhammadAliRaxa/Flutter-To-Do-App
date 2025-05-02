import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_to_do_list_app/db_service.dart';
import 'package:task_to_do_list_app/task.dart';

class ShowDialogBoX extends StatefulWidget {
  const ShowDialogBoX({super.key});

  @override
  State<ShowDialogBoX> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialogBoX> {
  TextEditingController datePickerController = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController decription = TextEditingController();
  DbService service=DbService();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (pickedDate != null && pickedDate != selectedDate) {
       datePickerController.text = pickedDate.toString();
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
  @override
  void dispose() {
    datePickerController.dispose();
    title.dispose();
    decription.dispose();
    super.dispose();
  }
  @override
  void initState() {
     service.fetchTasks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 11, 185, 204),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(6, 6),
                spreadRadius: 2,
                blurStyle: BlurStyle.solid,
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: CloseButton(),
                ),
                const Center(
                  child: Text(
                    "Add Task",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                    controller: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter title' : null,
                  ),
                  const SizedBox(height: 8),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: decription,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {},
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a task title' : null,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: datePickerController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onTap: () async {
                    _selectDate(context);
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please pick a date' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var id =service.id;
                        var dateTime = DateTime.parse(datePickerController.text);
                        var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                        Task task=Task(id: id.toString(),title:title.text.toString(), description: decription.text.toString(), date:formate1);
                        service.inserting(task);
                        Navigator.of(context).pop();
                        print(id);
                        title.text="";
                        decription.text="";
                        datePickerController.text="";
                      }
                    },
                    child: const Text(
                      'Add Task',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      );
  }
}