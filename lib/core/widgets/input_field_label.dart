import 'package:flutter/material.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';

class InputFieldLabel extends StatelessWidget {
  final String label;
  const InputFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeightHelper.semiBold,
          color: Theme.of(
            context,
          ).colorScheme.onSurfaceVariant.withOpacity(0.8),
        ),
      ),
    );
  }
}
