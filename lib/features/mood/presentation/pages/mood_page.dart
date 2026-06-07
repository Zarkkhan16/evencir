import 'dart:math' as math;

import 'package:evencir_app/app/di/injection.dart';
import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/core/widgets/primary_button.dart';
import 'package:evencir_app/features/mood/presentation/cubit/mood_cubit.dart';
import 'package:evencir_app/features/mood/presentation/cubit/mood_state.dart';
import 'package:evencir_app/features/mood/presentation/widgets/circular_mood_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoodCubit>(),
      child: const _MoodView(),
    );
  }
}

class _MoodView extends StatelessWidget {
  const _MoodView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        gradient: RadialGradient(
          center: Alignment(0, -0.7),
          radius: 1.2,
          colors: [AppColors.moodGlow, AppColors.background],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: BlocConsumer<MoodCubit, MoodState>(
          listener: (context, state) {
            if (state.status == MoodStatus.success && state.lastEntry != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Mood saved: ${state.lastEntry!.mood.label}'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.surfaceElevated,
                ),
              );
            }
            if (state.errorMessage != null && state.status == MoodStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mood',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Start your day',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'How are you feeling at the\nMoment?',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const labelSpace = 48.0;
                        final availableHeight = constraints.maxHeight - labelSpace;
                        final pickerSize = math
                            .min(constraints.maxWidth, availableHeight)
                            .clamp(280.0, 338.0);

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: pickerSize,
                              height: pickerSize,
                              child: CircularMoodPicker(
                                selectedMood: state.selectedMood,
                                onMoodChanged:
                                    context.read<MoodCubit>().selectMood,
                              ),
                            ),
                            const SizedBox(height: 22),
                            SizedBox(
                              width: pickerSize,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 220),
                                child: Text(
                                  state.selectedMood.label,
                                  key: ValueKey(state.selectedMood),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: PrimaryButton(
                    label: state.status == MoodStatus.submitting
                        ? 'Saving...'
                        : 'Continue',
                    onPressed: state.status == MoodStatus.submitting
                        ? null
                        : () => context.read<MoodCubit>().submit(),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            );
          },
        ),
      ),
    );
  }
}
