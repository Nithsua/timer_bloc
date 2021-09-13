import 'dart:async';

class Ticker {
  Stream<int> tick(int duration) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (i) => duration - i - 1,
    ).take(duration);
  }
}
