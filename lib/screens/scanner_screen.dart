import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> with SingleTickerProviderStateMixin {
  // Design tokens
  static const Color _brand = Color(0xFF2563EB);
  static const Color _brandLight = Color(0xFFEFF6FF);
  static const Color _textDark = Color(0xFF111827);
  static const Color _textMuted = Color(0xFF6B7280);
  static const Color _green = Color(0xFF10B981);

  late AnimationController _animationController;
  late Animation<double> _laserAnimation;

  CameraController? _cameraController;
  final TextRecognizer _textRecognizer = TextRecognizer();
  
  bool _isCameraInitialized = false;
  bool _isScanning = true;
  bool _scanComplete = false;
  bool _isProcessingImage = false;
  String _extractedText = "";
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _laserAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _errorMessage = "No cameras found on device.");
        return;
      }

      // Find the back camera
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );

      await _cameraController!.initialize();
      
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });

      _cameraController!.startImageStream(_processImage);
    } catch (e) {
      debugPrint("Camera initialization error: $e");
      setState(() => _errorMessage = "Failed to initialize camera. Ensure permissions are granted.");
    }
  }

  Future<void> _processImage(CameraImage image) async {
    if (_isProcessingImage || !_isScanning || !mounted) return;
    _isProcessingImage = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
      
      final camera = _cameraController!.description;
      final imageRotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation) ?? InputImageRotation.rotation0deg;

      final inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21;

      final inputImageMetadata = InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow: image.planes[0].bytesPerRow,
      );

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: inputImageMetadata,
      );

      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      
      // Look for a significant block of text to consider it a successful scan
      final text = recognizedText.text.trim();
      if (text.isNotEmpty && text.length > 5) {
        if (mounted) {
          setState(() {
            _extractedText = text;
            _isScanning = false;
            _scanComplete = true;
          });
          _animationController.stop();
          _cameraController?.stopImageStream();
        }
      }
    } catch (e) {
      debugPrint("OCR Error: $e");
    } finally {
      _isProcessingImage = false;
    }
  }

  void _rescan() {
    setState(() {
      _scanComplete = false;
      _isScanning = true;
      _extractedText = "";
      _animationController.repeat(reverse: true);
    });
    
    if (_cameraController?.value.isInitialized == true && !_cameraController!.value.isStreamingImages) {
      _cameraController!.startImageStream(_processImage);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Live Camera Feed or Error State
          if (_errorMessage.isNotEmpty)
            Positioned.fill(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline_rounded, color: Colors.white54, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (_isCameraInitialized && _cameraController != null)
            Positioned.fill(
              child: CameraPreview(_cameraController!),
            )
          else
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(color: _brand),
              ),
            ),
          
          // Scanner Overlay
          if (_isScanning || _scanComplete)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _laserAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _ScannerOverlayPainter(
                      laserPosition: _isScanning ? _laserAnimation.value : 0.5,
                      laserColor: _isScanning ? _brand : _green,
                      showLaser: _isScanning,
                    ),
                  );
                },
              ),
            ),

          // Top App Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close_rounded, color: Colors.white, size: 24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _isScanning ? Icons.document_scanner_rounded : Icons.check_circle_rounded,
                        color: _isScanning ? Colors.white : _green,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isScanning ? "Scanning Label..." : "Scan Complete",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 24),
                ),
              ],
            ),
          ),

          // Bottom Results Panel
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            bottom: _scanComplete ? 0 : -500,
            left: 0,
            right: 0,
            child: _buildResultsPanel(),
          ),

          // Instructions (only when scanning)
          if (_isScanning)
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Align text within the frame",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultsPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, -5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFFEDF7F2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.document_scanner_rounded, color: _green, size: 24),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Text Extracted Successfully",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: _textDark, letterSpacing: -0.3),
                    ),
                    Text(
                      "OCR Integration",
                      style: TextStyle(fontSize: 14, color: _textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: SingleChildScrollView(
              child: Text(
                _extractedText,
                style: const TextStyle(
                  fontSize: 15,
                  color: _textDark,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _rescan,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _brandLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        "Rescan",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: _brand),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _brand,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Meds",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final double laserPosition;
  final Color laserColor;
  final bool showLaser;

  _ScannerOverlayPainter({required this.laserPosition, required this.laserColor, this.showLaser = true});

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    // Define the scanning area
    final double scanAreaSize = width * 0.75;
    final Rect scanRect = Rect.fromCenter(
      center: Offset(width / 2, height / 2 - 60), 
      width: scanAreaSize,
      height: scanAreaSize * 1.2,
    );

    // Dark overlay
    final Path backgroundPath = Path()..addRect(Rect.fromLTWH(0, 0, width, height));
    final Path scanAreaPath = Path()..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(24)));
    final Path overlayPath = Path.combine(PathOperation.difference, backgroundPath, scanAreaPath);

    final Paint overlayPaint = Paint()..color = Colors.black.withOpacity(0.5); // reduced opacity so camera is visible
    canvas.drawPath(overlayPath, overlayPaint);

    // Corners
    final Paint cornerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    const double cornerLength = 35;
    const double radius = 24;

    // Top-left
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.left, scanRect.top + cornerLength)
        ..lineTo(scanRect.left, scanRect.top + radius)
        ..arcToPoint(Offset(scanRect.left + radius, scanRect.top), radius: const Radius.circular(radius))
        ..lineTo(scanRect.left + cornerLength, scanRect.top),
      cornerPaint,
    );

    // Top-right
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.right - cornerLength, scanRect.top)
        ..lineTo(scanRect.right - radius, scanRect.top)
        ..arcToPoint(Offset(scanRect.right, scanRect.top + radius), radius: const Radius.circular(radius))
        ..lineTo(scanRect.right, scanRect.top + cornerLength),
      cornerPaint,
    );

    // Bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.left, scanRect.bottom - cornerLength)
        ..lineTo(scanRect.left, scanRect.bottom - radius)
        ..arcToPoint(Offset(scanRect.left + radius, scanRect.bottom), radius: const Radius.circular(radius), clockwise: false)
        ..lineTo(scanRect.left + cornerLength, scanRect.bottom),
      cornerPaint,
    );

    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(scanRect.right - cornerLength, scanRect.bottom)
        ..lineTo(scanRect.right - radius, scanRect.bottom)
        ..arcToPoint(Offset(scanRect.right, scanRect.bottom - radius), radius: const Radius.circular(radius), clockwise: false)
        ..lineTo(scanRect.right, scanRect.bottom - cornerLength),
      cornerPaint,
    );

    // Laser
    if (showLaser) {
      final double laserY = scanRect.top + (scanRect.height * laserPosition);
      final Paint laserPaint = Paint()
        ..color = laserColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawLine(
        Offset(scanRect.left + 10, laserY),
        Offset(scanRect.right - 10, laserY),
        laserPaint,
      );

      // Glow
      final Paint laserGlowPaint = Paint()
        ..color = laserColor.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

      canvas.drawLine(
        Offset(scanRect.left + 10, laserY),
        Offset(scanRect.right - 10, laserY),
        laserGlowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScannerOverlayPainter oldDelegate) {
    return oldDelegate.laserPosition != laserPosition || oldDelegate.showLaser != showLaser;
  }
}
