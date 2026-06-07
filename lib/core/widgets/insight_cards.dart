import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/features/home/domain/entities/metric_insight.dart';
import 'package:flutter/material.dart';

class CaloriesInsightCard extends StatelessWidget {
  const CaloriesInsightCard({required this.insight, super.key});

  final MetricInsight insight;

  @override
  Widget build(BuildContext context) {
    const goal = 2500.0;
    final consumed = double.tryParse(insight.value) ?? 550;
    final progress = (consumed / goal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.textPrimary),
              children: [
                TextSpan(
                  text: insight.value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text: '  Calories',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            insight.subtitle,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: const Color(0xFF3A3A3C),
              color: AppColors.accentTeal,
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
              Text('2500', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

class WeightInsightCard extends StatelessWidget {
  const WeightInsightCard({required this.insight, super.key});

  final MetricInsight insight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.textPrimary),
              children: [
                TextSpan(
                  text: insight.value.replaceAll(' kg', ''),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text: '  kg',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (insight.trend != null)
            Row(
              children: [
                const Icon(
                  Icons.arrow_upward,
                  color: AppColors.accentGreen,
                  size: 14,
                ),
                const SizedBox(width: 2),
                Text(
                  insight.trend!,
                  style: const TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          Text(
            insight.label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class HydrationInsightCard extends StatelessWidget {
  const HydrationInsightCard({
    required this.progress,
    required this.onLogWater,
    super.key,
  });

  final double progress;
  final VoidCallback onLogWater;

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).clamp(0, 100).toInt();
    final loggedMl = (progress * 2000).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        color: AppColors.accentBlue,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Hydration',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: onLogWater,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'Log Now',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _ScaleLabel(label: '2 L', active: progress >= 1),
                    _ScaleLabel(label: '1.5 L', active: progress >= 0.75),
                    _ScaleLabel(label: '1 L', active: progress >= 0.5),
                    _ScaleLabel(label: '500 ml', active: progress >= 0.25),
                    _ScaleLabel(label: '0 L', active: progress >= 0),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.accentTealDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              loggedMl > 0
                  ? '$loggedMl ml added to water log'
                  : '500 ml added to water log',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.accentTeal,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScaleLabel extends StatelessWidget {
  const _ScaleLabel({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 2,
          color: active ? AppColors.accentBlue : AppColors.border,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: active ? AppColors.accentBlue : AppColors.textMuted,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class InsightsSectionHeader extends StatelessWidget {
  const InsightsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'My Insights',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
