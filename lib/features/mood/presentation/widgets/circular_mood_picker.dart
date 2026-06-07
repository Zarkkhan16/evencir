import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/features/mood/domain/entities/mood_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircularMoodPicker extends StatefulWidget {
  const CircularMoodPicker({
    required this.selectedMood,
    required this.onMoodChanged,
    super.key,
  });

  final MoodType selectedMood;
  final ValueChanged<MoodType> onMoodChanged;

  @override
  State<CircularMoodPicker> createState() => _CircularMoodPickerState();
}

class _CircularMoodPickerState extends State<CircularMoodPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;
  double _handleAngle = MoodType.calm.angle;
  bool _isDragging = false;

  final Map<MoodType, ui.Image> _images = {};
  bool _imagesLoaded = false;

  @override
  void initState() {
    super.initState();
    _handleAngle = widget.selectedMood.angle;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _angleAnimation = AlwaysStoppedAnimation(_handleAngle);
    _controller.addListener(() {
      setState(() => _handleAngle = _angleAnimation.value);
    });
    _loadImages();
  }

  Future<void> _loadImages() async {
    final entries = await Future.wait(
      MoodType.values.map((mood) async {
        final data = await rootBundle.load(mood.assetPath); // ← used here
        final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        return MapEntry(mood, frame.image);
      }),
    );
    if (mounted) {
      setState(() {
        _images.addEntries(entries);
        _imagesLoaded = true;
      });
    }
  }

  @override
  void didUpdateWidget(CircularMoodPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isDragging && oldWidget.selectedMood != widget.selectedMood) {
      _animateToAngle(widget.selectedMood.angle);
    }
  }

  void _animateToAngle(double target) {
    var begin = _handleAngle;
    var end = target;
    final delta = end - begin;
    if (delta > math.pi) {
      begin += 2 * math.pi;
    } else if (delta < -math.pi) {
      end += 2 * math.pi;
    }

    _angleAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward(from: 0);
  }

  void _updateFromLocalPosition(Offset local, Size size, {required bool dragging}) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = local - center;
    if (delta.distance < size.width * 0.10) return;

    final angle = math.atan2(delta.dy, delta.dx);
    setState(() {
      _isDragging = dragging;
      _handleAngle = angle;
    });

    final mood = MoodType.fromPickerAngle(angle);
    if (mood != widget.selectedMood) {
      widget.onMoodChanged(mood);
    }
  }

  void _onDragEnd() {
    setState(() => _isDragging = false);
    _animateToAngle(widget.selectedMood.angle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayAngle = _isDragging || _controller.isAnimating
        ? _handleAngle
        : widget.selectedMood.angle;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);

        return SizedBox(
          width: size,
          height: size,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanStart: (details) {
              _updateFromLocalPosition(
                details.localPosition,
                Size(size, size),
                dragging: true,
              );
            },
            onPanUpdate: (details) {
              _updateFromLocalPosition(
                details.localPosition,
                Size(size, size),
                dragging: true,
              );
            },
            onPanEnd: (_) => _onDragEnd(),
            onTapUp: (details) {
              _updateFromLocalPosition(
                details.localPosition,
                Size(size, size),
                dragging: false,
              );
              _onDragEnd();
            },
            child: CustomPaint(
              size: Size(size, size),
              painter: _MoodPickerPainter(
                mood: widget.selectedMood,
                handleAngle: displayAngle,
                moodImage: _imagesLoaded ? _images[widget.selectedMood] : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MoodPickerPainter extends CustomPainter {
  _MoodPickerPainter({
    required this.mood,
    required this.handleAngle,
    required this.moodImage,
  });

  final MoodType mood;
  final double handleAngle;
  final ui.Image? moodImage;

  static const _designSize = 305.0;
  static const _strokeWidth = 34.0;
  static const _faceSize = 122.0;

  static const _ringColors = [
    Color(0xFF88BBAC),
    Color(0xFF96CFC4),
    Color(0xFFA8C4F0),
    Color(0xFFCBBEEC),
    Color(0xFFE896B8),
    Color(0xFFF097B7),
    Color(0xFFF28EB4),
    Color(0xFFFFAA66),
    Color(0xFFFFBE78),
    Color(0xFF88BBAC),
  ];

  static const _ringStops = [
    0.0,
    0.125,
    0.167,
    0.30,
    0.375,
    0.52,
    0.625,
    0.78,
    0.875,
    1.0,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final stroke = _strokeWidth * (size.width / _designSize);
    final radius = (size.width - stroke) / 2;
    final faceSize = _faceSize * (size.width / _designSize);

    // Background fill
    canvas.drawCircle(
      center,
      radius - stroke / 2,
      Paint()..color = AppColors.background,
    );

    // Gradient ring
    final ringRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = const SweepGradient(
          startAngle: -math.pi / 2,
          colors: _ringColors,
          stops: _ringStops,
        ).createShader(ringRect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.butt,
    );

    // Face image
    _drawFace(canvas, center, faceSize);

    // Handle
    final handleX = center.dx + radius * math.cos(handleAngle);
    final handleY = center.dy + radius * math.sin(handleAngle);
    final handleScale = size.width / _designSize;

    // Glow
    canvas.drawCircle(
      Offset(handleX, handleY),
      19 * handleScale,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.22)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 * handleScale),
    );
    // White dot
    canvas.drawCircle(
      Offset(handleX, handleY),
      18 * handleScale,
      Paint()..color = Colors.white,
    );
  }

  void _drawFace(Canvas canvas, Offset center, double faceSize) {
    final rect = Rect.fromCenter(
      center: center,
      width: faceSize,
      height: faceSize,
    );

    if (moodImage != null) {
      final radius = Radius.circular(faceSize * 0.32);
      final rrect = RRect.fromRectAndRadius(rect, radius);

      canvas.save();
      canvas.clipRRect(rrect);

      paintImage(
        canvas: canvas,
        rect: rect,
        image: moodImage!,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_MoodPickerPainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.handleAngle != handleAngle ||
        oldDelegate.moodImage != moodImage;
  }
}
