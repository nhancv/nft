import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:simple_animations/simple_animations.dart';

class OToast with DynamicSize {
  OToast._private();

  static final OToast I = OToast._private();

  Timer toastTimer;
  OverlayEntry _overlayEntry;

  void showCustomToast(BuildContext context, String message,
      {TextStyle textStyle}) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry =
          createOverlayEntry(context, message, textStyle: textStyle);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(const Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
          _overlayEntry = null;
        }
      });
    }
  }

  OverlayEntry createOverlayEntry(BuildContext context, String message,
      {TextStyle textStyle}) {
    initDynamicSize(context);
    return OverlayEntry(
      builder: (BuildContext context) {
        return ToastContainer(
          padding: 10.W,
          message: message,
          textStyle: textStyle,
        );
      },
    );
  }
}

class ToastContainer extends StatefulWidget {
  const ToastContainer({Key key, this.message, this.textStyle, this.padding})
      : super(key: key);

  final double padding;
  final TextStyle textStyle;
  final String message;

  @override
  _ToastContainerState createState() => _ToastContainerState();
}

class _ToastContainerState extends BaseStateful<ToastContainer> {
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
        child: ToastMessageAnimation(
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

enum AniProps { translateY, opacity }

class ToastMessageAnimation extends StatelessWidget {
  const ToastMessageAnimation({@required this.child, this.play = false});

  final Widget child;
  final bool play;

  @override
  Widget build(BuildContext context) {
    final MultiTween<AniProps> tween = MultiTween<AniProps>()
      ..add(AniProps.translateY, Tween<double>(begin: -100.0, end: 0.0),
          const Duration(milliseconds: 250), Curves.easeOut)
      ..add(AniProps.translateY, Tween<double>(begin: 0.0, end: 0.0),
          const Duration(seconds: 1, milliseconds: 250))
      ..add(AniProps.translateY, Tween<double>(begin: 0.0, end: -100.0),
          const Duration(seconds: 1, milliseconds: 250), Curves.easeIn)
      ..add(AniProps.opacity, Tween<double>(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500))
      ..add(AniProps.opacity, Tween<double>(begin: 1.0, end: 1.0),
          const Duration(seconds: 1))
      ..add(AniProps.opacity, Tween<double>(begin: 1.0, end: 0.0),
          const Duration(milliseconds: 500));

    return play == false
        ? child
        : PlayAnimation<MultiTweenValues<AniProps>>(
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (BuildContext context, Widget child,
          MultiTweenValues<AniProps> value) {
        return Opacity(
          opacity: value.get(AniProps.opacity),
          child: Transform.translate(
              offset: Offset(0, value.get(AniProps.translateY)),
              child: child),
        );
      },
    );
  }
}
