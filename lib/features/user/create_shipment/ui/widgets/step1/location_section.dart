import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/user/create_shipment/data/models/governorate_model.dart';

class LocationSection extends StatelessWidget {
  final String title;
  final dynamic govValue;
  final List<GovernorateModel> governorates;
  final Function(dynamic) onChanged;
  final VoidCallback onMapTap;
  final bool hasLocation;

  const LocationSection({
    super.key,
    required this.title,
    required this.govValue,
    required this.governorates,
    required this.onChanged,
    required this.onMapTap,
    required this.hasLocation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 6.w),
          child: Text(title, style: theme.textTheme.titleLarge),
        ),
        verticalSpace(8),

        CustomShadowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المحافظة', style: theme.textTheme.bodyMedium),
              verticalSpace(8),
              
              DropdownButtonFormField(
                value: govValue,
                padding: EdgeInsets.all(8.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(

                    borderSide: BorderSide.none,
                  ),
                ),
                items: governorates.map((gov) => DropdownMenuItem(value: gov, child: Text(gov.name)),).toList(),
                onChanged: onChanged,
                hint: const Text('اختر المحافظة'),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.75),
                ),
              ),
              verticalSpace(16),
              
              AppTextButton(
                text: hasLocation
                    ? 'تم تحديد الموقع بنجاح ✓'
                    : 'تحديد الموقع على الخريطة',
                backgroundColor: hasLocation
                    ? theme.colorScheme.primary.withOpacity(0.3)
                    : theme.colorScheme.surfaceContainerHighest,
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: hasLocation
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: hasLocation ? FontWeight.bold : null,
                ),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  size: 22.sp,
                  color: hasLocation
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                onPressed: onMapTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
