
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget background;

  const BackgroundWidget({Key key, this.background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: background
    );
  }
}

class ImageBackgroundWidget extends StatelessWidget {
  final String imageAsset;

  const ImageBackgroundWidget({Key key, this.imageAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      background: Image.asset(
        imageAsset,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ColorBackgroundWidget extends StatelessWidget {
  final Color color;

  const ColorBackgroundWidget({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      background: Container(
      color: color,
      ),
    );
  }
}

class GradientBackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 52, 44, 36),
              const Color.fromARGB(255, 0, 0, 0)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
