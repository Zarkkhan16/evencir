import 'package:evencir_app/app/di/injection.dart';
import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/core/widgets/insight_cards.dart';
import 'package:evencir_app/core/widgets/workout_card.dart';
import 'package:evencir_app/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:evencir_app/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:evencir_app/features/home/presentation/widgets/home_header.dart';
import 'package:evencir_app/features/home/presentation/widgets/month_calendar_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CalendarCubit>()..load(),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatefulWidget {
  const _CalendarView();

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  static final _initialDate = DateTime(2024, 12, 22);

  late DateTime _sheetFocusedDay = _initialDate;
  late DateTime _sheetSelectedDay = _initialDate;

  void _openMonthCalendar(DateTime currentDate) {
    setState(() {
      _sheetFocusedDay = currentDate;
      _sheetSelectedDay = currentDate;
    });

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return MonthCalendarSheet(
              focusedDay: _sheetFocusedDay,
              selectedDay: _sheetSelectedDay,
              onPageChanged: (focused) {
                setSheetState(() => _sheetFocusedDay = focused);
                setState(() => _sheetFocusedDay = focused);
                context.read<CalendarCubit>().onPageChanged(focused);
              },
              onDaySelected: (selected, focused) {
                setSheetState(() {
                  _sheetSelectedDay = selected;
                  _sheetFocusedDay = focused;
                });
                setState(() {
                  _sheetSelectedDay = selected;
                  _sheetFocusedDay = focused;
                });
                Navigator.pop(sheetContext);
                context.read<CalendarCubit>().selectDay(selected, focused);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: BlocConsumer<CalendarCubit, CalendarState>(
          listener: (context, state) {
            if (state.errorMessage != null &&
                state.status == CalendarStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            final headerDate = DateFormat(
              'EEEE, d MMM yyyy',
            ).format(state.selectedDay);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          headerDate,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                HomeTopBar(
                  selectedDate: state.selectedDay,
                  onWeekTap: () => _openMonthCalendar(state.selectedDay),
                ),
                WeekCalendarStrip(
                  selectedDate: state.selectedDay,
                  onDateSelected: (selected) {
                    context.read<CalendarCubit>().selectDay(selected, selected);
                  },
                  onOpenMonthCalendar: () => _openMonthCalendar(state.selectedDay),
                ),
                if (state.status == CalendarStatus.loading &&
                    state.dashboard == null)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.dashboard case final dashboard?)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: AppSpacing.lg),
                          const WorkoutsSectionHeader(),
                          const SizedBox(height: AppSpacing.md),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CaloriesInsightCard(
                                    insight: dashboard.calories,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: SizedBox(
                                    height: 130,
                                    child: WeightInsightCard(
                                      insight: dashboard.weight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                            ),
                            child: HydrationInsightCard(
                              progress: dashboard.hydration.progress,
                              onLogWater: () =>
                                  context.read<CalendarCubit>().logWater(),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
