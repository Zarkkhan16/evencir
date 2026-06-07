import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({
    required this.date,
    this.onCalendarTap,
    super.key,
  });

  final DateTime date;
  final VoidCallback? onCalendarTap;

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('EEEE, d MMM').format(date);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              formatted,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if (onCalendarTap != null)
            GestureDetector(
              onTap: onCalendarTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
