import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier {

  int count = 0;

  void increase() {
    count ++;
    notifyListeners();
  }

}