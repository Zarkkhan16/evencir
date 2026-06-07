abstract final class CalendarWeekUtils {
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static DateTime mondayOfWeek(DateTime date) {
    final normalized = dateOnly(date);
    return normalized.subtract(Duration(days: normalized.weekday - DateTime.monday));
  }

  static List<DateTime> getWeekDates(DateTime date) {
    final monday = mondayOfWeek(date);
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  static DateTime calendarGridStart(DateTime monthDate) {
    final firstDay = DateTime(monthDate.year, monthDate.month, 1);
    return mondayOfWeek(firstDay);
  }

  static DateTime calendarGridEnd(DateTime monthDate) {
    final lastDay = DateTime(monthDate.year, monthDate.month + 1, 0);
    final daysUntilSunday = DateTime.sunday - lastDay.weekday;
    return dateOnly(lastDay.add(Duration(days: daysUntilSunday)));
  }

  static int getTotalWeeks(DateTime monthDate) {
    final start = calendarGridStart(monthDate);
    final end = calendarGridEnd(monthDate);
    return ((end.difference(start).inDays + 1) / 7).ceil();
  }

  static int getWeekOfMonth(DateTime date) {
    final gridStart = calendarGridStart(date);
    final weekMonday = mondayOfWeek(date);
    return weekMonday.difference(gridStart).inDays ~/ 7 + 1;
  }

  static String weekLabel(DateTime date) {
    final weekIndex = getWeekOfMonth(date);
    final totalWeeks = getTotalWeeks(date);
    return 'Week $weekIndex/$totalWeeks';
  }

  static bool isInSameWeek(DateTime a, DateTime b) {
    return isSameDay(mondayOfWeek(a), mondayOfWeek(b));
  }

  static bool isInWeek(DateTime day, DateTime weekAnchor) {
    return isInSameWeek(day, weekAnchor);
  }
}
