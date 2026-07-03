import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_state.dart';

class Step3Review extends StatelessWidget {
  final CreateShipmentCubit cubit;
  final CreateShipmentState state;
  const Step3Review({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShadowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مراجعة المواقع', style: theme.textTheme.titleLarge),
              const Divider(),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.location_on,
                  color: theme.colorScheme.secondary,
                ),
                title: Text('نقطة الانطلاق', style: theme.textTheme.bodySmall),
                subtitle: Text(
                  cubit.startGovernorate?.name ?? '',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.flag_outlined,
                  color: theme.colorScheme.secondary,
                ),
                title: Text('نقطة الوصول', style: theme.textTheme.bodySmall),
                subtitle: Text(
                  cubit.endGovernorate?.name ?? '',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(24),

        CustomShadowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تفاصيل الشحنة', style: theme.textTheme.titleLarge),
              const Divider(),
              verticalSpace(16),
              Text(
                'المحتوى: ${cubit.objectController.text}',
                style: theme.textTheme.bodyLarge,
              ),
              verticalSpace(16),

              Wrap(
                alignment: WrapAlignment.start,

                spacing: 16.w,
                runSpacing: 8.h,
                children: [
                  Chip(label: Text('الوزن: ${cubit.weightController.text} كغ')),
                  Chip(label: Text('الطول: ${cubit.lengthController.text} سم')),
                  Chip(label: Text('العرض: ${cubit.widthController.text} سم')),
                  Chip(
                    label: Text('الارتفاع: ${cubit.heightController.text} سم'),
                  ),
                ],
              ),

              // verticalSpace(16),

              // if (cubit.insurance)
              //   Container(
              //     padding: EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: theme.colorScheme.primary.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Row(
              //       children: [
              //         Icon(Icons.security, color: theme.colorScheme.primary),
              //         horizontalSpace(8),
              //         Text(
              //           'خدمة التأمين على الشحنة مفعلة',
              //           style: theme.textTheme.labelMedium?.copyWith(
              //             color: theme.colorScheme.primary,
              //             fontWeight: FontWeightHelper.bold,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
            ],
          ),
        ),

        verticalSpace(40),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: AppTextButton(
                text: 'رجوع',
                backgroundColor: Colors.transparent,
                textStyle: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeightHelper.bold,
                ),
                onPressed: state is SubmitLoading ? null : cubit.previousStep,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              flex: 2,
              child: AppTextButton(
                text: 'البحث عن سائقين',
                isLoading: state is SubmitLoading,
                backgroundColor: theme.colorScheme.secondary,
                onPressed: state is SubmitLoading ? null : cubit.submitShipment,
              ),
            ),
          ],
        ),
        verticalSpace(32),
      ],
    );
  }
}
