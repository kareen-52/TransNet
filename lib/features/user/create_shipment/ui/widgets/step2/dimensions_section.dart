import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';

class ShipmentDimensionsSection extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController lengthController;
  final TextEditingController widthController;
  final TextEditingController heightController;

  const ShipmentDimensionsSection({
    super.key,
    required this.weightController,
    required this.lengthController,
    required this.widthController,
    required this.heightController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomShadowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.straighten, color: theme.colorScheme.primary),
              horizontalSpace(8),
              Text('الأبعاد والوزن', style: theme.textTheme.titleMedium),
            ],
          ),
          verticalSpace(16),
          Row(
            children: [
              Expanded(
                child: _buildDimensionField('الوزن (كغ)', weightController),
              ),
              horizontalSpace(16),
              Expanded(
                child: _buildDimensionField('الطول (سم)', lengthController),
              ),
            ],
          ),
          verticalSpace(16),
          Row(
            children: [
              Expanded(
                child: _buildDimensionField('العرض (سم)', widthController),
              ),
              horizontalSpace(16),
              Expanded(
                child: _buildDimensionField('الارتفاع (سم)', heightController),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionField(String hint, TextEditingController controller) {
    return AppTextFormField(
      controller: controller,
      hintText: hint,
      fieldType: FieldType.number,
      validator: (val) {
        if (val == null || val.trim().isEmpty) return 'مطلوب';
        if (double.tryParse(val) == null || double.parse(val) <= 0) {
          return 'قيمة غير صالحة';
        }
        return null;
      },
    );
  }
}
