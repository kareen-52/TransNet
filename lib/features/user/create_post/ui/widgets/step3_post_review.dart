import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/core/widgets/shadow_card.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_state.dart';

class Step3PostReview extends StatelessWidget {
  final CreatePostCubit cubit;
  final CreatePostState state;
  const Step3PostReview({super.key, required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShadowCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مراجعة الإعلان', style: theme.textTheme.titleLarge),
              const Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.location_on, color: theme.colorScheme.secondary),
                title: Text('الانطلاق: ${cubit.startGovernorate?.name}', style: theme.textTheme.titleMedium),
                subtitle: Text(cubit.startDetailsCtrl.text),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.flag_outlined, color: theme.colorScheme.secondary),
                title: Text('الوصول: ${cubit.endGovernorate?.name}', style: theme.textTheme.titleMedium),
                subtitle: Text(cubit.endDetailsCtrl.text),
              ),
              const Divider(),
              Text('المحتوى: ${cubit.objectCtrl.text}', style: theme.textTheme.bodyLarge),
              verticalSpace(8),
              Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: [
                  Chip(label: Text('الوزن: ${cubit.weightCtrl.text} كغ')),
                  Chip(label: Text('الطول: ${cubit.lengthCtrl.text} سم')),
                  Chip(label: Text('العرض: ${cubit.widthCtrl.text} سم')),
                  Chip(label: Text('الارتفاع: ${cubit.heightCtrl.text} سم')),
                ],
              ),
              verticalSpace(16),
              // if (cubit.insurance)
              //   Container(
              //     padding: EdgeInsets.all(16.w),
              //     decoration: BoxDecoration(
              //       color: theme.colorScheme.primary.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(16.r),
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
              // verticalSpace(8),
              Text(
                'أقصى موعد للتوصيل: ${cubit.lastDate?.year}/${cubit.lastDate?.month}/${cubit.lastDate?.day}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                textStyle: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold),
                onPressed: isLoading ? null : cubit.previousStep,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              flex: 2,
              child: AppTextButton(
                text: 'حساب السعر',
                isLoading: isLoading,
                backgroundColor: theme.colorScheme.secondary,
                onPressed: isLoading ? null : cubit.submitPostStepOne,
              ),
            ),
          ],
        ),
        verticalSpace(32),
      ],
    );
  }
}