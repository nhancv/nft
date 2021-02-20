import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:vector_math/vector_math.dart' as math;

class BrickPage extends StatefulWidget {
  @override
  _BrickPageState createState() => _BrickPageState();
}

class _BrickPageState extends PageStateful<BrickPage>
    with SingleTickerProviderStateMixin {
  double dx = 0.1;
  double dy = 1;
  double anchorY = 1;
  double degree = 10;
  int direction = 1; // left

  AnimationController _animationController;

  @override
  void afterFirstBuild(BuildContext context) {
    super.afterFirstBuild(context);

    final double screenH = 1.SH;
    final double screenW = 1.SW;
    final double velocityY = 1 / screenH;
    final double velocityX = 1 / screenW;
    const int frameRate = 60;
    final int repeatRate = (1.0 / frameRate * 1000).toInt();
    Timer.periodic(Duration(milliseconds: repeatRate), (Timer timer) {
      if (dy < 0 - velocityY ||
          dy > 1 + velocityY ||
          dx < 0 - velocityX ||
          dx > 1 + velocityX) {
        timer.cancel();
        return;
      }
      if (direction == 1) {
        dx += velocityX;
        dy = (1 - tan(math.radians(degree)) * dx) - (1 - anchorY);
      } else if (direction == -1) {
        dx -= velocityX;
        dy = (1 - ((1 - dx) / tan(math.radians(degree)) + velocityY)) -
            (1 - anchorY);
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: _WDraggable(
        dx: dx,
        dy: dy,
        valueChanged: (Offset offset) {
          final double x = offset.dx;
          final double y = offset.dy;
          if (x >= 1.0) {
            direction = -1;
            anchorY = y;
            degree = 90 - degree;
          } else if (x <= 0) {
            direction = 1;
            anchorY = y;
            degree = 90 - degree;
          }
        },
        child: Container(
          width: 10,
          height: 10,
          color: Colors.red,
        ),
      ),
    );
  }
}

/// Draggable widget
class _WDraggable extends StatefulWidget {
  const _WDraggable({Key key, this.child, this.dx, this.dy, this.valueChanged})
      : super(key: key);

  final Widget child;
  final ValueChanged<Offset> valueChanged;
  final double dx;
  final double dy;

  @override
  _WDraggableState createState() => _WDraggableState();
}

class _WDraggableState extends State<_WDraggable> {
  ValueNotifier<Offset> valueListener =
      ValueNotifier<Offset>(const Offset(1, 1));

  @override
  void initState() {
    valueListener.addListener(_notifyParent);
    super.initState();
  }

  @override
  void didUpdateWidget(_WDraggable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dx != null && widget.dy != null) {
      valueListener.value = Offset(
        widget.dx.toDouble(),
        widget.dy.toDouble(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final GestureDetector handle = GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            final double dx = (valueListener.value.dx +
                    (details.delta.dx / context.size.width))
                .clamp(0.0, 1.0)
                .toDouble();
            final double dy = (valueListener.value.dy -
                    (details.delta.dy / context.size.height))
                .clamp(0.0, 1.0)
                .toDouble();
            valueListener.value = Offset(dx, dy);
          },
          child: widget.child,
        );

        return AnimatedBuilder(
          animation: valueListener,
          builder: (_, Widget child) {
            return Align(
              alignment: Alignment(
                valueListener.value.dx * 2 - 1,
                valueListener.value.dy * 2 - 1,
              ),
              child: child,
            );
          },
          child: handle,
        );
      },
    );
  }

  // Notify change to parent
  void _notifyParent() {
    if (widget.valueChanged != null) {
      widget.valueChanged(valueListener.value);
    }
  }
}
