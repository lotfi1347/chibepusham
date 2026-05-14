import 'dart:ui';

class PoseSmoother {
  Offset? _last;

  Offset smooth(Offset? input, {double factor = 0.25}) {
    if (input == null) return _last ?? Offset.zero;

    if (_last == null) {
      _last = input;
      return input;
    }

    final dx = _last!.dx + (input.dx - _last!.dx) * factor;
    final dy = _last!.dy + (input.dy - _last!.dy) * factor;

    _last = Offset(dx, dy);
    return _last!;
  }

  void reset() {
    _last = null;
  }
}