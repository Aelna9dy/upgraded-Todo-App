import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/list/add_task.dart';
import 'package:todo/screens/list/task_list_pages.dart';
import 'package:todo/screens/settings/settings.dart';
import 'package:todo/theme/myTheme.dart';

import '../provider/list_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> screens = [
    ListScreen(),
    SettingsScreen(),
  ];

  bool _isSearchBarVisible = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderList>(context);
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: MyThemeData.greenLight,
      appBar: AppBar(
        title: _isSearchBarVisible
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search..',
                  hintStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                ),
              )
            : const Text('To Do List'),
        actions: [
          IconButton(
            icon: Icon(
              _isSearchBarVisible ? Icons.close : Icons.search,
            ),
            onPressed: () {
              setState(() {
                _isSearchBarVisible = !_isSearchBarVisible;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  "assets/images/icon_list.png",
                ),
                size: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  "assets/images/icon_settings.png",
                ),
                size: 30,
              ),
              label: "",
            ),
          ],
        ),
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(color: MyThemeData.weightColor, width: 4),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[selectedIndex],
    );
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewTask();
      },
    );
  }
}
