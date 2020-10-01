import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier {
  int count = 0;

  /// Increase value and notify to update ui
  void increase() {
    count++;
    notifyListeners();
  }
}
