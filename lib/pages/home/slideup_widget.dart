import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideUpWidget extends StatefulWidget {
  final SlideUpController controller;

  const SlideUpWidget({Key key, this.controller}) : super(key: key);

  @override
  _SlideUpWidgetState createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SlideUpProvider(),
      child: Consumer<SlideUpProvider>(
        builder: (context, provider, child) {
          widget.controller?.providerContext = context;
          return provider.isShow
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                )
              : Container();
        },
      ),
    );
  }
}

class SlideUpProvider with ChangeNotifier {
  bool isShow = false;

  void updateState(bool newState) {
    isShow = newState;
    notifyListeners();
  }
}

class SlideUpController {
  SlideUpController._private();

  static final SlideUpController instance = SlideUpController._private();

  factory SlideUpController() => instance;

  BuildContext _providerContext;

  set providerContext(BuildContext context) {
    if (_providerContext != context) {
      _providerContext = context;
    }
  }

  void toggle() {
    if (_providerContext != null) {
      final provider = _providerContext.read<SlideUpProvider>();
      provider.updateState(!provider.isShow);
    } else {
      print('Need init provider context');
    }
  }
}
