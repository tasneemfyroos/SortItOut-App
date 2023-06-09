import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Classification App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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

  // web app 




  //mobile App 
  Future _captureImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
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

        // Display the category in a dialog box or any other way you prefer
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Image Category'),
            content: Text('The image belongs to the category: $category'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Error sending image to the server
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Classification App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image and Send'),
            ),
          ],
        ),
      ),
    );
  }
}


