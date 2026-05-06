import 'package:flutter/material.dart';
import 'package:graduation_progect/core/helpers/spacing.dart';
import 'package:graduation_progect/core/theming/font_weight_helper.dart';
import 'package:graduation_progect/core/widgets/app_text_button.dart';
import 'package:graduation_progect/features/user/create_shipment/logic/create_shipment_cubit.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step2/dimensions_section.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step2/shipment_insurance_section.dart';
import 'package:graduation_progect/features/user/create_shipment/ui/widgets/step2/shipment_object_section.dart';

class Step2Details extends StatelessWidget {
  final CreateShipmentCubit cubit;
  const Step2Details({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShipmentObjectSection(controller: cubit.objectController),

          verticalSpace(16),

          ShipmentDimensionsSection(
            weightController: cubit.weightController,
            lengthController: cubit.lengthController,
            widthController: cubit.widthController,
            heightController: cubit.heightController,
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
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeightHelper.bold,
                  ),
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
