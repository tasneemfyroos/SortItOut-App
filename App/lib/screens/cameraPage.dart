import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_testing/main.dart';
import 'package:flutter_app_testing/screens/home.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';



class CameraPage extends StatefulWidget {
  final void Function(File?) onImageCaptured;

  CameraPage({required this.onImageCaptured});
  

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  
  late CameraController _cameraController;
  late File _capturedImage;
  late Future<void> _initializeCameraControllerFuture;

  Future<bool> requestCameraPermission() async {
  PermissionStatus status = await Permission.camera.request();
  return status == PermissionStatus.granted;
  }

  Future<bool> checkCameraPermission() async {
  PermissionStatus status = await Permission.camera.status;
  return status == PermissionStatus.granted;
  }



  @override
  void initState() {
    super.initState();
    _checkPermissions(); // Check camera permissions when initializing the widget
    _capturedImage = File('');
    _initializeCameraControllerFuture = _initializeCameraController();
    

  }

  Future<void> _checkPermissions() async {
    bool hasPermission = await checkCameraPermission();
    if (!hasPermission) {
      bool granted = await requestCameraPermission();
      if (!granted) {
        // Handle camera permission denied
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Camera Permission'),
            content: Text('Camera permission is required to use this feature.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _initializeCameraController() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    // if (!_checkPermissions())

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
  try {
    await _initializeCameraControllerFuture;

    final image = await _cameraController.takePicture();
    final capturedImage = File(image.path);

     widget.onImageCaptured(capturedImage);

    // Pass the captured image back to the home page
    Navigator.pop(context, capturedImage);
  } catch (e) {
    print('Error capturing image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _captureImage,
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}