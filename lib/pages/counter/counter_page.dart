import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/pages/counter/counter_provider.dart';
import 'package:nft/widgets/screen_widget.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {

  final String argument;

  const CounterPage({Key key, this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(children: <Widget>[
        ScreenHeader(title: argument),
        Expanded(
          child: ScreenBody(),
        ),
      ]),
    );
  }
}

class ScreenHeader extends StatelessWidget {

  final String title;

  const ScreenHeader({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class ScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text(
                '${context.watch<CounterProvider>().count}',
                // Provide a Key to this specific Text widget. This allows
                // identifing the widget from inside the test suite,
                // and reading the text.
                key: Key('counter'),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              // Provide a Key to this button. This allows finding this
              // specific button inside the test suite, and tapping it.
              key: Key('increment'),
              child: Icon(Icons.add),
              onPressed: () {
                context.read<CounterProvider>().increase();
              },
              tooltip: 'Increment',
            ),
          );
        },
      ),
    );
  }
}
