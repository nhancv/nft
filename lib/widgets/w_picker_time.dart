import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:nft/widgets/w_bottom_action_sheet.dart';
import 'package:nft/widgets/w_button_inkwell.dart';
import 'package:nft/widgets/w_divider_line.dart';

/// Use: final Duration duration = await WPickerDate.showPicker(context);

class WPickerTime extends StatefulWidget {
  const WPickerTime({Key key, this.initDuration}) : super(key: key);

  final Duration initDuration;

  static Future<Duration> showPicker(BuildContext context,
      {Duration initDuration}) {
    return showCupertinoModalPopup<Duration>(
        context: context,
        builder: (BuildContext context) {
          return WPickerTime(
            initDuration: initDuration,
          );
        });
  }

  @override
  _WPickerTimeState createState() => _WPickerTimeState();
}

class _WPickerTimeState extends BaseStateful<WPickerTime> {
  Duration selected = const Duration(minutes: 1);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isTimeValid = selected > Duration.zero;
    return WBottomActionSheet(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Pick a duration',
                style: normalTextStyle(17.SP, color: const Color(0xFF8F8F8F)),
              ),
            ),
            const WDividerLine(),
            Container(
              height: 200,
              child: CupertinoTimerPicker(
                initialTimerDuration: widget.initDuration ?? selected,
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (Duration value) {
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
                  style: normalTextStyle(17.SP,
                      color: const Color(0xFF0080FA)
                          .withOpacity(isTimeValid ? 1 : 0.4)),
                ),
              ),
              onPressed: isTimeValid
                  ? () {
                      Navigator.of(context).pop(selected);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
