// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class QrisMenu extends StatelessWidget {
  const QrisMenu({super.key});

  Future<List<CameraDescription>> _getCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: _getCameras(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Scanner(cameras: snapshot.data!);
          } else {
            return const Center(child: Text('No cameras available'));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class Scanner extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Scanner({Key? key, required this.cameras}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0], // Use the main camera
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      // Force portrait mode by setting a fixed rotation
      if (mounted) {
        _controller.setFocusMode(FocusMode.auto);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Get the aspect ratio of the camera
            final cameraAspectRatio = _controller.value.aspectRatio;
            return Container(
              child: RotatedBox(
                quarterTurns: 1, // Rotate to portrait mode
                child: AspectRatio(
                  aspectRatio:
                      cameraAspectRatio, // Maintain the camera's aspect ratio
                  child: CameraPreview(_controller),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6482AD),
        onPressed: () {
          print('Capture button pressed!');
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
