import 'package:evencir_app/app/di/injection.dart';
import 'package:evencir_app/features/training_plan/domain/entities/training_plan.dart';
import 'package:evencir_app/features/training_plan/presentation/cubit/training_plan_cubit.dart';
import 'package:evencir_app/features/training_plan/presentation/cubit/training_plan_state.dart';
import 'package:evencir_app/features/training_plan/presentation/widgets/training_calendar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingPlanPage extends StatelessWidget {
  const TrainingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TrainingPlanCubit>()..load(),
      child: const _TrainingPlanView(),
    );
  }
}

class _TrainingPlanView extends StatelessWidget {
  const _TrainingPlanView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocConsumer<TrainingPlanCubit, TrainingPlanState>(
        listener: (context, state) {
          if (state.status == TrainingPlanStatus.saved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Training plan saved')),
            );
          }
          if (state.errorMessage != null &&
              state.status == TrainingPlanStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TrainingCalendarHeader(
                onSave: state.status == TrainingPlanStatus.saving
                    ? () {}
                    : () => context.read<TrainingPlanCubit>().save(),
              ),
              if (state.status == TrainingPlanStatus.loading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.plan case final plan?)
                Expanded(child: _TrainingCalendarList(plan: plan))
              else
                Expanded(
                  child: Center(
                    child: Text(state.errorMessage ?? 'No plan available'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TrainingCalendarList extends StatelessWidget {
  const _TrainingCalendarList({required this.plan});

  final TrainingPlan plan;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < plan.weeks.length; i++) ...[
          if (i > 0) const TrainingSectionDivider(),
          _WeekSection(
            weekIndex: i,
            week: plan.weeks[i],
            showDays: true,
          ),
        ],
      ],
    );
  }
}

class _WeekSection extends StatelessWidget {
  const _WeekSection({
    required this.weekIndex,
    required this.week,
    required this.showDays,
  });

  final int weekIndex;
  final WeekPlan week;
  final bool showDays;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TrainingPlanCubit>();
    final totalMinutes = week.sessions.fold<int>(
      0,
      (sum, session) => sum + estimateSessionMinutes(session),
    );

    void onAccept(
      TrainingDragPayload payload,
      String label,
      String number,
    ) {
      handleTrainingDrop(
        payload: payload,
        targetWeekIndex: weekIndex,
        targetDayLabel: label,
        targetDayNumber: number,
        moveSession: ({
          required sourceWeekIndex,
          required targetWeekIndex,
          required session,
          required targetDayLabel,
          required targetDayNumber,
        }) {
          cubit.moveSession(
            sourceWeekIndex: sourceWeekIndex,
            targetWeekIndex: targetWeekIndex,
            session: session,
            targetDayLabel: targetDayLabel,
            targetDayNumber: targetDayNumber,
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrainingWeekHeader(
          label: week.label,
          range: week.range,
          totalMinutes: totalMinutes == 0 ? 60 : totalMinutes,
        ),
        if (showDays)
          ...weekDaySlots().map((slot) {
            final session = sessionForDay(
              week.sessions,
              slot.label,
              slot.number,
            );
            if (session != null) {
              return TrainingWorkoutCard(
                weekIndex: weekIndex,
                session: session,
                onAccept: (payload) => onAccept(payload, slot.label, slot.number),
              );
            }
            return TrainingEmptyDayRow(
              weekIndex: weekIndex,
              dayLabel: slot.label,
              dayNumber: slot.number,
              onAccept: (payload) => onAccept(payload, slot.label, slot.number),
            );
          }),
      ],
    );
  }
}
