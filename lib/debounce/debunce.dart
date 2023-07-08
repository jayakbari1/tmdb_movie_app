import 'dart:async';
import 'dart:ui';

class Debouncer {
  Debouncer({
    required this.second,
  });
  final int second;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: second), action);
  }

  void cancelRequest() {
    _timer?.cancel();
  }
}
