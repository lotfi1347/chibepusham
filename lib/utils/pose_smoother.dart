import 'package:flutter/material.dart';

class PoseSmoother {
  Offset? _last;

  Offset smooth(Offset input) {
    if (_last == null) {
      _last = input;
      return input;
    }

    _last = Offset(
      _last!.dx * 0.7 + input.dx * 0.3,
      _last!.dy * 0.7 + input.dy * 0.3,
    );

    return _last!;
  }
}