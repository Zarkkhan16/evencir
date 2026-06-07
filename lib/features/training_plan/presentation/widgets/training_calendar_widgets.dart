import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';
import 'package:flutter/material.dart';

class TrainingDragPayload {
  const TrainingDragPayload({
    required this.weekIndex,
    required this.session,
  });

  final int weekIndex;
  final WorkoutSession session;
}

class TrainingCalendarHeader extends StatelessWidget {
  const TrainingCalendarHeader({required this.onSave, super.key});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            12,
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Training Calendar',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onSave,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(height: 1, color: AppColors.headerLineBlue),
      ],
    );
  }
}

class TrainingWeekHeader extends StatelessWidget {
  const TrainingWeekHeader({
    required this.label,
    required this.range,
    required this.totalMinutes,
    super.key,
  });

  final String label;
  final String range;
  final int totalMinutes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 16, AppSpacing.lg, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  range,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Total: ${totalMinutes}min',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingEmptyDayRow extends StatelessWidget {
  const TrainingEmptyDayRow({
    required this.weekIndex,
    required this.dayLabel,
    required this.dayNumber,
    required this.onAccept,
    super.key,
  });

  final int weekIndex;
  final String dayLabel;
  final String dayNumber;
  final ValueChanged<TrainingDragPayload> onAccept;

  @override
  Widget build(BuildContext context) {
    return DragTarget<TrainingDragPayload>(
      onWillAcceptWithDetails: (details) {
        final targetDay = '$dayLabel $dayNumber';
        return details.data.session.day != targetDay;
      },
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        final isActive = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: isActive ? AppColors.accentGreen.withValues(alpha: 0.08) : null,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 36,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayLabel,
                            style: TextStyle(
                              color: isActive
                                  ? AppColors.accentGreen
                                  : AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            dayNumber,
                            style: TextStyle(
                              color: isActive
                                  ? AppColors.accentGreen
                                  : AppColors.textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isActive)
                      const Expanded(
                        child: Text(
                          'Drop workout here',
                          style: TextStyle(
                            color: AppColors.accentGreen,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                height: 1,
                color: AppColors.border,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TrainingWorkoutCard extends StatelessWidget {
  const TrainingWorkoutCard({
    required this.weekIndex,
    required this.session,
    required this.onAccept,
    super.key,
  });

  final int weekIndex;
  final WorkoutSession session;
  final ValueChanged<TrainingDragPayload> onAccept;

  @override
  Widget build(BuildContext context) {
    final parts = session.day.split(' ');
    final dayLabel = parts.first;
    final dayNumber = parts.length > 1 ? parts.last : '';
    final isArms = session.title.toLowerCase().contains('arm');
    final tagLabel = isArms ? 'Arms Workout' : 'Leg Workout';
    final tagBg = isArms ? AppColors.armsTag : AppColors.legsTag;
    final tagText = isArms ? AppColors.armsTagText : AppColors.legsTagText;
    final payload = TrainingDragPayload(weekIndex: weekIndex, session: session);

    final card = Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 12, 12, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.drag_indicator,
                      color: AppColors.textMuted,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tagBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tagLabel,
                              style: TextStyle(
                                color: tagText,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            session.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      session.duration,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return DragTarget<TrainingDragPayload>(
      onWillAcceptWithDetails: (details) => details.data.session.day != session.day,
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        final isActive = candidateData.isNotEmpty;
        return Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 10, AppSpacing.lg, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayLabel,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      dayNumber,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Draggable<TrainingDragPayload>(
                  data: payload,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Opacity(
                      opacity: 0.92,
                      child: SizedBox(width: 280, child: card),
                    ),
                  ),
                  childWhenDragging: Opacity(opacity: 0.35, child: card),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: isActive
                          ? Border.all(color: AppColors.accentGreen, width: 1.5)
                          : null,
                    ),
                    child: card,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TrainingSectionDivider extends StatelessWidget {
  const TrainingSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 1,
      color: AppColors.sectionLineTeal,
    );
  }
}

int estimateSessionMinutes(WorkoutSession session) {
  final match = RegExp(r'(\d+)m').firstMatch(session.duration);
  if (match != null) {
    return int.tryParse(match.group(1)!) ?? 30;
  }
  return 30;
}

List<({String label, String number})> weekDaySlots() {
  return const [
    (label: 'Mon', number: '8'),
    (label: 'Tue', number: '9'),
    (label: 'Wed', number: '10'),
    (label: 'Thu', number: '11'),
    (label: 'Fri', number: '12'),
    (label: 'Sat', number: '13'),
    (label: 'Sun', number: '14'),
  ];
}

WorkoutSession? sessionForDay(List<WorkoutSession> sessions, String label, String number) {
  for (final session in sessions) {
    if (session.day == '$label $number') return session;
  }
  return null;
}

void handleTrainingDrop({
  required TrainingDragPayload payload,
  required int targetWeekIndex,
  required String targetDayLabel,
  required String targetDayNumber,
  required void Function({
    required int sourceWeekIndex,
    required int targetWeekIndex,
    required WorkoutSession session,
    required String targetDayLabel,
    required String targetDayNumber,
  }) moveSession,
}) {
  moveSession(
    sourceWeekIndex: payload.weekIndex,
    targetWeekIndex: targetWeekIndex,
    session: payload.session,
    targetDayLabel: targetDayLabel,
    targetDayNumber: targetDayNumber,
  );
}
