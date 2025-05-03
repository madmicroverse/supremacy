extension DateTimeUtils on DateTime {
  DateTime get yearDateTime => DateTime(year);

  DateTime get yearMonthDateTime => DateTime(year, month);

  DateTime get nextMonth => copyWith(month: month + 1);

  DateTime get nextYear => copyWith(year: year + 1);

  bool sameYearMonth(DateTime other) =>
      yearMonthDateTime == other.yearMonthDateTime;

  List<DateTime> mothsUntil(DateTime? limit) {
    final months = <DateTime>[yearMonthDateTime];

    while (limit != null && !months.last.sameYearMonth(limit)) {
      final newMonth = months.last.copyWith(month: months.last.month + 1);
      months.add(newMonth);
    }

    return months;
  }

  bool equalsUpToMinutes(DateTime? other) {
    return year == other?.year &&
        month == other?.month &&
        day == other?.day &&
        hour == other?.hour &&
        minute == other?.minute;
  }
}
