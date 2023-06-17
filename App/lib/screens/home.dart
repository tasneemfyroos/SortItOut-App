import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_testing/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_testing/screens/eWasteDisposal.dart';
import 'package:flutter_app_testing/screens/clothingDisposal.dart';
import 'package:flutter_app_testing/screens/cameraPage.dart';

class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  File? _capturedImage;
  var categoryName;
  var binContents;
  bool _isLoading = false;

  //mobile App
  void _processCapturedImage(File? image) async {
    setState(() {
      categoryName = "";
      binContents = "";
      _capturedImage = image;
      _isLoading = true;

    });
    // final picker = ImagePicker();
    // final image = await picker.pickImage(source: ImageSource.camera);
    // setState(() {
    //   _image = File(image!.path);
    //   _isLoading = true;
    // });
    _sendImage();
  }

  Future _sendImage() async {
    if (_capturedImage != null) {
      final uri = Uri.parse('https://getclass-rxsfwafrhq-uc.a.run.app');
      final request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('file', _capturedImage!.path));

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SortItOut',
                    style: TextStyle(
                      fontFamily: "marcellus",
                      fontSize: 18,
                    )),
                SizedBox(width: 8),
                Image(
                    image: AssetImage('images/logo.png'),
                    height:50),
              ],
            ),
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
                    if (_capturedImage != null && !_isLoading)
                      Positioned.fill(
                          left: getSizes()[2],
                          top: 5,
                          right: getSizes()[2],
                          bottom: getSizes()[2],
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                if (_capturedImage != null)
                                  Text("Let's SortItOut!",
                                      style: TextStyle(
                                        fontFamily: "marcellus",
                                        fontSize: 16,
                                      )),
                                // AspectRatio(
                                  // aspectRatio: 1.0, // Set the desired aspect ratio (1:1 in this case)
                                  Image.file(
                                    _capturedImage!,
                                    fit: BoxFit.scaleDown, // Adjust the BoxFit option as per your requirement
                                  ),
                                // ),
                                Text("The category is:",
                                    style: TextStyle(
                                        fontFamily: "marcellus", fontSize: 14)),
                                Text(categoryName,
                                    style: TextStyle(
                                        fontFamily: "marcellus", fontSize: 16, color:Color(0xFF664229))),
                                Text("The bin classification is:",
                                    style: TextStyle(
                                        fontFamily: "marcellus", fontSize: 14)),
                                Text(binContents,
                                    style: TextStyle(
                                        fontFamily: "marcellus", fontSize: 16, color:Color(0xFF664229))),
                                
                                if (categoryName=="Electronic waste" || categoryName=="Clothing" || categoryName=="Shoes")
                                  Text("Click Here to see the closest site",
                                      style: TextStyle(
                                          fontFamily: "marcellus", fontSize: 12)),
                                  if (categoryName =="Electronic waste" )
                                    ElevatedButton(
                                        onPressed: () {
                                          // Add your button action here
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => EwasteDisposal()),
                                            );
                                        },
                                        child: Text('E-Waste Disposal Sites'),
                                      ),
                                  if (categoryName == "Clothing" || categoryName == "Shoes")
                                    ElevatedButton(
                                        onPressed: () {
                                          // Add your button action here
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ClothingDisposal()),
                                            );
                                        },
                                        child: Text('Clothing/Shoes Donation Sites'),
                                      ),

                                
                              ])),
                  ],
                ),
                // if (_capturedImage != null) Image.file(_capturedImage!),
                  InkWell(
                      onTap: () {
                        Navigator.push<File>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(
                              onImageCaptured: (capturedImage) {
                                if (capturedImage != null) {
                                  _processCapturedImage(capturedImage);
                                }
                              },
                            ),
                          ),
                        )
                        .then((capturedImage) {
                          if (capturedImage != null) {
                            // Set the captured image in the home page
                            setState(() {
                              _capturedImage = capturedImage;
                            });
                          }
                        });
                      },
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
                                  image: AssetImage('images/cameraNew.png'),
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
