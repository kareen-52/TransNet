import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/app_text_form_field.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';

class TrackingCard extends StatelessWidget {
  const TrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomShadowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(Icons.radar, color: theme.colorScheme.primary, size: 25.sp),
              horizontalSpace(8),
              Text(
                'تتبع شحنتك',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            'أدخل رقم الشحنة لمتابعة حالة طلبك.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          verticalSpace(12),

          const AppTextFormField(
            hintText: 'رقم الشحنة',
            prefixIcon: Icon(Icons.numbers),
            fieldType: FieldType.number,
          ),
          verticalSpace(12),

          AppTextButton(
            text: 'ابحث الآن',
            backgroundColor: theme.colorScheme.primary,
            textStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary,
            ),
            prefixIcon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
