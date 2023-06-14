import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


// import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

// image bg width, image bg height, padding of image
// circle width, padding of icon
List<double> getSizes() {
  return [240, 360, 20, 95, 15];
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
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Classification App',
      theme: ThemeData(
        primarySwatch: getColor()
      ),
      home: ImageCaptureScreen(),
    );
  }
}




class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();

}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  File? _image;
  var categoryName = "";
  // web app =
  bool _isLoading = false;

  //mobile App 
  Future _captureImage() async {
    setState(() {
      categoryName = "";
    });
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      _isLoading = true;
    });
    _sendImage();
  }

  Future _sendImage() async {
    if (_image != null) {
      final uri = Uri.parse('https://getclassification-rxsfwafrhq-uc.a.run.app/');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', _image!.path));

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          // Image successfully sent to the server
          final responseBody = await response.stream.bytesToString();
          print(responseBody);

          // Extract the category from the response
          final category = jsonDecode(responseBody)['category'];
          // categoryName = category;
          setState(() {
            categoryName = category;
          });
          // Display the category in a dialog box or any other way you prefer

          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     title: Text('Image Category'),
          //     content: Text('The image belongs to the category: $category'),
          //     actions: [
          //       TextButton(
          //         onPressed: () => Navigator.pop(context),
          //         child: Text('OK'),
                // ),
              // ],
            // ),
          // );
        } else {
          // Error sending image to the server
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          )
        ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Waste Classification App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                  Container(
                    width: getSizes()[0],
                    height: getSizes()[1],
                    decoration: BoxDecoration(
                      color: getColor()[500], // Rectangle color
                      borderRadius: BorderRadius.circular(10), // Rounded edges
                    ),
                  ),
                  if (_isLoading)
                      Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  if (_image != null && !_isLoading)
                    Positioned.fill(
                      left: getSizes()[2],
                      top: 5,
                      right: getSizes()[2],
                      bottom: getSizes()[2],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            if(_image != null)
                              Text(
                                  "Let's SortItOut!",
                                  style: TextStyle(
                                      fontFamily: "marcellus",
                                      fontSize: 16,
                                  )
                              ),
                              Image.file(
                              _image!,
                              fit: BoxFit.scaleDown,
                              ),
                              Text(
                                "the category is",
                                style: TextStyle(
                                  fontFamily: "marcellus",
                                  fontSize: 14
                                )
                              ),
                              Text(
                                  categoryName,
                                  style: TextStyle(
                                      fontFamily: "marcellus",
                                      fontSize: 16
                                  )
                              ),
                          ]
                      )
                    ),
              ],
            ),
            InkWell(
              onTap: _captureImage,
              child: Stack(
                children: [
                  Container(
                    width: getSizes()[3],
                    height: getSizes()[3],
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                  ),
                Positioned.fill(
                  left: getSizes()[4],
                  top: getSizes()[4],
                  right: getSizes()[4],
                  bottom: getSizes()[4],
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/camera.png'),
                        fit:BoxFit.contain,
                      )
                    ]
                  )
                )
                ],
              )
            )
          ],
        ),
      ),
    ),
  );
}


