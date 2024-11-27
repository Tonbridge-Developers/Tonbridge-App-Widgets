import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticPager extends StatefulWidget {
  final int totalRowCount;
  final int pageSize;
  final List<int> availableRowsPerPage;
  final PanopticDataSource dataSource;
  final int visibleButtonCount;

  final void Function(int)? onRowsPerPageChanged;
  final void Function()? onPageNavigationStart;
  final void Function()? onPageNavigationEnd;

  const PanopticPager({
    required this.totalRowCount,
    required this.pageSize,
    required this.dataSource,
    this.visibleButtonCount = 3,
    this.availableRowsPerPage = const [10, 20, 50, 100],
    this.onRowsPerPageChanged,
    this.onPageNavigationStart,
    this.onPageNavigationEnd,
    super.key,
  });

  @override
  State<PanopticPager> createState() => _PanopticPagerState();
}

class _PanopticPagerState extends State<PanopticPager> {
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
    _pageCount = _calculatePageCount(widget.totalRowCount, widget.pageSize);
    _halfButtonCount = (widget.visibleButtonCount * 0.5).floor();
    if (_halfButtonCount < 1) {
      _halfButtonCount = 1;
    }
    widget.dataSource.addOnPageChangeListener(_handleDataSourcePageChange);
  }

  int _calculatePageCount(int rowCount, int pageSize) {
    int pageCount = (rowCount / pageSize).ceil();
    if (pageCount < 1) {
      return 1;
    }
    return pageCount;
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

  /// Handles the data source's page change event being called externally.
  /// (i.e. not called by the pager itself)
  Future _handleDataSourcePageChange(int index) async {
    if (_currentIndex == index) {
      return;
    }
    _currentIndex = index;
    _animateToIndex(index);
    _pageCount = _calculatePageCount(widget.totalRowCount, widget.pageSize);
  }

  Future _handleButtonPress(int direction) async {
    widget.onPageNavigationStart?.call();
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

    if (_pageCount > widget.visibleButtonCount) {
      int animateToIndex;
      int pageCountDiff = _pageCount - widget.visibleButtonCount;
      if (_currentIndex > pageCountDiff) {
        animateToIndex = pageCountDiff;
      } else if (_currentIndex < _halfButtonCount) {
        animateToIndex = 0;
      } else {
        animateToIndex = _currentIndex - _halfButtonCount;
      }

      _animateToIndex(animateToIndex);

      if (oldIndex != _currentIndex) {
        await widget.dataSource.handlePageChange(oldIndex, _currentIndex);
        widget.dataSource.notifyListeners();
      }
    }

    setState(() => _loading = false);
    widget.onPageNavigationEnd?.call();
  }

  void _handlePageSizeChange(int? newPageSize) {
    if (newPageSize == null) {
      return;
    }
    widget.onRowsPerPageChanged?.call(newPageSize);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool smallDevice =
        PanopticExtension.getDeviceType(context) == DeviceType.small;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageButtons(theme),
          if (!smallDevice) ...[
            const SizedBox(width: 4),
            _buildInfo(theme),
            const Spacer(),
            _buildPageSizeDropdown(theme),
          ]
        ],
      ),
    );
  }

  Widget _buildInfo(ThemeData theme) {
    String results = '${widget.totalRowCount} results';
    // String filters = widget.filterCount != null ? ' using ${widget.filterCount} filters' : '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
      ),
      child: Text(results),
    );
  }

  Widget _buildPageSizeDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Rows per page:'),
          const SizedBox(width: 10),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              // itemHeight: 50,
              isDense: true,
              borderRadius:
                  BorderRadius.circular(CoreValues.cornerRadius * 0.8),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              value: widget.pageSize,
              items: widget.availableRowsPerPage
                  .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e.toString())))
                  .toList(),
              onChanged: _handlePageSizeChange,
            ),
          ),
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
        _buildButton<CoreIcons>(
          value: CoreIcons.doubleleft,
          selected: false,
          theme: theme,
          disabled: atStart || _loading,
          onPressed: () async =>
              await _handleButtonPress(-double.maxFinite.toInt()),
        ),
        _buildButton<CoreIcons>(
          value: CoreIcons.chevronleft,
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
        _buildButton<CoreIcons>(
            value: CoreIcons.chevronright,
            selected: false,
            theme: theme,
            disabled: atEnd || _loading,
            onPressed: () async => await _handleButtonPress(1)),
        _buildButton<CoreIcons>(
            value: CoreIcons.doubleright,
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
    if (value is CoreIcons) {
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
    widget.dataSource.removeOnPageChangeListener(_handleDataSourcePageChange);
    super.dispose();
  }
}
