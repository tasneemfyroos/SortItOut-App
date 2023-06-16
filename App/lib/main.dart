
import 'package:flutter/material.dart';
import 'package:flutter_app_testing/screens/home.dart';
import 'package:flutter_app_testing/screens/clothingDisposal.dart';
import 'package:flutter_app_testing/screens/educational.dart';
import 'package:flutter_app_testing/screens/eWasteDisposal.dart';

// import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

// image bg width, image bg height, padding of image
// circle width, padding of icon
List<double> getSizes() {
  return [360, 500, 20, 95, 15];
}

MaterialColor getColor() {
  return new MaterialColor(0xFF758d93,
      <int,Color>{50: Color(0xFFE3F2FD), // Shade 50
        100: Color(0xFFe5d3b3), // Shade 100
        200: Color(0xFFa3b5c0), // Shade 200
        300: Color(0xFFafeeee), // Shade 300
        400: Color(0xFF987554), // Shade 400
        500: Color(0xFFbdb5a4), // Shade 500
        600: Color(0xFF664229), // Shade 600
        700: Color(0xFF503f37), // Shade 700
        800: Color(0xFF758d93), // Shade 800(primary color)
        900: Color(0xFF98f5e1), // Shade 900
      });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ImageCaptureScreen(),
    WasteSortingQuiz(),
    ClothingDisposal(),
    EwasteDisposal(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Classification App',
      theme: ThemeData(
        primarySwatch: getColor()
      ),
       home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.blueAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Educational',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Clothing Disposal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer),
              label: 'E-waste Disposal',
            ),
          ],
        ),
      ),
    );
  }
}