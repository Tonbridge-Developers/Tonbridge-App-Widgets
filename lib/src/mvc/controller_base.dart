import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';

abstract class ControllerBase<T> {
  GlobalKey<PanopticFormState> formKey = GlobalKey<PanopticFormState>();
  final List<void Function()> _startListeners = [];
  final List<void Function()> _finishListeners = [];
  final T model;

  ControllerBase(this.model);

  void addStartListener(void Function() listener) {
    _startListeners.add(listener);
  }

  void addFinishListener(void Function() listener) {
    _finishListeners.add(listener);
  }

  void removeStartListener(void Function() listener) {
    _startListeners.remove(listener);
  }

  void removeFinishListener(void Function() listener) {
    _finishListeners.remove(listener);
  }

  void notifyStartOperation() {
    for (var element in _startListeners) {
      element();
    }
  }

  void notifyFinishOperation() {
    for (var element in _finishListeners) {
      element();
    }
  }

  Future<R> asyncOperation<R>(Future<R> Function() operation) async {
    notifyStartOperation();
    R result = await operation();
    notifyFinishOperation();

    return result;
  }

  Future<Iterable<Future>> asyncOperations(Iterable<Future> operations) async {
    notifyStartOperation();
    await Future.wait(operations);
    notifyFinishOperation();

    return operations;
  }
}
