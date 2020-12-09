import 'package:flutter/material.dart';

abstract class ChangeNotifierSafety with ChangeNotifier {
  bool disposed = false;

  @protected
  void resetState();

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
}
