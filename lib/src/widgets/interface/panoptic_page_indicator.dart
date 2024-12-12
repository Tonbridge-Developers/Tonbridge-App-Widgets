import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticPageIndicator extends StatefulWidget {
  final ValueNotifier<int> pageCount;
  final ValueNotifier<int> currentPage;
  final int visibleButtonCount;

  final void Function(int)? onPageChanged;

  const PanopticPageIndicator({
    required this.pageCount,
    required this.currentPage,
    required this.visibleButtonCount,
    this.onPageChanged,
    super.key,
  });

  @override
  State<PanopticPageIndicator> createState() => _PanopticPageIndicatorState();
}

class _PanopticPageIndicatorState extends State<PanopticPageIndicator> {
  late ScrollController _controller;
  final double _buttonSize = 40;
  final double _buttonHorizontalMargin = 1;
  int _currentIndex = 0;
  int _pageCount = 0;
  int _halfButtonCount = 0;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _pageCount = widget.pageCount.value;
    _halfButtonCount = (widget.visibleButtonCount * 0.5).floor();
    if (_halfButtonCount < 1) {
      _halfButtonCount = 1;
    }

    widget.pageCount.addListener(_updatePageCount);
    widget.currentPage.addListener(_updateCurrentPage);
  }

  void _updatePageCount() {
    setState(() {
      _pageCount = widget.pageCount.value;
    });
  }

  void _updateCurrentPage() {
    setState(() {
      _currentIndex = widget.currentPage.value - 1;
      _animateToIndex(_currentIndex);
    });
  }

  double _calculatePageButtonListWidth() {
    return (_buttonSize + 2 * _buttonHorizontalMargin) *
        (_pageCount < widget.visibleButtonCount
            ? _pageCount
            : widget.visibleButtonCount);
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * (_buttonSize + 2 * _buttonHorizontalMargin),
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future _handleButtonPress(int direction) async {
    int oldIndex = _currentIndex;

    setState(() {
      _loading = true;
      _currentIndex += direction;
      if (_currentIndex < 0) {
        _currentIndex = 0;
      }
      if (_currentIndex >= _pageCount) {
        _currentIndex = _pageCount - 1;
      }
    });

    widget.currentPage.value = _currentIndex + 1;

    if (oldIndex != _currentIndex) {
      widget.onPageChanged?.call(_currentIndex);
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageButtons(theme),
        ],
      ),
    );
  }

  Widget _buildPageButtons(ThemeData theme) {
    bool atStart = _currentIndex == 0;
    bool atEnd = _currentIndex == _pageCount - 1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton<PanopticIcons>(
          value: PanopticIcons.doubleleft,
          selected: false,
          theme: theme,
          disabled: atStart || _loading,
          onPressed: () async =>
              await _handleButtonPress(-double.maxFinite.toInt()),
        ),
        _buildButton<PanopticIcons>(
          value: PanopticIcons.chevronleft,
          selected: false,
          theme: theme,
          disabled: atStart || _loading,
          onPressed: () async => await _handleButtonPress(-1),
        ),
        SizedBox(
          width: _calculatePageButtonListWidth(),
          height: 50,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: _pageCount,
            itemBuilder: (ctx, index) {
              return _buildButton<int>(
                  value: index + 1,
                  selected: index == _currentIndex,
                  theme: theme,
                  disabled: _loading,
                  onPressed: () async =>
                      await _handleButtonPress(index - _currentIndex));
            },
          ),
        ),
        _buildButton<PanopticIcons>(
            value: PanopticIcons.chevronright,
            selected: false,
            theme: theme,
            disabled: atEnd || _loading,
            onPressed: () async => await _handleButtonPress(1)),
        _buildButton<PanopticIcons>(
            value: PanopticIcons.doubleright,
            selected: false,
            theme: theme,
            disabled: atEnd || _loading,
            onPressed: () async =>
                await _handleButtonPress(double.maxFinite.toInt())),
      ],
    );
  }

  Widget _buildButton<T>({
    required T value,
    required bool selected,
    required ThemeData theme,
    required void Function() onPressed,
    disabled = false,
  }) {
    Widget child;
    Color buttonColor;
    if (value is PanopticIcons) {
      child = PanopticIcon(
        icon: value,
        size: 20,
        // color: theme.colorScheme.onPrimary,
      );
      buttonColor = theme.colorScheme.primary;
      buttonColor = theme.colorScheme.surface;
    } else {
      child = Text(value.toString());
      buttonColor =
          selected ? theme.colorScheme.primary : theme.colorScheme.surface;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: _buttonHorizontalMargin),
      constraints:
          BoxConstraints.tightFor(width: _buttonSize, height: _buttonSize),
      child: Center(
        child: MaterialButton(
          height: 50,
          disabledColor: theme.colorScheme.surface,
          onPressed: disabled ? null : onPressed,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
          ),
          color: buttonColor,
          child: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.pageCount.removeListener(_updatePageCount);
    widget.currentPage.removeListener(_updateCurrentPage);

    super.dispose();
  }
}
