import 'package:desafio2_dsi/src/screens/Home.dart';
import 'package:desafio2_dsi/src/screens/Players.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int paginaActual = 1;

  List<Widget> screens = [
    Home(),
    Players(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('NBA'),
        ),
        body: screens[paginaActual],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (change) {
            setState(() {
              paginaActual = change;
            });
          },
          currentIndex: paginaActual,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Equipos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle), label: "Players")
          ],
        ),
      ),
    );
  }
}
