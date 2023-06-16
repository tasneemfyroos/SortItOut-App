import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_testing/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  File? _image;
  var categoryName;
  var binContents;
  bool _isLoading = false;

  //mobile App
  Future _captureImage() async {
    setState(() {
      categoryName = "";
      binContents = "";
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
      final uri = Uri.parse('https://getclass-rxsfwafrhq-uc.a.run.app');
      final request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('file', _image!.path));

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          // Image successfully sent to the server
          final responseBody = await response.stream.bytesToString();
          print(responseBody);

          // Extract the category from the response
          final category = jsonDecode(responseBody)['category'];
          final bin = jsonDecode(responseBody)['bin'];
          // categoryName = category;
          setState(() {
            categoryName = category;
            binContents = bin;
          });
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
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('SortItOut'),
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
                        borderRadius:
                            BorderRadius.circular(10), // Rounded edges
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
                              children: <Widget>[
                                if (_image != null)
                                  Text("Let's SortItOut!",
                                      style: TextStyle(
                                        fontFamily: "marcellus",
                                        fontSize: 16,
                                      )),
                                Image.file(
                                  _image!,
                                  fit: BoxFit.scaleDown,
                                ),
                                Text("the category is",
                                    style: TextStyle(
                                        fontFamily: "marcellus", fontSize: 14)),
                                Text(categoryName,
                                    style: TextStyle(
                                        fontFamily: "marcellus", fontSize: 16)),
                                // Text(binContents,
                                //     style: TextStyle(
                                //         fontFamily: "marcellus", fontSize: 14)),
                              ])),
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
                            child: Row(children: [
                              Image(
                                image: AssetImage('images/camera.png'),
                                fit: BoxFit.contain,
                              )
                            ]))
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
}
