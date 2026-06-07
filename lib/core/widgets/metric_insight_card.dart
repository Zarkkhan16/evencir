import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class MetricInsightCard extends StatelessWidget {
  const MetricInsightCard({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.accentColor,
    super.key,
    this.trend,
  });

  final String label;
  final String value;
  final String subtitle;
  final Color accentColor;
  final String? trend;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                if (trend != null)
                  Text(
                    trend!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.accentGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
