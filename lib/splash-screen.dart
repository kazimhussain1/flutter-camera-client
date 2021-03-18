import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera-screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500), () {
      initCamera(context);
    });
    return Scaffold(
        body: Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(84.0),
          child: Image.asset("assets/splash.png"),
        ),
      ),
    ));
  }
}

void initCamera(BuildContext context) async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CameraScreen(camera: firstCamera)));

}
