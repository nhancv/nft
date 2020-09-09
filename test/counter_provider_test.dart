import 'package:nft/pages/counter/counter_provider.dart';
import 'package:test/test.dart';

void main() {
  /// Test case 1:
  /// - Crease counter value by 1
  /// - Verify that the value is correct with expected value 1
  test('Counter value should be incremented', () {
    // Init counter provider
    final CounterProvider counter = CounterProvider();

    // Increase counter value from 0 to 1
    counter.increase();

    // Expect new counter value must be 1
    expect(counter.count, 1);
  });
}
