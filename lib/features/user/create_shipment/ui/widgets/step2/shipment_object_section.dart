import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';

class ShipmentObjectSection extends StatelessWidget {
  final TextEditingController controller;

  const ShipmentObjectSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomShadowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.category_outlined, color: theme.colorScheme.primary),
              horizontalSpace(8),
              Text('ماهية الغرض', style: theme.textTheme.titleMedium),
            ],
          ),
          verticalSpace(16),
          AppTextFormField(
            controller: controller,
            hintText: 'أدخل وصفاً تفصيلياً (مثال: أثاث خشبي)',
            fieldType: FieldType.multiline,
            validator: (val) =>
                val == null || val.trim().isEmpty ? 'هذا الحقل مطلوب' : null,
          ),
        ],
      ),
    );
  }
}
