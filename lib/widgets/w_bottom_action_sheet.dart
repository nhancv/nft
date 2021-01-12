import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

//     showCupertinoModalPopup<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return WBottomActionSheet(
//             body: Container(
//               color: Colors.white,
//               height: 50,
//               alignment: Alignment.center,
//               child: const Text('empty'),
//             ),
//           );
//         });
class WBottomActionSheet extends StatelessWidget {
  const WBottomActionSheet({Key key, @required this.body, this.onCancel})
      : super(key: key);

  final Widget body;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    const double _kEdgeHorizontalPadding = 8.0;
    const double _kEdgeVerticalPadding = 10.0;

    const double _kBlurAmount = 20.0;

    final Orientation orientation = MediaQuery.of(context).orientation;
    double actionSheetWidth;
    if (orientation == Orientation.portrait) {
      actionSheetWidth =
          MediaQuery.of(context).size.width - (_kEdgeHorizontalPadding * 2);
    } else {
      actionSheetWidth =
          MediaQuery.of(context).size.height - (_kEdgeHorizontalPadding * 2);
    }

    return Theme(
      data: Theme.of(context).copyWith(
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: '.SF UI Display')),
      child: Material(
        color: Colors.transparent,
        child: Semantics(
          namesRoute: true,
          scopesRoute: true,
          explicitChildNodes: true,
          label: 'Alert',
          child: Container(
            width: actionSheetWidth,
            margin: const EdgeInsets.symmetric(
              horizontal: _kEdgeHorizontalPadding,
              vertical: _kEdgeVerticalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(9.0),
                    child: Container(
                      width: actionSheetWidth,
                      color: const Color(0xF5151015),
                      child: body,
                    )),
                const SizedBox(height: 12),
                Container(
                  width: actionSheetWidth,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: _kBlurAmount, sigmaY: _kBlurAmount),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(9.0),
                          child: Container(
                            height: 51,
                            alignment: Alignment.center,
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style:
                                  normalTextStyle(17.SP, color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            if (onCancel != null) {
                              onCancel();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
