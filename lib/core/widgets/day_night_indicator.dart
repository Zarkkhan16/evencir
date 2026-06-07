import 'dart:async';

import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DayNightIndicator extends StatefulWidget {
  const DayNightIndicator({
    this.temperature = '9°',
    super.key,
  });

  final String temperature;

  @override
  State<DayNightIndicator> createState() => _DayNightIndicatorState();
}

class _DayNightIndicatorState extends State<DayNightIndicator> {
  late Timer _timer;
  late bool _isDaytime;

  @override
  void initState() {
    super.initState();
    _isDaytime = _resolveIsDaytime(DateTime.now());
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      final next = _resolveIsDaytime(DateTime.now());
      if (next != _isDaytime && mounted) {
        setState(() => _isDaytime = next);
      }
    });
  }

  bool _resolveIsDaytime(DateTime time) {
    return time.hour >= 6 && time.hour < 18;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _isDaytime ? '☀️' : '🌙',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 4),
        Text(
          widget.temperature,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
