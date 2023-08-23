import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../models/task.dart';

class ProviderList extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  getAllTaskFromFireStore() async {
    //get all tasks from fireStore
    QuerySnapshot<Task> querySnapshot = await getTaskCollection().get();

    taskList = querySnapshot.docs.map((e) {
      return e.data();
    }).toList();
    // filter all tasks(selectedDate)
    taskList = taskList.where((task) {
      DateTime taskDate = DateTime.fromMillisecondsSinceEpoch(task.date);

      if (selectedDate.day == taskDate.day &&
          selectedDate.month == taskDate.month &&
          selectedDate.year == taskDate.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((Task task1, Task task2) {
      DateTime date1 = DateTime.fromMillisecondsSinceEpoch(task1.date);
      DateTime date2 = DateTime.fromMillisecondsSinceEpoch(task2.date);
      return date1.compareTo(date2);
    });

    notifyListeners();
  }

  void setNewSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    getAllTaskFromFireStore();
    notifyListeners();
  }
}
