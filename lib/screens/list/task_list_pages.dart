import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/list_provider.dart';
import 'package:todo/screens/list/task_widget.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    var theme = Theme.of(context);
    if (provider.taskList.isEmpty) {
      provider.getAllTaskFromFireStore();
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            provider.setNewSelectedDate(date);
          },
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: theme.primaryColor,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidget(
                task: provider.taskList[index],
              );
            },
            itemCount: provider.taskList.length,
          ),
        )
      ],
    );
  }
}
