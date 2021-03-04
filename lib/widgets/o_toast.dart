import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:simple_animations/simple_animations.dart';

/// OToast.I.showCustomToast(context, 'hello');
class OToast with DynamicSize {
  OToast._private();

  static final OToast I = OToast._private();

  Timer _toastTimer;
  OverlayEntry _overlayEntry;

  void showCustomToast(BuildContext context, String message,
      {TextStyle textStyle, double padding, Duration duration}) {
    Duration validDuration = const Duration(seconds: 2);
    if (duration != null && duration.inMilliseconds >= 500) {
      validDuration = duration;
    }
    if (_toastTimer == null || !_toastTimer.isActive) {
      _overlayEntry = _createOverlayEntry(
        context,
        message,
        textStyle: textStyle,
        padding: padding,
        duration: validDuration,
      );
      Overlay.of(context).insert(_overlayEntry);
      _toastTimer = Timer(validDuration, () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
          _overlayEntry = null;
        }
      });
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context, String message,
      {TextStyle textStyle, double padding, Duration duration}) {
    initDynamicSize(context);
    return OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            _ToastContainer(
              padding: padding ?? 30.W,
              duration: duration,
              message: message,
              textStyle: textStyle,
            ),
            AbsorbPointer(
              child: Container(color: Colors.transparent),
            ),
          ],
        );
      },
    );
  }
}

class _ToastContainer extends StatefulWidget {
  const _ToastContainer(
      {Key key, this.message, this.textStyle, this.padding, this.duration})
      : super(key: key);

  final double padding;
  final TextStyle textStyle;
  final String message;
  final Duration duration;

  @override
  _ToastContainerState createState() => _ToastContainerState();
}

class _ToastContainerState extends BaseStateful<_ToastContainer> {
  double top;

  @override
  void afterFirstBuild(BuildContext context) {
    super.afterFirstBuild(context);
    setState(() {
      top = 1.SH / 2 - context.size.height / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isReady = top != null;
    return Positioned(
      top: top ?? 0,
      width: 1.SW - (widget.padding ?? 10.W) * 2,
      left: widget.padding ?? 10.W,
      child: Opacity(
        opacity: isReady ? 1 : 0,
        child: _ToastMessageAnimation(
          duration: widget.duration,
          play: isReady,
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20.W),
            child: Container(
              padding: EdgeInsets.only(
                  left: 10.W, right: 10.W, top: 13.H, bottom: 10.H),
              decoration: BoxDecoration(
                  color: const Color(0xFF323846),
                  borderRadius: BorderRadius.circular(20.W)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.message ?? '',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: widget.textStyle ??
                      TextStyle(
                        fontSize: 18.SP,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFFFFFF),
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _AniProps { translateY, opacity }

class _ToastMessageAnimation extends StatelessWidget {
  const _ToastMessageAnimation(
      {@required this.child, this.play = false, this.duration});

  final Widget child;
  final bool play;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final Duration totalDuration = duration ?? const Duration(seconds: 2);

    final MultiTween<_AniProps> tween = MultiTween<_AniProps>()
      ..add(_AniProps.translateY, Tween<double>(begin: -50.0, end: 0.0),
          const Duration(milliseconds: 250), Curves.easeOut)
      ..add(_AniProps.translateY, Tween<double>(begin: 0.0, end: 0.0),
          Duration(milliseconds: totalDuration.inMilliseconds - 500))
      ..add(_AniProps.translateY, Tween<double>(begin: 0.0, end: -50.0),
          const Duration(seconds: 0, milliseconds: 250), Curves.easeIn)
      ..add(_AniProps.opacity, Tween<double>(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 250))
      ..add(_AniProps.opacity, Tween<double>(begin: 1.0, end: 1.0),
          Duration(milliseconds: totalDuration.inMilliseconds - 500))
      ..add(_AniProps.opacity, Tween<double>(begin: 1.0, end: 0.0),
          const Duration(milliseconds: 250));

    return play == false
        ? child
        : PlayAnimation<MultiTweenValues<_AniProps>>(
            duration: tween.duration,
            tween: tween,
            child: child,
            builder: (BuildContext context, Widget child,
                MultiTweenValues<_AniProps> value) {
              return Opacity(
                opacity: value.get(_AniProps.opacity),
                child: Transform.translate(
                    offset: Offset(0, value.get(_AniProps.translateY)),
                    child: child),
              );
            },
          );
  }
}
