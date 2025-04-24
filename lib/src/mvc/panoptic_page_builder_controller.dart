import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

abstract class PanopticPageBuilderController<T> extends ChangeNotifier {
  final T model;
  ShowFiltersDelegate? _onShowFilters;
  ShowHelpDelegate? _onShowHelp;

  // page parameters
  String _pageTitle = 'Page';
  PanopticButton? _actionButton;
  List<PanopticSplitButtonAction> _splitButtonActions = const [];
  bool _hideSearch = false;
  Widget? _leading;
  TabBar? _tabs;
  PanopticLoading? _loadingWidget;
  Widget? _helpContent;
  int? _filterCount;
  bool _useFilterForm = true;
  SingleTickerProviderStateMixin? ticker;
  TabController? tabController;
  String? errorMessage;

  String get pageTitle => _pageTitle;
  PanopticButton? get actionButton => _actionButton;
  List<PanopticSplitButtonAction> get splitButtonActions => _splitButtonActions;
  bool get hideSearch => _hideSearch;
  Widget? get leading => _leading;
  TabBar? get tabs => _tabs;
  PanopticLoading? get loadingWidget => _loadingWidget;
  Widget? get helpContent => _helpContent;
  int? get filterCount => _filterCount;
  bool get useFilterForm => _useFilterForm;

  set pageTitle(String value) {
    _pageTitle = value;
    notifyPageChange();
  }

  set actionButton(PanopticButton? value) {
    _actionButton = value;
    notifyPageChange();
  }

  set splitButtonActions(List<PanopticSplitButtonAction> value) {
    _splitButtonActions = value;
    notifyPageChange();
  }

  set hideSearch(bool value) {
    _hideSearch = value;
    notifyPageChange();
  }

  set leading(Widget? value) {
    _leading = value;
    notifyPageChange();
  }

  set tabs(TabBar? value) {
    _tabs = value;
    notifyPageChange();
  }

  set loadingWidget(PanopticLoading? value) {
    _loadingWidget = value;
    notifyPageChange();
  }

  set helpContent(Widget? value) {
    _helpContent = value;
    notifyPageChange();
  }

  set filterCount(int? value) {
    _filterCount = value;
    notifyPageChange();
  }

  set useFilterForm(bool value) {
    _useFilterForm = value;
    notifyPageChange();
  }

  PanopticPageBuilderController(this.model, {this.ticker});

  final _loadingNotifiers = <String, ValueNotifier<bool>>{
    'content': ValueNotifier<bool>(false),
    'filters': ValueNotifier<bool>(false),
  };

  final _changeNotifiers = <String, ChangeNotifier>{
    'page': ChangeNotifier(),
    'filters': ChangeNotifier(),
  };

  bool get isContentLoading => _loadingNotifiers['content']!.value;
  bool get isFiltersLoading => _loadingNotifiers['filters']!.value;

  set onShowFilters(ShowFiltersDelegate? value) {
    _onShowFilters = value;
  }

  set onShowHelp(ShowHelpDelegate? value) {
    _onShowHelp = value;
  }

  static PanopticPageBuilderController? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PanopticPageBuilderInherited>()
        ?.controller;
  }

  static PanopticPageBuilderController of(BuildContext context) {
    final ctrl = maybeOf(context);
    assert(ctrl != null, 'No PanopticPageBuilderController found in context');
    return ctrl!;
  }

  void initialise();

  ValueNotifier<bool> getLoadingNotifier(String key) {
    if (!_loadingNotifiers.containsKey(key)) {
      _loadingNotifiers[key] = ValueNotifier<bool>(false);
    }
    return _loadingNotifiers[key]!;
  }

  ValueNotifier<bool> get contentLoadingNotifier =>
      _loadingNotifiers['content']!;
  ValueNotifier<bool> get filtersLoadingNotifier =>
      _loadingNotifiers['filters']!;

  ChangeNotifier get pageChangeNotifier => _changeNotifiers['page']!;
  ChangeNotifier get contentChangeNotifier => this;
  ChangeNotifier get filtersChangeNotifier => _changeNotifiers['filters']!;

  ChangeNotifier getChangeNotifier(String key) {
    if (key == 'content') {
      return this;
    }
    if (!_changeNotifiers.containsKey(key)) {
      _changeNotifiers[key] = ChangeNotifier();
    }
    return _changeNotifiers[key]!;
  }

  void loadingContent(Future<dynamic> Function() fn) {
    final contentNotifier = _loadingNotifiers['content']!;
    contentNotifier.value = true;
    fn().whenComplete(() {
      contentNotifier.value = false;
    });
  }

  void loadingFilters(Future<dynamic> Function() fn) {
    final filtersNotifier = _loadingNotifiers['filters']!;
    filtersNotifier.value = true;
    fn().whenComplete(() {
      filtersNotifier.value = false;
    });
  }

  void loadingCustom(String key, Future<dynamic> Function() fn) {
    if (!_loadingNotifiers.containsKey(key)) {
      _loadingNotifiers[key] = ValueNotifier<bool>(false);
    }
    final customNotifier = _loadingNotifiers[key]!;
    customNotifier.value = true;
    fn().whenComplete(() => customNotifier.value = false);
  }

  void notifyPageChange() {
    pageChangeNotifier.notifyListeners();
  }

  void notifyContentChange() {
    notifyListeners();
  }

  void notifyFiltersChange() {
    filtersChangeNotifier.notifyListeners();
  }

  void notifyCustomChange(String key) {
    if (!_changeNotifiers.containsKey(key)) {
      _changeNotifiers[key] = ChangeNotifier();
    }
    _changeNotifiers[key]!.notifyListeners();
  }

  void showFilters() {
    _onShowFilters?.call();
  }

  void showHelp() {
    _onShowHelp?.call();
  }

  /// Use this when setting multiple fields at once to avoid multiple page rebuilds.
  /// Note that this will not change a field if you pass null for it. For that, use the setter.
  /// e.g. setPageFields({pageTitle: 'New Title', filterCount: 3})
  void setPageFields({
    String? pageTitle,
    PanopticButton? actionButton,
    List<PanopticSplitButtonAction>? splitButtonActions,
    bool? hideSearch,
    Widget? leading,
    TabBar? tabs,
    PanopticLoading? loadingWidget,
    Widget? helpContent,
    int? filterCount,
    bool? useFilterForm,
  }) {
    _pageTitle = pageTitle ?? _pageTitle;
    _actionButton = actionButton ?? _actionButton;
    _splitButtonActions = splitButtonActions ?? _splitButtonActions;
    _hideSearch = hideSearch ?? _hideSearch;
    _leading = leading ?? _leading;
    _tabs = tabs ?? _tabs;
    _loadingWidget = loadingWidget ?? _loadingWidget;
    _helpContent = helpContent ?? _helpContent;
    _filterCount = filterCount ?? _filterCount;
    _useFilterForm = useFilterForm ?? _useFilterForm;
    notifyPageChange();
  }

  void generateTabs<J>(
    List<J> items, {
    List<PanopticIcons>? icons,
    bool scrollable = false,
    TabController? controller,
    EdgeInsets? padding,
    Color? indicatorColor,
    bool automaticIndicatorColorAdjustment = true,
    double indicatorWeight = 2.0,
    EdgeInsetsGeometry indicatorPadding = EdgeInsets.zero,
    Decoration? indicator,
    TabBarIndicatorSize? indicatorSize,
    Color? dividerColor,
    double? dividerHeight,
    Color? labelColor,
    TextStyle? labelStyle,
    EdgeInsetsGeometry? labelPadding,
    Color? unselectedLabelColor,
    TextStyle? unselectedLabelStyle,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    WidgetStateProperty<Color>? overlayColor,
    MouseCursor? mouseCursor,
    bool? enableFeedback,
    void Function(int)? onTap,
    ScrollPhysics? physics,
    InteractiveInkFeatureFactory? splashFactory,
    BorderRadius? splashBorderRadius,
    TabAlignment? tabAlignment,
    TextScaler? textScaler,
    TabIndicatorAnimation? indicatorAnimation,
  }) {
    if (items.isEmpty) {
      _tabs = null;
      return;
    }
    if (icons != null && items.length != icons.length) {
      throw Exception(
          'Cannot generate tabs: Items and icons must be the same length');
    }

    if (tabController == null) {
      if (controller != null) {
        tabController = controller;
      } else if (ticker != null) {
        tabController = TabController(
          length: items.length,
          vsync: ticker!,
        );
      }
    } else {
      if (controller != null) {
        tabController?.dispose();
        tabController = controller;
      } else if (ticker != null) {
        tabController?.dispose();
        tabController = TabController(
          length: items.length,
          vsync: ticker!,
        );
      }
    }

    _tabs = TabBar(
      controller: tabController,
      tabs: [
        for (int i = 0; i < items.length; i++)
          PanopticTab(
            coreIcon: icons != null ? icons[i] : null,
            text: items[i].toString(),
          ),
      ],
      isScrollable: scrollable,
      padding: padding,
      indicatorColor: indicatorColor,
      automaticIndicatorColorAdjustment: automaticIndicatorColorAdjustment,
      indicatorWeight: indicatorWeight,
      indicatorPadding: indicatorPadding,
      indicator: indicator,
      indicatorSize: indicatorSize,
      dividerColor: dividerColor,
      dividerHeight: dividerHeight,
      labelColor: labelColor,
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      unselectedLabelColor: unselectedLabelColor,
      unselectedLabelStyle: unselectedLabelStyle,
      dragStartBehavior: dragStartBehavior,
      overlayColor: overlayColor,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      onTap: onTap,
      physics: physics,
      splashFactory: splashFactory,
      splashBorderRadius: splashBorderRadius,
      tabAlignment: tabAlignment,
      textScaler: textScaler,
      indicatorAnimation: indicatorAnimation,
    );

    notifyPageChange();
  }

  void onNetworkError(String url, int errorCode) {
    errorMessage = 'Network error';
    debugPrint('Network error: $url returned status code $errorCode');
    notifyContentChange();
  }

  void error(String message) {
    errorMessage = message;
    notifyContentChange();
  }

  void clearError() {
    errorMessage = null;
    notifyContentChange();
  }

  @override
  void dispose() {
    tabController?.dispose();
    for (final notifier in _loadingNotifiers.values) {
      notifier.dispose();
    }
    for (final notifier in _changeNotifiers.values) {
      notifier.dispose();
    }
    super.dispose();
  }
}

typedef ShowFiltersDelegate = void Function();
typedef ShowHelpDelegate = void Function();
