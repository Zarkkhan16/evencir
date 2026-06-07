import 'package:evencir_app/core/utils/calendar_week_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalendarWeekUtils', () {
    test('December 2024 has 6 calendar weeks', () {
      final month = DateTime(2024, 12, 1);
      expect(CalendarWeekUtils.getTotalWeeks(month), 6);
    });

    test('December 22 2024 is week 4 of 6', () {
      final date = DateTime(2024, 12, 22);
      expect(CalendarWeekUtils.getWeekOfMonth(date), 4);
      expect(CalendarWeekUtils.weekLabel(date), 'Week 4/6');
    });

    test('getWeekDates returns Monday through Sunday', () {
      final date = DateTime(2024, 12, 22);
      final week = CalendarWeekUtils.getWeekDates(date);

      expect(week.length, 7);
      expect(week.first.weekday, DateTime.monday);
      expect(week.last.weekday, DateTime.sunday);
      expect(CalendarWeekUtils.isSameDay(week[6], date), isTrue);
    });

    test('isInWeek handles month boundaries', () {
      final anchor = DateTime(2024, 12, 2);
      final week = CalendarWeekUtils.getWeekDates(anchor);

      expect(CalendarWeekUtils.isInWeek(week.first, anchor), isTrue);
      expect(CalendarWeekUtils.isInWeek(DateTime(2024, 11, 30), anchor), isFalse);
    });

    test('February 2024 has 5 weeks', () {
      expect(CalendarWeekUtils.getTotalWeeks(DateTime(2024, 2, 1)), 5);
    });

    test('first week of month includes leading days from previous month', () {
      final date = DateTime(2024, 12, 1);
      expect(CalendarWeekUtils.getWeekOfMonth(date), 1);
      final week = CalendarWeekUtils.getWeekDates(date);
      expect(week.first, DateTime(2024, 11, 25));
    });
  });
}
