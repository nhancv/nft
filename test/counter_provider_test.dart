import 'package:nft/pages/counter/counter_provider.dart';
import 'package:test/test.dart';

void main() {
  test('Counter value should be incremented', () {
    final CounterProvider counter = CounterProvider();

    counter.increase();

    expect(counter.count, 1);
  });
}
