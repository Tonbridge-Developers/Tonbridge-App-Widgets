import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/date_time_picker/options/board_item_option.dart';

class DateTimeUtil {
  ///. Default Minimum Date Year
  static const int minimumYear = 1970;

  /// Default Maximum Date Year
  static const int maximumYear = 2050;

  ///. Default Minimum Date
  static DateTime defaultMinDate = DateTime(minimumYear, 1, 1, 0, 0);

  /// Default Maximum Date
  static DateTime defaultMaxDate = DateTime(maximumYear, 12, 31, 23, 59);

  /// List of days of the week beginning on Sunday
  static List<int> weekdayVals = [7, 1, 2, 3, 4, 5, 6];

  /// Update the date when the year or month is changed.
  /// Therefore, get the last date that exists in year and month.
  static int? getExistsMaxDate(
    List<BoardPickerItemOption> options,
    BoardPickerItemOption selected,
    int val,
  ) {
    if (![DateType.year, DateType.month].contains(selected.type)) {
      return null;
    }

    final yearOption = options.firstWhere((x) => x.type == DateType.year);
    final monthOption = options.firstWhere((x) => x.type == DateType.month);

    var year = yearOption.value;
    var month = monthOption.value;

    if (selected.type == DateType.year) {
      year = val;
    } else if (selected.type == DateType.month) {
      month = val;
    }

    month += 1;
    if (month > 12) month = 1;
    final date = DateTime(year, month, 1).addDay(-1);

    return date.day;
  }

  /// If minimum and maximum dates are specified,
  /// check whether they are within the range and return values that fall within the range.
  static DateTime rangeDate(
    DateTime date,
    DateTime? minimumDate,
    DateTime? maximumDate,
  ) {
    DateTime newVal = date;
    if (minimumDate != null && date.isBefore(minimumDate)) {
      newVal = minimumDate;
    } else if (maximumDate != null && date.isAfter(maximumDate)) {
      newVal = maximumDate;
    }
    return newVal;
  }

  static int? existDay(int year, int month, int day) {
    final val = DateTime(year, month, day);
    final same = year == val.year && month == val.month && day == val.day;

    // 指定の日付と実際の変換した値が異なる場合は
    // 日(day)が存在しない範囲である
    if (!same) {
      if (month == 12) {
        year += 1;
        month = 1;
      } else {
        month += 1;
      }
      return DateTime(year, month, 1).add(const Duration(days: -1)).day;
    }
    return null;
  }
}
