import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/core/widgets/insight_cards.dart';
import 'package:evencir_app/core/widgets/workout_card.dart';
import 'package:evencir_app/features/home/domain/entities/home_dashboard.dart';
import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({
    required this.dashboard,
    required this.onLogWater,
    super.key,
  });

  final HomeDashboard dashboard;
  final VoidCallback onLogWater;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WorkoutsSectionHeader(),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: WorkoutCard(
            title: dashboard.workout.title,
            dateRange: dashboard.workout.dateRange,
            duration: dashboard.workout.duration,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        const InsightsSectionHeader(),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: CaloriesInsightCard(insight: dashboard.calories)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: SizedBox(
                  height: 130,
                  child: WeightInsightCard(insight: dashboard.weight),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: HydrationInsightCard(
            progress: dashboard.hydration.progress,
            onLogWater: onLogWater,
          ),
        ),
      ],
    );
  }
}
