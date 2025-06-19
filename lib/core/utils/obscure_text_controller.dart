// lib/core/utils/obscure_text_controller.dart
import 'package:flutter/material.dart';

class ObscureTextController {
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  void toggle() => isVisible.value = !isVisible.value;

  void dispose() => isVisible.dispose();
}
