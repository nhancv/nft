import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/pages/counter/counter_provider.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/widgets/p_appbar_empty.dart';
import 'package:nft/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key key, this.argument}) : super(key: key);

  final String argument;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends BaseStateful<CounterPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PAppBarEmpty(
      child: WKeyboardDismiss(
        child: Column(children: <Widget>[
          AppBar(
            title: const Text('Counter Page'),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.H),
              child: Text(widget.argument ?? '')),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Text(
                  '${context.watch<CounterProvider>().count}',

                  /// Provide a Key to this specific Text widget. This allows
                  /// identifying the widget from inside the test suite,
                  /// and reading the text.
                  key: const Key('counter'),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                /// Provide a Key to this button. This allows finding this
                /// specific button inside the test suite, and tapping it.
                key: const Key('increment'),
                onPressed: () {
                  context.read<CounterProvider>().increase();
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
