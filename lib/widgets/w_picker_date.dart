import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:nft/widgets/w_bottom_action_sheet.dart';
import 'package:nft/widgets/w_button_inkwell.dart';
import 'package:nft/widgets/w_divider_line.dart';

/// Use: final DateTime dateTime = await WPickerDate.showPicker(context);

class WPickerDate extends StatefulWidget {
  const WPickerDate({Key key, this.initDateTime}) : super(key: key);

  final DateTime initDateTime;

  static Future<DateTime> showPicker(BuildContext context,
      {DateTime initDateTime}) {
    return showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return WPickerDate(
            initDateTime: initDateTime,
          );
        });
  }

  @override
  _WPickerDateState createState() => _WPickerDateState();
}

class _WPickerDateState extends BaseStateful<WPickerDate> {
  DateTime selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WBottomActionSheet(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Pick a time',
                style: normalTextStyle(17.SP, color: const Color(0xFF8F8F8F)),
              ),
            ),
            const WDividerLine(),
            Container(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: widget.initDateTime ?? selected,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime value) {
                  HapticFeedback.selectionClick();
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ),
            const WDividerLine(),
            WButtonInkwell(
              child: Container(
                height: 57,
                alignment: Alignment.center,
                child: Text(
                  'Confirm',
                  style: normalTextStyle(17.SP, color: const Color(0xFF0080FA)),
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
