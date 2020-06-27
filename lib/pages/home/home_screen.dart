import 'package:flutter/material.dart';
import 'package:nft/pages/home/slideup_widget.dart';
import 'package:nft/widgets/screen_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(children: <Widget>[
        HomeScreenHeader(),
        Expanded(
          child: HomeScreenBody(),
        ),
        HomeScreenFooter()
      ]),
    );
  }
}

class HomeScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody>
    with SingleTickerProviderStateMixin {
  SlideUpController slideUpController = SlideUpController();

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          // Start animation at begin
          slideUpController.toggle();
        } else if (status == AnimationStatus.dismissed) {
          // To hide widget, we need complete animation first
          slideUpController.toggle();
        }
      });
    _fadeAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey,
            child: RaisedButton(
              child: Text('Slide up widget'),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
        ),
        SlideTransition(
          position: _offsetAnimation,
          child: SlideUpWidget(
            controller: slideUpController,
          ),
        )
      ],
    );
  }
}

class HomeScreenFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
