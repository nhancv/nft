import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:nft/widgets/w_bottom_action_sheet.dart';
import 'package:nft/widgets/w_button_inkwell.dart';
import 'package:nft/widgets/w_divider_line.dart';

/// Use: final int index = await WPickerValue.showPicker(context, initialIndex: 0, initValues: <String>[]);

class WPickerValue extends StatefulWidget {
  const WPickerValue({Key key, this.initialIndex, this.initValues})
      : super(key: key);

  final int initialIndex;
  final List<String> initValues;

  static Future<int> showPicker(BuildContext context,
      {int initialIndex = 0, List<String> initValues}) {
    return showCupertinoModalPopup<int>(
        context: context,
        builder: (BuildContext context) {
          return WPickerValue(
            initialIndex: initialIndex,
            initValues: initValues,
          );
        });
  }

  @override
  _WPickerValueState createState() => _WPickerValueState();
}

class _WPickerValueState extends BaseStateful<WPickerValue> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final List<Widget> children = widget.initValues == null
        ? <Widget>[]
        : widget.initValues
            .map(
              (String e) => Container(
                alignment: Alignment.center,
                child: Text(e,
                    style: normalTextStyle(
                      20.SP,
                      color: Colors.black,
                    )),
              ),
            )
            .toList();
    const double itemExtent = 50;
    final double height =
        children.isNotEmpty ? (children.length * itemExtent) : itemExtent;

    return WBottomActionSheet(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Pick a value',
                style: normalTextStyle(
                  17.SP,
                  color: const Color(0xFF8F8F8F),
                ),
              ),
            ),
            const WDividerLine(),
            Container(
              height: height,
              child: CupertinoPicker(
                onSelectedItemChanged: (int index) {
                  HapticFeedback.selectionClick();
                  setState(() {
                    selected = index;
                  });
                },
                itemExtent: itemExtent,
                children: children,
                scrollController: FixedExtentScrollController(
                    initialItem: widget.initialIndex ?? 0),
              ),
            ),
            const WDividerLine(),
            WButtonInkwell(
              child: Container(
                height: 57,
                alignment: Alignment.center,
                child: Text(
                  'Confirm',
                  style: mediumTextStyle(
                    17.SP,
                    color: const Color(0xFF0080FA),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(selected);
              },
            ),
          ],
        ),
      ),
    );
  }
}
