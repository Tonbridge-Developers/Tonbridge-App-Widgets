import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class PanopticDateTimeline extends StatefulWidget {
  const PanopticDateTimeline(
      {super.key,
      required this.firstDate,
      required this.lastDate,
      required this.initialDate,
      this.controller,
      required this.onDateChange});
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final Function(DateTime) onDateChange;
  final EasyDatePickerController? controller;

  @override
  State<PanopticDateTimeline> createState() => _PanopticDateTimelineState();
}

class _PanopticDateTimelineState extends State<PanopticDateTimeline> {
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLinePicker(
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      focusedDate: _selectedDate,
      onDateChange: (date) {
        setState(() {
          _selectedDate = date;
        });
        widget.onDateChange(date);
      },
      controller: widget.controller,
    );
  }
}
