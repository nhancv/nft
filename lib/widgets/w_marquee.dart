import 'package:flutter/material.dart';

// WMarquee(
//   scrollDirection: Axis.horizontal,
//   padding: EdgeInsets.symmetric(horizontal: 5.W),
//   child: Text('very long long long'),
// ),
class WMarquee extends StatefulWidget {
  const WMarquee({
    @required this.child,
    this.padding,
    this.scrollDirection = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.backDuration = const Duration(milliseconds: 5000),
    this.pauseDuration = const Duration(milliseconds: 1200),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Axis scrollDirection;
  final Duration animationDuration, backDuration, pauseDuration;

  @override
  _WMarqueeState createState() => _WMarqueeState();
}

class _WMarqueeState extends State<WMarquee> {
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scroll();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WMarquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset
    scrollController.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      padding: widget.padding,
      controller: scrollController,
      scrollDirection: widget.scrollDirection,
      physics: const BouncingScrollPhysics(),
    );
  }

  Future<void> scroll() async {
    while (scrollController.hasClients) {
      await Future<void>.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.ease);
      await Future<void>.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(0.0,
            duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}
