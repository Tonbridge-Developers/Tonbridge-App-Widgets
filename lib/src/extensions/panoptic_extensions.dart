// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart' as dio;
import 'package:uuid/uuid.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'package:os_detect/os_detect.dart' as os_detect;

class PanopticExtension {
  static bool isWebOrDesktop() {
    return kIsWeb ||
        os_detect.isMacOS ||
        os_detect.isWindows ||
        os_detect.isLinux;
  }

  static int get currentAcademicYear =>
      DateTime.now().add(const Duration(days: -244)).year;

  static DeviceType getDeviceType(BuildContext context) {
    return MediaQuery.of(context).size.width < 800
        ? DeviceType.small
        : DeviceType.large;
  }

  Color getFontColorForBackground(Color background) {
    return (background.computeLuminance() > 0.179)
        ? Colors.black
        : Colors.white;
  }

  static String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static Color stringToColor(String id) {
    try {
      var hash = 0;
      for (int i = 0; i < id.length; i++) {
        hash = const AsciiCodec().encode(id[i])[0] + ((hash << 5) - hash);
      }
      String color = "#";
      for (int i = 0; i < 3; i++) {
        int value = (hash >> (i * 8)) & 0xFF;
        String hex = value.toRadixString(16);
        color += hex;
      }
      color = color.substring(1);
      if (color.length == 1) {
        color += "00000";
      } else if (color.length == 2) {
        color += "0000";
      } else if (color.length == 3) {
        color += color;
      } else if (color.length == 4) {
        color += "00";
      } else if (color.length == 5) {
        color += "0";
      } else if (color.isEmpty) {
        throw Exception("Invalid Hex String");
      }

      return Color(int.parse(color, radix: 16)).withOpacity(1.0);
    } catch (exception) {
      return Colors.black;
    }
  }

  static String stringToHex(String id) {
    try {
      var hash = 0;
      for (int i = 0; i < id.length; i++) {
        hash = const AsciiCodec().encode(id[i])[0] + ((hash << 5) - hash);
      }
      String Color = "#";
      for (int i = 0; i < 3; i++) {
        int value = (hash >> (i * 8)) & 0xFF;
        String hex = value.toRadixString(16);
        Color += hex;
      }
      Color = Color.substring(1);
      if (Color.length == 1) {
        Color += "00000";
      } else if (Color.length == 2) {
        Color += "0000";
      } else if (Color.length == 3) {
        Color += Color;
      } else if (Color.length == 4) {
        Color += "00";
      } else if (Color.length == 5) {
        Color += "0";
      } else if (Color.isEmpty) {
        throw Exception("Invalid Hex String");
      }

      return "ff$Color";
    } catch (exception) {
      return "#ffffff";
    }
  }

  static Color hexToColor(String hex) {
    return Color(int.parse(hex.replaceAll('#', ''), radix: 16))
        .withOpacity(1.0);
  }

  static String colorToHex(Color orig) {
    return orig.value.toRadixString(16);
  }

  static Color createGradientColor(Color original) {
    var hslcolor = HSLColor.fromColor(original);
    try {
      return hslcolor.withHue(hslcolor.hue + 40).toColor();
    } catch (_) {
      return hslcolor.withHue(hslcolor.hue - 40).toColor();
    }
  }

  static Color createReadableColor(Color original, context) =>
      HSLColor.fromColor(original).withLightness(0.6).toColor();

  static void navigatePage(bool replace, Widget page, BuildContext context) {
    if (replace) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ));
    } else {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ));
    }
  }

  static void navigatePageUrl(bool replace, String url, BuildContext context) {
    if (replace) {
      Navigator.of(context).pushReplacementNamed(url);
    } else {
      Navigator.of(context).pushNamed(url);
    }
  }

  static Future<T?> showBottomSheetWithValue<T>(
    BuildContext context,
    Widget page,
    String? title, {
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool expand = true,
    double desktopWidthFactor = 0.6,
    DisplayMode displayMode = DisplayMode.deviceDefault,

    ///for Dialog only - if false, the dialog will be 80% of the screen width (or 100% if on mobile)
    bool dialogFitToContent = false,

    ///for Dialog only
    List<Widget> dialogActions = const [],
  }) async {
    bool accessibleTheme =
        ThemeProvider.controllerOf(context).currentThemeId.startsWith('white');

    DisplayMode mode = displayMode == DisplayMode.deviceDefault
        ? (getDeviceType(context) == DeviceType.large && isWebOrDesktop()
            ? DisplayMode.slideOver
            : DisplayMode.bottomSheet)
        : displayMode;

    if (mode == DisplayMode.slideOver) {
      return await showDialog<T>(
        context: context,
        barrierColor:
            accessibleTheme ? Theme.of(context).colorScheme.surface : null,
        builder: (BuildContext context) => PanopticSlideOver(
          title: title,
          child: page,
        ),
      );
    }

    if (mode == DisplayMode.dialogBox) {
      return await showDialog<T>(
        context: context,
        barrierDismissible: isDismissible,
        barrierColor:
            accessibleTheme ? Theme.of(context).colorScheme.surface : null,
        builder: (BuildContext context) => PanopticDialog(
          title: title ?? '',
          actions: dialogActions,
          scrollable: isScrollControlled,
          isDismissible: isDismissible,
          child: dialogFitToContent
              ? page
              : Container(
                  width: MediaQuery.of(context).size.width *
                      (isWebOrDesktop() ? desktopWidthFactor : 0.8),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width),
                  child: page,
                ),
        ),
      );
    }

    if (mode == DisplayMode.bottomSheet) {
      return await showModalBottomSheet<T>(
        context: context,
        barrierColor:
            accessibleTheme ? Theme.of(context).colorScheme.surface : null,
        builder: (BuildContext context) => DraggableScrollableSheet(
          maxChildSize: 0.9,
          minChildSize:
              PanopticExtension.isWebOrDesktop() || expand ? 0.7 : 0.4,
          initialChildSize:
              PanopticExtension.isWebOrDesktop() || expand ? 0.7 : 0.4,
          expand: false,
          builder: (context, scrollController) => ListView(
            controller: scrollController,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: isDismissible ? 0 : 10,
                  bottom: isDismissible ? 0 : 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title ?? '',
                        textScaler: const TextScaler.linear(1.34),
                      ),
                    ),
                    if (isDismissible)
                      IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: const Icon(Icons.close_rounded))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: page,
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
              )
            ],
          ),
        ),
        isScrollControlled: isScrollControlled,
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
        isDismissible: isDismissible,
        showDragHandle: isDismissible,
        constraints: BoxConstraints(
            maxWidth: getDeviceType(context) == DeviceType.large
                ? MediaQuery.of(context).size.width *
                    (PanopticExtension.isWebOrDesktop()
                        ? desktopWidthFactor
                        : 0.8)
                : MediaQuery.of(context).size.width,
            minWidth: getDeviceType(context) == DeviceType.large
                ? MediaQuery.of(context).size.width *
                    (PanopticExtension.isWebOrDesktop()
                        ? desktopWidthFactor
                        : 0.8)
                : MediaQuery.of(context).size.width),
      );
    }

    return null;
  }

  static Future<bool> launch(String url,
      {LaunchMode mode = LaunchMode.platformDefault}) async {
    Uri uri = Uri.parse(url);

    if (url.startsWith("ton.school://") || await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
      return true;
    } else {
      return false;
    }
  }

  static String formatDate(DateTime date, {String format = "dd/MM/yyyy"}) {
    return DateFormat(format).format(date);
  }

  static void showToast(String message, BuildContext? context,
      {ToastType type = ToastType.success,
      String? subTitle,
      bool usingWrapper = true}) {
    if (!usingWrapper && context == null) {
      throw Exception('Either use the wrapper or provide a context');
    }

    PanopticIcons icon = PanopticIcons.success;

    ToastificationType toastificationType = ToastificationType.success;

    switch (type) {
      case ToastType.success:
        icon = PanopticIcons.success;

        toastificationType = ToastificationType.success;
        break;
      case ToastType.error:
        icon = PanopticIcons.error;

        toastificationType = ToastificationType.error;
        break;
      case ToastType.warning:
        icon = PanopticIcons.warning;
        toastificationType = ToastificationType.warning;
        break;
      case ToastType.info:
        icon = PanopticIcons.info;
        toastificationType = ToastificationType.info;
        break;
    }

    toastification.show(
      context: usingWrapper ? null : context,
      title: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: PanopticExtension.isWebOrDesktop()
          ? Alignment.topRight
          : Alignment.bottomCenter,
      type: toastificationType,
      borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
      closeOnClick: true,
      applyBlurEffect: true,
      style: ToastificationStyle.fillColored,
      icon: PanopticIcon(
        icon: icon,
        color: Colors.white,
        margin: EdgeInsets.zero,
        size: 28,
      ),
      description: subTitle != null
          ? Text(
              subTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          : null,
    );
  }

  static void showToastWithoutContext(String message,
      {ToastType type = ToastType.success,
      String? subTitle,
      bool usingWrapper = true}) {
    PanopticIcons icon = PanopticIcons.success;

    ToastificationType toastificationType = ToastificationType.success;

    switch (type) {
      case ToastType.success:
        icon = PanopticIcons.success;

        toastificationType = ToastificationType.success;
        break;
      case ToastType.error:
        icon = PanopticIcons.error;

        toastificationType = ToastificationType.error;
        break;
      case ToastType.warning:
        icon = PanopticIcons.warning;
        toastificationType = ToastificationType.warning;
        break;
      case ToastType.info:
        icon = PanopticIcons.info;
        toastificationType = ToastificationType.info;
        break;
    }

    toastification.show(
      title: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: PanopticExtension.isWebOrDesktop()
          ? Alignment.topRight
          : Alignment.bottomCenter,
      type: toastificationType,
      borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
      closeOnClick: true,
      applyBlurEffect: true,
      style: ToastificationStyle.fillColored,
      icon: PanopticIcon(
        icon: icon,
        color: Colors.white,
        margin: EdgeInsets.zero,
        size: 28,
      ),
      description: subTitle != null
          ? Text(
              subTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          : null,
    );
  }

  static int calculateCrossAxisCount(BuildContext context,
      {double baseSize = 300}) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = width ~/ baseSize;
    return crossAxisCount <= 0 ? 1 : crossAxisCount;
  }

  static Future<String?> openBarcodeScanner(BuildContext context) async {
    return await Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PanopticBarcodeScanner(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    ));
  }

  static void saveFile(
      Uint8List data, String fileName, MimeType mimeType, BuildContext context,
      {bool share = true, bool download = true, bool shareOnWeb = false}) {
    if (download) {
      FileSaver.instance
          .saveFile(name: fileName, bytes: data, mimeType: mimeType);
    }

    if (share &&
        (!PanopticExtension.isWebOrDesktop() ||
            (PanopticExtension.isWebOrDesktop() && shareOnWeb))) {
      try {
        Share.shareXFiles(
          [
            XFile.fromData(
              data,
              mimeType: mimeType.type,
              name: fileName,
            ),
          ],
          subject: 'Share $fileName',
          fileNameOverrides: [fileName],
        );
      } catch (e) {
        showToast(
            'File Saved - Find it in ${Theme.of(context).platform == TargetPlatform.windows ? 'Downloads' : 'Files'}',
            context);
      }
    } else {
      showToast(
          'File Saved - Find it in ${Theme.of(context).platform == TargetPlatform.windows ? 'Downloads' : 'Files'}',
          context);
    }
  }

  static Color shiftHue(Color color, double shiftAmount) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withHue((hsl.hue + shiftAmount) % 360).toColor();
  }

  static MimeType mimeTypeFromExtension(String extension) {
    return MimeType.values.firstWhere(
        (element) => element.type.contains(extension),
        orElse: () => MimeType.custom);
  }

  static MimeType mimeTypeFromName(String name) {
    return MimeType.values.firstWhere((element) => element.name.contains(name),
        orElse: () => MimeType.custom);
  }

  static double calculateAspectRatio(BuildContext context,
      {double mobile = 2.5, double desktop = 1.5}) {
    return PanopticExtension.getDeviceType(context) == DeviceType.large
        ? (desktop * MediaQuery.of(context).textScaler.scale(1))
        : (mobile * MediaQuery.of(context).textScaler.scale(1));
  }

  static List<List<T>> splitListIntoGroups<T>(List<T> list, int groupSize) {
    List<List<T>> groups = [];
    for (int i = 0; i < list.length; i += groupSize) {
      int end = (i + groupSize < list.length) ? i + groupSize : list.length;
      groups.add(list.sublist(i, end));
    }
    return groups;
  }
}

/// Converts to and from [Uint8List] and [List]<[int]>.

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  /// Create a new instance of [Uint8ListConverter].
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    if (json == null) return null;

    return Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    if (object == null) return null;

    return object.toList();
  }
}

extension CellValueExtension on CellValue {
  get() {
    switch (this) {
      case TextCellValue _:
        return (this as TextCellValue).value.text;
      case IntCellValue _:
        return (this as IntCellValue).value;
      case DoubleCellValue _:
        return (this as DoubleCellValue).value;
      case BoolCellValue _:
        return (this as BoolCellValue).value;
      case DateCellValue _:
        return (this as DateCellValue).asDateTimeLocal();
      case TimeCellValue _:
        return (this as DateCellValue).asDateTimeLocal();
      case DateTimeCellValue _:
        return (this as DateCellValue).asDateTimeLocal();
      case _:
        return null;
    }
  }
}

extension DecimalExtension on num {
  double normalize() {
    return this / 1.000000000000000000000000000000000;
  }

  String toRadixString(int radix) {
    return round().toRadixString(radix);
  }

  int roundToNearestEven() {
    int rounded = round();
    // If the rounded number is odd, adjust by 1 towards the nearest even number
    return rounded.isOdd ? rounded - 1 : rounded;
  }

  int roundToNearestEvenOrOne() {
    int rounded = round();
    // If the rounded number is odd, adjust by 1 towards the nearest even number
    return rounded == 1 ? rounded : (rounded.isOdd ? rounded - 1 : rounded);
  }
}

extension NullableDecimalExtension on num? {
  double? normalize() {
    return this != null ? this! / 1.000000000000000000000000000000000 : null;
  }

  int roundToNearestEven() {
    if (this == null) return 0;
    int rounded = this!.round();
    // If the rounded number is odd, adjust by 1 towards the nearest even number
    return rounded.isOdd ? rounded - 1 : rounded;
  }

  int roundToNearestEvenOrOne() {
    if (this == null) return 0;
    int rounded = this!.round();
    // If the rounded number is odd, adjust by 1 towards the nearest even number
    return rounded == 1 ? rounded : (rounded.isOdd ? rounded - 1 : rounded);
  }
}

extension IntExtension on int {
  bool hasFlag<T extends Enum>(T flag) {
    int bit = 1 << flag.index;
    return (this & bit) == bit;
  }
}

extension StreamedResponseExtension on StreamedResponse {
  bool isSuccess() {
    return statusCode >= 200 && statusCode < 300;
  }
}

extension ResponseExtension on Response {
  bool isSuccess() {
    return statusCode >= 200 && statusCode < 300;
  }
}

extension DioResponseExtension on dio.Response<dynamic> {
  bool isSuccess() {
    return statusCode != null ? statusCode! >= 200 && statusCode! < 300 : false;
  }
}

extension CoreBaseFileExtension on CoreBaseFile {
  CoreFile toCoreFile() {
    return CoreFile(lastModified: DateTime.now(), uploadedDate: DateTime.now())
      ..id = id
      ..documentName = documentName
      ..contentType = contentType
      ..content = content
      ..tagsString = tagsString
      ..uploadedDate = uploadedDate
      ..uploadedBy = uploadedBy;
  }
}

extension CoreFileExtension on CoreFile {
  CoreBaseFile toBaseFile() {
    return CoreBaseFile(uploadedDate: DateTime.now())
      ..id = id
      ..documentName = documentName
      ..contentType = contentType
      ..content = content
      ..tagsString = tagsString
      ..uploadedDate = uploadedDate
      ..uploadedBy = uploadedBy;
  }
}

extension TimeOfDayExtension on TimeOfDay {
  static TimeOfDay fromJson(String json) {
    final parts = json.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String toJson(TimeOfDay time) {
    return '${time.hhmm()}:00';
  }

  String hhmm() {
    String hour = this.hour.toString();
    String minute = this.minute.toString();
    if (hour.length == 1) {
      hour = '0$hour';
    }
    if (minute.length == 1) {
      minute = '0$minute';
    }
    return '$hour:$minute';
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString({String format = "dd/MM/yyyy"}) {
    return DateFormat(format).format(this);
  }

  /// Add day
  /// Generate a new DateTime using the constructor of
  /// DateTime to account for daylight saving time
  DateTime addDay(int v) {
    return DateTime(year, month, day + v);
  }

  DateTime addDayWithTime(int v) {
    return DateTime(year, month, day + v, hour, minute, second);
  }

  bool isMinimum(DateTime date, DateType dt, {bool equal = true}) {
    bool operator(a, b) {
      if (equal) {
        return a <= b;
      }
      return a < b;
    }

    switch (dt) {
      case DateType.year:
        return operator(year, date.year);
      case DateType.month:
        if (year < date.year) return true;
        return year <= date.year && operator(month, date.month);
      case DateType.day:
        if (year < date.year) return true;
        if (year <= date.year && month < date.month) return true;
        return year <= date.year &&
            month <= date.month &&
            operator(day, date.day);
      case DateType.hour:
        if (year < date.year) return true;
        if (year <= date.year && month < date.month) return true;
        if (year <= date.year && month <= date.month && day < date.day) {
          return true;
        }
        return year <= date.year &&
            month <= date.month &&
            day <= date.day &&
            operator(hour, date.hour);
      case DateType.minute:
        if (year < date.year) return true;
        if (year <= date.year && month < date.month) return true;
        if (year <= date.year && month <= date.month && day < date.day) {
          return true;
        }
        if (year <= date.year &&
            month <= date.month &&
            day <= date.day &&
            hour < date.hour) {
          return true;
        }
        return year <= date.year &&
            month <= date.month &&
            day <= date.day &&
            hour <= date.hour &&
            operator(minute, date.minute);
    }
  }

  bool isMaximum(DateTime date, DateType dt, {bool equal = true}) {
    bool operator(a, b) {
      if (equal) {
        return a >= b;
      }
      return a > b;
    }

    switch (dt) {
      case DateType.year:
        return operator(year, date.year);
      case DateType.month:
        if (year > date.year) return true;
        return year >= date.year && operator(month, date.month);
      case DateType.day:
        if (year > date.year) return true;
        if (year >= date.year && month > date.month) return true;
        return year >= date.year &&
            month >= date.month &&
            operator(day, date.day);
      case DateType.hour:
        if (year > date.year) return true;
        if (year >= date.year && month > date.month) return true;
        if (year >= date.year && month >= date.month && day > date.day) {
          return true;
        }
        return year >= date.year &&
            month >= date.month &&
            day >= date.day &&
            operator(hour, date.hour);
      case DateType.minute:
        if (year > date.year) return true;
        if (year >= date.year && month > date.month) return true;
        if (year >= date.year && month >= date.month && day > date.day) {
          return true;
        }
        if (year >= date.year &&
            month >= date.month &&
            day >= date.day &&
            hour > date.hour) {
          return true;
        }
        return year >= date.year &&
            month >= date.month &&
            day >= date.day &&
            hour >= date.hour &&
            operator(minute, date.minute);
    }
  }

  bool compareDate(DateTime d1) {
    return d1.year == year && d1.month == month && d1.day == day;
  }

  DateTime calcMonth(int diff) {
    DateTime date = this;
    if (diff > 0) {
      var nextYear = year;
      var nextMonth = month + diff;

      if (month >= 12) {
        final x = nextMonth % 12;
        nextYear += nextMonth ~/ 12;
        nextMonth = x;
      }
      date = DateTime(nextYear, nextMonth, 1);
    } else if (diff < 0) {
      DateTime x0 = DateTime(date.year, date.month, 1);
      for (var i = 0; i < diff.abs(); i++) {
        final y = x0.addDay(-1);
        x0 = DateTime(y.year, y.month, 1);
      }
      date = x0;
    }
    return date;
  }

  /// Check if the date is within the specified range
  bool isWithinRange(DateTime minimum, DateTime maximum) {
    return isAfter(minimum) && isBefore(maximum);
  }

  /// Obtain a value of a specified type from DateTime
  int valFromType(DateType type) {
    switch (type) {
      case DateType.year:
        return year;
      case DateType.month:
        return month;
      case DateType.day:
        return day;
      case DateType.hour:
        return hour;
      case DateType.minute:
        return minute;
    }
  }

  DateTime removeTime() {
    return DateTime(year, month, day);
  }

  String toWeekDayString() {
    switch (weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "Unknown";
    }
  }

  String toAge({trailing = ' ago'}) {
    const int second = 1;
    const int minute = 60 * second;
    const int hour = 60 * minute;
    const int day = 24 * hour;
    const int month = 30 * day;
    const int year = 12 * month;

    Duration timeSpan = DateTime.now().difference(this);
    int delta = timeSpan.inSeconds.abs();

    if (delta < minute) {
      return "<1m$trailing";
    } else if (delta < hour) {
      return "${timeSpan.inMinutes}m$trailing";
    } else if (delta < day) {
      return "${timeSpan.inHours}h$trailing";
    } else if (delta < month) {
      return "${timeSpan.inDays}d$trailing";
    } else if (delta < year) {
      int months = (timeSpan.inDays / 30).floor();
      return "${months}mth$trailing";
    } else {
      int years = (timeSpan.inDays / 365).floor();
      return "${years}yrs$trailing";
    }
  }

  DateTime zeroTime() {
    return DateTime(year, month, day);
  }
}

extension DateTimeNullExtension on DateTime? {
  String formatDate({String format = "dd/MM/yyyy"}) {
    return DateFormat(format).format(this!);
  }
}

extension ListExtension<T> on List<T> {
  List<T> shuffle() {
    int n = length;

    while (n > 1) {
      n--;
      int k = Random().nextInt(n + 1);
      T value = this[k];
      this[k] = this[n];
      this[n] = value;
    }

    return this;
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inPlace = false]) {
    final ids = <dynamic>{};
    var list = inPlace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension DeltaExtension on Delta {
  String toHtml() {
    QuillDeltaToHtmlConverter converter = QuillDeltaToHtmlConverter(toJson());

    return converter.convert();
  }

  Delta fromHtml(String html) {
    return HtmlToDelta().convert(html);
  }
}

extension DataGridRowExtension on DataGridRow {
  T getItem<T>() {
    PanopticDataGridRow<T> row = this as PanopticDataGridRow<T>;
    return row.item;
  }
}

extension DataGridRowsExtension on List<DataGridRow> {
  List<T> getItems<T>() {
    return cast<PanopticDataGridRow<T>>().map((e) => e.item).toList();
  }
}

extension ColorExtension on Color {
  String toHex({bool leadingHash = true, bool inclAlpha = false}) {
    final buffer = StringBuffer();
    if (leadingHash) buffer.write('#');
    if (inclAlpha) {
      buffer.write(alpha.toRadixString(16).padLeft(2, '0'));
    }

    buffer.write(red.toRadixString(16).padLeft(2, '0'));
    buffer.write(green.toRadixString(16).padLeft(2, '0'));
    buffer.write(blue.toRadixString(16).padLeft(2, '0'));

    return buffer.toString();
  }
}

extension StringExtension on String {
  bool containsAny(List<String> values) {
    for (String value in values) {
      if (contains(value)) {
        return true;
      }
    }
    return false;
  }

  T? firstMatch<T>(List<T> values) {
    for (T value in values) {
      if (contains(value.toString())) {
        return value;
      }
    }
    return null;
  }

  bool get isWhiteSpace {
    return trim().isEmpty;
  }

  String firstToUpper() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toTitleCase() {
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  String nameToPossessive() {
    if (trim().isEmpty) {
      return this;
    }
    final lastChar = this[length - 1];
    if (lastChar == 's' || lastChar == 'S') {
      return "$this'";
    }
    if (lastChar.toUpperCase() == lastChar) {
      return "$this'S";
    }
    return "$this's";
  }

  Delta toDelta() {
    return HtmlToDelta().convert(this);
  }

  String fromDelta(Delta delta) {
    QuillDeltaToHtmlConverter converter =
        QuillDeltaToHtmlConverter(delta.toJson());

    return converter.convert();
  }
}

extension StringNullableExtension on String? {
  bool get isWhiteSpace {
    if (this == null) {
      return false;
    }
    return this!.trim().isEmpty;
  }

  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }

  bool get isNullOrWhitespace {
    return this?.trim().isEmpty ?? true;
  }
}

extension DebugStringExtension<T> on T {
  String toDebugString() {
    final serialized = jsonEncode(this);
    return serialized;
  }
}

String generateGUID() {
  return const Uuid().v4().toString().substring(0, 32);
}

String? calculateAge(DateTime birthDate, DateTime ageAtDate) {
  DateTime dateOfBirth = birthDate;
  int months = ageAtDate.month - dateOfBirth.month;
  int years = ageAtDate.year - dateOfBirth.year;

  if (ageAtDate.day < dateOfBirth.day) {
    months--;
  }

  if (months < 0) {
    years--;
    months += 12;
  }

  return '$years.$months';
}

String getUniqueKeyOriginalBiased(int size) {
  List<String> chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
          .split('');

  List<int> data =
      List<int>.generate(size, (index) => Random.secure().nextInt(256));
  StringBuffer result = StringBuffer();
  for (var b in data) {
    result.write(chars[b % chars.length]);
  }
  return result.toString();
}

class ColumnSizeController extends ColumnSizer {
  @override
  double computeCellWidth(
    GridColumn column,
    DataGridRow row,
    Object? cellValue,
    TextStyle textStyle,
  ) {
    // I set the property to maximumWidth but you can play more.
    return column.maximumWidth;
  }
}
