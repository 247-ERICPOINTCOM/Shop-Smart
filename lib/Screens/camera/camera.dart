import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopsmartly/constants/constants.dart';
import 'camera_preview/camera_preview.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription>? cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewPage(
                    picture: picture,
                  )));
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking a picture: $e');
      return null;
    }
  }

  Future pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the picked image, for example, display it in your app.
      // You can also pass this image to the `PreviewPage` or handle it as needed.
      // The picked image file is in pickedFile.path.
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("Camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController.value.isInitialized) {
      final size = _cameraController.value.previewSize!;
      final screenAspectRatio = MediaQuery.of(context).size.aspectRatio;
      final cameraAspectRatio = size.aspectRatio;
      final cameraWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Camera preview adjusted to fill the entire screen
              Positioned(
                top: 0,
                left: 0,
                width: cameraWidth,
                height: 450,
                child: CameraPreview(_cameraController),
              ),
              Positioned(
                top: 10, // Adjust top value as needed
                right: 10, // Adjust right value as needed
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 30,
                  icon: Icon(
                    _isRearCameraSelected
                        ? CupertinoIcons.switch_camera
                        : CupertinoIcons.switch_camera_solid,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(
                        () => _isRearCameraSelected = !_isRearCameraSelected);
                    initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                  },
                ),
              ),
              // Positioned(
              //   top: 10, // Adjust top value as needed
              //   left: 10, // Adjust left value as needed
              //   child: ElevatedButton(
              //     onPressed: pickImageFromGallery,
              //     style: ElevatedButton.styleFrom(
              //       primary: Colors.white,
              //     ),
              //     child: Icon(
              //       Icons.photo_library,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      color: kPrimaryLightColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          icon: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                          onPressed: pickImageFromGallery,
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: takePicture,
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.circle, color: Colors.white),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
