import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';
import 'package:powerlifting_app/screens/Home Screen/video_page.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() {
    return _Record();
  }
}

class _Record extends State<RecordScreen> {
  bool _isLoading = true;
  late CameraController _cameraController;
  bool _isRecording = false;
  bool _flipped = false;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    if (_flipped == false) {
      final cameras = await availableCameras();
      final back = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
      _cameraController = CameraController(back, ResolutionPreset.max);
      await _cameraController.initialize();
      setState(() => _isLoading = false);
    } else {
      final cameras = await availableCameras();
      final front = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      _cameraController = CameraController(front, ResolutionPreset.max);
      await _cameraController.initialize();
      setState(() => _isLoading = false);
    }
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.red,
              iconSize: 35,
              key: Key('back-cups'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              },
            ),
          ),
          body: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CameraPreview(_cameraController),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: FloatingActionButton(
                    key: Key('recordcheck'),
                    backgroundColor: Colors.red,
                    child: Icon(_isRecording ? Icons.stop : Icons.circle),
                    onPressed: () => _recordVideo(),
                  ),
                ),
                Row(children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                      height: 100,
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.flip_camera_android),
                          onPressed: () {
                            setState(() {
                              _flipped = !_flipped;
                              _initCamera();
                            });
                          },
                        ),
                      ))
                ]),
              ],
            ),
          ));
    }
  }
}
