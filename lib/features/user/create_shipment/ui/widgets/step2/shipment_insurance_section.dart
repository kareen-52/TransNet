import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';

class ShipmentInsuranceSection extends StatelessWidget {
  final bool isInsuranceActive;
  final ValueChanged<bool?> onChanged;

  const ShipmentInsuranceSection({
    super.key,
    required this.isInsuranceActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: CheckboxListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            value: isInsuranceActive,
            onChanged: onChanged,
            title: Text('تأمين على الشحنة', style: theme.textTheme.titleMedium),
            subtitle: Text(
              'حماية شاملة ضد الفقدان أو التلف',
              style: theme.textTheme.bodySmall,
            ),
            secondary: Icon(Icons.security, color: theme.colorScheme.primary),
            activeColor: theme.colorScheme.surface,
            checkColor: theme.colorScheme.primary,
          ),
        ),

        verticalSpace(12),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.outline,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.info, size: 22.sp),

              horizontalSpace(16),

              Expanded(
                child: RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    style: theme.textTheme.bodySmall,
                    children: [
                      const TextSpan(
                        text: 'سيتم احتساب التكلفة النهائية بناءً على ',
                      ),
                      TextSpan(
                        text: 'الوزن، الأبعاد، والمسافة المقطوعة',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeightHelper.extraBold,
                          color: theme.colorScheme.onSurface,
                          fontSize: 13.sp,
                        ),
                      ),
                      const TextSpan(text: ' لضمان أدق تسعير.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
