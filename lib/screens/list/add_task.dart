import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task.dart';
import 'package:todo/provider/list_provider.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  String title = "";
  String description = "";
  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late ProviderList provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderList>(context);
    var theme = Theme.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add New Task",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              TextFormField(
                onChanged: (text) {
                  title = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please entre task";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "entre your task",
                  labelStyle:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  description = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Please entre description";
                  }
                  return null;
                },
                maxLines: 2,
                minLines: 2,
                decoration: InputDecoration(
                  labelText: "entre your description",
                  labelStyle:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Selected Time",
                style: theme.textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () {
                  chooseDate();
                },
                child: Text(
                  formatDate(selectedDate, [yyyy, '/', mm, '/', dd]),
                  style:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text(
                  "Add",
                  style:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
        title: title,
        description: description,
        date: selectedDate.millisecondsSinceEpoch,
      );
      addTaskToFireStore(task).timeout(
        const Duration(milliseconds: 500),
        onTimeout: () {
          print('task was add after Provider');
          provider.getAllTaskFromFireStore();
          Navigator.pop(context);
        },
      );
    }
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chooseDate != null) {
      setState(() {
        selectedDate = chooseDate;
      });
    }
  }
}
