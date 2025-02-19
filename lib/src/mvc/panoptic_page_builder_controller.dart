import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/mvc/panoptic_page_builder_inherited.dart';

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

  PanopticPageBuilderController(this.model);

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

  @override
  void dispose() {
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
