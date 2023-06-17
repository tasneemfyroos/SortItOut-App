
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
  return [300, 450, 20, 95, 15];
}

List<double> sizes = [300, 450, 20, 95, 15];

MaterialColor getColor() {
  return new MaterialColor(0xFF132A32,
      <int,Color>{50: Color(0xFFE3F2FD), // Shade 50
        100: Color(0xFFe5d3b3), // Shade 100
        200: Color(0xFFa3b5c0), // Shade 200
        300: Color(0xFFafeeee), // Shade 300
        400: Color(0xFF987554), // Shade 400
        500: Color(0xFFbdb5a4), // Shade 500
        600: Color(0xFF664229), // Shade 600
        700: Color(0xFF8A8B47), // Shade 700
        800: Color(0xFF758d93), // Shade 800
        900: Color(0xFF132A32), // Shade 900(primary color)
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
    EducationalPage(),
    ClothingDisposal(),
    EwasteDisposal(),
  ];

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme.apply(
      fontFamily: 'marcellus',
    );
    sizes[0] = deviceWidth*0.8;
    sizes[1] = deviceHeight*0.6;
    return MaterialApp(
      // title: 'Waste Classification App',
      theme: ThemeData(
        primarySwatch: getColor(),
        textTheme: textTheme,
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
          selectedItemColor: getColor()[700],
          unselectedItemColor: getColor()[800],
          items: [
            BottomNavigationBarItem(
              // icon: Icon(Icons.home),
              icon: Image(
                  image: AssetImage('images/cameraNew.png'),
                  height:deviceHeight/15),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.book),
              icon: Image(
                  image: AssetImage('images/infoLogo.png'),
                  height:deviceHeight/15),
              label: 'Educational',
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.shopping_bag),
              icon: Image(
                  image: AssetImage('images/mapLogo.png'),
                  height:deviceHeight/15),
              label: 'Clothing Disposal',
            ),
            BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage('images/ewasteLogo.png'),
                  height:deviceHeight/15),
              // icon: Icon(Icons.computer),
              label: 'E-waste Disposal',
            ),
          ],
        ),
      ),
    );
  }
}