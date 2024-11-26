import 'dart:async';
import 'package:flutter/material.dart';

abstract class PanopticPageController<T> {
  final List<void Function()> _showFiltersListeners = [];
  final List<void Function()> _showHelpListeners = [];
  final T model;

  final List<State> _viewStates = [];

  bool get isFinished => _finished;
  bool get hasFuture => _future != null;
  bool get isInitialised => _initialised;
  Future<dynamic>? get future => _future;
  List<State> get viewStates => _viewStates;

  bool _initialised = false;
  Future<dynamic>? _future;
  bool _finished = false;

  PanopticPageController(this.model, {State? viewState}) {
    if (viewState != null) {
      _viewStates.add(viewState);
    }
  }

  @mustCallSuper
  void initialise() {
    _initialised = true;
  }

  void addViewState(State state) {
    _viewStates.add(state);
  }

  void removeViewState(State state) {
    _viewStates.remove(state);
  }

  void setStates() {
    if (!_initialised) {
      return;
    }

    Set<State> toRemove = {};
    for (State state in _viewStates) {
      if (state.mounted) {
        // ignore: invalid_use_of_protected_member
        state.setState(() {});
      } else {
        toRemove.add(state);
      }
    }
    _viewStates.removeWhere((element) => toRemove.contains(element));
  }

  void addShowFiltersListener(void Function() listener) {
    _showFiltersListeners.add(listener);
  }

  void removeShowFiltersListener(void Function() listener) {
    _showFiltersListeners.remove(listener);
  }

  void addShowHelpListener(void Function() listener) {
    _showHelpListeners.add(listener);
  }

  void removeShowHelpListener(void Function() listener) {
    _showHelpListeners.remove(listener);
  }

  void showFilters() {
    for (void Function() listener in _showFiltersListeners) {
      listener();
    }
  }

  void showHelp() {
    for (void Function() listener in _showHelpListeners) {
      listener();
    }
  }

  void setLoading(Future<dynamic> Function() operation, {bool setStateOnFinish = true}) {
    _finished = false;
    setStates();
    _future = operation().then((d) {
      if (setStateOnFinish) {
        setStates();
      }
      _finished = true;
    });
  }

  void setLoadingSet(Iterable<Future> operations, {bool setStateOnFinish = true}) {
    _finished = false;

    _future = Future.wait(operations).then((d) {
      if (setStateOnFinish) {
        setStates();
      }
      _finished = true;
    });
  }

  void dispose() {}
}
