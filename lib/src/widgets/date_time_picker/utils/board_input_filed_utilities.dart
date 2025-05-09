import 'package:collection/collection.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

import '../board_datetime_options.dart';

enum BoardDateTimeInputError { illegal, outOfRange }

extension BoardDateTimeInputErrorExtension on BoardDateTimeInputError {
  String get message {
    switch (this) {
      case BoardDateTimeInputError.illegal:
        return 'Illegal format error';
      case BoardDateTimeInputError.outOfRange:
        return 'Out of Range';
    }
  }
}

class ValidatorResult {
  final List<TextBloc>? splited;
  final BoardDateTimeInputError? error;
  final DateTimePickerType pickerType;

  ValidatorResult({
    this.splited,
    this.error,
    required this.pickerType,
  });

  DateTime? get datetime {
    if (pickerType == DateTimePickerType.time) {
      final date = DateTime.now();

      final hour = splited?.firstWhereOrNull(
        (e) => e.dateType == DateType.hour,
      );
      final minute = splited?.firstWhereOrNull(
        (e) => e.dateType == DateType.minute,
      );

      return DateTime(
        date.year,
        date.month,
        date.day,
        hour == null || hour.text.isEmpty ? 0 : int.parse(hour.text),
        minute == null || minute.text.isEmpty ? 0 : int.parse(minute.text),
      );
    }

    final year = splited?.firstWhereOrNull(
      (e) => e.dateType == DateType.year,
    );
    final month = splited?.firstWhereOrNull(
      (e) => e.dateType == DateType.month,
    );
    final day = splited?.firstWhereOrNull(
      (e) => e.dateType == DateType.day,
    );
    final hour = splited?.firstWhereOrNull(
      (e) => e.dateType == DateType.hour,
    );
    final minute = splited?.firstWhereOrNull(
      (e) => e.dateType == DateType.minute,
    );
    if (year == null ||
        month == null ||
        year.text.isEmpty ||
        month.text.isEmpty) {
      return null;
    }
    return DateTime(
      int.parse(year.text),
      int.parse(month.text),
      day == null || day.text.isEmpty ? 1 : int.parse(day.text),
      hour == null || hour.text.isEmpty ? 0 : int.parse(hour.text),
      minute == null || minute.text.isEmpty ? 0 : int.parse(minute.text),
    );
  }
}

class TextBloc {
  String text;
  final int start;
  final int end;
  DateType? dateType;

  TextBloc({
    required this.text,
    required this.start,
    required this.end,
  });
}

extension StringExtension on String {
  int get count {
    switch (this) {
      case 'y':
        return 4;
      case 'M':
      case 'd':
      case 'H':
      case 'm':
        return 2;
      default:
        return 0;
    }
  }

  DateType get dateType {
    switch (this) {
      case 'y':
        return DateType.year;
      case 'M':
        return DateType.month;
      case 'd':
        return DateType.day;
      case 'H':
        return DateType.hour;
      case 'm':
        return DateType.minute;
      default:
        return DateType.year;
    }
  }

  String dateFormat(String delimiter) {
    switch (this) {
      case PickerFormat.mdy:
        return 'MM${delimiter}dd${delimiter}yyyy';
      case '${PickerFormat.mdy}Hm':
        return 'MM${delimiter}dd${delimiter}yyyy HH:mm';
      case PickerFormat.dmy:
        return 'dd${delimiter}MM${delimiter}yyyy';
      case '${PickerFormat.dmy}Hm':
        return 'dd${delimiter}MM${delimiter}yyyy HH:mm';
      case PickerFormat.ymd:
        return 'yyyy${delimiter}MM${delimiter}dd';
      case '${PickerFormat.ymd}Hm':
        return 'yyyy${delimiter}MM${delimiter}dd HH:mm';
      default:
        return 'HH:mm';
    }
  }
}
