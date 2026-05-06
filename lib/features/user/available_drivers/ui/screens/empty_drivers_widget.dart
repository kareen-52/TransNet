import 'package:flutter/material.dart';
import 'package:graduation_progect/core/widgets/state_handlers/empty_state_widget.dart';

class EmptyDriversWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const EmptyDriversWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return EmptyStateWidget(
      title: 'عذراً، لا يوجد سائقون متاحون حالياً',
      subTitle:
          'جميع السائقين في منطقتك منشغلون بالمهام،\nحاول مرة أخرى بعد قليل.',
      onRetry: onRetry,
    );
  }
}
