import 'package:evencir_app/core/theme/app_colors.dart';
import 'package:evencir_app/core/theme/app_spacing.dart';
import 'package:evencir_app/core/utils/calendar_week_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    required this.selectedDate,
    required this.onWeekTap,
    super.key,
  });

  final DateTime selectedDate;
  final VoidCallback onWeekTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 8, AppSpacing.lg, 0),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_none,
            color: AppColors.textPrimary,
            size: 22,
          ),
          Expanded(
            child: GestureDetector(
              onTap: onWeekTap,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    color: AppColors.textSecondary.withValues(alpha: 0.9),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    CalendarWeekUtils.weekLabel(selectedDate),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 22),
        ],
      ),
    );
  }
}

class WeekCalendarStrip extends StatelessWidget {
  const WeekCalendarStrip({
    required this.selectedDate,
    required this.onDateSelected,
    required this.onOpenMonthCalendar,
    super.key,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onOpenMonthCalendar;

  @override
  Widget build(BuildContext context) {
    final days = CalendarWeekUtils.getWeekDates(selectedDate);
    const labels = ['M', 'TU', 'W', 'TH', 'F', 'SA', 'SU'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 16, AppSpacing.lg, 12),
          child: Text(
            'Today, ${DateFormat('d MMM yyyy').format(selectedDate)}',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = days[index];
              final isSelected = CalendarWeekUtils.isSameDay(day, selectedDate);
              final isInWeek = CalendarWeekUtils.isInWeek(day, selectedDate);

              return GestureDetector(
                onTap: () => onDateSelected(day),
                child: Column(
                  children: [
                    Text(
                      labels[index],
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.accentGreen
                            : isInWeek
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isInWeek && !isSelected
                            ? AppColors.accentGreen.withValues(alpha: 0.12)
                            : !isSelected
                            ? const Color(0xFF2C2C2E)
                            : null,
                        border: isSelected
                            ? Border.all(
                                color: AppColors.accentGreenRing,
                                width: 1.5,
                              )
                            : isInWeek
                            ? Border.all(
                                color: AppColors.accentGreen.withValues(alpha: 0.35),
                                width: 1,
                              )
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.accentGreen
                              : isInWeek
                              ? AppColors.textPrimary
                              : AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.accentGreen
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        GestureDetector(
          onTap: onOpenMonthCalendar,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
