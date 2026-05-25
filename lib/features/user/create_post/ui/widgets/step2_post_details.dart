import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/user/create_post/logic/create_post_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step2/dimensions_section.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step2/shipment_insurance_section.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step2/shipment_object_section.dart';

class Step2PostDetails extends StatelessWidget {
  final CreatePostCubit cubit;
  const Step2PostDetails({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: cubit.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShipmentObjectSection(controller: cubit.objectCtrl),
          verticalSpace(16),
          ShipmentDimensionsSection(
            weightController: cubit.weightCtrl,
            lengthController: cubit.lengthCtrl,
            widthController: cubit.widthCtrl,
            heightController: cubit.heightCtrl,
          ),
          verticalSpace(16),
          

          Text('أقصى موعد متاح للتوصيل', style: theme.textTheme.titleMedium),
          verticalSpace(8),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now(), // لا يمكن اختيار تاريخ ماضي
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) cubit.updateDate(date);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.lastDate == null
                        ? 'اختر التاريخ'
                        : "${cubit.lastDate!.year}/${cubit.lastDate!.month}/${cubit.lastDate!.day}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                        color: cubit.lastDate == null ? Colors.grey : theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.calendar_month_rounded, color: theme.colorScheme.primary),
                ],
              ),
            ),
          ),
          verticalSpace(16),

          ShipmentInsuranceSection(
            isInsuranceActive: cubit.insurance,
            onChanged: (val) => cubit.updateInsurance(val ?? false),
          ),
          verticalSpace(40),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: AppTextButton(
                  text: 'السابق',
                  backgroundColor: Colors.transparent,
                  textStyle: TextStyle(color: theme.colorScheme.secondary, fontWeight: FontWeight.bold),
                  onPressed: cubit.previousStep,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                flex: 2,
                child: AppTextButton(
                  text: 'التالي',
                  onPressed: cubit.nextStep,
                  backgroundColor: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          verticalSpace(32),
        ],
      ),
    );
  }
}