import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/provider/list_provider.dart';

import '../../firebase_utils.dart';

class TaskWidget extends StatelessWidget {
  Task task;

  TaskWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              onPressed: (context) {
                deleteTaskFromFireStore(task).timeout(
                  const Duration(milliseconds: 500),
                  onTimeout: () {
                    print("todo was delete");
                    provider.getAllTaskFromFireStore();
                  },
                );
              },
              icon: Icons.delete,
              label: "Delete",
            )
          ],
        ),
        child: Container(
          // margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Container(
                color: theme.primaryColor,
                height: 80,
                width: 4,
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: theme.primaryColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.description,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Image(
                  image: AssetImage(
                    "assets/images/icon_check.png",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
