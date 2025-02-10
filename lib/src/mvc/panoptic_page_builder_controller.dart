import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/mvc/panoptic_page_builder_inherited.dart';

abstract class PanopticPageBuilderController extends ChangeNotifier {
  ShowFiltersDelegate? _onShowFilters;
  ShowHelpDelegate? _onShowHelp;

  final _loadingNotifiers = <String, ValueNotifier<bool>>{
    'content': ValueNotifier<bool>(false),
    'filters': ValueNotifier<bool>(false),
  };

  final _changeNotifiers = <String, ChangeNotifier>{
    'filters': ChangeNotifier(),
    'page': ChangeNotifier(),
  };

  bool get isPageLoading => _loadingNotifiers['page']!.value;
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

  ChangeNotifier getChangeNotifier(String key) {
    if (key == 'content') {
      return this;
    }
    if (!_changeNotifiers.containsKey(key)) {
      _changeNotifiers[key] = ChangeNotifier();
    }
    return _changeNotifiers[key]!;
  }

  ChangeNotifier get contentChangeNotifier => this;
  ChangeNotifier get filtersChangeNotifier => _changeNotifiers['filters']!;

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

  void notifyContentChange() {
    notifyListeners();
  }

  void notifyFiltersChange() {
    _changeNotifiers['filters']!.notifyListeners();
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
}

typedef ShowFiltersDelegate = void Function();
typedef ShowHelpDelegate = void Function();
