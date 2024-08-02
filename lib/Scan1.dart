import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class MushroomScanScreen extends StatefulWidget {
  @override
  _MushroomScanScreenState createState() => _MushroomScanScreenState();
}

class _MushroomScanScreenState extends State<MushroomScanScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  int currentViewIndex = 0;
  List<String?> capturedImages = [null, null, null]; // List to hold image paths

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras![0], ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      final image = await _controller!.takePicture();
      setState(() {
        // Save the image path in the current index
        capturedImages[currentViewIndex] = image.path;

        // Move to the next index if it is less than 2
        if (currentViewIndex < 2) {
          currentViewIndex++;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _processImages() {
    // Example: Print the paths of the captured images
    for (var path in capturedImages) {
      if (path != null) {
        print('Captured image path: $path');
      }
    }

    // Example: Navigate to another page or process the images
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsPage(capturedImages: capturedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: CameraPreview(_controller!),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: ScannerOverlay(),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.white,
                        ),
                        child: capturedImages[index] != null
                            ? Image.file(
                                File(capturedImages[index]!),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text(
                                  'View ${index + 1}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _captureImage,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(Icons.camera_alt, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      if (capturedImages.every((image) => image != null))
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                            onPressed: _processImages,
                            child: Text('Process Images'),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double squareSize = size.width * 0.8;
    final double left = (size.width - squareSize) / 2;
    final double top = (size.height - squareSize) / 2;

    final rect = Rect.fromLTWH(left, top, squareSize, squareSize);
    canvas.drawRect(rect, paint);

    // Draw corner markers
    final markerLength = squareSize * 0.1;
    final topLeft = Offset(left, top);
    final topRight = Offset(left + squareSize, top);
    final bottomLeft = Offset(left, top + squareSize);
    final bottomRight = Offset(left + squareSize, top + squareSize);

    // Top Left
    canvas.drawLine(topLeft, topLeft + Offset(markerLength, 0), paint);
    canvas.drawLine(topLeft, topLeft + Offset(0, markerLength), paint);

    // Top Right
    canvas.drawLine(topRight, topRight + Offset(-markerLength, 0), paint);
    canvas.drawLine(topRight, topRight + Offset(0, markerLength), paint);

    // Bottom Left
    canvas.drawLine(bottomLeft, bottomLeft + Offset(markerLength, 0), paint);
    canvas.drawLine(bottomLeft, bottomLeft + Offset(0, -markerLength), paint);

    // Bottom Right
    canvas.drawLine(bottomRight, bottomRight + Offset(-markerLength, 0), paint);
    canvas.drawLine(bottomRight, bottomRight + Offset(0, -markerLength), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ResultsPage extends StatelessWidget {
  final List<String?> capturedImages;

  ResultsPage({required this.capturedImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results')),
      body: ListView.builder(
        itemCount: capturedImages.length,
        itemBuilder: (context, index) {
          return capturedImages[index] != null
              ? Image.file(File(capturedImages[index]!))
              : SizedBox.shrink();
        },
      ),
    );
  }
}
