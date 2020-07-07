import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key key, this.background}) : super(key: key);

  final Widget background;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: background);
  }
}

class ImageBackgroundWidget extends StatelessWidget {
  const ImageBackgroundWidget({Key key, this.imageAsset}) : super(key: key);

  final String imageAsset;

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
  const ColorBackgroundWidget({Key key, this.color}) : super(key: key);

  final Color color;

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
  const GradientBackgroundWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      background: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(255, 52, 44, 36),
              Color.fromARGB(255, 0, 0, 0)
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
