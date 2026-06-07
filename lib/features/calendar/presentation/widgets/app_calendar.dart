import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatelessWidget {
  const AppCalendar({
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    required this.markedDays,
    super.key,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;
  final void Function(DateTime focused) onPageChanged;
  final Set<DateTime> markedDays;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isMarked(DateTime day) {
    return markedDays.any((marked) => _isSameDay(marked, day));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: TableCalendar<void>(
        firstDay: DateTime(2024, 1, 1),
        lastDay: DateTime(2025, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => _isSameDay(day, selectedDay),
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: Theme.of(context).textTheme.titleMedium!,
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: AppColors.textSecondary,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: Theme.of(context).textTheme.bodySmall!,
          weekendStyle: Theme.of(context).textTheme.bodySmall!,
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          defaultTextStyle: Theme.of(context).textTheme.bodyMedium!,
          weekendTextStyle: Theme.of(context).textTheme.bodyMedium!,
          todayDecoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          todayTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.textPrimary,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppColors.accentGreen,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.background,
            fontWeight: FontWeight.w600,
          ),
          markerDecoration: const BoxDecoration(
            color: AppColors.accentGreen,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 1,
          markerSize: 5,
          markerMargin: const EdgeInsets.only(top: 4),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, day, events) {
            if (!_isMarked(day)) return null;
            if (_isSameDay(day, selectedDay)) return null;
            return Positioned(
              bottom: 1,
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
