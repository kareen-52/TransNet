import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';

class ActiveOrderCard extends StatelessWidget {
  final Widget header;
  final Widget timeline;
  final Widget footer;

  const ActiveOrderCard({
    super.key,
    required this.header,
    required this.timeline,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomShadowCard(
      child: Column(
        children: [
          header,
          verticalSpace(32),
          timeline,
          verticalSpace(32),
          Divider(color: theme.colorScheme.outline.withOpacity(0.8)),
          verticalSpace(24),
          footer,
        ],
      ),
    );
  }
}