import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/core/utils/calendar_week_utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthCalendarSheet extends StatelessWidget {
  const MonthCalendarSheet({
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
    required this.onPageChanged,
    super.key,
  });

  final DateTime focusedDay;
  final DateTime selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;
  final void Function(DateTime focused) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3C),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: TableCalendar<void>(
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2025, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) =>
                  CalendarWeekUtils.isSameDay(day, selectedDay),
              onDaySelected: onDaySelected,
              onPageChanged: onPageChanged,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekHeight: 28,
              rowHeight: 40,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                leftChevronIcon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
                rightChevronIcon: const Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                weekendStyle: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedMonth) {
                  return _DayCell(
                    day: day,
                    selectedDay: selectedDay,
                    focusedMonth: focusedMonth,
                  );
                },
                todayBuilder: (context, day, focusedMonth) {
                  return _DayCell(
                    day: day,
                    selectedDay: selectedDay,
                    focusedMonth: focusedMonth,
                    isToday: true,
                  );
                },
                selectedBuilder: (context, day, focusedMonth) {
                  return _DayCell(
                    day: day,
                    selectedDay: selectedDay,
                    focusedMonth: focusedMonth,
                    isSelected: true,
                  );
                },
                outsideBuilder: (context, day, focusedMonth) {
                  return _DayCell(
                    day: day,
                    selectedDay: selectedDay,
                    focusedMonth: focusedMonth,
                    isOutside: true,
                  );
                },
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: true,
                defaultTextStyle: TextStyle(color: Colors.transparent, fontSize: 0),
                selectedTextStyle: TextStyle(color: Colors.transparent, fontSize: 0),
                todayTextStyle: TextStyle(color: Colors.transparent, fontSize: 0),
                outsideTextStyle: TextStyle(color: Colors.transparent, fontSize: 0),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom + 12),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.selectedDay,
    required this.focusedMonth,
    this.isSelected = false,
    this.isToday = false,
    this.isOutside = false,
  });

  final DateTime day;
  final DateTime selectedDay;
  final DateTime focusedMonth;
  final bool isSelected;
  final bool isToday;
  final bool isOutside;

  @override
  Widget build(BuildContext context) {
    final inSelectedWeek = CalendarWeekUtils.isInWeek(day, selectedDay);
    final selected = isSelected || CalendarWeekUtils.isSameDay(day, selectedDay);

    return Center(
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: inSelectedWeek && !selected
              ? AppColors.accentGreen.withValues(alpha: 0.14)
              : null,
          border: selected
              ? Border.all(color: AppColors.accentGreenRing, width: 1.5)
              : inSelectedWeek
              ? Border.all(
                  color: AppColors.accentGreen.withValues(alpha: 0.35),
                  width: 1,
                )
              : isToday
              ? Border.all(color: AppColors.border, width: 1)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          '${day.day}',
          style: TextStyle(
            color: selected
                ? AppColors.accentGreen
                : isOutside
                ? AppColors.textMuted.withValues(alpha: 0.55)
                : AppColors.textPrimary,
            fontSize: 15,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
