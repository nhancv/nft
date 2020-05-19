/*
 * MIT License
 *
 * Copyright (c) 2020 Nhan Cao
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/provider/lite_bloc.dart';
import 'package:nft/widgets/app_popup.dart';

class MainBloc {
  MainBloc._private() {
    initLogic();
  }
  static final instance = MainBloc._private();

  final appLoading = LiteBlocDefault<bool>();
  final localeBloc = LiteBlocDefault<Locale>();

  BuildContext _context;

  // @nhancv 10/25/2019: Init context, need call this function after root widget initialized.
  //class AppContent extends StatelessWidget {
  //  @override
  //  Widget build(BuildContext context) {
  //    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));
  //
  //    return Scaffold(
  //      backgroundColor: Colors.transparent,
  //      body: Container(),
  //    );
  //  }
  //
  //  // @nhancv 10/25/2019: After widget initialized.
  //  void onAfterBuild(BuildContext context) {
  //    MainBloc().initContext(context);
  //  }
  //}
  void initContext(BuildContext context) {
    _context = context;
  }

  BuildContext getContext() {
    if (_context == null)
      throw Exception(
          'You need to init context after root widget initialized.');
    return _context;
  }

  @override
  void dispose() {
    appLoading.dispose();
  }

  @override
  void initLogic() {}

  /// @nhancv 2019-10-26: Cupertino Page Route push
  void navigatePush(Widget screen) {
    if (_context == null) return;
    Navigator.push(_context, CupertinoPageRoute(builder: (context) => screen));
  }

  /// @nhancv 2019-10-26: Cupertino Page Route push replacement
  void navigateReplace(Widget screen) {
    if (_context == null) return;
    Navigator.pushReplacement(
        _context, CupertinoPageRoute(builder: (context) => screen));
  }

  /// @nhancv 2019-10-26: Dismiss dialog
  void dismissDialog() {
    if (_context == null) return;
    Navigator.pop(_context);
  }

  /// @nhancv 10/25/2019: Show dialog
  void showAlertDialog(String message) {
    if (_context == null) return;
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => AppAlertDialog(message: message),
    );
  }

  // @nhancv 11/14/2019: Show dialog with full customization
  void showAppDialog(WidgetBuilder builder, {bool barrierDismissible = false}) {
    if (_context == null) return;
    showDialog(
      context: _context,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }
}
