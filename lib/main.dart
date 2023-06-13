import 'package:flutter/material.dart';
import 'package:prism/pages/citizens_list_page.dart';
import 'package:prism/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: [
              const Text("Home"),
              const Text("List of Citizens"),
            ].elementAt(_selectedIndex),
          ),
          body: [
            const HomePage(),
            const CitizensListPage(),
          ].elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: setCurrentIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 10,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Citizens",
              ),
            ],
          )),
    );
  }
}
